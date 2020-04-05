#include <SoftwareSerial.h>
#include <TinyGPS.h>
TinyGPS gps;
SoftwareSerial ss(2, 3);
int sensor= A0;
int led =13;

void setup()
{
  analogReference(DEFAULT);
  pinMode(sensor,INPUT);
  pinMode(led,OUTPUT);
  Serial.begin(9600);
  ss.begin(9600);
}
void loop()
{
  if(analogRead(sensor)<400 && analogRead(sensor)>200)
  {
    for(int j=0;j<150;j++)
      {
       digitalWrite(led, HIGH);
       delay(1000);
       digitalWrite(led, LOW);
       delay(1000); 
      }
      if(analogRead(sensor)<400 && analogRead(sensor)>200)
        {
          sms();
        }
  }
}

void sms()
{
  bool newData = false;
  unsigned long chars;
  unsigned short sentences, failed;
  for (unsigned long start = millis(); millis() - start < 1000;)
  {
    while (ss.available())
    {
      char c = ss.read();
      // Serial.write(c); // uncomment this line if you want to see the GPS data flowing
      if (gps.encode(c)) // Did a new valid sentence come in?
        newData = true;
    }
  }

  if (newData)
  {
    float flat, flon;
    int year;
    byte month, day, hour, minute, second, hundredths;
    unsigned long age;
    String bike_no = String("PY 01 GT 1005\n");
    gps.f_get_position(&flat, &flon, &age);
    String pos = String("Position:\nlat-" + String(flat,DEC) + "\nlong-" + String(flon,DEC));
    gps.crack_datetime(&year, &month, &day, &hour, &minute, &second, &hundredths, &age);
    String date = String("\nDate - " + String(day) + "/" + String(month) + "/" + String(year));
    String time = String("\nTime - " + String(hour) + ":" + String(minute) + ":" + String(second));
    String all = String(String(bike_no) + String(pos) + String(date) + String(time));
    Serial.print("\r");
    delay(1000);
    Serial.print("AT+CMGF=1\r");
    delay(1000);
    Serial.print("AT+CMGS=\"+919944503201\"\r"); //Number to which you want to send the sms
    delay(1000);
    Serial.print(all); //The text of the message to be sent
    delay(1000);
    Serial.write(0x1A);
    delay(1000);
        }
}
