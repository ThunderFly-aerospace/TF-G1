include <../Parameters.scad>


g2_0_part_space = 2; // mezera mezi zadni a predni casti

g2_5_height = 608_bearing_outer_diameter*2;
g2_5_width = 70;
g2_5_threads = 2; // kolik ma byt sroubu skrz nosnou tyc

g2_5_m3_length = 50; // sroub, ktery se pouziva na sesroubovani s nosnou tyci
g2_5_servo_shift = 30; 
g2_5_servo_wall = 5;

g2_5_m8_length = 60; // sroub, ktery se pouziva jako osa pro podlozku
g2_5_front_l = main_tube_outer_diameter + 608_bearing_outer_diameter*2;// jak moc ma byt magnet v predu

g2_5_zapusteni_serva = 30;
g2_5_length = g2_5_zapusteni_serva + 2*main_tube_outer_diameter + 30;
g2_5_length_offset = -10;

g2_5_bearing_space = 2; // mezera pro podlozku mezi loziskem a stenou..




servo_20kg_axis_offset = 10; // jak je osa mimo stredu
servo_20kg_body_x = 42;
servo_20kg_body_y = 21;
servo_20kg_body_z = 40;
servo_20kg_thread_x = 48/2;
servo_20kg_thread_y = 10/2;

servo_20kg_bolt_d = 2.5+0.3;
servo_20kg_nut_d = 5+0.3;

g2_6_plate_thickness = 10;
g2_6_servo_distance = 60; // jak je daleko servo pred tyci kola
g2_6_servo_shift = 30; // jak je osa serva mimo stredu
g2_6_servo_bolt_l = 8; // delka sroubu od konce serva po zacatek matky
g2_6_min_wall_around = 10; // minimalni material okolo serva

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
                translate([g2_0_part_space/2, -g2_5_width/2, 0])
                    cube([g2_0_part_space/2, g2_5_width, g2_6_plate_thickness]);
                
                translate([g2_6_servo_distance-servo_20kg_body_y/2-g2_6_min_wall_around, servo_20kg_axis_offset-servo_20kg_body_x/2-g2_6_min_wall_around+g2_6_servo_shift, 0])
                    cube([servo_20kg_body_y+2*g2_6_min_wall_around, servo_20kg_body_x+2*g2_6_min_wall_around, g2_6_plate_thickness]);
            }
        }
    
        translate([0,0,-global_clearance/2])
            cylinder(r=radius, h=g2_5_height+global_clearance, $fn=draft?50:100);
        
        for(i=[-1:1]){
            translate([0, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                    cylinder(h=g2_5_m3_length/2+5, d=M3_screw_diameter, $fn=draft?50:100);
            // tvar matice
            translate([g2_5_m3_length/2-5, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                        cylinder(h=M3_nut_height+20, d=M3_nut_diameter, $fn=draft?50:100);
        }
        
        
        translate([g2_6_servo_distance, servo_20kg_axis_offset+g2_6_servo_shift, 0])
            union(){ // tato union je model serva
                translate([-servo_20kg_body_y/2, -servo_20kg_body_x/2, 0])
                    cube([servo_20kg_body_y, servo_20kg_body_x, servo_20kg_body_z]);
                
                translate([servo_20kg_thread_y, servo_20kg_thread_x, 0])
                    cylinder(h=50, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([servo_20kg_thread_y, -servo_20kg_thread_x, 0])
                    cylinder(h=50, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([-servo_20kg_thread_y, servo_20kg_thread_x, 0])
                    cylinder(h=50, d=servo_20kg_bolt_d, $fn=draft?50:100);
                translate([-servo_20kg_thread_y, -servo_20kg_thread_x, 0])
                    cylinder(h=50, d=servo_20kg_bolt_d, $fn=draft?50:100);
                
                translate([servo_20kg_thread_y, servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=40, d=servo_20kg_nut_d, $fn=6);
                translate([servo_20kg_thread_y, -servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=40, d=servo_20kg_nut_d, $fn=6);
                translate([-servo_20kg_thread_y, servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=40, d=servo_20kg_nut_d, $fn=6);
                translate([-servo_20kg_thread_y, -servo_20kg_thread_x, g2_6_servo_bolt_l])
                    cylinder(h=40, d=servo_20kg_nut_d, $fn=6);
            }
        } 
}

rotate([0,0,180]) 888_2006();
