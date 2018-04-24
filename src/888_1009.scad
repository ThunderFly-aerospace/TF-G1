//vyvažovací přípravek


module 888_1009_base_half(x_size = 180, y_size = 120, z_size = 20, thickness = 10){     //základna

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

    888_1009_base_half();
    mirror([1,0,0])
        888_1009_base_half();
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
			cube([x_size,y_size,z_size], center = true);
        //otvor pro rotorový list
		rotate([0,0,45])
			cube([45,150,40], center = true);
               
/*\        rotate([0,0,45])
            666_1201(draft = true, holes = true);*/
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  

//výstupek pro nasazení rysky vlevo
	translate([10,30,20])
		cylinder(h = 10, r = 5, $fn = 50);

        //otvory pro šrouby
        translate([x_size/2 - x_size/10, 0, 0])
            cylinder(h = 10, d =  M3_screw_diameter, $fn = 20, center = true);

        hull(){
            translate([-x_size/2 + x_size/10, -M3_screw_diameter, 0])
                cylinder(h = 10, d =  M3_screw_diameter, $fn = 20, center = true);
            translate([-x_size/2 + x_size/10, M3_screw_diameter, 0])
                cylinder(h = 10, d =  M3_screw_diameter, $fn = 20, center = true);
        }

    }

/*    color([1,0.5,0])
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  
*/


//final module tvar
}


module 888_1009_cradle(){		//kolébka
		//základní deska
		color([0.5,0,0])
			cube([125,80,10]);

		//zábrana vlevo
		translate([0,0,10])
			color([0.5,0,0])
				cube([10,80,40]);				//zábrana
		
	difference(){
		translate([-10.5,40 - 12.5/2,10 + 50/3 - 25])
				cube([11.5,12.5,27]);				//koska pro hrot
		
		translate([-14,31.25,-4])
			rotate([16,0,0])
				cube([15,10,35]);

		translate([-14,39.55,0])
			rotate([-16,0,0])
				cube([15,10,35]);

		translate([-5,30,-1.45])
				cube([6,20,25]);
	}
		
		//zábrana vpravo
		translate([115,0,10])
			color([0.5,0,0])
				cube([10,80,40]);
	

	difference(){
		translate([ + 124,40 - 12.5/2,10 + 50/3 - 25])
				cube([11.5,12.5,27]);				//koska pro hrot
		
		translate([ + 124,31.25,-4])
			rotate([16,0,0])
				cube([15,10,35]);

		translate([124,39.55,0])
			rotate([-16,0,0])
				cube([15,10,35]);

		translate([124,30,-1.45])
				cube([6,20,25]);
	}


//final module kolébka	
}

/*
translate([10 + 2.5,34.972,50.063])
		888_1009_cradle();

translate([10,45,100])
		888_1009_shape();
*/
		888_1009_base();


include <../Parameters.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>

