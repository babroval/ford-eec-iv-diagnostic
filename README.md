![Alt text](Ford_EEC-IV_scanner_app.png)
![Alt text](Ford_EEC-IV_scanner.png)

FORD EEC-IV diagnostic scanner
==============================
Java desktop project for diagnostic petrol multipoint injection for cars with 
Ford EEC-IV ECU(engine control unit).

The principle is, that commands from USB port converts by bridge CP2101 to UART0 port of AVR controller, and commands from other UART1 port of controller converts by transceiver 75ALS176 to Ford EEC-IV diagnostic port with Ford DCL communication standard which is the same as RS-485 standard with minor changes.
An usual USB-RS485 converter can't synchronize with ECU because of losing time for virtual COM port emulation, so controller, in this case, is like a "cache" or a "buffer".
 
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/babroval/ford-eec-iv-scanner/blob/master/LICENSE)
```
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>babroval.eec_iv</groupId>
  <artifactId>eec-iv</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <name>eec-iv</name>
  
  <dependencies> 
    <dependency>
      <groupId>org.scream3r</groupId>
      <artifactId>jssc</artifactId>
      <version>2.8.0</version>
    </dependency>
  </dependencies>
  
  <build>
    <sourceDirectory>src</sourceDirectory>
    <plugins>
      <plugin>
        <artifactId>maven-compiler-plugin</artifactId>
        <version>3.7.0</version>
        <configuration>
          <source>1.8</source>
          <target>1.8</target>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>
```
Table of Contents
-----------------
  * [Requirements](#requirements)
  * [Usage](#usage)
  * [Contributing](#contributing)
  * [License](#license)  

Requirements
------------
  The FORD EEC-IV scanner interface board can be made independently or a ready module can be found, for example:
  * [Crumb128][crumb128] V4.0
  <br/>The first part of the code for AVR controller was creating in Assembly language. The EEC-IV_asm file is a bit messy, so EEC-IV.hex for ATmega128 is included to write flash memory by any cheap analog of AVR programmer:
  * [AVRISP][avrisp]
  <br/>In this part everything can be done with:
  * [AVR Studio 4][avr].14.589
  * [JRE][jre] 8


Usage
-----
FORD EEC-IV scanner is easiest to use with [Eclipse IDE][eclipse]:  
File -> Import -> Git -> Projects From Git > URI

#### Error handling
All exceptions are converted into unchecked type to
keep code clean as possible.
<br/>
<br/>

Contributing
------------
To contribute to FORD EEC-IV scanner, clone this repo locally and  
commit your code on a separate branch.
<br/>
<br/>

License
-------
Self-Storage Unit is licensed under the [MIT][mit] license.  

[avrisp]: https://www.microchip.com/developmenttools/ProductDetails/atavrisp2
[crumb128]: https://www.chip45.com/products/crumb128-4.0_avr_atmega_module_board_atmega128_usb_rs485.php
[avr]: http://www.microchip.com/mplab/avr-support/avr-and-sam-downloads-archive
[jre]: http://www.oracle.com/technetwork/java/javase/downloads/
[eclipse]: https://www.eclipse.org/downloads/
[mit]: https://github.com/babroval/ford-eec-iv-scanner/blob/master/LICENSE/

