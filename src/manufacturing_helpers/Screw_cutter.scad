
draft = true;

module screw_cutter(draft){

width = 10;
depth = 20;


//délka šroubu, kterou potřebujeme
height_need_screw = 21.5;

//délka navíc pro upevnění šroubu
tolerance = 10;

//průměr řezaného šroubu
diamter_of_cut_screw = M3_screw_diameter;


difference(){

	translate([-width/2, -depth/2,0])
			cube([width,depth,height_need_screw + tolerance]);

	//šroub
	translate([0,0,-global_clearance/2])
			cylinder (h = height_need_screw + tolerance + global_clearance, r = diamter_of_cut_screw/2, $fn = draft ? 50 : 100 );

	//prořez
	translate([- global_clearance/2 - diamter_of_cut_screw, - depth/2 - global_clearance/2,height_need_screw])
			cube([width + global_clearance, depth + global_clearance, global_clearance]);

	}	

}


screw_cutter(draft);



include <../../Parameters.scad>