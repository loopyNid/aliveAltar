
#include <NewPing.h>

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 300 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
int led = 9;
int brightness = 0;
int fadeAmount = 4;




NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  pinMode(led, OUTPUT);
}

void loop() {
  analogWrite(led, brightness);
  delay(50);                     // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  Serial.print("Ping: ");
  Serial.print(sonar.ping_cm()); // Send ping, get distance in cm and print result (0 = outside set distance range)
  Serial.println("cm");

  if( sonar.ping_cm() < 70 && sonar.ping_cm() > 2){
    if(brightness >= 255){
      brightness = 255;
    } else {
      brightness = brightness + fadeAmount;
    }
  }else if( sonar.ping_cm() >70) {
    if( brightness <= 0 ){
      brightness = 0;
    } else {
    brightness =  brightness - fadeAmount;
    } 
  }
  
 
}
