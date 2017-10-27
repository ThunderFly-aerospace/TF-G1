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

        //UPPER
            difference (){
	            translate([0,-10,0])
	                rotate ([0,-90, 160])			//rotate([0,-90,152.5])
	                    airfoil(naca = 0005, L = 95, N=101, h = 152, open = false);
				translate ([140,-68,0]) 
	            	cube ([15,15,15]);
			
        		x = 170;
        		y = 170;
        		z = 60;
				fen_x = 1;
				fen_y = 5;
				fen_size = 0.2;

				fen_size_x = fen_size * x / 2;
				fen_size_y = fen_size * y / 100;

				strut_x = (x - fen_x * fen_size_x) / (fen_x + 10); 
				strut_y = (y - fen_y * fen_size_y) / (fen_y + 0);

				// take away windows from fenestrated surface
				  
				    
				    
			    translate([135,-90,3])
			    rotate([0,0,70])
			    for (i = [0:fen_x - 1]) {
			      translate([i * (fen_size_x + strut_x) + strut_x, 0, 0])
			      for (i = [0:fen_y - 1]) {
			        translate([0, i * (fen_size_y + strut_y) + strut_x, -1]) 
			       cube([fen_size_x, fen_size_y, z+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
			      }
			  }
			translate([125,-90,32])
			    rotate([0,0,70])
			    for (i = [0:fen_x - 1]) {
			      translate([i * (fen_size_x + strut_x) + strut_x, 0, 0])
			      for (i = [0:fen_y - 1]) {
			        translate([0, i * (fen_size_y + strut_y) + strut_x, -1]) 
			        cube([fen_size_x, fen_size_y, z+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
			      }
			  }
			 
						}	        


        //LOWER
        	difference (){
            translate([0,10,0])
                rotate ([0,-90,-160])		//rotate([0,-90,-152.5])
                    airfoil(naca = 0005, L =95, N=101, h = 152, open = false);

			translate ([140,55,0]) 
            	cube ([15,15,15]);
        //fenestrated surface
        //fenestrated surface
        
        		x = 170;
        		y = 170;
        		z = 60;
				fen_x = 1;
				fen_y = 9;
				fen_size = 0.5;

				fen_size_x = fen_size * x / 2;
				fen_size_y = fen_size * y / 100;

				strut_x = (x - fen_x * fen_size_x) / (fen_x + 10); 
				strut_y = (y - fen_y * fen_size_y) / (fen_y + 0);

		// take away windows from fenestrated surface
		  
		    
		    
		    translate([-20,40,3])
		    rotate([0,0,-70])
		    for (i = [0:fen_x - 1]) {
		      translate([i * (fen_size_x + strut_x) + strut_x, 0, 0])
		      for (i = [0:fen_y - 1]) {
		        translate([0, i * (fen_size_y + strut_y) + strut_x, -1]) 
		        cube([fen_size_x, fen_size_y, z+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
		      }
		  }

		      translate([-10,40,32])
		    rotate([0,0,-70])
		    for (i = [0:fen_x - 1]) {
		      translate([i * (fen_size_x + strut_x) + strut_x, 0, 0])
		      for (i = [0:fen_y - 1]) {
		        translate([0, i * (fen_size_y + strut_y) + strut_x, -1]) 
		        cube([fen_size_x, fen_size_y, z+2]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
		      }
		  }
       	}
        //VERTICAL
            difference (){
                translate ([140,75,0])//translate([115,74,0])
                    rotate([90,-87,0])
                        airfoil(naca = 0005, L = 150, N=101, h = 150, open = false);


                //VERTICAL - fenestrating windows
                translate([130,-82,40])
                  for (i = [0:7]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 20, 0])  //sude prorezy
                            cube([30, 0.2, 50]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                    else{
                        translate([0, i * 20, -20]) // liche prorezy
                            cube([30, 0.2, 50]); // the fenestrations have to start a bit lower and be a bit taller, so that we don't get 0 sized objects
                    }
                }
            }

	    } // end of union
        // Start of substraction objects


        //tube
        
        translate([0,0,-10])
            cylinder (h = 90, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);
		
        translate ([0,0,80])
          rotate ([0,0,0])
		cylinder (h = 5, r1 = main_tube_outer_diameter/2, r2 = 0, $fn = 200);
        
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









