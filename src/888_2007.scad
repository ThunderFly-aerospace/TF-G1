include <../Parameters.scad>

g2_7_length = 35;
module 888_2007(draft = true){
    translate([0, main_tube_outer_diameter/2, 0]) difference(){
        union(){
            hull(){
                translate([0,0,0])
                    rotate([90, 0,0])
                        cylinder(d=1.75*608_bearing_outer_diameter, h=main_tube_outer_diameter, $fn=draft?50:100);
                translate([g2_7_length,-main_tube_outer_diameter, -608_bearing_outer_diameter])
                        cube([1, main_tube_outer_diameter, 2*608_bearing_outer_diameter-2]);
            }
            hull(){
                translate([g2_7_length, -main_tube_outer_diameter/2, 0])
                    rotate([0, 90, 0])
                        cylinder(d=70, h=5, $fn=draft?50:100);
                translate([g2_7_length-2*M4_nut_height, -main_tube_outer_diameter/2-30 , -5])
                        cube([0.1, 60, 10]);
            }
       }
        
        rotate([90, 0, 0])
            cylinder(h=main_tube_outer_diameter, d=608_bearing_outer_diameter-6, $fn=draft?50:100);
        rotate([90, 0, 0])
            cylinder(h=608_bearing_thickness, d=608_bearing_outer_diameter, $fn=draft?50:100);
        translate([0, -main_tube_outer_diameter+608_bearing_thickness, 0])
            rotate([90, 0, 0])
                cylinder(h=608_bearing_thickness, d=608_bearing_outer_diameter, $fn=draft?50:100);
    
        // diry pro srouby do podlozky
            
            translate([g2_7_length-M4_nut_diameter, -main_tube_outer_diameter/2 - 46/2, 0]){
                rotate([0, 90, 0]) cylinder(d= M4_screw_diameter, h=10, $fn=draft?50:100);
                rotate([0, 90, 0]) cylinder(d= M4_nut_diameter, h=M4_nut_height, $fn=6);
            }
            translate([g2_7_length-M4_nut_diameter, -main_tube_outer_diameter/2 + 46/2, 0]){
                rotate([0, 90, 0]) cylinder(d= M4_screw_diameter, h=10, $fn=draft?50:100);
                rotate([0, 90, 0]) cylinder(d= M4_nut_diameter, h=M4_nut_height, $fn=6);
            }


    }

}
888_2007();