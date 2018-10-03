draft = true;

use <./lib/naca4.scad>
include <../Parameters.scad>


use <888_3007.scad>


module efsm_17(){
    hull(){
        for(i=[-1:1]){
            translate([i*bearing_efsm_17_m/2, i*bearing_efsm_17_m/2, 0])
                cylinder(h=bearing_efsm_17_a1, d=bearing_efsm_17_h-bearing_efsm_17_m, $fn=draft?50:100);
            translate([i*bearing_efsm_17_m/2, -i*bearing_efsm_17_m/2, 0])
                cylinder(h=bearing_efsm_17_a1, d=bearing_efsm_17_h-bearing_efsm_17_m, $fn=draft?50:100);
        }
    }
    cylinder(h=bearing_efsm_17_ag, d=bearing_efsm_17_db, $fn=draft?50:100);
}


difference(){
    union(){
        888_3007(draft);
        translate([0,0,g3_7_height/2-bearing_efsm_17_ag]) color("red") efsm_17();
    }
    translate([0,0,-100]) cube(200);
}