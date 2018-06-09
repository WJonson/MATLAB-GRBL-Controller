# MATLAB GRBL Controller


A GRBL Gcode sender for MATLAB! This project was created for a Mechatronics class and because there are no MATLAB GRBL controllers online yet. Our goal for the GUI was to provide much of the same functionality as the other GRBL controllers out there, as well as, add additional functions specific for our project. Users can draw circles, squares, write text, and read Gcode .txt files.   

## Getting Started

We won't cover the mechanical aspects of the project and will just list some of the core components used. MATLAB is needed to run the app and functions, and if you want to edit the app you need to have a version that has "APP DESIGNER" as well. Lastly, this project uses the machine as a plotter with a pen, therefore, GRBL needs to be modded to work with one. Under "software" we listed an instructable page that goes over how to mod GRBL for this.

### Prerequisites

Software:
  - MATLAB with "APP Designer"
  - GRBL 1.1 modded for XY Plotter
     http://www.instructables.com/id/How-to-Control-a-Servo-Using-GRBL/

Hardware:
  - Arduino UNO with GRBL
  - 2 Stepper Motors and 1 Mirco Servo
  - 2 Stepper Motor Drivers
  - External Power Source
  - Linear Rails
  - (Optional) Arduino Motor Shield

```
Our Hardware:
  - KEYSTUDIO Arduino UNO w/ Arduino CNC Shield v3
  - 2 A4988 Stepper Motor Drivers
     https://www.amazon.com/gp/product/B016O7TD6O/ref=oh_aui_detailpage_o04_s00?ie=UTF8&psc=1
  - 2 Beauty Star NEMA 17, 1.8 Deg, 40 N.cm Stepper Motors
     https://www.amazon.com/gp/product/B0716S32G4/ref=oh_aui_detailpage_o06_s00?ie=UTF8&psc=1
  - 1 Tower Pro SG90 Mirco Servo
     https://www.amazon.com/TowerPro-Micro-Airplane-Helicopter-Controls/dp/B01J477UHU/ref=sr_1_1?ie=UTF8&qid=1528511710&sr=8-1&keywords=tower+pro+sg90
  - External Power Source (Used PSU from school)
  - Spare Linear Rails lying around
```

### Installing

After downloading the files, be sure to place all of the functions in the same directory. The "LETTER GCODE" file must be placed in this directory as well. To run the GUI click on the following .mlapp file.

```
GRBL_Controller.mlapp
```

## How to Use

### Machine Control
This tab is used to setup GRBL. The user can enter the COM port that the Arudino is connected to and connect/disconnect from it.

As of the initial release: Only "Unlock", "Homming", and "Return to Zero" are functioning as well as the "COMM Port" functions.

Example of COMM Port Entry:
```
COMM Port:  'COM8'
```

### Draw Circle
The user can draw a circle of any radius and place its center anywhere (within the limits of the machine). The inputs for all three properties MUST be in MILIMETERS. Once the properties are inputted, click "Draw Circle" to create the Gcode .txt file and send it to the Arduino.

Example
```
Circle Radius: 30
X-Center: 50
Y-Center: 50
```

Gcode Output File Name:
```
gcode_G02circle.txt
```

Main Function:
```
G02plotCircle.m
```

### Draw Square
The user can draw a square of any length for the sides and place it anywhere (within the limits of the machine). The inputs for all three properties MUST be in MILIMETERS. Once the properties are inputted, click "Draw Square" to create the Gcode .txt file and send it to the Arduino.

Example
```
Sides Length: 10
X-Start: 100
Y-Start: 20
```

Gcode Output File Name:
```
gcode_Square.txt
```

Main Function:
```
plotSquare.m
```

### Write Text
We wanted to the user to be able to write any text they desired and place it anywhere (again within the limits of the machine). The user enters text at the "Enter Text" area which can include:

```
Letters A-Z (Capitals only)
Numbers 0-9
Symbols !, @, #, %, ?
Spaces
```
As of the initial release: Enter all letters CAPATALIZED

Word Start(X-Axis) and Word Start(Y-Axis) (in Milimeters) determines where the first letter will begin. Each character is approximately 16.7 mm tall and about 5 mm wide. Once all paratmers are set, click "Write" to generate the Gcode and send it to the Arduino.

Example
```
Word Start(X-Axis): 200
Word Start(Y-Axis): 70
Enter Text: HELLO WORLD!
```

Gcode Output File Name:
```
gcode_TEXT.txt
```

Main Function:
```
writeText.m
```

### Draw Image
This function does not create any Gcode and only allows for pre-exsisting Gcode to be sent to the Gcode. The file must be of .txt format and listed in the current directory. Once the file is selected from the drop down menu, select "Send Gcode".

## Contributing

I hope that more people will take interest in this project so that MATLAB could have a reliable and functional GRBL controller. I have commented the functions 

## Authors

* **Wesley Jonson** - *Initial work* - [WJonson](https://github.com/WJonson)
* **Rex Congdon**   - *Mechanical work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Sergio Rivera Lavado - Created circuit_to_gcode.m function. I followed his approach to createing Gcode files in MATLAB.
	https://www.mathworks.com/matlabcentral/fileexchange/34965-circuit-to-gcode
* lingib - Created Instructable on how to use GRBL with a PEN
	http://www.instructables.com/id/How-to-Control-a-Servo-Using-GRBL/
* Mojtaba Azadi, Ph.D. - SFSU Mechatronics Instructor
