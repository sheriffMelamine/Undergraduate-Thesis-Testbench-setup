#include <Wire.h>
#include <ESP8266WiFi.h> 
#include <PubSubClient.h>

#define SDA 0
#define SCL 2

int magstat;
int lowbyte;
word highbyte;
int rawAngle;
double degAngle;
String msgStr = "";
unsigned long first = 0;

const char* ssid = "drone-testbench-thesis";
const char* password = "tbthesis";
const char* mqttServer = "192.168.0.100";
const char* mqttUserName = "aiferdous";
const char* mqttPwd = "12341234";  
const char* clientID = "username0001"; 
const char* topic = "Pitch/angle";	//Edit topic name according to the position of joint. Possible options: "Pitch/angle","Yaw/angle","Roll/angle"

WiFiClient espClient;
PubSubClient client(espClient);

void setup_wifi() {
  delay(10);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());

}

void reconnect() {
  while (!client.connected()) {
    if (client.connect(clientID, mqttUserName, mqttPwd)) {
      Serial.println("MQTT connected");
     
    }
    else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);  // wait 5sec and retry
    }

  }

}

void setup() {

  Serial.begin(115200);
  Wire.begin(SCL,SDA);
  
  setup_wifi();
  client.setServer(mqttServer, 1883);
  
}
 
void loop() {
  while (WiFi.status() != WL_CONNECTED){
    Serial.print(".");
    delay(1000);
  }
  if (!client.connected()) { 
    reconnect(); 
  }
  client.loop();
  if(first==0)
    first=millis();

  Wire.beginTransmission(0x36); 
  Wire.write(0x0B); 
  Wire.endTransmission(); 
  Wire.requestFrom(0x36, 1); 
  
  while(Wire.available() == 0); 
  magstat = Wire.read(); 
  
  Wire.beginTransmission(0x36); 
  Wire.write(0x0D); 
  Wire.endTransmission(); 
  Wire.requestFrom(0x36, 1); 
  
  while(Wire.available() == 0); 
  lowbyte = Wire.read(); 
 
  Wire.beginTransmission(0x36);
  Wire.write(0x0C); 
  Wire.endTransmission();
  Wire.requestFrom(0x36, 1);
  
  while(Wire.available() == 0);  
  highbyte = Wire.read();
  highbyte = highbyte << 8; 
  rawAngle = highbyte | lowbyte; 

  degAngle = rawAngle * 0.087890625;
  

   msgStr = "{\"angle\" :" + String(degAngle) + ",\"time\":"+String(millis()-first)+",\"magstatus\":"+(magstat==55?"\"Perfect\"":magstat!=39?"\"Out of reach\"":"\"Too close\"")+"}";
   Serial.println(msgStr);
   byte arrSize = msgStr.length() + 1;
   char msg[arrSize];
   msgStr.toCharArray(msg, arrSize);
   client.publish(topic, msg);
   delay(125);
}
