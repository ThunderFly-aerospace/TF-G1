module 666_1033(){

    curvedPipe([[0,0,100],        //body ohybu
                [60,0,100],
                [130,0,0],
                [130,500,0],
                [60,500,100],
                [0,500,100],
               ],
                5,
                [20,20,20,20,20],     // radiusy
                10,
                8);
}
666_1033();

use <./lib/naca4.scad>
use <./lib/curvedPipe.scad>
include <../Parameters.scad>