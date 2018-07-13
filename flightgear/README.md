# TF-G1 autogyro flightgear simulator model

Model vírníku TF-G1 pro simulátor flightgear.  Je určen k neletovému testování letových konfigurací, misí a změn. 

![Flightgear simulator in action](./docs/img/fly2.png "Flightgear simulator in action")

## Instalace a použití

### Linux
Složka TF-G1 obsahuje komletní model. Instalace do simulátoru se provede zkopírováním složky mezi ostatní modely Flightgearu. V OS Linux je tato složka umístěna na adrese: /usr/share/games/flightgear/Aircraft/

K instalaci modelu lze použít i simlink do naklonovaného repozitáře.  Flightgear ale v základním nastavení neprochází simlinky, proto je to potřeba povolit parametrem ''--allow-nasal-read'', podle následujícího příkladu.

    fgfs --aircraft=TF-G1 --disable-terrasync --disable-random-objects --disable-real-weather-fetch --allow-nasal-read=/usr/share/games/flightgear/Aircraft/TF-G1/Models/Liveries --timeofday=noon


### Windows

Ve Windows je model potřeba zkopírovat do odpovídající složky mezi modely letadel. 








