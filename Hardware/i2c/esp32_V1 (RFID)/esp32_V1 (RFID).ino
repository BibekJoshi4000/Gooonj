#define RX_ESP_1 3
#define TX_ESP_1 1
void setup() {
  Serial.begin(115200);
  Serial2.begin(9600, SERIAL_8N1, RX_ESP_1, TX_ESP_1);

}

void loop() {
  Serial.print("data = ");
  Serial.println(Serial2.readString());
delay(200);
}
