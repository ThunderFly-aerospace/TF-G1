//improving rendering speed.
draft = false;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fn = draft ? 50 : 200;
$fa = 10;

module 666_1018(draft){
    bearing_cage_outer_d = 35 + 0.4;
    wall = 2;
    ground_thickness = 1;
    bearing_cage_inner_d = 27;
    axis_d = 8 + 0.4;
   
   
   
   difference(){
      union(){
          difference(){
            cylinder(h = ground_thickness+wall, d = bearing_cage_outer_d + 2*wall);
            translate([0,0, ground_thickness]) cylinder(h = wall+global_clearance, d=bearing_cage_outer_d);
          }
          cylinder(h = 6, d1 = bearing_cage_inner_d, d2 = axis_d+2*wall);
      }
       cylinder(h= 6+global_clearance, d = axis_d);
       translate([0,0,-global_clearance]) cylinder(h= 1, d1 = axis_d+1, d2 = axis_d);
   } 
}


666_1018(draft);
include <../Parameters.scad>