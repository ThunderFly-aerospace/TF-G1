draft = true;

use <./lib/naca4.scad>
include <../Parameters.scad>

use <888_2001.scad>
use <888_2002.scad>
use <888_2003.scad>
use <888_2004.scad>
use <888_2005.scad>
use <888_2006.scad>
use <888_2007.scad>


difference(){
    union(){

       color([0.8, 0.2, 0.2, 0.7])  translate([0,0,-25.8-2]) 888_2004();
        color([0.2, 0.8, 0.2, 0.3]) translate([0,0,-25.8-2]) 888_2004_drillhelper();
        translate([0,0,-25.8-2]) rotate([180,0,-90]) 888_2002();

        888_2005();
        rotate([0,0,180]) 888_2006();
        
        888_2007():
    }
translate([-200, 0, -100]) cube(200);    
}