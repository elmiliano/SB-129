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
