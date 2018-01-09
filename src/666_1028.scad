use <./lib/naca4.scad>
include <../Parameters.scad>

draft = true;

module 666_1028(){
    //BASIC DROP
    //render(convexity = 2) 
    difference (){
        union (){
            translate([0,0,-8.5])
                rotate_extrude($fn = draft ? 50 : 200)
                    rotate([0,0,90])
                        difference()
                        {
                            polygon(points = airfoil_data(naca=0030, L = 140)); 
                            square(200, 200); 
                        }


        //TRIANGLE PROFILE

        //UPPER - od osy x do minus y
            difference (){
	            translate([0,-10,-0.5]) // elementary negative Z shift to improve adhesion on the printig surface
	                rotate ([0,-90, 160])			//rotate([0,-90,152.5])
	                    airfoil(naca = 0005, L = 95, N = draft ? 50 : 100, h = 152, open = false);
				translate ([140,-68,0]) 
	            	cube ([15,15,15]);
			
        		            	//UPPER - fenestrating windows
                translate([125,-70,35])
                	rotate([0,0,70])	
                    for (i = [0:7]) { // opakovani cyklu
                        if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                            translate([0, i * 19, 10])  //sude prorezy
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
            translate([0,10,-0.5]) // elementary negative Z shift to improve adhesion on the printig surface
                rotate ([0,-90,-160])		//rotate([0,-90,-152.5])
                    airfoil(naca = 0005, L =95, N = draft ? 50 : 100, h = 152, open = false);

			translate ([140,55,0]) 
            	cube ([15,15,15]);

            	//LOWER - fenestrating windows
                translate([0,20,35])
                    rotate([0,0,-70])	
                    for (i = [0:7]) { // opakovani cyklu
                        if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                            translate([0, i * 19, 10])  //sude prorezy
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
                translate ([140,75,-0.5]) // elementar Z shift to improve adhesion on the printig surface
                    rotate([90,-87,0])
                        airfoil(naca = 0005, L = 150, N = draft ? 50 : 100, h = 150, open = false);


                //VERTICAL - fenestrating windows
                translate([130,-72,40])
                  for (i = [1:7]) { // opakovani cyklu
                    if (i % 2 == 0){ // testovani jestli jde o lichy nebo sudy prorez
                        translate([0, i * 18, 30])  //sude prorezy
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
            cylinder (h = 90, r = main_tube_outer_diameter/2, $fn= draft ? 50 : 200);
		
        translate ([0,0,80])
            cylinder (h = 15, r1 = main_tube_outer_diameter/2, r2 = 0, $fn = draft ? 50 : 200);
        
        //screw
        translate ([-150*0.4,0,150*0.4/2])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        //nut
        translate([17.5,0,150*0.4])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r = Nut_diameter_M3/2, $fn = 6);


        translate([17.5,0,150*0.4/2])
            rotate([0,90,0])
                cylinder (h = Nut_height_M3+10, r = Nut_diameter_M3/2, $fn = 6);

        // wing tensile scructure (upper)
        translate ([200,-84,53])
            rotate ([0,0,70])
                cube([1.8,250,11]);
        translate ([200,-84,20])
            rotate ([0,0,70])
                cube([1.8,250,11]);

        // wing tensile scructure (lower)
        translate ([0,11,53])
            rotate ([0,0,-70])
                cube([1.8,250,11]);
        translate ([0,11,20])
            rotate ([0,0,-70])
                cube([1.8,250,11]);


        //cleanup for printing
        translate ([-149.9,-75,-1])
        		 cube ([150,150,170]);

        translate ([-50,-100,-200])
            cube ([200,200,200]);
    
        //translate ([-75,-75,-10])
        	//cube ([150,150,150]);    

    }	
 
}

module 666_1028_drillhelper(height = 60, height_of_cap_cylinder = 2)
{
    radius=main_tube_outer_diameter/2;
    wall_thickness=main_tube_outer_diameter/10;
    width=main_tube_outer_diameter+2*wall_thickness;    
    depth=main_tube_outer_diameter*2;
    //height=depth;


    c_na_druhou=width*width+width*width;
    uhlopricka=sqrt(c_na_druhou);
    c2_na_druhou=(depth/2*depth/2)+(depth/2*depth/2);
    uhlopricka_2=sqrt(c2_na_druhou);

    M3_screw_radius=M3_screw_diameter/2;
    wall_thickness_M3_cylinder_X = M3_screw_radius;
    stred_M4_cylinder_X = width/2 - M3_screw_radius * 2;
    stred_M4_cylinder_Z_horni = height - M3_screw_radius - M3_screw_diameter*0.75;
    stred_M4_cylinder_Z_dolni = M3_screw_radius + M3_screw_diameter*2;

    difference (){

        translate([-(depth/2),-(width/2),height_of_cap_cylinder])
            cube ([depth,width,height]);
            
            //tube
        translate([0,0,-1])
            cylinder(h = height+1, r = radius, $fn = draft ? 50 : 100);

        //screw
        translate ([-150*0.4,0,150*0.4/2 - 20])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);

        translate ([-150*0.4,0,150*0.4 - 20])
            rotate ([0,90,0])
                cylinder (h = 100, r = M3_screw_diameter/2, $fn = 20);
            
        //bevelled edge
        translate([depth/2, width/2-1, -3])
            rotate([0,0,45])
                cube([depth/2,depth/2,height+6]);

        translate([-(depth/2),width/2-1,-3])
            rotate([0,0,45])
                cube([depth/2,depth/2,height+6]);

        translate([-(depth/2),-uhlopricka_2-width/2+1,-3])
            rotate([0,0,45])
                cube([depth/2,depth/2,height+6]);

        translate([depth/2,-uhlopricka_2-width/2+1,-3])
            rotate([0,0,45])
                cube([depth/2,depth/2,height+6]);
    }
}	


/*translate ([75, 0, 62])
    rotate([0, 180, 0])
        666_1028_drillhelper();
*/

666_1028();

//For printing size limits check.
//translate([0,-75,0])
  //cube ([150,150,150]);









