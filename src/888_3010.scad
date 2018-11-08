include <../Parameters.scad>


module 888_3010(draft = true){
    translate([0, 0, 0]) difference(){
       cylinder(d=70, h=15);
    
        translate([0, -46/2, 0]){
            cylinder(d= M4_screw_diameter, h=20, $fn=draft?50:100);
            cylinder(d= M4_nut_diameter, h=M4_nut_height+3, $fn=6);
        }
        translate([0,  46/2, 0]){
            cylinder(d= M4_screw_diameter, h=20, $fn=draft?50:100);
            cylinder(d= M4_nut_diameter, h=M4_nut_height+3, $fn=6);
        }

        translate([0,0,7]){
        	cylinder(h=15-6.5, d1=15, d2=30);
        }
        //translate([0,0,4]){
        //	cylinder(h=20, d=M5_nut_diameter, $fn=6);
        //}
        translate([0,0,-0.1]){
        	cylinder(d=M5_screw_diameter, h=30);
        }
    }
}
888_3010();