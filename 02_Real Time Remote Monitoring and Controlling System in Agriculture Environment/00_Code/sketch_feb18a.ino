int x=A0;
int y=A1;

void setup()
{
  Serial.begin(9600);
  analogReference(DEFAULT);
  pinMode(x,INPUT);
  pinMode(y,INPUT);
}

void loop()
{
  Serial.print("Sensor: X=");
  Serial.print(analogRead(x));
  Serial.print(" Y=");
  Serial.print(analogRead(y));
  Serial.println(" ");
  delay(200);
}
