// Trubicka pro pouziti 8 mm lozisek KSTM a EFSM s M4 sroubem

include <../parameters.scad>
use <lib/igus.scad>

$fn = 50;

module 888_2014(){
    difference(){
        cylinder(d = M8_plug_diameter, h = 12-global_clearance);
        cylinder(d = M4_screw_diameter, h = 12);
    }
}

888_2014();
