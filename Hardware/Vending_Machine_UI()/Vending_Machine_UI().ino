#include <Wire.h>
#include <Adafruit_SSD1306.h>
#include <Adafruit_GFX.h>

#define OLED_WIDTH 128
#define OLED_HEIGHT 64
const int yes = 15;
const int no = 2;

#define OLED_ADDR   0x3C

Adafruit_SSD1306 display(OLED_WIDTH, OLED_HEIGHT);

void setup() {
  display.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
  display.clearDisplay();

  pinMode(15,INPUT);
  pinMode(16,INPUT);
  Serial.begin(115200);
}

void loop() {
option();
display.clearDisplay();
}

void option(){
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
    mobile_user();
    Serial.println("mobile");
    return;
  }
  if (digitalRead(no) == 1){
     gooonj_card();
    Serial.println("Gooonj Card");
    delay(500);
    return;
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
  display.println("00113f5a");
  display.display();
  display.setCursor(22,45);
  display.println("Enter Password");
  display.setCursor(50,55);
  display.print("1546");
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
  display.println("00113f5a");
  display.display();
  display.setCursor(22,45);
  display.println("Enter Password");
  display.setCursor(50,55);
  display.print("1546");
  display.display();
  delay(500);  
}