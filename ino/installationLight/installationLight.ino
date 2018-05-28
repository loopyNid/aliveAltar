
#include <NewPing.h>

#define trigPin1 3 // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define echoPin1 2  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 400 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
#define trigPin2 5
#define echoPin2 4
#define trigPin3 11
#define echoPin3 10
#define trigPin4 13
#define echoPin4 12
int led = 9;
int brightness = 0;
int fadeAmount = 4;

NewPing sonar1(trigPin1, echoPin1, MAX_DISTANCE); // NewPing setup of pins and maximum distance.
NewPing sonar2(trigPin2, echoPin2, MAX_DISTANCE);
NewPing sonar3(trigPin3, echoPin3, MAX_DISTANCE);
NewPing sonar4(trigPin4, echoPin4, MAX_DISTANCE);

void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  pinMode(led, OUTPUT);
 
}

void loop() {

  analogWrite(led, brightness);
  
  delay(50);                     // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.

  unsigned int uS1 = sonar1.ping();
  unsigned int uS2 = sonar2.ping();
  unsigned int uS3 = sonar3.ping();
  unsigned int uS4 = sonar4.ping();
  unsigned int uS1RNDT = uS1 / US_ROUNDTRIP_CM;
  unsigned int uS2RNDT = uS2 / US_ROUNDTRIP_CM;
  unsigned int uS3RNDT = uS3 / US_ROUNDTRIP_CM;
  unsigned int uS4RNDT = uS4 / US_ROUNDTRIP_CM;
  //uS1
  if(uS1RNDT == 0){
    
  }
  else{
  Serial.print("US1:");
  Serial.println(uS1RNDT); // Send ping, get distance in cm and print result (0 = outside set distance range)
 
  if(((uS1RNDT < 70) && (uS1RNDT > 2)) || ((uS2RNDT < 70) && (uS2RNDT > 2))||((uS3RNDT < 70) && (uS3RNDT > 2)) || ((uS4RNDT < 70) && (uS4RNDT > 2))){
     if(brightness >= 245){
       brightness = 255;
     } else {
       brightness = brightness + fadeAmount;
     }
  }else if((uS1RNDT > 70) || (uS2RNDT > 70)|| (uS3RNDT > 70) || (uS4RNDT > 70)){
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
  if(uS3RNDT == 0){
  
  }
  else{
  Serial.print("US3:");
  Serial.println(uS3RNDT);
  
  }
   if(uS3RNDT == 0){
  
  }
  else{
  Serial.print("US4:");
  Serial.println(uS4RNDT);
  
  }

 
}
