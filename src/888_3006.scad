use <./lib/naca4.scad>
include <../Parameters.scad>
draft = true;



module 888_3006(draft){    /////// 1. díl (AZ, YAW)

cone_radius_one = 65;
cone_radius_two = 45;
cone_height = 25;
cylinder_height = 10;

whole_length = cone_height + cylinder_height;

//lícovaný šroub  M6
shank_diameter = 8 + 1 ;		//průměr dříku + tolerance pro díru
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

//šířka žebra
rib_thickness = 7;

rotate_angle = 40;

//výška podstavy počítaná z celkové délky použitého lícovaného šroubu
height_of_base = whole_screw_length - whole_length + head_screw_height;

base_thickness = 30-18-6; // sila materialu pod srouby pro pridelani

difference(){
    union (){
        cylinder(r1=g3_0_cone1, r2=g3_0_cone2, h = g3_0_cone_height);
    
    }
}

}


888_3006(draft);
