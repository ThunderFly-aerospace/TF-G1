
// Nastavení zobrazení
/*$vpr = [ 80.90, 0.00, 27.10 ];
$vpt = [ 307.28, 104.40, -30.79 ];
$vpd = 1433.98;
*/
//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


/*
TODO:

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
module 888_1025(draft = true){

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
                            drop(draft);
                            translate([0,0,- hull_z_size/2])
                                    cube([hull_drop_length, hull_y_size + 10, hull_z_size]);
                        }

                        intersection(){
                            // kryt pylonu - limit the size to maximum printable size by intersection with cube
                            translate([cover_pilon_position,0,0])
                                rotate ([-90,0,0])
                                    translate ([hull_wall_thickness,0,0])
                                        resize([170 - hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance - global_clearance ,(170*cover_pilon_naca/100) - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                                            airfoil(naca = cover_pilon_naca, L = 170, N = draft ? 30 : 100, h = draft ? 30 : 100, open = false);

                            translate ([0,-(main_tube_outer_diameter/2)-hull_wall_thickness, -hull_z_size/2])
                                    cube ([hull_x_size, hull_y_size,hull_z_size]);
                        }
                    }
                    difference(){
                        translate([hull_wall_thickness,0,0])
                            hollowing_skeleton(hull_wall_thickness, draft);

                        // materiál pro šrouby mezi díly 2 a 3
                        rotate([45,0,0])
                           translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            scale([1.8, 1, 1])
                              sphere (r = 20, $fs = 0.5, $fa = 10);

                        rotate([-45,0,0])
                           translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                            scale([1.8, 1, 1])
                              sphere (r = 20, $fs = 0.5, $fa = 10);

                        //přední stěna Z+
                        translate([0, 0, width_of_engine_holder/2 ])
                         cube([top_cover_division[1], hull_y_size, hull_wall_thickness]);

                        //přední stěna Z-
                        translate([0, 0, - hull_wall_thickness - width_of_engine_holder/2])
                          cube([top_cover_division[1], hull_y_size, hull_wall_thickness]);
                    }
                }
            }

            //engine holder
            translate ([-global_clearance,0 , - width_of_engine_holder/2])
                cube ([ top_cover_division[1] + global_clearance, hull_y_size/4, width_of_engine_holder]);

            translate ([0,hull_y_size/4 ,0])
                rotate ([0,90,0])
                   cylinder(d = width_of_engine_holder, h = width_of_engine_holder);

            //for rotor pilon
            translate ([cover_pilon_position+2*hull_wall_thickness,-10,0])
                rotate ([-90,0,0])
                    resize([170 - 2*hull_wall_thickness  - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*cover_pilon_naca/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                        airfoil(naca = cover_pilon_naca, L = 170, N = draft ? 30 : 100, h = 200, open = false);

            // díry pro šrouby ke spojení krytu
            rotate([45,0,0])
                translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                    translate([7,-5,0])
                        rotate([0,0,(15 + surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false))])
                            rotate([90,0,-90])
                                bolt(size = 3, length = 12, pocket = true, pocket_size = 35);

            rotate([-45,0,0])
                translate([hull_drop_length * (top_cover_division[3]/hull_drop_length), hull_drop_length * surface_distance(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false),0])
                    translate([7,-5,0])
                        rotate([0,0,(15 + surface_angle(x = top_cover_division[3]/hull_drop_length, naca = hull_airfoil_thickness, open = false))])
                            rotate([90,0,-90])
                                bolt(size = 3, length = 12, pocket = true, pocket_size = 35);

            //šrouby
            for (position_number = [1:5])
            {
                screw_top(position_number, draft);
                mirror([0,0,1])
                    screw_top(position_number, draft);
            }

        //final difference
        }

        intersection(){
                // lemy pro výztuhu a slepení
                difference(){
                    union(){

                        // spodní lem
                        translate([0,0,-hull_z_size/2])
                            cube([hull_x_size, hull_wall_thickness, hull_z_size]);

                        //lemy pro slepení dílů ve směru délky krytu (v podélném směru)

                        translate([top_cover_division[1] - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, - hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        translate([top_cover_division[2] - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance,-hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        // lem u šroubového spoje
                        translate([top_cover_division[3] - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance,-hull_z_size])
                            cube([hull_wall_thickness * 2, hull_y_size, hull_z_size*2]);

                        translate([top_cover_division[4], main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, -hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        translate([top_cover_division[5], main_tube_outer_diameter/2 + coupling_wall_thickness + global_clearance, -hull_z_size])
                            cube([hull_wall_thickness, hull_y_size, hull_z_size*2]);

                        //podélná výztuha boční
                        translate([top_cover_division[1],main_tube_outer_diameter/2 + 4*coupling_wall_thickness + global_clearance,-hull_z_size/2])
                            cube([top_cover_division[5] - top_cover_division[1], hull_wall_thickness, hull_z_size]);
                        translate([top_cover_division[1],main_tube_outer_diameter/2 + 2*coupling_wall_thickness + global_clearance,-hull_z_size/2])
                            cube([top_cover_division[5] - top_cover_division[1], hull_wall_thickness, hull_z_size]);

                        // honí podélná výztuha
                        translate([0,0,-hull_wall_thickness])
                             cube([hull_x_size, hull_z_size*2, 2*hull_wall_thickness]);

                        // malé výztuhy v přední části krytu
                        translate([0,0,width_of_engine_holder/2 + hull_wall_thickness])       // výztuha v přední části krytu
                            rotate([-48,0,0])
                                cube([top_cover_division[1], hull_wall_thickness, hull_z_size]);

                        mirror([0,0,1])
                        translate([0,0,width_of_engine_holder/2 + hull_wall_thickness])       // výztuha v přední části krytu
                            rotate([-48,0,0])
                                cube([top_cover_division[1], hull_wall_thickness, hull_z_size]);
                    }
                    //pro lepení - odstranění kusu lemů  z díry pro horní otvor
                    translate ([cover_pilon_position + 2*hull_wall_thickness,-10,0])
                        rotate ([-90,0,0])
                            resize([170 - 2*hull_wall_thickness - trailing_wall*hull_wall_thickness - trailing_wall*global_clearance  - global_clearance - trailing_wall*hull_wall_thickness ,(170*cover_pilon_naca/100) - 2*hull_wall_thickness - 2*hull_wall_thickness - 2*global_clearance ,200], auto=true)
                               airfoil(naca = cover_pilon_naca, L = 170, N = draft ? 50 : 100, h = 200, open = false);

                   // odstranění výztuhy v místě držáku předního motoru
                   translate ([-global_clearance,0 , - width_of_engine_holder/2])
                       cube ([ top_cover_division[1] + global_clearance, hull_y_size/4, width_of_engine_holder]);

                   translate ([0,hull_y_size/4 ,0])
                       rotate ([0,90,0])
                          cylinder(d = width_of_engine_holder, h = width_of_engine_holder);

                   translate([ribbon_width + hull_wall_thickness, 0, 0])
                        hollowing_skeleton(ribbon_width, draft);
                }

            //odstranění přesahů z vnější strany
            drop(draft);
        }
    }
//konec model celek
}



module 888_1025_part_A(part_number, draft){

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
                    888_1025(draft);
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
                            translate([division_position - lock_length - global_clearance/2 + hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness, 0])
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
                    888_1025(draft);
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


module 888_1025_part_B(part_number, draft){
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
                    888_1025(draft);
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
                    888_1025(draft);
                    translate([previous_division - global_clearance/100, -20,-150])
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
                            translate([division_position - hull_wall_thickness, main_tube_outer_diameter/2 + coupling_wall_thickness + 3*hull_wall_thickness, -hull_z_size ])
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
                            translate([previous_division - hull_wall_thickness, main_tube_outer_diameter/2, - lock_width/2 - global_clearance/2])
                                cube([lock_length + global_clearance/2, hull_y_size, lock_width + global_clearance]);
                            //čtverec pro zámek Z-
                            translate([previous_division - hull_wall_thickness,main_tube_outer_diameter/2 + coupling_wall_thickness - global_clearance/2 + 3*hull_wall_thickness, -hull_z_size])
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


module position_888_1025(){
    translate([-engine_holder_beam_depth - hull_wall_thickness, 0, 0]) // musí to být posunuto asi o těch 6mm a nevím proč.
        rotate([90,0,0])
            children();
}

/*

888_1025_part_A(1, draft);

translate([0,0,-10])
888_1025_part_B(1, draft);

*/

position_888_1025()
    888_1025(draft);

use <888_1000.scad>

use <./lib/stdlib/naca4.scad>
use <./lib/stdlib/bolts.scad>
include <../parameters.scad>
