#include <LiquidCrystal.h> // lcd display header 
#include <SoftwareSerial.h>  //configuring software serial
#include <string.h> 
#include <ctype.h>
SoftwareSerial Gsm(2, 3);  // assigining software serial rx and tx pin
LiquidCrystal lcd(1#include <LiquidCrystal.h>
#include <SoftwareSerial.h>
#include <TinyGPS.h>
long  lat,lon;
SoftwareSerial ss(2, 3);
TinyGPS gps;
int modem_power_led = 13;
int warning_led = 12;
int ignitor_relay = 11;
int smoke_sensor = A0;
LiquidCrystal lcd(5, 6, 7, 8, 9, 10);
float flat, flon;
int year;
byte month, day, hour, minute, second, hundredths;
unsigned long age;

void setup()
{
  Serial.begin(9600); // connect serial
  gpsSerial.begin(9600); // connect gps sensor
  pinMode(modem_power_led, OUTPUT);
  pinMode(warning_led, OUTPUT);
  pinMode(ignitor_relay, OUTPUT);
  lcd.begin(16,2);
  lcd.setCursor(0,0);
  lcd.print("    WELCOME     ");
  delay(2000);
  lcd.print("    CO DETECTOR    ");
  delay(20000);
}


void Nowarning()
{
   bool newData = false;
  unsigned long chars;
  unsigned short sentences, failed;
  for (unsigned long start = millis(); millis() - start < 1000;)
  {
    while (ss.available())
    {
      char c = ss.read();
      if (gps.encode(c))
      newData = true;
    }
  }

  if (newData)
  {
  lcd.setCursor(0,1);
  gps.encode(gpsSerial.read());
  gps.crack_datetime(&year, &month, &day, &hour, &minute, &second, &hundredths, &age);
  String date = String( String(day) + "/" + String(month) + "/" + String(year));
  String time = String( String(hour) + ":" + String(minute) + ":" + String(second));
  String lcd0 = String(String(date) + String (time));
  lcd.print(lcd0);
  delay(1000);
}



void Warning()
{
  sms();
  ledwarning();
  ign();
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
      if (gps.encode(c))
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
 
 
void ledwarning();
{   
 for(int p=0; p<=30; p++)
  { 
   digitalWrite(warning_led, HIGH);
   delay(1000);
   digitalWrite(warning_led, LOW);
   delay(1000);
  }
   break;
}

void ign()
{
  digitalWrite(ignitor_relay, HIGH);
  lcd.setCursor(16,0);
  lcd.autoscroll();
  lcd.print("Contact Helpline");
  lcd.setCursor(16,1);
  lcd.print("0413 2264789");
}

void loop()
{
    if(analogRead(smoke_sensor)>700)
  {
    Nowarning();
  }
  else
  {
    Warning();
  }
}
2, 11, 7, 6, 5, 4); //assigining pins for register select, enable, D0-D4 for LCD

float Sensor = A0; //reading analog value from temperature sensor at PIN
int j=0;
int k=0;
int soundPin = 13; //led pin
String writeParam ="";
int rxPin = 0;                    // RX PIN  
int txPin = 1;                    // TX TX 
int byteGPS=-1; 
char linea[300] = ""; 
char comandoGPR[7] = "$GPRMC"; 
int cont=0; 
int bien=0; 
int conta=0; 
int indices[13];
int BYTE;

void setup()
{
  pinMode(soundPin, OUTPUT);       // Initialize LED pin   
  pinMode(rxPin, INPUT);   
  pinMode(txPin, OUTPUT);
  Serial.begin(4800);
  for (int i=0;i<300;i++)
    {                         // Initialize a buffer for received data     
      linea[i]=' ';   
     } 
  Gsm.begin(9600);
  analogReference(DEFAULT);
  lcd.begin(16, 2);
  lcd.print("    WELCOME ");
  delay(2000);
  lcd.setCursor(0,0);
  lcd.print("    ALLERT  ");
  delay(5000);  
}
void loop()
{ 
digitalWrite(soundPin, HIGH);   
byteGPS=Serial.read();         // Read a byte of the serial port   
if (byteGPS == -1) 
{           // See if the port is empty yet     
delay(100);    
} 
else 
{     // note: there is a potential buffer overflow here!     
linea[conta]=byteGPS;        // If there is serial port data, it is put in the buffer     
conta++;                           
Serial.print(byteGPS, BYTE); 
if (byteGPS==13)
{            // If the received byte is = to 13, end of transmission       
// note: the actual end of transmission is <CR><LF> (i.e. 0x13 0x10)       
digitalWrite(soundPin, LOW);        
cont=0;       
bien=0;       // The following for loop starts at 1, because this code is clowny and the first byte is the <LF> (0x10) from the previous transmission.       
for (int i=1;i<7;i++)
{     // Verifies if the received command starts with $GPR         
if (linea[i]==comandoGPR[i-1])
{           
bien++;         
}      
}       
if(bien==6)
{               // If yes, continue and process the data        
for (int i=0;i<300;i++)
{           
if (linea[i]==',')
{    // check for the position of the  "," separator             
// note: again, there is a potential buffer overflow here!             
indices[cont]=i;             
cont++;         
}          
if (linea[i]=='*')
{    // ... and the "*"         
indices[12]=i;          
cont++;         
}      
}       
Serial.println("");      // ... and write to the serial port      
Serial.println("");    
Serial.println("---------------");  
for (int i=0;i<12;i++)
{        
  switch(i)
{           
case 0 :Serial.print("Time in UTC (HhMmSs): ");break;             
case 1 :Serial.print("Status (A=OK,V=KO): ");break;
case 2 :Serial.print("Latitude: ");break; 
case 3 :Serial.print("Direction (N/S): ");break;  
case 4 :Serial.print("Longitude: ");break;     
case 5 :Serial.print("Direction (E/W): ");break; 
}          
for (int j=indices[i];j<(indices[i+1]-1);j++)
{            
  Serial.print(linea[j+1]);       
}           Serial.println("");       
}         Serial.println("---------------"); 
}       conta=0;                    // Reset the buffer  
for (int i=0;i<300;i++)
{        
linea[i]=' '; 
sendSMS();
}                    
}
}
} 

void sendSMS()
{
  if(k==0)
  {
    Serial.print("AT+CMGF=1\r");                                                        // AT command to send SMS message
    delay(100);
    Serial.println("AT + CMGS = \"9600648204\"");                                     // recipient's mobile number
    delay(100);
    String intro = String("customer name \r");
    delay(100);
    Serial.println((char)26);                       // End AT command with a ^Z, ASCII code 26
    delay(100);
    Serial.println();
    delay(5000);
  }
   k++; 
}
