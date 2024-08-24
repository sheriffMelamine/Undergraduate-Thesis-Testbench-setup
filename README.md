#  Undergraduate-Thesis-Testbench-setup
##  Description
This project contains the necessary guidelines for hardware and software setup for using the testbench developed during the thesis work which is submitted to Mechanical Engineering Department of BUET under the title of **Enhancing Quadcopter Trajectory Tracking with Model Predictive Controller and Linear Quadratic Integral Controller Using Linear Parameter Varying Approach under Variable Disturbances**. Prospective users should follow this repository for understanding the thesis or using this testbench for their research.
##  Getting Started
###  Dependencies
*  Windows 10 or later versions
*  MATLAB 2022 or later versions
*  Arduino IDE
### Installing
*  Download and install Industrial Communication Toolbox in MATLAB for MQTT functionalities
*  Download and install [Eclipse mosquitto]( https://mosquitto.org/download/) (64-bit build)
*  Download [MQTT Explorer]( https://github.com/thomasnordquist/MQTT-Explorer/releases/download/v0.4.0-beta.6/MQTT-Explorer-0.4.0-beta.6.exe) 
*  Follow along [this tutorial]( https://iotcircuithub.com/esp8266-programming-arduino/) for setting up Arduino IDE for ESP01 (Hack: You can actually just short-circuit the RESET pin with GND instead of using a RESET Button)
*  Watch [this video](https://youtu.be/IDMMzxDV4PQ?si=-UPuiMfHLJFbvFbT) for setting up Windows Firewall so that MQTT can work
*  Copy the files in the [mosquitto]( https://github.com/sheriffMelamine/Undergraduate-Thesis-Testbench-setup/tree/main/mosquitto) directory and paste them in the mosquitto folder in Program-Files of your computer

##  How To Use the Files
### Setting up Sensors

*(On progress...)*

###  Usage of Testbench

**MQTT Credentials**  

MQTT Server: ```192.168.0.100```  
MQTT Username: ```aiferdous```  
MQTT Password: ```12341234```  

*You can change the MQTT credentials by updating the mosquitto.conf and passwd files that you pasted before. For doing that, you must update them using command prompt or edit the files, the details of which can by found in the website documentation of mosquitto or you can watch related YouTube videos.*

**WiFi Router Credentials**  

SSID: ```drone-testbench-thesis```  
Password: ```tbthesis```
*  Firstly, open command prompt and run the mosquitto server by running the command ```mosquitto```.
*  Power the testbench and the router. Check in MQTT Explorer if the topics are visible to your computer.
*  Then set the drone to its initial orientation of zero roll,pitch and yaw and run the [Encoder_data.m](https://github.com/sheriffMelamine/Undergraduate-Thesis-Testbench-setup/blob/main/wireless_setup/MATLAB%20Scripts/Encoder_data.m) script.
*  While the script is running, the encoder data will be automatically recorded. You can modify the value of the variable n to change the size of data you want to store before running it. The movement of the attached drone should take place during this period which is to be recorded.
*  After data is stored, run the [Calibrate.m](https://github.com/sheriffMelamine/Undergraduate-Thesis-Testbench-setup/blob/main/wireless_setup/MATLAB%20Scripts/Calibrate.m) script for post-processing the data for the calibrated output.
*  You can repeat the last previous three steps for as many takes you want for storing the data.

### PWM Calibration Files

*(On Progress...)*
##  Acknowledgements
*  [Department of Mechanical Engineering, BUET](https://me.buet.ac.bd/)
*  [Research and Innovation centre for Science and Engineering, BUET](https://rise.buet.ac.bd/#/)
