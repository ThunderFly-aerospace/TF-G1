draft = true;

use <./lib/naca4.scad>
include <../Parameters.scad>


use <666_1027.scad>
use <888_1018.scad>

use <888_2002.scad>
use <888_2003.scad>
use <888_2004.scad>
use <888_2005.scad>
use <888_2006.scad>
use <888_2007.scad>


difference(){
    union(){
      color([0.1, 0.1, 0.1, 0.2])
        translate([70, 0, 0]){
            888_2005();
            rotate([0,0,180])
              888_2006();
        }

        //translate([70,0,-25.8])
        //  difference()
        //  {
        //      cylinder(h=150, d = main_tube_outer_diameter, $fn = 100);
        //      cylinder(h=150, d = main_tube_inner_diameter, $fn = 100);
        //  }
    }

    translate([-200, 0, -100])
        cube(200);
}
color([0.2, 0.4, 0.4, 0.5])
  translate([0,0,80])
    rotate([90,0,0])
        666_1027();

color([1, 0.6, 0.2, 1])
  translate([0,0,70])
    rotate([0,0,0]){
        888_1018();
        mirror([0,1,0])
            888_1018(draft);
    }
