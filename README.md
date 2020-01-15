# TF-G1 UAV autogyro

![TF-G1 in flight](./docs/img/TF-G1_flight.JPG "TF-G1 autogyro in flight during testing")

![TF-G1 porototype](./docs/img/TF-G1_runway.JPG "TF-G1 autogyro sitting on the test runway")

The TF-G1 autogyro created by ThunderFly s.r.o. is a [unmanned aerial vehicle (UAV)](https://en.wikipedia.org/wiki/Unmanned_aerial_vehicle) designed to be operable in almost any weather. 
The main features of that design are:

  * Weather insensitive operation
  * High safety due to stable autorotation mode which does not require autopilot or pilot attention
  * Greater altitude and area coverage than existing UAV designs  like multi-copters or helicopters
  * Absence of [downwash](https://en.wikipedia.org/wiki/Downwash), therefore a minimal occurence of [Brownout](https://en.wikipedia.org/wiki/Brownout_(aeronautics))
  * High descent rates
  * Ability to enter and return into the fail-safe mode (stable autorotation)

The benefits which come of this feature set are usability of application where the system could be potentially damaged, although the safety must retain as high as possible.  The example of this applications is searching and rescue missions in the harsh weather unflyable by conventional aircraft. 

## Build
Most of the components are coded in OpenSCAD. To render all components run following commands in Linux CLI: 

    sudo pip install stlsort

    sudo apt install python3-numpy-stl

    make 

The design files and related documents are covered by [GNU GENERAL PUBLIC LICENSE Version 3](https://www.gnu.org/licenses/gpl-3.0.en.html)

For additional information contact ThunderFly s.r.o. representative at info@thunderfly.cz
