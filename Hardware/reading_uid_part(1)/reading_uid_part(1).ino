#include <SPI.h>
#include <MFRC522.h>
 
#define SS_PIN 21
#define RST_PIN 22
MFRC522 mfrc522(SS_PIN, RST_PIN); 
 
void setup() 
{
  Serial.begin(115200);
  SPI.begin(); 
  mfrc522.PCD_Init();
  Serial.println("Approximate your card to the reader...");
  Serial.println();

}
void loop() 
{
  if ( ! mfrc522.PICC_IsNewCardPresent()) 
  {
    return;
  }
  if ( ! mfrc522.PICC_ReadCardSerial()) 
  {
    return;
  }
  Serial.print("UID tag :");
  String content= "";
  byte letter;
  for (byte i = 0; i < mfrc522.uid.size; i++) 
  {
     Serial.print(mfrc522.uid.uidByte[i], HEX);
  }
  Serial.println();
} 