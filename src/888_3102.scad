draft = true;

use <./lib/naca4.scad>
include <../Parameters.scad>


use <888_3000.scad>
use <888_3001.scad>
use <888_3002.scad>
use <888_3003.scad>
use <888_3004.scad>
use <888_3005.scad>
use <888_3006.scad>
use <888_3007.scad>
use <888_3008.scad>
use <888_3009.scad>

module licovany_sroub_m6(delka = 70){
    translate([0,0,(11-5.5)/2]) color([0,0,1]){
        cylinder(d=13, h=5.5);
        cylinder(d=8, h=5.5+delka);
        cylinder(d=6, h=5.5+delka+11);
    }
}

module 888_3102(){
    translate([0,0,0]) 888_3006();
    translate([0,0,78]) 888_3007();
    translate([0,0,77]) translate([150, 0, 0]) rotate([0,-90,0]) 888_3008();
    translate([0,0,-25]) 888_3009();

}
difference(){
888_3102();
cube(500);

}
