use <./lib/naca4.scad>
include <../Parameters.scad>

module 666_1028(){
//mirror ([1,0,0])

    //BASIC DROP
    //render(convexity = 2) 
    difference (){

        union (){
            translate([0,0,-8.5])
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0030, L = 140)); 
                          square(200, 200); 
                        }


        //TRIANGLE PROFILE

        //UPPER - od osy x do minus y
            difference (){
	            translate([0,-10,0])
	                rotate ([0,-90, 160])			//rotate([0,-90,152.5])
	                    airfoil(naca = 0005, L = 95, N=101, h = 152, open = false);
				translate ([140,-68,0]) 
	            	cube ([15,15,15]);
			
        		            	//UPPER - fenestrating windows
                translate([125,-70,30])
                	rotate([0,0,70])	
                  for (i = [0:7]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            cube([30, 0.1, 25]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 19, -20]) // liche prorezy
                            cube([30, 0.1, 25]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
        
       	}
						}	        


        //LOWER - od osy x do plus y
        	difference (){
            translate([0,10,0])
                rotate ([0,-90,-160])		//rotate([0,-90,-152.5])
                    airfoil(naca = 0005, L =95, N=101, h = 152, open = false);

			translate ([140,55,0]) 
            	cube ([15,15,15]);

            	//LOWER - fenestrating windows
                translate([0,20,40])
                	rotate([0,0,-70])	
                  for (i = [0:7]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 19, 5])  //sude prorezy
                            cube([30, 0.1, 25]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 19, -20]) // liche prorezy
                            cube([30, 0.1, 25]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
        
       	}
       }
        //VERTICAL
            difference (){
                translate ([140,75,0])//translate([115,74,0])
                    rotate([90,-87,0])
                        airfoil(naca = 0005, L = 150, N=101, h = 150, open = false);


                //VERTICAL - fenestrating windows
                translate([130,-72,40])
                  for (i = [1:7]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 18, 20])  //sude prorezy
                            cube([30, 0.1, 50]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 18, -20]) // liche prorezy
                            cube([30, 0.1, 50]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }
            }

	    } // end of union
        // Start of substraction objects


        //tube
        
        translate([0,0,-10])
            cylinder (h = 90, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);
		
        translate ([0,0,80])
            cylinder (h = 15, r1 = main_tube_outer_diameter/2, r2 = 0, $fn = 200);
        
        //screw
        translate ([-150*0.4,0,150*0.4/2])
            rotate ([0,90,0])
                cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4])
            rotate ([0,90,0])
                cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

        //nut
        translate([17.5,0,150*0.4])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


        translate([17.5,0,150*0.4/2])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);



        //cleanup for printing
        translate ([-149.9,-75,-1])
        		 cube ([150,150,170]);

        translate ([-50,-100,-200])
            cube ([200,200,200]);
    
        //translate ([-75,-75,-10])
        	//cube ([150,150,150]);    

    }	
 
}	


666_1028();

//For printing size limits check.
//translate([0,-75,0])
  //cube ([150,150,150]);









