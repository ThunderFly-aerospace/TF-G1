include <../Parameters.scad>


g2_5_height = 30;
g2_5_width = 70;
g2_5_threads = 2; // kolik ma byt sroubu skrz nosnou tyc

g2_5_m3_length = 70; // sroub, ktery se pouziva na sesroubovani s nosnou tyci
g2_5_servo_shift = 30; 
g2_5_servo_wall = 5;

g2_5_m8_length = 60; // sroub, ktery se pouziva jako osa pro podlozku
g2_5_front_l = main_tube_outer_diameter + 608_bearing_outer_diameter*2;// jak moc ma byt magnet v predu

g2_5_zapusteni_serva = 30;
g2_5_length = g2_5_zapusteni_serva + 2*main_tube_outer_diameter + 30;
g2_5_length_offset = -10;

width_real = g2_5_m3_length + M3_nut_height;
width_magnet = g2_5_m8_length + 11 + 5;

module 888_2005(draft = true){
    radius=main_tube_outer_diameter/2;
    
    difference(){
        union(){
            //translate([-g2_5_length/2+g2_5_length_offset,-g2_5_width/2,0]) cube([g2_5_length, g2_5_width, g2_5_height]);
            hull(){
                    cylinder(h=g2_5_height, d = width_real);
                    translate([g2_5_m3_length+g2_5_zapusteni_serva, -(servo_20kg_width+g2_5_servo_wall*2)/2, 0]) cube([global_clearance, servo_20kg_width+2*g2_5_servo_wall, g2_5_height]);
                    #translate([-g2_5_front_l, -(g2_5_m3_length)/2, 0]) cube([global_clearance, g2_5_m3_length, g2_5_height]);
            }
        }
        
        // hlavni nosna tyc
        translate([0,0,-global_clearance/2]) cylinder(r=radius, h=g2_5_height+global_clearance);
        
        // diry pro M3 srouby do hlavni tyce
        for (i = [1:g2_5_threads]){
            dif = g2_5_height/(g2_5_threads+1);    
            translate([0, width_real/2, dif*i]) rotate([90, 0, 0]) cylinder(h=width_real, d=M3_screw_diameter);
            translate([0, width_real/2, dif*i]) rotate([90, 0, 0]) cylinder(h=M3_nut_height, d=M3_nut_diameter, $fn=6);
            translate([0, -width_real/2+M3_nut_height, dif*i]) rotate([90, 0, 0]) cylinder(h=M3_nut_height, d=M3_nut_diameter);
        }
        
        //hlavni dira pro servo
       translate([g2_5_servo_shift, -servo_20kg_width/2, 0]) cube([servo_20kg_height, servo_20kg_width, g2_5_height ]);
        
        // dira pro osu do loziska
        translate([-g2_5_front_l+608_bearing_outer_diameter*1, width_magnet/2, g2_5_height/2]) rotate([90, 0, 0]) cylinder(h=width_magnet+1, d=M8_screw_diameter);
        //dira pro dil s loziskem
        translate([-g2_5_front_l, -radius, 0]) cube([608_bearing_outer_diameter*2-global_clearance, main_tube_outer_diameter+1.5, g2_5_height]);
    }
}

888_2005();
