//vyvažovací přípravek


wall_thickness=10; 

module 888_1009_base_half(x_size = 160, y_size = 100, z_size = 20, thickness = 10){     //základna

    translate([-x_size/2,-y_size/2,0])
        cube([x_size/2,y_size,thickness], center = false);         //základní plocha


    //podpěra

    render()
    translate([x_size/2 - thickness,-y_size/2,0])
        rotate([90,0,90])           
            difference(){

                   cube([120,80,thickness]);          //základní plocha pro zkosení

                translate([0,0,-5])
                    rotate([0,0,45])
                        cube([120,120,20]);     //zkosení
                translate([120,0,-5])
                    rotate([0,0,45])
                        cube([120,120,20]);     //zkosení
                //vyskousnutí
                translate([60,31.73,-5])
                    rotate([0,0,30])
                        cube([40,40,20]);    
                translate([60,31.73,-5])
                    rotate([0,0,45+15])
                        cube([40,40,20]);       


            }

//final module základna
}



module 888_1009_base(){		//základna

difference(){
    888_1009_base_half();
//otvory pro šrouby M3
translate([- global_clearance - 160, 120/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);

translate([- global_clearance - 160,- 120/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);
}
mirror([1,0,0])

difference(){
    888_1009_base_half();
//otvory pro šrouby M3
translate([- global_clearance - 160, 120/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);

translate([- global_clearance - 160,- 120/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);
}


}


module 888_1009_shape_A(x_size = 130, y_size = 60, z_size = 8){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 200;       // celková délka polotovaru
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    airfoil_thickness = (airfoil_NACA/100) * (airfoil_depth + bridge_thickness); // vypočtená maximální tloušťka profilu

    render()
    difference(){
        //základní materiál
		color([0,0.5,0])
		translate ([160/2 - 25, 0, 0])
			minkowski(){
				cube([x_size/2-25,y_size/2 - 25,z_size-1], center = true);
	            cylinder(h = 1, r =  25, $fn = 50, center = true);
			}
        //otvor pro rotorový list
		rotate([0,0,45])
			cube([45,150,40], center = true);

        translate ([ 0, 0, 20])
			rotate([0,0,45])
				cube([50,150,40], center = true);

               
/*        rotate([0,0,45])
            666_1201(draft = true, holes = true);*/
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  

        //otvory pro šrouby
        translate([110/2 - x_size/10, 0, 0])
            cylinder(h = 10, d =  6.5, $fn = 20, center = true);
    }

/*    color([1,0.5,0])
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  
*/
}

module 888_1009_shape(x_size = 130, y_size = 60, z_size = 8){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 200;       // celková délka polotovaru
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    airfoil_thickness = (airfoil_NACA/100) * (airfoil_depth + bridge_thickness); // vypočtená maximální tloušťka profilu

    render()
    difference(){
        //základní materiál
		color([0,0.5,0])
		minkowski(){
			cube([x_size/2-25,y_size/2 - 25,z_size], center = true);
            cylinder(h = 1, r =  25, $fn = 50, center = true);
		}
        //otvor pro rotorový list
		rotate([0,0,45])
			cube([45,150,40], center = true);
               
/*\        rotate([0,0,45])
            666_1201(draft = true, holes = true);*/
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  

        //otvory pro šrouby
        translate([110/2 - x_size/10, 0, 0])
            cylinder(h = 10, d =  6.5, $fn = 20, center = true);

        translate([-110/2, 0, 0])
            cylinder(h = 10, d =  6.5, $fn = 20, center = true);

    }

/*    color([1,0.5,0])
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  
*/



//final module tvar
}


module 888_1009_cradle_half(x_size = 160, y_size = 80, z_size = 20, thickness = 10){		//kolébka
	//základní deska
	translate([0,-y_size/2,0])
	color([0.5,0,0])
		cube([x_size/2 - wall_thickness*1.5,y_size,thickness]);


	difference(){
		translate([x_size/2 - wall_thickness*2.5,-y_size/2,0])
			color([0.5,0,0])
				cube([wall_thickness*3.5,80,wall_thickness*3]);
		
		translate([x_size/2 - wall_thickness/2,25,25/2])
			rotate([-16,0,0])
				cube([wall_thickness*2 - 5,50,50], center = true);

		translate([x_size/2 - wall_thickness/2,-25,25/2])
			rotate([16,0,0])
				cube([wall_thickness*2,50,50],center = true);

		// zůžení přesahující kostky
		translate([x_size/2,-25,25/2])
			cube([wall_thickness*2,30,50],center = true);

		translate([x_size/2,25,25/2])
			cube([wall_thickness*2,30,50],center = true);

	}
}


module 888_1009_cradle(x_size = 180, y_size = 80, z_size = 20, thickness = 10){		//kolébka

difference(){
	888_1009_cradle_half();

translate([- global_clearance - 160, 80/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);

translate([- global_clearance - 160,- 80/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);


}	
    mirror([1,0,0])
difference(){
	888_1009_cradle_half();

translate([- global_clearance - 160, 80/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);

translate([- global_clearance - 160,- 80/4,10/2])
	rotate([0,90,0])	
		cylinder(h = 320 + 2*global_clearance, r = M3_screw_diameter/2, $fn = 6);


}
}


translate([0,0,20])
		888_1009_cradle();

translate([0,0,100])
		888_1009_shape_A();

		888_1009_base();


include <../Parameters.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>

