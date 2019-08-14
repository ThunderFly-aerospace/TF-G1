use <./rotorhead_kardan_bottom_testpart.scad>
use <./rotorhead_kardan_centerpart.scad>
use <./rotorhead_kardan_top_testpart.scad>


rotorhead_kardan_bottom_testpart();
translate([0,0,15+3+5])
    rotate([180,0,0])
        rotorhead_kardan_center_part();
        
        
translate([0,0,15+17.5])
    rotate([180,0,0])
        rotorhead_kardan_top_testpart();