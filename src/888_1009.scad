//vyvažovací přípravek


wall_thickness=10; 

module 888_1009_base_half(x_size = 215, y_size = 100, z_size = 20, thickness = 10){     //základna

render()
    difference(){
        union(){
            translate([0, -y_size/2, 0])
                cube([x_size/2, y_size, thickness], center = false);         //základní plocha


            //podpěra

                    difference(){

                        translate([x_size/2 - thickness, -y_size/6,0])
                            cube([thickness,y_size/3,5*thickness]);          //základní plocha pro zkosení

                        //vyskousnutí
                        translate([x_size/2 - thickness,0,4*thickness])
                            rotate([30,0,0])
                                cube([thickness,y_size/3,20]);

                        mirror([0,1,0])
                        translate([x_size/2 - thickness,0,4*thickness])
                            rotate([30,0,0])
                                cube([thickness,y_size/3,20]);    


                    }
        }

    //otvory pro šrouby M3
    translate([thickness, 120/4, thickness/2])
        rotate([0,90,0])
        {   
            rotate([0,0,30]) // srovnání matky s povrchem placatou stranou
                cylinder(h = x_size, d = Nut_diameter_M3, $fn = 6);
            cylinder(h = x_size, d = M3_screw_diameter, $fn = 20, center = true);
        }

    translate([thickness,- 120/4, thickness/2])
        rotate([0,90,0])
        {   
            rotate([0,0,30])
                cylinder(h = x_size, d = Nut_diameter_M3, $fn = 6);
            cylinder(h = x_size, d = M3_screw_diameter, $fn = 20, center = true);
        }

    // odlehčení podložky
    translate([0, -y_size/10, 0])
        cube([x_size/5, y_size/5, thickness], center = false);         //základní plocha


    }

//final module základna
}



module 888_1009_base(){		//základna

    888_1009_base_half();
    mirror([1,0,0])
        888_1009_base_half();


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
		translate ([110/2 - x_size/4, -y_size/2, 0])
			minkowski(){
				cube([x_size/2,y_size,z_size-1], center = true);
	            cylinder(h = 1, r = 25 - global_clearance, $fn = 100, center = true);
			}
        //otvor pro rotorový list
        rotate([0,0,45])
        translate ([ -100/2 + 45/2, 0, 0])
    			cube([100, 250, 40], center = true);

        translate ([ 0, 0, 20])
			rotate([0,0,45])
				cube([50,250,40], center = true);
              
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  

        //otvory pro šrouby
        translate([110/2, 0, 0])
            cylinder(h = 10, d =  M6_screw_diameter, $fn = 20, center = true);
    }
}

module 888_1009_shape_B(x_size = 130, y_size = 60, z_size = 8){

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 200;       // celková délka polotovaru
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    airfoil_thickness = (airfoil_NACA/100) * (airfoil_depth + bridge_thickness); // vypočtená maximální tloušťka profilu

    render()
    difference(){
        //základní materiál
        color([0,0.5,0])
        translate ([-110/2 + x_size/4, y_size/2, 0])
            minkowski(){
                cube([x_size/2,y_size,z_size-1], center = true);
                cylinder(h = 1, r = 25 - global_clearance, $fn = 100, center = true);
            }
        //otvor pro rotorový list
        rotate([0,0,45])
        translate ([ 100/2 - 45/2, 0, 0])
                cube([100, 250, 40], center = true);

        translate ([ 0, 0, 20])
            rotate([0,0,45])
                cube([50,250,40], center = true);
              
        rotate([0,0,45])
            translate ([ -airfoil_depth/2, length/2, 0])
                rotate([90, 0, 0])
                    airfoil(naca = airfoil_NACA, L = airfoil_depth + bridge_thickness, N = 100, h = length, open = false);  

        //otvory pro šrouby
        translate([-110/2, 0, 0])
            cylinder(h = 10, d =  M6_screw_diameter, $fn = 20, center = true);
    }
}


module 888_1009_cradle_half(x_size = 210, y_size = 100, z_size = 20, thickness = 10){		//kolébka

render()
    difference(){
        union(){
        	//základní deska
        	translate([0,-y_size/2,0])
        	color([0.5,0,0])
        		cube([x_size/2 - thickness*1.5, y_size, thickness]);


        	difference(){
        		translate([x_size/2 - thickness*2.5,-y_size/2,0])
        			color([0.5,0,0])
        				cube([wall_thickness*(1.5+2),y_size,wall_thickness*3]);
        		
        		translate([x_size/2 - thickness, 0, thickness + 4])
        			rotate([-16,0,0])
                        translate([0, 0, -thickness - 4])
        				    cube([thickness*1.5, y_size,y_size/2]);

                mirror([0,1,0])
                    translate([x_size/2 - thickness, 0, thickness + 4])
                        rotate([-16,0,0])
                            translate([0, 0, -thickness - 4])
                                cube([thickness*1.5, y_size,50]);

        		// zůžení přesahující kostky
        		translate([x_size/2 + thickness, -y_size/3, 25/2])
        			cube([thickness*1.5, y_size/2, 50],center = true);

        		translate([x_size/2 + thickness, y_size/3, 25/2])
        			cube([thickness*1.5, y_size/2, 50],center = true);
                

        	}
        }

        translate([thickness, 80/4, thickness/2])
            rotate([0,90,0])
            {    
                rotate([0,0,30])
                    cylinder(h = x_size, d = Nut_diameter_M3, $fn = 6);
                cylinder(h = x_size, d = M3_screw_diameter, $fn = 20, center = true);
            }

        translate([thickness,- 80/4,thickness/2])
            rotate([0,90,0])    
            {    
                rotate([0,0,30])
                    cylinder(h = x_size, d = Nut_diameter_M3, $fn = 6);
                cylinder(h = x_size, d = M3_screw_diameter, $fn = 20, center = true);
            }

        //otvor pro šrouby k uchycení listu
        translate([110/2, 0, Nut_height_M6 + global_clearance])
            cylinder(h = 3*thickness, d =  M6_screw_diameter, $fn = 20);
        translate([110/2, 0, 0])
            cylinder(h = Nut_height_M6, d =  Nut_diameter_M6, $fn = 6);


        //otvory pro šrouby k uchycení libely
        translate([x_size/2 - thickness*1.75, 20, thickness *2])
            rotate([0,0,-90])
                union(){
                    cylinder(h = thickness*2, r = M3_screw_diameter/2, $fn = 20, center = true);
                    translate([- Nut_diameter_M3/2, 0, 0])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                //final union
                }


        translate([x_size/2 - thickness*1.75, -20, thickness *2])
            rotate([0,0,-90])
                union(){
                    cylinder(h = thickness*2, r = M3_screw_diameter/2, $fn = 20, center = true);
                    translate([- Nut_diameter_M3/2, 0, 0])        
                        cube([Nut_diameter_M3,Nut_diameter_M3+20,Nut_height_M3]);
                    cylinder(h = Nut_height_M3, r = Nut_diameter_M3/2, $fn = 6);
                //final union
                }
    }
}


module 888_1009_cradle(x_size = 180, y_size = 80, z_size = 20, thickness = 10){		//kolébka

	888_1009_cradle_half();

    mirror([1,0,0])
        888_1009_cradle_half();


    translate([0,0,thickness+4])
        %cube([160, 100, 8],center = true);

    translate([160/2 + 7.5, 0, 3*thickness+7.5])
        %cube([15, 55, 15],center = true);


}


//translate([0,0,30])
//		888_1009_cradle();

translate([0,0,100])
		888_1009_shape_B();

//		888_1009_base();


include <../Parameters.scad>
use <./lib/naca4.scad>
include <../Parameters.scad>

