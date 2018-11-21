use <./lib/naca4.scad>
include <../Parameters.scad>
use <./lib/curvedPipe.scad>
draft = true;
$fs =  draft ? 50 :100;


module kostka(p, r, y, h){
    rotate([r, p, y])
        translate([-g3_7_length/2,-g3_7_width/2,-h])
            cube([g3_7_length, g3_7_width, 30]);
}


module 888_3006(draft){    /////// 1. díl (AZ, YAW)

    height = 50;
    magnet_d = 80;
    cylinder_height = magnet_d/2;

    difference(){
        union(){
            cylinder(r=g3_0_cone1, h=5, $fn=draft?50:100);

            translate([0,0,5]) 
                cylinder(r1=g3_0_cone1, r2 = magnet_d/2 , h = height/2 - 5, $fn=draft?50:100);

            cylinder(r = magnet_d/2 , h = height, $fn=draft?50:100);

              
        }

        
        for (i=[0:3]) rotate([0, 0, 90*i]){
            translate([0, 70/2, 0])
                cylinder(h = 2*cylinder_height, d = M4_screw_diameter, $fn = 50);
            
            translate([0, 70/2, 0])
               cylinder(h = height - 10, d = M4_nut_diameter, $fn = 6);
        }

        // otvor pro vývody
        rotate([0,0,45])
           curvedPipe([[0,57/2,height], [0,57/2,height / 2], [0,100,height / 2]], 2, [20], 8, 0);

        // srouby pri pridelani na strechu
        for (i = [0:3]){
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, -global_clearance]) 
                    cylinder(h = 100, d = M6_screw_diameter, $fn = 50);
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, -global_clearance])
                    cylinder(h=1, d1=M6_screw_diameter+2, d2=M6_screw_diameter, $fn=draft?50:100);
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, 30-18-5]) 
                    rotate([0,0,30]) 
                        cylinder(h=20, d=M6_nut_diameter, $fn=6, $fn=6);
        }
        
    }
}

888_3006(draft);
