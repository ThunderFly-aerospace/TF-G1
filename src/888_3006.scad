use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;
$fs =  draft ? 50 :100;



module 888_3006(draft){    /////// 1. díl (AZ, YAW)

    //lícovaný šroub  M6
    8_shank_diameter = 8.4;		//průměr dříku + tolerance pro díru
    screw_length = 30; // délka lícovaného sroubu
    whole_screw_length = screw_length + 11+6; 		//celková délka
    thread_length = 11;				//délka závitu
    thread_diameter = 6; 
    length_screw_behind_nut = 3;
    head_screw_diameter = 13 + 0.2;		//průměr válcové hlavy šroubu
    head_screw_height = 8 + 0.2;		//výška válcové hlavy šroubu


    //samojistná šestihranná matice ISO 7040 - M6
    lock_nut_diameter = 11.05; //výška samojistné matice pro průměr M6
    lock_nut_height = 8; 


    difference(){
        union(){
            cylinder(r=g3_0_cone1, h=5, $fn=draft?50:100);

            translate([0,0,5]) 
                cylinder(r1=g3_0_cone1, r2=g3_0_cone2, h = g3_0_cone_height-5, $fn=draft?50:100);

            cylinder(r=g3_0_cone2, h = g3_0_height-g3_0_cone_top_height, $fn=draft?50:100);

            // Kuzel v horni casti
            //translate([0,0,g3_0_height-g3_0_cone_top_height]) 
            //    cylinder(r1=g3_0_cone2, r2=8+1, h = g3_0_cone_top_height, $fn=draft?50:100);
            
            // omezeni pro osu yaw
            difference(){
                translate([0,0,g3_0_height-g3_0_cone_top_height])
                    cylinder(r=g3_0_cone2, h = 20, $fn=draft?50:100);
                
                union (){
                center = bearing_efsm_12_ag - bearing_efsm_12_a1;
                for(pitch = g3_0_pitch_limit){
                    for(yaw = g3_0_yaw_limit){
                        for(roll = g3_0_roll_limit){
                            translate([0, 0, g3_0_height+center])
                                rotate([roll, pitch, yaw])
                                    translate([-g3_7_length/2,-g3_7_width/2,-center])
                                        cube([g3_7_length, g3_7_width, 30]);
                        }
                    }
                }
                }
            }
            
            difference(){
                union(){
                    translate([0,0,g3_0_height])
                        cylinder(d=16.7, h = bearing_efsm_12_ag, $fn=draft?50:100);
                  
                    translate([0,0,g3_0_height-bearing_efsm_12_ag])
                        cylinder(d=16.7+3, h = bearing_efsm_12_ag, $fn=draft?50:100);
                }
                translate([-50,-g3_1_yaw_width/2,g3_0_height]) 
                    cylinder(r=1, h = 20, $fn=draft?50:100);
            }
        }
        
        // srouby pri pridelani na strechu
        for (i = [0:3]){
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, -global_clearance]) 
                    cylinder(h=100, d=M6_screw_diameter, $fn=draft?50:100);
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, -global_clearance])
                    cylinder(h=1, d1=M6_screw_diameter+2, d2=M6_screw_diameter, $fn=draft?50:100);
            rotate([0, 0, i*90]) 
                translate([g3_0_srcew_dist, 0, 30-18-5]) 
                    rotate([0,0,30]) 
                        cylinder(h=20, d=M6_nut_diameter, $fn=6, $fn=6);
        }
        
        // kapsa pro matici s podlozkou
        translate([-M10_nut_diameter, -g3_1_service_holl_width/2, g3_0_height-g3_1_service_holl_height-(g3_0_bearing_bolt_len-g3_7_height/2-bearing_efsm_12_ag/2)])
            cube([200, g3_1_service_holl_width, g3_1_service_holl_height]);
        cylinder(h = 1000, d = M10_screw_diameter, $fn = draft?50:100);
    }
}

888_3006(draft);
