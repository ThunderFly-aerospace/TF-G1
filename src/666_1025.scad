/*
// Nastavení zobrazení
$vpr = [338, 0, 357];
$vpt = [180, 25, -18];
$vpd = 1280;
*/
//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

/*
TODO:

Přední díl obsahuje převis ve směru vybrání pro držák motoru. (U horního zámku)
Otvory pro šrouby v předním dílu jsou oválné, protože nejsou kolmo k rovině modelu.


*/


////// otvory pro šrouby pro připevnění k dílu 666_1027
module screw_top (position_number, draft){
            //funkce

            distance_top = - hull_drop_length * surface_distance(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false);
            //echo (distance_top);

        if (position_number > 2 && position_number < 5) //tato podmínka znamená, že v pozici 2,3 a 4 se šroub neotáčí podle surface_angle a ani neposouvá podle surface_distance, protože je na podložce rovná hrana. Je tam tedy dané pevné posunugí -hull_z_size/2
        {


            if (distance_top <= - (hull_z_size - 2*hull_corner_radius)/2)
            {
                distance_top = - (hull_z_size - 2*hull_corner_radius)/2;

                translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size/2])
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

            //final if
            }

            else
            {
                distance_top = distance_top;

                translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,- hull_z_size])
                    cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            //final if
            }

        //final if
        }
        else
        {
            if (distance_top <= - (hull_z_size - 2*hull_corner_radius)/2)
            {
                distance_top = - (hull_z_size - 2*hull_corner_radius)/2;

                translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
                    rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            //fianl if
            }

            else
            {
                distance_top = distance_top;

                translate([hull_drop_length * (top_screw_position[position_number]/hull_drop_length),main_tube_outer_diameter/4,distance_top])
                    rotate([0,surface_angle(x = top_screw_position[position_number]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            cylinder(h = 40, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
            //final if
            }

        //final if
        }

//final module
}


/////////////////////////////////////
module 666_1025(draft = true){

    //UPPER SCREWS


    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness


union(){

    difference(){
        union(){
            difference(){
                union(){
                    //základní kapka
                    intersection (){
                            drop_skin(draft);
                    translate([0,0,- hull_z_size/2])
                            cube([hull_drop_length, hull_y_size + 10, hull_z_size]);
                    }

                    intersection(){
                    // 666_1032 part holder - limit the size to maximum printable size by intersection with cube
                    translate([cover_pilon_position,0,0])
                        rotate ([-90,0,0])
                            translate ([hull_wall_thickness,0,0])
                                resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance - global_clearance ,(170*0030/100) - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                                    airfoil(naca = 0030, L = 170, N = draft ? 30 : 100, h = draft ? 30 : 100, open = false);

                    translate ([0,-(main_tube_outer_diameter/2)-hull_wall_thickness, -hull_z_size/2])
                            cube ([hull_x_size, hull_y_size,hull_z_size]);
                    }
                }

            translate([hull_wall_thickness,0,0])
                    hollowing_skeleton(hull_wall_thickness, draft);
            }

            //lem
                intersection(){
                    difference(){
                        translate([0,0,-hull_z_size/2])
                            cube([hull_x_size, hull_wall_thickness, hull_z_size]); // spodní lem

                        //odebrání dna
                        translate([ribbon_width/2,0,0])
                            hollowing_skeleton(ribbon_width, draft);
                    }

                //odstranění dna z vnější strany krytu
                    drop(draft);
              }
        }

            //engine holder
            translate ([-global_clearance,-1 - main_tube_outer_diameter/2 - hull_wall_thickness, - width_of_engine_holder/2])
                   cube ([ top_cover_division[1] + global_clearance, hull_y_size+10, width_of_engine_holder]);

            //for tube in back
            translate ([hull_x_size-70,0,0])
                rotate ([0,90,0])
                    cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 20 : 50);

            //for rotor pilon
            translate ([cover_pilon_position+2*hull_wall_thickness,-10,0])
                rotate ([-90,0,0])
                    resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                        airfoil(naca = 0030, L = 170, N = draft ? 30 : 100, h = 200, open = false);

            //šrouby

            for (position_number = [1:5])
            {
                screw_top(position_number, draft);
                mirror([0,0,1])
                    screw_top(position_number, draft);
            }

            //spojení částí C a D

            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                   union(){
                               cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([0,0, - M3_nut_height - 5])
                                cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                        translate([M3_nut_diameter/2,0, - M3_nut_height - 5])
                            rotate([0,0,90])
                                cube([20,M3_nut_diameter, M3_nut_height]);
                        translate([0,0,3])
                                cylinder(h = 30, r = M3_nut_diameter/2, $fn = draft ? 100 : 200);
                    }

            mirror([0,0,1])

            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                    union(){
                                cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([0,0, - M3_nut_height - 5])
                                cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                        translate([M3_nut_diameter/2,0, - M3_nut_height - 5])
                            rotate([0,0,90])
                                cube([20,M3_nut_diameter, M3_nut_height]);
                        translate([0,0,3])
                                cylinder(h = 30, r = M3_nut_diameter/2, $fn = draft ? 100 : 200);
                    }

         /*   //nápis
            translate([hull_x_size/4 + 35, hull_y_size/4, hull_z_size/2 - hull_wall_thickness/5])
                linear_extrude(hull_wall_thickness)
                    text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");

            // boční text s identifikací

            translate([hull_x_size/4 + 35, hull_y_size/4, -hull_z_size/2 + hull_wall_thickness/5])
                rotate([0,180,0])
                    linear_extrude(hull_wall_thickness)
                        text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");
        */

    //uchycení rotorové hlavy

pozadovana_vyska = 70;
pozadovany_uhel = 10;
tyc = pozadovana_vyska / (sin(pozadovany_uhel));
uhlopricka = pozadovana_vyska / (tan(pozadovany_uhel));
strana_a = (uhlopricka*(cos(45)))/2;

    translate([-strana_a/2 + main_pilon_position,0,strana_a/2])
        union(){
                rotate([-90 - pozadovany_uhel,0,-pozadovany_uhel])
                    cylinder(h= tyc, r = main_tube_outer_diameter/4, $fn = 100);
            translate([strana_a,0,0])
                rotate([-90 - pozadovany_uhel,0,pozadovany_uhel])
                   cylinder(h= tyc, r = main_tube_outer_diameter/4, $fn = 100);

            translate([strana_a,0,-strana_a])
                rotate([-90 + pozadovany_uhel,0,pozadovany_uhel])
                    cylinder(h= tyc, r = main_tube_outer_diameter/4, $fn = 100);
            translate([0,0,- strana_a])
                rotate([-90 + pozadovany_uhel,0,-pozadovany_uhel])
                    cylinder(h= tyc, r = main_tube_outer_diameter/4, $fn = 100);
        }
translate([-engine_holder_beam_depth+beam_patern*5.5, 0, 0])

   rotate([180,0,0])
   union(){
        translate([0, pilon_pipe_base_front_y, pilon_pipe_base_front_z])
            orientate([-pilon_pipe_base_front_x + pilon_pipe_head_front_x, -(pilon_pipe_base_front_y-pilon_pipe_head_front_y), height_of_vertical_tube-pilon_pipe_base_front_z],vref=[0,0,1], roll=0)
                rotate([90,0,0])    
                    translate([0, 0, -20])
                       % cylinder(d = pilon_pipe_diameter, h = 500, $fn = draft? 20 : 60);
   }

    //final difference
    }

        intersection(){
            union(){

                //přední stěna Z+
                translate([0, 0, width_of_engine_holder/2 ])
                   cube([top_cover_division[1], hull_y_size, hull_wall_thickness]);

                //přední stěna Z-
                translate([0, 0, - hull_wall_thickness - width_of_engine_holder/2])
                    cube([top_cover_division[1], hull_y_size, hull_wall_thickness]);

                //pro rovnou horní hranu předního lemu
                difference()
                {
                    translate([top_cover_division[1] - hull_wall_thickness, main_tube_outer_diameter, -width_of_engine_holder/2 - hull_wall_thickness])
                        cube([hull_wall_thickness, hull_y_size, width_of_engine_holder + 2* hull_wall_thickness]);

                    // otvor pro prostup přívodů k motoru
                    translate([top_cover_division[1] - hull_wall_thickness*2, main_tube_outer_diameter, width_of_engine_holder/2 - 10])
                        cube([hull_wall_thickness*4, 400, 7]);
                }

                // lem pro výztuhu a slepení dílu A
                difference(){
                    union(){
                        translate([top_cover_division[1] - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        //pro lepení - čtverec
                        //difference(){
                            translate([top_cover_division[2] - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance,-hull_z_size])
                                cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                        //odečtení nápisu od příčné výztuhy
                        //nápis
                        /*    translate([hull_x_size/4 + 35, hull_y_size/4, hull_z_size/2 - hull_wall_thickness/5])
                                linear_extrude(hull_wall_thickness)
                                    text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");

                        // boční text s identifikací
                            translate([hull_x_size/4 + 35, hull_y_size/4, -hull_z_size/2 + hull_wall_thickness/5])
                                rotate([0,180,0])
                                    linear_extrude(hull_wall_thickness)
                                        text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");
                        */
                        //}

                        //pro lepení - čtverec
                        difference(){
                            union(){
                                translate([top_cover_division[3] - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance,-hull_z_size])
                                        cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                                translate([top_cover_division[3], main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, -hull_z_size])
                                        cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);
                            }

                            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                                    cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

                            mirror([0,0,1])
                            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                                    cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        }

                        //pro lepení - čtverec
                        translate([top_cover_division[4], main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, -hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        //výztuha uprostřed
                        difference(){
                            translate([0,0,-hull_wall_thickness])
                                 cube([hull_x_size, hull_z_size*2, 2*hull_wall_thickness]);
                            translate ([-global_clearance,-1 - main_tube_outer_diameter/2 - hull_wall_thickness, - width_of_engine_holder/2])
                               cube ([ top_cover_division[1] + global_clearance, hull_y_size+10, width_of_engine_holder]);
                                    //for tube in back
                            translate ([hull_x_size-70,0,0])
                                rotate ([0,90,0])
                                    cylinder (h = 80, r =  main_tube_outer_diameter/2, $fn = draft ? 20 : 50);

                        }

                        //podélná výztuha
                        //difference(){
                            union(){
                                translate([top_cover_division[1],main_tube_outer_diameter/2 + 4*coupling_wall_thickness + global_clearance,-hull_z_size/2])
                                    cube([top_cover_division[4] - top_cover_division[1], hull_wall_thickness, hull_z_size]);
                                translate([top_cover_division[1],main_tube_outer_diameter/2 + 2*coupling_wall_thickness + global_clearance,-hull_z_size/2])
                                    cube([top_cover_division[4] - top_cover_division[1], hull_wall_thickness, hull_z_size]);

                                translate([0,0,width_of_engine_holder/2 + hull_wall_thickness])       // výztuha v přední části krytu
                                    rotate([-48,0,0])
                                        cube([top_cover_division[1], hull_wall_thickness, hull_z_size]);

                                mirror([0,0,1])
                                translate([0,0,width_of_engine_holder/2 + hull_wall_thickness])       // výztuha v přední části krytu
                                    rotate([-48,0,0])
                                        cube([top_cover_division[1], hull_wall_thickness, hull_z_size]);

                            }
                        //odečtení nápisu od podélné výztuhy
                        //nápis
                        /*    translate([hull_x_size/4 + 35, hull_y_size/4, hull_z_size/2 - hull_wall_thickness/5])
                                linear_extrude(hull_wall_thickness)
                                    text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");

                        // boční text s identifikací

                            translate([hull_x_size/4 + 35, hull_y_size/4, -hull_z_size/2 + hull_wall_thickness/5])
                                rotate([0,180,0])
                                    linear_extrude(hull_wall_thickness)
                                        text("TF-G1", size = 30, halign = "center", valign = "center", font = "PT Sans");
                        */
                        //}

                    }


                    //pro lepení - odstranění kusu z díry pro horní držák
                    translate ([180+2*hull_wall_thickness,-10,0])
                        rotate ([-90,0,0])
                            resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*0030/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                               airfoil(naca = 0030, L = 170, N = draft ? 50 : 100, h = 200, open = false);

                   translate([ribbon_width/2,0,0])
                        hollowing_skeleton(ribbon_width, draft);
                }

            }
            //odstranění přesahů z vnější strany
            drop(draft);
        }

 //šrouby mezi díly 2 a 3


       intersection(){
       		union(){
                difference(){

            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 12,38])
               rotate([90,0,0])
                            union(){
                                translate([15,7,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 20, r = 20, $fn = draft ? 100 : 200);
                                            translate([0,0,20])
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                        }
                                mirror([1,0,0])
                                translate([21,7,-12])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 15, r = 20, $fn = draft ? 100 : 200);
                                            translate([0,0,15])
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                        }
                            }
            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                    union(){
                                cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([0,0, - M3_nut_height - 5])
                                cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                        translate([M3_nut_diameter/2,0, - M3_nut_height - 5])
                            rotate([0,0,90])
                                cube([20,M3_nut_diameter, M3_nut_height]);
                        translate([0,0,3])
                                cylinder(h = 30, r = M3_nut_diameter/2, $fn = draft ? 100 : 200);

                    }

                }
            }
            drop(draft);

        //intersection
        }

    mirror([0,0,1])
       intersection(){

            union(){
                difference(){
            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 12,38])
                rotate([90,0,0])
                            union(){
                                translate([15,7,-13])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 20, r = 20, $fn = draft ? 100 : 200);
                                            translate([0,0,20])
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                        }
                                mirror([1,0,0])
                                translate([21,7,-12])
                                    rotate([0,-75,0])
                                        union(){
                                                cylinder(h = 15, r = 20, $fn = draft ? 100 : 200);
                                            translate([0,0,15])
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                                sphere (r = 20,$fs = 0.5, $fa = 10);
                                        }
                            }
            translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false) - 15,40])
                rotate([ 2* (surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false)),90,0])
                    union(){
                                cylinder(h = 30, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                        translate([0,0, - M3_nut_height - 5])
                                cylinder(h = M3_nut_height, r = M3_nut_diameter/2, $fn = 6);
                        translate([M3_nut_diameter/2,0, - M3_nut_height - 5])
                            rotate([0,0,90])
                                cube([20,M3_nut_diameter, M3_nut_height]);
                        translate([0,0,3])
                                cylinder(h = 30, r = M3_nut_diameter/2, $fn = draft ? 100 : 200);

                    }

                }
            }
            drop(draft);

        //intersection
        }

//final union

}


//konec model celek
}



module 666_1025_part_A(part_number, draft){

    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    division_position = top_cover_division[part_number];
    previous_division = top_cover_division[part_number - 1];

    part_lenght = division_position - previous_division;
    lock_width = 10;
    part_flip = 4;  // část od které se otáčí pořadí zámků.

    if (part_number < part_flip) {
        difference(){
            union(){
                //základní dělení pro tisk
                intersection(){
                    666_1025(draft);
                    translate([previous_division + global_clearance/100,-20,0])
                        cube([part_lenght - global_clearance/100, 150*2, 150]);
                }

                //zámky přidané
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - lock_length + hull_wall_thickness, main_tube_outer_diameter,0])
                                   cube([lock_length, hull_y_size, lock_width/2]);
                            //čtverec pro zámek Z+
                            translate([previous_division - lock_length + hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + 3*hull_wall_thickness, main_tube_outer_diameter ])
                                    cube([lock_length, lock_width, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky
                }

            //final union
            }

            //zámky odečtení
            if (part_number != (part_flip-1)){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - lock_length - global_clearance/2 + hull_wall_thickness, main_tube_outer_diameter,- global_clearance/2])
                                cube([lock_length + global_clearance/2, hull_y_size, lock_width/2 + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([division_position - lock_length - global_clearance/2 + hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness,hull_z_size/2 - main_tube_outer_diameter])
                                cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky vlevo
                }
            }

        //final difference
        }
    }
    else{       // pokud jde o díl až za prostředním dělením.

        difference(){
            union(){
                //základní dělení pro tisk
                intersection(){
                    666_1025(draft);
                    translate([previous_division - global_clearance/100, -20,0])
                        cube([part_lenght - global_clearance/100, 150*2, 150]);
                }

                //zámky přidané
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - hull_wall_thickness, main_tube_outer_diameter, 0])
                                    cube([lock_length, hull_y_size, lock_width/2]);
                            //čtverec pro zámek Z+
                            translate([division_position - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + 3*hull_wall_thickness, main_tube_outer_diameter])
                                    cube([lock_length, lock_width, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky
                }
            //final union
            }

            if (part_number != part_flip){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.
                //zámky odečtení
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - hull_wall_thickness, main_tube_outer_diameter/2, - global_clearance/2])
                                cube([lock_length + global_clearance/2, hull_y_size, lock_width/2 + global_clearance]);
                            //čtverec pro zámek Z+
                            translate([previous_division - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness, main_tube_outer_diameter])
                                cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky vlevo
                }
            }
        //final difference
        }

    }
//final module
}


module 666_1025_part_B(part_number, draft){
    beta = 90 - trailing_edge_angle(naca = hull_airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness

    division_position = top_cover_division[part_number];
    previous_division = top_cover_division[part_number - 1];

    part_lenght = division_position - previous_division;
    lock_width = 10;
    part_flip = 4;  // část od které se otáčí pořadí zámků.

    if (part_number < part_flip) {
        difference(){
            union(){
                //základní dělení pro tisk
                intersection(){
                    666_1025(draft);
                    translate([previous_division + global_clearance/100,-20,-150])
                        cube([part_lenght - global_clearance/100, 150*2, 150]);
                }

                //zámky přidané
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - lock_length + hull_wall_thickness, main_tube_outer_diameter,-lock_width/2])
                                   cube([lock_length, hull_y_size, lock_width/2]);
                            //čtverec pro zámek Z-
                            translate([previous_division - lock_length + hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + 3*hull_wall_thickness, - hull_z_size - main_tube_outer_diameter])
                                    cube([lock_length, lock_width, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky
                }

            //final union
            }

            //zámky odečtení
            if (part_number != (part_flip-1)){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - lock_length - global_clearance/2 + hull_wall_thickness, main_tube_outer_diameter,-lock_width/2 - global_clearance/2])
                                cube([lock_length + global_clearance/2, hull_y_size, lock_width/2 + global_clearance]);
                            //čtverec pro zámek Z-
                            translate([division_position - lock_length - global_clearance/2 + hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness,- hull_z_size - main_tube_outer_diameter ])
                                cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky vlevo
                }
            }

        //final difference
        }
    }
    else{       // pokud jde o díl až za prostředním dělením.

        difference(){
            union(){
                //základní dělení pro tisk
                intersection(){
                    666_1025(draft);
                    translate([previous_division - global_clearance/100, -20,0])
                        cube([part_lenght - global_clearance/100, 150*2, 150]);
                }

                //zámky přidané
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([division_position - hull_wall_thickness, main_tube_outer_diameter, -lock_width/2])
                                    cube([lock_length, hull_y_size, lock_width/2]);
                            //čtverec pro zámek Z-
                            translate([division_position - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + 3*hull_wall_thickness, -main_tube_outer_diameter - hull_z_size ])
                                    cube([lock_length, lock_width, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky
                }
            //final union
            }

            if (part_number != part_flip){   // na společném lemu pro prostřední díl se otvory na zámky vynechávají.
                //zámky odečtení
                union(){
                    intersection(){
                        drop_skin(draft);
                        union(){
                            //čtverec pro zámek horní
                            translate([previous_division - hull_wall_thickness, main_tube_outer_diameter/2, -lock_width/2 - global_clearance/2])
                                cube([lock_length + global_clearance/2, hull_y_size, lock_width/2 + global_clearance]);
                            //čtverec pro zámek Z-
                            translate([previous_division - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness, - main_tube_outer_diameter - hull_z_size])
                                cube([lock_length + global_clearance/2, lock_width + global_clearance, hull_z_size]);
                        //union
                        }
                    //intersection
                    }
                //union zámky vlevo
                }
            }
        //final difference
        }

    }


//final module
}

/*

666_1025_part_A(1, draft);

translate([0,0,-10])
666_1025_part_B(1, draft);

*/


666_1025(draft);


use <888_1000.scad>
use <666_1027.scad>

use <./lib/naca4.scad>
include <../parameters.scad>
