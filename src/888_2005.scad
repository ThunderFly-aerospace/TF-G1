include <../Parameters.scad>


g2_0_part_space = 2; // mezera mezi zadni a predni casti

g2_5_height = 608_bearing_outer_diameter*2;
g2_5_width = 70+5.5+11;
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

g2_5_podlozka_d = 16;

width_real = g2_5_m3_length + M3_nut_height;
width_magnet = g2_5_m8_length + 11 + 5;

module 888_2005(draft = true){
    radius=main_tube_outer_diameter/2;
    
    difference(){
        union(){
            translate([g2_0_part_space/2, -g2_5_width/2, 0])
                cube([g2_5_front_l-g2_0_part_space/2, g2_5_width, g2_5_height]);
        }
        
        // hlavni nosna tyc
        translate([0,0,-global_clearance/2])
            cylinder(r=radius, h=g2_5_height+global_clearance, $fn=draft?50:100);
        
        // diry pro spojeni s 888_2006
        
        for(i=[-1:1]){
            translate([0, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                    cylinder(h=g2_5_m3_length/2+5, d=M3_screw_diameter, $fn=draft?50:100);
            // tvar matice
            translate([g2_5_m3_length/2-5, i*g2_5_width/3, g2_5_height/2])
                rotate([0, 90, 0])
                    rotate([0,0,0])
                        cylinder(h=M3_nut_height+0.5, d=M3_nut_diameter, $fn=6);
            // kapsa
            translate([g2_5_m3_length/2-5, i*g2_5_width/3, g2_5_height/2])
                rotate([-i*90, 0, 0])
                    translate([0, -M3_nut_diameter/2,-2])
                        cube([M3_nut_height+0.5, M3_nut_diameter, 100]);

        }
        
        // okomentuj pro kontrolu matic
        // translate([20,-100, 0]) cube(300);
        
        // dira pro osu do loziska
        translate([main_tube_outer_diameter+608_bearing_outer_diameter*1, g2_5_width/2, g2_5_height/2])
            rotate([90, 0, 0])
                cylinder(h=g2_5_width+1, d=M8_screw_diameter, $fn=draft?50:100);
        translate([main_tube_outer_diameter+608_bearing_outer_diameter*1, g2_5_width/2, g2_5_height/2])
            rotate([90, 0, 0])
                cylinder(h=5.5, d=15, $fn=draft?50:100);
        translate([main_tube_outer_diameter+608_bearing_outer_diameter*1, -g2_5_width/2+10, g2_5_height/2])
            rotate([90, 0, 0])
                cylinder(h=11, d=g2_5_podlozka_d, $fn=draft?50:100);
        // diry pro podlozku a hlavu licovaneho sroubu M8x70
        
        //dira pro dil s loziskem
        translate([main_tube_outer_diameter, -radius-g2_5_bearing_space/2, -global_clearance/2]) cube([608_bearing_outer_diameter*2+global_clearance, main_tube_outer_diameter+g2_5_bearing_space, g2_5_height+global_clearance]);
    }
}

888_2005();
