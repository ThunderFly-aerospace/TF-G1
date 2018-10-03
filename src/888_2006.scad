include <../Parameters.scad>



module 888_2006(draft = true){
    radius=main_tube_outer_diameter/2;
    
    difference(){
        union(){
            intersection(){
                translate([g2_0_part_space/2, -g2_5_width/2, 0])
                    cube([g2_5_front_l-g2_0_part_space/2, g2_5_width, g2_5_height]);
                cylinder(d=g2_5_width, h=g2_5_height, $fn=draft?50:100);
            }
            hull(){
                
                intersection(){
                    translate([g2_0_part_space/2, -g2_5_width/2, 0])
                        cube([g2_5_front_l-g2_0_part_space/2, g2_5_width, g2_5_height]);
                    cylinder(d=g2_5_width, h=g2_6_plate_thickness, $fn=draft?50:100);
                }
                translate([g2_0_part_space/2, -g2_5_width/2, 0])
                    cube([g2_0_part_space/2, g2_5_width, g2_6_plate_thickness]);
                
                intersection(){
                   translate([g2_0_part_space/2, -100, 0]) cube(200);
        
                    rotate([0, 0, 45])
                        translate([g2_6_servo_distance-servo_20kg_body_y/2-g2_6_min_wall_around, servo_20kg_axis_offset-servo_20kg_body_x/2-g2_6_min_wall_around+g2_6_servo_shift, 0])
                            cube([servo_20kg_body_y+2*g2_6_min_wall_around, servo_20kg_body_x+2*g2_6_min_wall_around, g2_6_plate_thickness]);
                }
               
            }
        }
    
        translate([0,0,-global_clearance/2])
            cylinder(r=radius, h=g2_5_height+global_clearance, $fn=draft?50:100);
        
        for(i=[-1,1]){
            translate([0, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                    cylinder(h=g2_5_m3_length/2+5, d=M3_screw_diameter, $fn=draft?50:100);
            // tvar matice
            translate([g2_5_m3_length/2-5, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                        cylinder(h=M3_nut_height+30, d=M3_nut_diameter, $fn=draft?50:100);
        }
        
        bolts = g2_0_vertical_bolts;
        for(i=[1:bolts]){
            translate([0, 0, i*g2_5_height/(bolts+1)])
                rotate([0, 90, 0])
                    cylinder(h=g2_5_m3_length/2+5, d=M3_screw_diameter, $fn=draft?50:100);
            // tvar matice
            translate([g2_5_m3_length/2-5, 0, i*g2_5_height/(bolts+1)])
                rotate([0, 90, 0])
                        cylinder(h=M3_nut_height+30, d=M3_nut_diameter, $fn=draft?50:100);
        }
        
        
        
        
        rotate([0, 0, 45]) translate([g2_6_servo_distance, servo_20kg_axis_offset-g2_6_servo_shift, 0])
            #union(){ // tato union je model serva
                translate([-servo_20kg_body_y/2, -servo_20kg_body_x/2, -servo_20kg_body_below])
                    cube([servo_20kg_body_y, servo_20kg_body_x, servo_20kg_body_z]);
        
                translate([0, servo_20kg_axis_offset, -servo_20kg_below])
                    cylinder(d = 5, h=servo_20kg_below);
                
                translate([0, -1+servo_20kg_axis_offset, -servo_20kg_below])
                    //cube([15, 2 , 1]);
                    cylinder(r=15, h=1);
                
                translate([servo_20kg_thread_y, servo_20kg_thread_x, 0])
                    cylinder(h=5, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([servo_20kg_thread_y, -servo_20kg_thread_x, 0])
                    cylinder(h=5, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([-servo_20kg_thread_y, servo_20kg_thread_x, 0])
                    cylinder(h=5, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([-servo_20kg_thread_y, -servo_20kg_thread_x, 0])
                    cylinder(h=5, d=servo_20kg_bolt_d, $fn=draft?50:100);
                
                translate([servo_20kg_thread_y, servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=5, d=servo_20kg_nut_d, $fn=6);
                translate([servo_20kg_thread_y, -servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=5, d=servo_20kg_nut_d, $fn=6);
                translate([-servo_20kg_thread_y, servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=5, d=servo_20kg_nut_d, $fn=6);
                translate([-servo_20kg_thread_y, -servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=5, d=servo_20kg_nut_d, $fn=6);
            }
        } 
}

rotate([0,0,180]) 888_2006();
