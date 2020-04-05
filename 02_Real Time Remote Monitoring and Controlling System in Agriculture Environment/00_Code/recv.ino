#include <LiquidCrystal.h>
LiquidCrystal lcd(12,11,5,4,3,2);
int led=13;


void setup() 
{
  lcd.begin(16,2);
  Serial.begin(9600);
  pinMode(led,OUTPUT);
}

void loop() 
{
if (Serial.available())
{
  clear.lcd();
  lcd.setCursor(0,0);
  lcd.print("Foot Pressure:");
  while (Serial.available() > 0)
  {
      lcd.setCursor(0,1);
      lcd.println(Serial.read());
      if(Serial.read()>200)
    {
    digitalWrite(led,HIGH);
    delay(100);
    }
    else
    {
    digitalWrite(led,LOW);
    delay(100);
    }
      
    }
  }
    delay(100);

    Serial.flush();
  
   
  }
