// Correr en Arduino IDE, seguir este link -> 
// https://www.circuitbasics.com/how-to-set-up-the-dht11-humidity-sensor-on-an-arduino/?fbclid=IwAR0y2C-RkUd0NE2oHNovG4evrQzV3PZTprS6Q1berOfZjEyEn6uk5G4kdr8

#include <dht.h>

dht DHT;
int time = 0;

#define DHT11_PIN 7 

void setup(){
  Serial.begin(9600);
}

void loop(){
  int chk = DHT.read11(DHT11_PIN);
  Serial.println( String(DHT.temperature) + ';' + String(DHT.humidity) + ';' + String(time) );
  delay(1000);
  time += 1;
  Serial.flush();
}
