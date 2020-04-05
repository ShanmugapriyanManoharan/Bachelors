
#include <LiquidCrystal.h> // lcd display header 
#include <SoftwareSerial.h>  //configuring software serial

SoftwareSerial ZIGBEE(2, 3);  // assigining software serial rx and tx pin
LiquidCrystal lcd(12, 11, 7, 6, 5, 4); //assigining pins for register select, enable, D0-D4 for LCD

float temperature = A1; //reading analog value from temperature sensor at PIN
int humidity = A2;
int ldr = A3;
int moisture = A4;
int i=0;

String writeParam ="";
void setup()
{
  Serial.begin(9600);
  ZIGBEE.begin(9600);
  analogReference(DEFAULT);
  lcd.begin(16, 2);
  lcd.print("    WELCOME ");
  delay(2000);
  lcd.setCursor(0,0);
  lcd.print("    SENSORS      ");
  delay(5000);  // give time to log on to network.
}

void sendSMS()
{
  Serial.print("AT+CMGF=1\r");                                                        // AT command to send SMS message
  delay(100);
  Serial.println("AT + CMGS = \"9944503201\"");                                     // recipient's mobile number
  delay(100);
  
  String intro = String("AGRICULTURE SMS\r");
  
  int temp_c = (analogRead(temperature)/3); // getting the value from TEMPERATURE SENSOR
  int temp_f = ((temp_c * 1.8) + 32);
  String a = String(temp_c, DEC);
  String a1 = String(temp_f, DEC);
  String t = String(String(intro)+ "Temperature : " + a + "C " + a1 + "F\r");
  
  int analog2 = (analogRead(humidity));  //geting the analog value form HUMIDITY SENSOR
  analog2 = map(analog2, 0, 1023, 0, 100);
  String b = String(analog2, DEC);
  String th = String(String(t)+ "Humidity : " + b + "%RH\r");
  
  int r1 = (analogRead(ldr));   //getting the analog value from LDR
  r1 = map(r1, 0, 1023, 0, 10);
  String c = String(r1, DEC);
  String thl = String(String(th) + "SunLight : " + c + "lux\r");
  
  int analog4 = (analogRead(moisture));   // getting the analog value from MOISTURE SENSOR
  analog4 = map(analog4, 0, 1023, 0, 10);
  String d = String(analog4, DEC);
  String thlm = String( String(thl) + "Moisture : " + d + "MC\r");
  
  if(analog4 > 7)
  { 
    String m = ("ON");
    String sens = String(String(thlm) + "MOTOR : " + String(m));
    Serial.println(sens);        // message to send
    delay(100);
    Serial.println((char)26);                       // End AT command with a ^Z, ASCII code 26
    delay(100);
    Serial.println();
    delay(5000);                                     // give module time to send SMS                                
  }
  else 
  {
    String m = ("OFF");
    String sens = String(String(thlm) + "MOTOR : " + String(m));
    Serial.println(sens);        // message to send
    delay(100);
    Serial.println((char)26);                       // End AT command with a ^Z, ASCII code 26
    delay(100);
    Serial.println();
    delay(5000);                                     // give module time to send SMS                                
  }
}

void loop()
{
  int temp_c = (analogRead(temperature)/3);
  int temp_f = ((temp_c * 1.8) + 32);
  lcd.setCursor(0, 1);
  lcd.print("Temp :");
  lcd.print(temp_c);
  lcd.print("\337C ");
  lcd.print(temp_f);
  lcd.print("\337F");
  delay(2000);
  
  lcd.setCursor(0,1);
  lcd.print("Humidity :");
  int analog2 = (analogRead(humidity));
  analog2 = map(analog2, 0, 1023, 0, 100);
  lcd.print(analog2);
  lcd.print("% RH     ");
  delay(2000);
  
  lcd.setCursor(0,1);
  lcd.print("LDR:");

  int r1 = (analogRead(ldr));
  r1 = map(r1, 0, 1023, 0, 10);
  lcd.print(r1);
  lcd.print("lux        ");
  delay(2000);
 
  lcd.setCursor(0,1);
  lcd.print("Moisture:");
  int analog4 = (analogRead(moisture));
  analog4 = map(analog4, 0, 1023, 0, 10);
  lcd.print(analog4);
  lcd.print("MC      ");
  delay(2000);
  
  //sending SMS
     if(i == 7)
     {sendSMS();
     i=0;}
    i++;
    
  
  //Motor Controlling
  if(analog4 > 7)
  {
    ZIGBEE.println('1');
  }
  else
  {
    ZIGBEE.println('0');
  }
 
  //Light controlled
  if(r1 < 1)
    {
      ZIGBEE.println('9');
    }
   if(r1 > 6)
    {
      ZIGBEE.println('8');
    }
  
}
