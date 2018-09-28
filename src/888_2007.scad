include <../Parameters.scad>

g2_7_length = 50;
module 888_2007(draft = true){
    difference(){
        union(){
            translate([0,0,0])
                rotate([90, 0,0])
                    cylinder(d=2*608_bearing_outer_diameter, h=main_tube_outer_diameter);
            translate([0,-main_tube_outer_diameter, -608_bearing_outer_diameter])
                    cube([g2_7_length, main_tube_outer_diameter, 2*608_bearing_outer_diameter]);
        }
        
        rotate([90, 0, 0])
            cylinder(h=main_tube_outer_diameter, d=M8_screw_diameter, $fn=draft?50:100);
        rotate([90, 0, 0])
            cylinder(h=608_bearing_thickness, d=608_bearing_outer_diameter, $fn=draft?50:100);
        translate([0, -main_tube_outer_diameter+608_bearing_thickness, 0])
            rotate([90, 0, 0])
                cylinder(h=608_bearing_thickness, d=608_bearing_outer_diameter, $fn=draft?50:100);
    }

}
888_2007();