#include <Arduino.h>
#include <WiFi.h>
#include <FirebaseESP32.h>
#include "DHT.h"
#include "EmonLib.h"
#include <driver/adc.h>

#include "addons/TokenHelper.h"

#include "addons/RTDBHelper.h"

#define DHTPIN 4 
#define DHTTYPE DHT11 

DHT dht(DHTPIN, DHTTYPE);

#define DEVICE_UID "4X"

#define WIFI_SSID ""
#define WIFI_PASSWORD ""

#define API_KEY ""

#define DATABASE_URL "" 


#define ADC_INPUT 34


#define HOME_VOLTAGE 230.0


#define ADC_BITS    10
#define ADC_COUNTS  (1<<ADC_BITS)

EnergyMonitor emon1;

short measurements[30];
short measureIndex = 0;
unsigned long lastMeasurement = 0;
unsigned long timeFinishedSetup = 0;

unsigned long update_energy_interval = 1000;

String device_location = "Main Bedroom";

FirebaseData fbdo;

FirebaseAuth auth;

FirebaseConfig config;

String databasePath = "";

String fuid = "";

unsigned long elapsedMillis = 0;

unsigned long update_interval = 10000;

int count = 0;

bool isAuthenticated = false;

float temperature = 24.7;
float humidity = 60;
float watts = 0.0;

FirebaseJson temperature_json;
FirebaseJson humidity_json;
FirebaseJson energy_json;

void Wifi_Init() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
      Serial.print(".");
      delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();
}

void firebase_init() {
  
    config.api_key = API_KEY;

    config.database_url = DATABASE_URL;

    Firebase.reconnectWiFi(true);

    Serial.println("------------------------------------");
    Serial.println("Sign up new user...");

    if (Firebase.signUp(&config, &auth, "", ""))
    {
        Serial.println("Success");
        isAuthenticated = true;

        databasePath = "/" + device_location;
        fuid = auth.token.uid.c_str();
    }
    else
    {
        Serial.printf("Failed, %s\n", config.signer.signupError.message.c_str());
        isAuthenticated = false;
    }

    config.token_status_callback = tokenStatusCallback;

    Firebase.begin(&config, &auth);
}

void dhtt11_init(){
  dht.begin();

  temperature_json.add("deviceuid", DEVICE_UID);
  temperature_json.add("name", "Temperature");
  temperature_json.add("type", "Temperature");
  temperature_json.add("location", device_location);
  temperature_json.add("value", temperature);

  String jsonStr;
  temperature_json.toString(jsonStr, true);
  Serial.println(jsonStr);

  humidity_json.add("deviceuid", DEVICE_UID);
  humidity_json.add("name", "Humidity");
  humidity_json.add("type", "Humidity");
  humidity_json.add("location", device_location);
  humidity_json.add("value", humidity);

  String jsonStr2;
  humidity_json.toString(jsonStr2, true);
  Serial.println(jsonStr2);

  energy_json.add("deviceuid", DEVICE_UID);
  energy_json.add("name", "Energy");
  energy_json.add("type", "Energy");
  energy_json.add("location", device_location);
  energy_json.add("value", watts);

 
  String jsonStr3;
  energy_json.toString(jsonStr3, true);
  Serial.println(jsonStr3);
}

void setup() {
  adc1_config_channel_atten(ADC1_CHANNEL_6, ADC_ATTEN_DB_11);
  analogReadResolution(10);

  emon1.current(ADC_INPUT, 30);

  Serial.begin(115200);
 
  Wifi_Init();
 
  firebase_init();
  
  dhtt11_init();
}

void updateSensorReadings(){
  Serial.println("------------------------------------");
  Serial.println("Reading Sensor data ...");

  humidity = dht.readHumidity();
  temperature = dht.readTemperature();

 
  if (isnan(temperature) || isnan(humidity)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  Serial.printf("Temperature reading: %.2f \n", temperature);
  Serial.printf("Humidity reading: %.2f \n", humidity);

  temperature_json.set("value", temperature);
  humidity_json.set("value", humidity);
}

void compute_energy(){
     elapsedMillis = millis();


    double amps = emon1.calcIrms(1480);
    watts = amps * HOME_VOLTAGE;

    energy_json.set("value", watts);

    Serial.println("Energy Measurement - ");
    Serial.print("Amps: ");
    Serial.println(amps);

    Serial.println("Energy Measurement - ");
    Serial.print("Watts: ");
    Serial.println(watts);

  
}

void uploadSensorData() {
  if (millis() - elapsedMillis > update_interval && isAuthenticated && Firebase.ready())
    {
      elapsedMillis = millis();

      updateSensorReadings();
      compute_energy();

      String temperature_node = databasePath + "/temperature";  
      String humidity_node = databasePath + "/humidity"; 
      String energy_node = databasePath + "/energy";  

      if (Firebase.setJSON(fbdo, temperature_node.c_str(), temperature_json))
      {
          Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
          Serial.println("ETag: " + fbdo.ETag());
          Serial.print("VALUE: ");
          printResult(fbdo); //see addons/RTDBHelper.h
          Serial.println("------------------------------------");
          Serial.println();
      }
      else
      {
          Serial.println("FAILED");
          Serial.println("REASON: " + fbdo.errorReason());
          Serial.println("------------------------------------");
          Serial.println();
      }

      if (Firebase.setJSON(fbdo, humidity_node.c_str(), humidity_json))
      {
          Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
          Serial.println("ETag: " + fbdo.ETag());
          Serial.print("VALUE: ");
          printResult(fbdo); //see addons/RTDBHelper.h
          Serial.println("------------------------------------");
          Serial.println();
      }
      else
      {
          Serial.println("FAILED");
          Serial.println("REASON: " + fbdo.errorReason());
          Serial.println("------------------------------------");
          Serial.println();
      } 

      if (Firebase.setJSON(fbdo, energy_node.c_str(), energy_json))
      {
          Serial.println("PASSED");
          Serial.println("PATH: " + fbdo.dataPath());
          Serial.println("TYPE: " + fbdo.dataType());
          Serial.println("ETag: " + fbdo.ETag());
          Serial.print("VALUE: ");
          printResult(fbdo); //see addons/RTDBHelper.h
          Serial.println("------------------------------------");
          Serial.println();
      }
      else
      {
          Serial.println("FAILED");
          Serial.println("REASON: " + fbdo.errorReason());
          Serial.println("------------------------------------");
          Serial.println();
      } 
    }
}

void loop() {
  uploadSensorData();
}