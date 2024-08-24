
#include <Servo.h>
#define MIN_PULSE_LENGTH 1000 // Minimum pulse length in µs
#define MAX_PULSE_LENGTH 2000 // Maximum pulse length in µs

#define encoder 2
#define motor 3

unsigned int rpm;
volatile byte pulses;
unsigned long TIME;
unsigned int pulse_per_turn = 20;
unsigned int pwms[] = {1020,1030,1040,1050,1060,1070, 1080};
unsigned int pwmn = 10;
unsigned int sample =4;
int pwmcount = 0;
Servo motA; 
//depends on the number of slots on the slotted disc

void count(){
  // counting the number of pulses for calculation of rpm
  pulses++;
}
void setup(){
  //reset all to 0
  rpm = 0;
  pulses = 0;
  TIME = 0;

  Serial.begin(115200);
  pinMode(encoder, INPUT);// setting up encoder pin as input
  //triggering count function everytime the encoder turns from HIGH to LOW
  motA.attach(motor, MIN_PULSE_LENGTH, MAX_PULSE_LENGTH);
  motA.writeMicroseconds(MIN_PULSE_LENGTH);
  delay(10000);
  attachInterrupt(digitalPinToInterrupt(encoder), count, FALLING);
}

void loop(){
  if (pwmcount/sample==pwmn)pwmcount=0;
  if (pwmcount%sample==0) motA.writeMicroseconds(pwms[pwmcount/sample]); 
  if (millis() - TIME >= 1000){ // updating every 1 second
    
    detachInterrupt(digitalPinToInterrupt(encoder)); // turn off trigger
    //calcuate for rpm 
    rpm = (60 *1000 / pulse_per_turn)/ (millis() - TIME) * pulses;
    TIME = millis();
    pulses = 0;
    //print output 
    Serial.print("PWM: ");
    Serial.print(pwms[pwmcount/sample]);
    pwmcount++;
    Serial.print("RPM: ");
    Serial.println(rpm);
    //trigger count function everytime the encoder turns from HIGH to LOW
    attachInterrupt(digitalPinToInterrupt(encoder), count, FALLING);
  }
}
