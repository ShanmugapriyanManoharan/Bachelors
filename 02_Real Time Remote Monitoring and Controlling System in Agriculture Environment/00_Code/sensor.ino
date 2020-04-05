#include <LiquidCrystal.h>

  int  sensorValue=0;
  long outputValue=0;
void setup() {
pinMode(A0,INPUT);
  pinMode(9,OUTPUT);
  Serial.begin(9600);

// put your setup code here, to run once:

}

void loop() {
  
  sensorValue=analogRead(A0);
  outputValue=map(sensorValue,0,1023,0,255);
  Serial.println(outputValue);
  delay(100);
  if(outputValue>100)
  {
    digitalWrite(9,HIGH);
    delay(3000);
  }
    else
    {
    digitalWrite(9,LOW);
    delay(100);
  }
  
  // put your main code here, to run repeatedly:

}
