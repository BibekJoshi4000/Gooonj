#include <WiFi.h>
#include <HTTPClient.h>
#include <ArduinoJson.h>
#include <Arduino_JSON.h>
#include <Wire.h>
#include <Adafruit_SSD1306.h>
#include <Adafruit_GFX.h>
#include <Servo.h> 

#define OLED_WIDTH 128
#define OLED_HEIGHT 64
#define RXp2 16
#define TXp2 17
#define Null_maker 18

int httpResponseCode;

const int yes = 15;
const int no = 2;
const char* ssid = "Morningstar";
const char* password = "kivan321";
const char* serverName = "https://gooonj.cyclic.app/api/v1/verifyUser/card";
const int servo = 4;
bool isCard = false;
bool isMobile = false;
String userId ="";
String userPin="";
String mobUserId="";
String mobUserOtp="";

#define OLED_ADDR   0x3C

Adafruit_SSD1306 display(OLED_WIDTH, OLED_HEIGHT);

void setup() {
Serial.begin(115200);
  while (!Serial) continue;
  Serial1.begin(9600, SERIAL_8N1, RXp2, TXp2);
  display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
  display.clearDisplay();
  pinMode(15,INPUT);
  pinMode(16,INPUT);
  pinMode(Null_maker,OUTPUT);
  wifi();
}

void loop() {
// http.begin(serverName);
// http.addHeader("Content-Type", "application/json");

option();
display.clearDisplay();
}

void option(){
    if(!isMobile && !isCard) {
      display.clearDisplay();
      display.setTextSize(1);
      display.setTextColor(WHITE);
      display.setCursor(10, 0);
      display.println("Select access mode");
      display.setTextSize(1);
      display.setTextColor(WHITE);
      display.setCursor(2, 50);
      display.println("Phone");
      display.setCursor(60, 50);
      display.println("Gooonj Card");
      display.display();
      if (digitalRead(yes) == 1){
        delay(500);
        isMobile = true;
      }
        
      if (digitalRead(no) == 1){
        delay(500);
        isCard = true;
      }

    }
    if (isMobile && !isCard){
      mobile_user();
    }
    if (!isMobile && isCard ){
      gooonj_card();
    }


}
void gooonj_card(){
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(15, 0);
  display.println("Tap Gooonj Card");
  display.display();
  display.setCursor(31,13);
  display.println("Gooonj ID");
  display.setCursor(33,25);
  dataFromMega(); 
  display.println(userId);
  display.display();
  display.setCursor(22,45);
  display.println("Enter Password");
  display.setCursor(50,55);
  display.print(userPin);
  display.display();
  delay(500);
}
void mobile_user(){
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(8, 0);
  display.println("Enter your details");
  display.display();
  display.setCursor(31,13);
  display.println("Gooonj ID");
  display.setCursor(33,25);  
  mobiledataFromMega();  
  display.println(mobUserId);
  display.display();
  display.setCursor(22,45);
  display.println("Enter Password");
  display.setCursor(50,55);
  display.print(mobUserOtp);
  display.display();
  delay(500);  
}

void dataFromMega(){
  StaticJsonDocument<300> doc;
  if (Serial1.available()) {

    DeserializationError err = deserializeJson(doc, Serial1);

    if (err == DeserializationError::Ok) {

      Serial.print("ID = ");
      Serial.println(doc["ID"].as<String>());
      String userid = doc["ID"];
      userId = userid;

      Serial.print("Pin = ");
      Serial.println(doc["PIN"].as<String>());
      String userpin = doc["PIN"];
      userPin = userpin;

      // Serial.println(doc["MID"].as<String>());
      // String mob_userpin = doc["MID"];
      // mobUserId = mob_userpin;

      // Serial.println(doc["OTP"].as<String>());
      // String mobileOTP = doc["OTP"];
      // mobUserOtp = mobileOTP; 
      if(userPin.length() == 4 && userId.length() == 8 && userPin != "null" && userId != "null"){
        verifyGID_PIN();  
      }


      
    } 
    else {
      Serial.print("deserializeJson() returned ");
      Serial.println(err.c_str());
  
      while (Serial1.available() > 0)
        Serial1.read();
    }
  }
}



void verifyGID_PIN(){
  while( httpResponseCode != 200 ||  httpResponseCode != 400){
       if ((userId.length()==8) && (userPin.length()==4) && userPin != "null"){
        
        HTTPClient http;
        http.begin(serverName);
         String body = "{\"gooonjId\":\"" + userId+ "\",\"pin\":\"" + userPin + "\"}" ;
        http.addHeader("Content-Type", "application/json");
        
          httpResponseCode = http.POST(body);
          // hit++; }
            
            // delay(8000);
                  if(httpResponseCode>0){
            Serial.println(body);
              String response = http.getString(); 
              Serial.println(httpResponseCode);   //Print return code
              Serial.println(response);           //Print request answer
              JSONVar obj = JSON.parse(response);
              if (JSON.typeof(obj) == "undefined") {
                  Serial.println("Parsing input failed!");
                  
                }
                Serial.println("JSON object = ");
                Serial.println(obj);
                
                JSONVar keys = obj.keys();
                for (int i = 0; i < keys.length(); i++) {
                  JSONVar value = obj[keys[i]];
                  Serial.print(keys[i]);
                  Serial.print(" = ");
                  Serial.println(value);
                  
                }
            
            
            }
            else{
            
              Serial.print("Error on sending POST: ");
              Serial.println(httpResponseCode);
            
            }
            
            http.end();

              // delay(3000);
           userId ="";
             userPin="";
            digitalWrite(Null_maker,1);
            
             
            

            delay(100);

            digitalWrite(Null_maker,0);

    
     
      } 

  }
}


void mobiledataFromMega(){
  StaticJsonDocument<300> doc1;
  if (Serial1.available()) {

    DeserializationError err = deserializeJson(doc1, Serial1);

    if (err == DeserializationError::Ok) {

      // Serial.print("ID = ");
      // Serial.println(doc["ID"].as<String>());
      // String userid = doc["ID"];
      // userId = userid;

      // Serial.print("ID = ");
      // Serial.println(doc["PIN"].as<String>());
      // String userpin = doc["PIN"];
      // userPin = userpin;

      Serial.println(doc1["MID"].as<String>());
      String mob_userpin = doc1["MID"];
      mobUserId = mob_userpin;

      Serial.println(doc1["OTP"].as<String>());
      String mobileOTP = doc1["OTP"];
      mobUserOtp = mobileOTP;
            
    } 
    else {
      Serial.print("deserializeJson() returned ");
      Serial.println(err.c_str());
  
      while (Serial1.available() > 0)
        Serial1.read();
    }
  }
}

void wifi(){
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());
}