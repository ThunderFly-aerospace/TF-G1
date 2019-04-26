//include<../UST/Parameters.scad>

draft = false;
center_diameter = 140;
center_height = 10;
connecting_module_length = 17;
distance_bearing = 180;
distance = distance_bearing-center_diameter/2 - connecting_module_length*2 -7;
leg_width = 60;
pitch_bearing = 15;
bearing_angle_side=5;
bearing_angle_inner=-2;

//Screw diameter and nut for M5 [mm]
M5_screw_diameter=5.5;
M5_head_height = 5;
M5_head_diameter = 13+0.5;
M5_nut_height = 4.5;
M5_nut_diameter = 9.4;
M5_nut_pocket = 8.4;


//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
M4_screw_head_height = 4;
M4_nut_height = 3.2;
M4_nut_diameter = 8.4;
M4_nut_pocket = 7.5;
M4_screw_head_diameter=6;

g3_0_srcew_dist = 55;
//pripojovací část
difference(){
    translate([-connecting_module_length,-leg_width/2,0])
        cube([connecting_module_length,leg_width,center_height*2]);
    translate([-connecting_module_length/2,15,center_height])
        rotate([0,90,0]){
            cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true);
        }
    translate([-connecting_module_length/2,-15,center_height])
        rotate([0,90,0]){
            cylinder(h=connecting_module_length*2,d=M4_screw_diameter,center=true);
        }
}

translate([distance-70+35,0,center_height])

rotate([-bearing_angle_side,20,0]){
    //translate([distance-70+35,0,center_height])
        cube([70,leg_width/2,center_height],center=true);
}
difference(){
    //základna
    translate([0,-leg_width/2,0])
        cube([distance+35,leg_width,center_height]);
    //naklon
    rotate([bearing_angle_side,bearing_angle_inner,0]){
        translate([distance+35-70,-leg_width/2,center_height-5])
            cube([70,leg_width/2,center_height]);
    }
    //naklon
    rotate([-bearing_angle_side,bearing_angle_inner,0]){
        translate([distance-70+35,0,center_height-5])
            cube([70,leg_width/2,center_height]);
    }
    connecting_bearing_hole();

    translate([0,15,center_height])
        rotate([0,90,0]){
        cylinder(h=5,d=M4_screw_head_diameter,$fn=draft?50:100);
    }
    translate([0,-15,center_height])
        rotate([0,90,0]){
        cylinder(h=5,d=M4_screw_head_diameter,$fn=draft?50:100);
    }

}

// diry pro pripojeni lozisek
module connecting_bearing_hole(y){
    rotate([-bearing_angle_side,bearing_angle_inner,0]){
        translate([distance-18,pitch_bearing,0])
            cylinder(h=center_height,d=M5_screw_diameter,$fn=draft?50:100);
        translate([distance+18,pitch_bearing,0])
            cylinder(h=center_height,d=M5_screw_diameter,$fn=draft?50:100);
    }

    rotate([bearing_angle_side,bearing_angle_inner,0]){
        translate([distance-18,-pitch_bearing,0])
            cylinder(h=center_height,d=M5_screw_diameter,$fn=draft?50:100);
        translate([distance+18,-pitch_bearing,0])
            cylinder(h=center_height,d=M5_screw_diameter,$fn=draft?50:100);
    }
}
