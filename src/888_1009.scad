//vyvažovací přípravek

module 888_1009_base(){		//základna

			cube([150,150,20]);			//základní plocha
	
//podpěra vpravo
	translate([140,15,20])
		rotate([90,0,90])
			
			difference(){
					cube([120,80,10]);			//základní plocha pro zkosení
				translate([0,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([120,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([60,31.73,-5])
					rotate([0,0,45])
						cube([20,20,20]);		//vyskousnutí


			}

//podpěra vlevo
	translate([0,15,20])
		rotate([90,0,90])
			
			difference(){
					cube([120,80,10]);			//základní plocha pro zkosení
				translate([0,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([120,0,-5])
					rotate([0,0,45])
						cube([120,120,20]);		//zkosení
				translate([60,31.73,-5])
					rotate([0,0,45])
						cube([20,20,20]);		//vyskousnutí


			}

//final module základna
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

	union(){
		//zábrana vlevo
		translate([0,0,10])
			color([0.5,0,0])
				cube([10,80,40]);				//zábrana
		translate([-12.5,40 - 12.5/2,10 + 50/3 - 10])
				cube([12.5,12.5,5]);				//koska pro hrot
		translate([-12.5/2 - 2.5,40,10 + 50/3 - 10 - 20])
			rotate([0,0,45])
				cylinder(h = 20, r1 = 0, r2 = 12.5/2, $fn = 4);

		//zábrana vpravo
		translate([115,0,10])
			color([0.5,0,0])
				cube([10,80,40]);
	}
//final module kolébka	
}

translate([10 + 2.5,35,55])
		%888_1009_cradle(draft);


translate([10,45,100])
		888_1009_shape();

		888_1009_base(draft);


include <../Parameters.scad>
use <./lib/naca4.scad>
use <./666_1201.scad>
