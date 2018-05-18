
#include <NewPing.h>

#define trigPin1 12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define echoPin1 11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
#define trigPin2 10
#define echoPin2 6
int led = 9;
int brightness = 0;
int fadeAmount = 4;

NewPing sonar1(trigPin1, echoPin1, MAX_DISTANCE); // NewPing setup of pins and maximum distance.
NewPing sonar2(trigPin2, echoPin2, MAX_DISTANCE);

void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  pinMode(led, OUTPUT);
 
}

void loop() {
 
  analogWrite(led, brightness);
  
  delay(50);                     // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.

  unsigned int uS1 = sonar1.ping();
  unsigned int uS2 = sonar2.ping();
  unsigned int uS1RNDT = uS1 / US_ROUNDTRIP_CM;
  unsigned int uS2RNDT = uS2 / US_ROUNDTRIP_CM;
  if(uS1RNDT == 0){
    
  }
  else{
  Serial.print("US1:");
  Serial.println(uS1RNDT); // Send ping, get distance in cm and print result (0 = outside set distance range)
 
  if((uS1RNDT < 70) && (uS1RNDT > 2)){
     if(brightness >= 245){
       brightness = 255;
     } else {
       brightness = brightness + fadeAmount;
     }
  }else if(uS1RNDT > 70){
     if( brightness <= 10 ){
       brightness = 0;
     } else {
      brightness =  brightness - fadeAmount;
     }
  }
  }
  if(uS2RNDT == 0){
  
  }
  else{
  Serial.print("US2:");
  Serial.println(uS2RNDT);
  }

 
}
