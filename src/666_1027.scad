/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/

draft = true;


module lightening(x_size, y_size, z_size){        // generování dutin pro snížení hmotnosti podložky

    // lightening holes list
    lightening_hole_size = 15;
    lightening_hole_spacing = 5;

    lightening_grid_list = [
        for (j = [10 : lightening_hole_size + lightening_hole_spacing : x_size], i = [10 : lightening_hole_size + lightening_hole_spacing : y_size])
    /*if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) )*/

            [j,0, i] ];


        rotate([0,45,0])
    for (j = lightening_grid_list) {
        translate(j)
            translate([0,-main_tube_outer_diameter*1.5,z_size/2])
                cube([15, 50, 15]);
    }

    for (i = [10 : lightening_hole_size + 2*lightening_hole_spacing : x_size])
        translate([i,- main_tube_outer_diameter,-z_size/2])
            rotate([0,0,45])
                cube([15, 15, z_size*2]);
}

//pouze příčné odlehčení
module lightening_pricne (x_size, y_size, z_size){

       lightening_hole_size = 15;
    lightening_hole_spacing = 5;

    lightening_grid_list = [
        for (j = [10 : lightening_hole_size + lightening_hole_spacing : x_size], i = [10 : lightening_hole_size + lightening_hole_spacing : y_size])
    /*if ((j>(x_size-10) && i>(y_size-10)) || (j<10 && i<10) || (j<10 && i>(y_size-10)) || (j>(x_size-10) && i<10) )*/
            [j,0, i] ];


        rotate([0,45,0])
    for (j = lightening_grid_list) {
        translate(j)
            translate([0,-main_tube_outer_diameter*1.5,z_size/2])
                cube([15, 50, 15]);
    }
}

//sestava - šroub, matka, kvádřík

module screw_top (position_number, draft){
	//funkce

	distance_top = - hull_drop_length * surface_distance(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
	//echo (distance_top);

	if (position_number > 1 && position_number < 5) //tato podmínka znamená, že v pozici 2,3 a 4 se šroub neotáčí podle surface_angle a ani neposouvá podle surface_distance, protože je na podložce rovná hrana. Je tam tedy dané pevné posunugí -hull_z_size/2
	{


    	if (distance_top <= - maximum_printable_size/2)
    	{
    		distance_top = - maximum_printable_size/2;
    		translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size/2])
           			union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                    	translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                        	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
    			    }
    		//final if
    		}

    	else
    	{
    		distance_top = distance_top;
    		translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size])
       		    	union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                    	translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                        	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
    			    }
    	//final if
    	}
    //final if
    }
    else
    {
    	if (distance_top <= - maximum_printable_size/2)
    	{
    		distance_top = - maximum_printable_size/2;
    		translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
    			rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
           			union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                    	translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                        	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
        				//final union
    				}
    	//fianl if
    	}

    	else
    	{
    		distance_top = distance_top;
    		translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
    			rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
       		    	union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                	    translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                    	   cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
    			    }
    	//final if
    	}
        //final if
    }
}

///////////////////////
        module screw_bottom (position_number,draft){
        	//funkce

        	distance_bottom = - hull_drop_length * surface_distance(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
        	//echo (distance_bottom);

        	if (position_number > 1 && position_number < 3)
        	{


        	if (distance_bottom <= - maximum_printable_size/2)
        	{
        		distance_bottom = - maximum_printable_size/2;
        		translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,- hull_z_size/2])
	       			union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                    	translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                        	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
        			}
        		//final if
        		}

        	else
        	{
        		distance_bottom = distance_bottom;
        		translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,- hull_z_size])
       		    	union(){
    			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                    	translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                        	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                    	translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                        	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
        			}
        	//final if
        	}
        //final if
        }
        else
 		{
        	if (distance_bottom <= - maximum_printable_size/2)
        	{
        		distance_bottom = - maximum_printable_size/2;
        		translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,distance_bottom])
        			rotate([0,surface_angle(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
		       			union(){
        			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        	translate([- M3_nut_diameter/2, 0, M3_nut_height + 2*hull_wall_thickness])
                            	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                        	translate([0,0, M3_nut_height + 2*hull_wall_thickness])
                            	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
        				}
        	//fianl if
        	}

        	else
        	{
        		distance_bottom = distance_bottom;
        		translate([hull_drop_length * (bottom_screw_position[position_number]/hull_drop_length),- main_tube_outer_diameter/4,distance_bottom])
        			rotate([0,surface_angle(x = bottom_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
	       		    	union(){
        			        cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        	translate([- M3_nut_diameter/2, 0,M3_nut_height +  2*hull_wall_thickness])
                            	cube([M3_nut_diameter,M3_nut_diameter+20,M3_nut_height]);
                        	translate([0,0,M3_nut_height +  2*hull_wall_thickness])
                            	cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
        			    }
        	//final if
        	}
        //final if
        }





//final module
}

////////////////////////////
module 666_1027(draft){

//výpočty pro odlehčení závisející na šířce kapky - počítáme počet čtverečků
/*
B = 5;       //B = šířka mezery    2 -< B -< 6
A = 15;      //A = délka uhlopříčky čtverečku    10 -< A -< 20
X = (hull_drop_length/hull_airfoil_thickness)*100;
X = surface_distance(x = base_division[1]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
Z = A * sqrt(2)			//délka strany čtverce

echo("Z is", Z);
*/


//////
distance_top = - hull_drop_length * surface_distance(x = top_screw_position[1]/hull_drop_length, naca = hull_airfoil_thickness, open = false);

////////
//A = hull_drop_length*(base_division[3]/hull_drop_length);		//délka v ose X
/*
B = hull_drop_length*surface_distance(x = base_division[1]/hull_drop_length, naca = hull_airfoil_thickness, open = false); 	//Délka v ose Z

C = (B - 5) / (15 + 5); //B -> vzdálenost v ose z
echo("C is", C);
echo(floor (C));

*/

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    hole_for_nut_x = 15;
    hole_for_nut_y = 50;
    hole_for_nut_z = 20;
    y_size = 100;
    z_size = 150;
    x_size = 580;

    //akumulátor
    width =width_of_accumulator + accumulator_holder_width;
    depth = accumulator_holder_width;
    height = height_of_accumulator - sink_of_accumulator + accumulator_holder_thickness;


    //kostka spojky pro akumulátor, ve které je umístěn otvor pro šroub
    width_cube = accumulator_holder_thickness;    //šířka kostky ve které je otvor na šroub
    depth_cube = accumulator_holder_width;
    height_cube = accumulator_holder_thickness; //výška kostky ve které je otvor na šroub


    //opticalFlow
    width_optical_flow_senzor = 45.5;
    depth_optical_flow_senzor = 10;
    height_optical_flow_senzor = 35;
    sink_of_optical_flow_senzor = depth_optical_flow_senzor - 5;
    M3_optical_flow_senzor_Z = 30.4;
    M3_optical_flow_senzor_X = 24;
    M3_optical_flow_senzor_Z_alone = 9.1;
    M3_optical_flow_senzor_X_alone = 16.7;

    //translate([move_of_accumulator,hull_corner_radius,-height_of_accumulator])
        //rotate([270,0,0])
            //888_1001();



    union(){
//samotná podložka

    difference(){
        union(){
            intersection (){
                hollowing_skeleton(hull_wall_thickness + global_clearance, draft);
                translate([main_tube_outer_diameter,-main_tube_outer_diameter/2 - thickness_between_tubes, - (hull_z_size - 2*hull_wall_thickness - 2*global_clearance)/2 ]) // podložka je vepředu seříznuta posunutím v ose X, aby vznikla toleranční mezera za přední částí krytu.
                    cube([hull_drop_length - main_tube_outer_diameter, main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness, hull_z_size - 2*hull_wall_thickness - 2*global_clearance]);
            }


            //sloupky pro GPS
            translate([hull_x_size - 115 - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness, 0])
                rotate([0, 0, 0])
                     union(){

                             translate([0, 0, -GPS_middle_length/2])
                                 rotate([-90,0,0])
                                     cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                             translate([0, 0, GPS_middle_length/2])
                                 rotate([-90,0,0])
                                     cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                             translate([(-GPS_middle_length*sqrt(3))/2, 0, 0])
                                 rotate([-90,0,0])
                                     cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                    /*
                        translate([-GPS_middle_length/2,0,0])
                            rotate([-90,0,0])
                                cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                        translate([GPS_middle_length/2,0,0])
                            rotate([-90,0,0])
                                cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20);
                        translate([0,0,(GPS_middle_length*sqrt(3))/2])
                            rotate([-90,0,0])
                                cylinder(h = 5, r1 = 2 * M3_screw_diameter, r2 = M3_screw_diameter/2 + 2, $fn = draft ? 10 :20); */
                    }

            //otvory pro šrouby k připevnění k horizontální trubce  Mylsím, že to je mrtvý kus kódu, nebo nevím co má dělat.
			/*%intersection(){
           		union(){
           			translate([base_division[1]*0.75 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, main_tube_outer_diameter/2])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);

                    translate([base_division[1] + (base_division[2] - base_division[1])/4 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, main_tube_outer_diameter/2])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);

                    translate([base_division[2]*1.15 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, main_tube_outer_diameter/2])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);


                    translate([base_division[4]*0.86 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, main_tube_outer_diameter/2])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);


           			translate([base_division[1]*0.75 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, - main_tube_outer_diameter/2 - hull_z_size])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);

                    translate([base_division[1] + (base_division[2] - base_division[1])/4 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, - main_tube_outer_diameter/2 - hull_z_size])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);

                    translate([base_division[2]*1.15 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, - main_tube_outer_diameter/2 - hull_z_size])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);


                    translate([base_division[4]*0.86 - M3_nut_diameter, - hull_y_size/2 + M3_nut_diameter/2, - main_tube_outer_diameter/2 - hull_z_size])
        				cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);

				}

           		intersection (){
                		hollowing_skeleton(hull_wall_thickness + global_clearance, draft);
                	translate([main_tube_outer_diameter,-main_tube_outer_diameter/2 - thickness_between_tubes, - hull_z_size/2]) // podložka je vepředu seříznuta posunutím v ose X, aby vznikla toleranční mezera za přední částí krytu.
                   		cube([hull_drop_length - main_tube_outer_diameter, main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness, hull_z_size]);
            	}
			}*/

		//union
        }

        //drážka pro lem od horního a spodního krytu
        difference(){
            translate ([-10,- hull_wall_thickness - global_clearance/2,- hull_z_size/2 - 10])
                cube([hull_drop_length + 20, 2*hull_wall_thickness + global_clearance, hull_z_size + 20 ]);
            translate([ribbon_width*0.75,0])
                hollowing_skeleton(1.5*ribbon_width,draft);
        }

        //for front part
        translate ([-global_clearance,-5 - main_tube_outer_diameter/2 - hull_wall_thickness,- width_of_engine_holder/2 - hull_wall_thickness - global_clearance])
            cube([top_cover_division[1] + 2, hull_y_size + 10, width_of_engine_holder + 2*hull_wall_thickness + 2*global_clearance]);

        //for tube in back
        translate ([hull_x_size-70,0,0])
            rotate ([0,90,0])
                cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 50 : 100);

        // podélné odlehčení
        translate([0,main_tube_outer_diameter/4,z_size/3.5])
            rotate ([0,90,0])
                cylinder(h = hull_drop_length, r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 20 : 50);

        translate([0,main_tube_outer_diameter/4, -z_size/3.5])
            rotate ([0,90,0])
                cylinder(h = hull_drop_length, r = tube_for_undercarriage_outer_diameter/2, $fn = draft ? 20 : 50);



        //vyříznutí díry pro horizontální trubku
        translate([0,0,0])
            rotate([0,90,0])
                cylinder(h = hull_drop_length, r = main_tube_outer_diameter/2, $fn = draft ? 50 : 100);
        translate([0,- main_tube_outer_diameter, -main_tube_outer_diameter/2])
                cube([hull_drop_length, main_tube_outer_diameter, main_tube_outer_diameter]);


/*
        //odlehčující prořezy
        translate([0,0,0])
            lightening(x_size, y_size, z_size);

        translate([112,0,30])
            lightening_pricne (x_size, y_size, z_size);
        //translate([224,0,30])
            //lightening_pricne (x_size, y_size, z_size);
        translate([-112,0,0])
            lightening_pricne (x_size, y_size, z_size);
        */


        //odečtení spojek trubek

        //666_1004 - přední
        translate([height_666_1026 + global_clearance/2, - hull_y_size/2, - height_666_1004/2 - global_clearance/2])
               cube([coupling_width_666_1004 + global_clearance, hull_y_size, height_666_1004]);

        //666_1004 - zadní
        translate([second_undercarriage_hole - coupling_width_666_1004/2 - global_clearance/2, - hull_y_size/2, - height_666_1004/2 - global_clearance/2])
                cube([coupling_width_666_1004 + global_clearance, hull_y_size, height_666_1004 + global_clearance ]);

        //666_1017 - prostředek
        translate([main_pilon_position - coupling_width_666_1017/2 - global_clearance/2, - hull_y_size/2, - coupling_width_666_1017/2 - global_clearance/2])        // rozměr v podélné ose zvětšen, aby byla možnost přesněji nastavit těžiště posouváním pilonu po hlavní trubce.
                cube ([coupling_width_666_1017 + global_clearance, hull_y_size, coupling_width_666_1017 + global_clearance]);


        //průchod kabelů od serv na ocasu hned za středním pilonem
        translate([main_pilon_position + coupling_width_666_1017/2, - hull_y_size/2, - height_666_1004/2 - global_clearance/2])
           cube([coupling_width_666_1004/2, hull_y_size, height_666_1004 + global_clearance ]);



        //šrouby a matky HORNÍ kryt - vždy spojení šroubu a matky dohromady

        for (position_number = [1:5])
        {
        		screw_top(position_number, draft);
        	mirror([0,0,1])
        		screw_top(position_number, draft);
        }

    	//šrouby a matky SPODNÍ kryt - vždy spojení šroubu a matky dohromady

        for (position_number = [1:4])
        {
        		screw_bottom(position_number, draft);
        	mirror([0,0,1])
        		screw_bottom(position_number, draft);
        }

        //spojení akumulátor + otvor na šroub + otvor na matku

        union (){
            //akumulátor
            translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - sink_of_accumulator,-height_of_accumulator*1.5])
               		cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

            //šrouby pro připevnění akumulátorů
            translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,0,-height_of_accumulator])
                rotate([270,0,0])
                    cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

            translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2,0,-height_of_accumulator])
                rotate([270,0,0])
                    cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

            //matka spodní
            translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,-main_tube_outer_diameter/4,-height_of_accumulator])
                rotate([90,0,0])
                   cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);

            translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2, - main_tube_outer_diameter/4,-height_of_accumulator])
                rotate([90,0,0])
                   cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);

            //matka horní
            translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2,-height_of_accumulator])
                rotate([90,0,0])
                   cylinder(h = M3_nut_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

            translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2, main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2,-height_of_accumulator])
                rotate([90,0,0])
                   cylinder(h = M3_nut_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

        }

        //spojení akumulátor + otvor na šroub + otvor na matku

        mirror ([0,0,1])
            union (){
                //akumulátor
                translate([move_of_accumulator,main_tube_outer_diameter/2 + coupling_wall_thickness - sink_of_accumulator,-height_of_accumulator*1.5])
                   		cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

        	    //šrouby pro připevnění akumulátorů
                translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,0,-height_of_accumulator])
                    rotate([270,0,0])
                        cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

                translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2,0,-height_of_accumulator])
                    rotate([270,0,0])
                        cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

                //matka spodní
                translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,-main_tube_outer_diameter/4,-height_of_accumulator])
                    rotate([90,0,0])
                       cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);

                translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2, - main_tube_outer_diameter/4,-height_of_accumulator])
                    rotate([90,0,0])
                       cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);

                //matka horní
                translate([move_of_accumulator - accumulator_holder_width/2 - accumulator_holder_thickness/2,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2,-height_of_accumulator])
                    rotate([90,0,0])
                       cylinder(h = M3_nut_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);

                translate([move_of_accumulator + width_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2, main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance/2,-height_of_accumulator])
                    rotate([90,0,0])
                       cylinder(h = M3_nut_height + global_clearance, r = M3_nut_diameter/2, $fn = 6);
            }


        //připevnění horizontální trubky
        //A
        translate([base_division[1]*0.75,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])
                   cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                translate([0,0, base_mounting_screw_length/2 - M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);
                translate([0,0, - hull_z_size - base_mounting_screw_length/2 + M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);
            }


        //B
        translate([base_division[1] + (base_division[2] - base_division[1])/4,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, base_mounting_screw_length/2 - M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);

                translate([0,0, - hull_z_size - base_mounting_screw_length/2 + M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);
            }


        //C
        translate([base_division[2]*1.15,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, base_mounting_screw_length/2 - M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);

                translate([0,0,  - hull_z_size - base_mounting_screw_length/2 + M3_screw_head_height])
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);
            }
        //D
        translate([base_division[4]*0.86,0,0])
            union(){
                translate([0,0, -hull_z_size/2 - 20])
                    cylinder(h = hull_z_size, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,0, (base_mounting_screw_length - 10)/2 - M3_screw_head_height])       // TODO, poslední šroub je zatím uměle o 10mm kratší
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);

                translate([0,0, - hull_z_size - (base_mounting_screw_length - 10)/2 + M3_screw_head_height])   // TODO, poslední šroub je zatím uměle o 10mm kratší
                    cylinder(h = hull_z_size, r = M3_nut_diameter/2, $fn = 6);
            }


        //sloupky pro GPS anténu - matky a otvory pro šrouby
        translate([hull_x_size - 115 - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness, 0])
            union(){
                translate([0,- main_tube_outer_diameter,-GPS_middle_length/2])
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                translate([0,- main_tube_outer_diameter,GPS_middle_length/2])
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
                translate([(-GPS_middle_length*sqrt(3))/2,- main_tube_outer_diameter, 0])
                    rotate([-90,0,0])
                        cylinder (h = 54, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

                translate([0,- main_tube_outer_diameter*1.5, -GPS_middle_length/2])
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);
                translate([0,- main_tube_outer_diameter*1.5, GPS_middle_length/2])
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);
                translate([(-GPS_middle_length*sqrt(3))/2,- main_tube_outer_diameter*1.5, 0])
                    rotate([-90,0,0])
                        cylinder(h = main_tube_outer_diameter, r = M3_nut_diameter/2, $fn = 6);

            }
/*
//ODLEHČENÍ
for (position_number = [1:5]){
B = hull_drop_length*surface_distance(x = base_division[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false); 	//Délka v ose Z

C = (B - 5) / (15 + 5); //B -> vzdálenost v ose z
echo("C is", C);
echo(floor (C));


//for (i = [0:10*sqrt(2) + 5: hull_drop_length*(base_division[position_number]/hull_drop_length)], j = [0: 10*sqrt(2) + 5 : B])
	for(i = [0: 15 + 10 : hull_drop_length*(base_division[position_number]/hull_drop_length)], j = [0: 15 + 5 : floor(C) * 15 + floor(C) * 5 ])

{

translate([35,0,0])
rotate([0,180,180])
%union(){
translate([i,0,j])
	rotate([0,45,0])
		cube ([10,hull_z_size, 10], center = true);
}
}
}
*/
    //final difference
    }
/*
intersection(){
	        translate([base_division[1]*0.75,0,0])
        	translate([-M3_nut_diameter, - hull_y_size/2, main_tube_outer_diameter])
        		cube([M3_nut_diameter*2, hull_y_size/2, hull_z_size]);
hollowing_skeleton(hull_wall_thickness,draft);

}*/
    //final union
    }

//final part
}

module 666_1027_part(part_number, draft){

    division_position = base_division[part_number];
    previous_division = base_division[part_number - 1];

    part_lenght = division_position - previous_division;

    intersection(){
        666_1027(draft);
            translate([previous_division,-75,-75])
                    cube([part_lenght,150,150]);
    }

//fianl part module
}

666_1027(draft);

 /*
    666_1027_part(1,draft);

translate([20,0,0])
    666_1027_part(2,draft);

translate([40,0,0])
    666_1027_part(3,draft);

translate([60,0,0])
    666_1027_part(4,draft);
*/

//666_1025();
//666_1029();


/*
//jen znázornění držáku akumulátoru
translate([move_of_accumulator ,main_tube_outer_diameter/2 + coupling_wall_thickness,height_of_accumulator])
    rotate([-90,0,0])
        888_1001();
translate([move_of_accumulator ,main_tube_outer_diameter/2 + coupling_wall_thickness,-height_of_accumulator])
    rotate([-90,0,0])
        888_1001();
*/
use <./lib/naca4.scad>
include <../parameters.scad>
use <666_1032.scad>
use <666_1004.scad>
use <666_1026.scad>
use <888_1001.scad>
use <666_1025.scad>
use <666_1029.scad>
use <888_1000.scad>
use <888_1001.scad>
use <888_1003.scad>
