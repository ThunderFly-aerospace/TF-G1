use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;
$fs =  draft ? 50 :100;



module 888_3009(draft){    /////// 1. díl (AZ, YAW)

//lícovaný šroub  M6
8_shank_diameter = 8.4;		//průměr dříku + tolerance pro díru


difference(){
    union (){
        cylinder(r=g3_0_cone1, h=g3_9_height-global_clearance, $fn=draft?50:100);
    }
    
    // srouby pri pridelani na strechu
    for (i = [0:3]){
        rotate([0, 0, i*90]) translate([g3_0_srcew_dist, 0, -global_clearance/2]) cylinder(h=g3_9_height+global_clearance, d1=M6_screw_diameter, d=M6_screw_diameter, $fn=draft?50:100);
        rotate([0, 0, i*90]) translate([g3_0_srcew_dist, 0, -global_clearance]) cylinder(h=1, d1=M6_screw_diameter+2, d2=M6_screw_diameter, $fn=draft?50:100);
    }
}
}

888_3009(draft);
