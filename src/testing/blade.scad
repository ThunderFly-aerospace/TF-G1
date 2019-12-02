include <../../parameters.scad>
use <../lib/stdlib/naca4.scad>

//rotorblade_naca = 4412;
rotorblade_naca = 0014;
rotorblade_depth = 65;
echo(rotorblade_depth);

blade_length = 140*6;
//blade_length = 140*3;

blade_root_depth = 50;
blade_root_length = 110-10;
blade_root_thickness = 12;
blade_root_angle = 0;

blade_root_translation_length = 20+10;

blade_root_holes_positions = [
        [0, 0],
        [10+17-9, 20],
        [0, 40],
        [10+17-10.4, 60],
        [0, 80]
    ];

blade_print_cuts = [0, 140, 140*2, 140*3, 140*4, 140*5, 140*6];


airfoil_length = blade_length - blade_root_length - blade_root_translation_length;

rotorblade_infill_space = 0.01;
space = 15;
perimeter = 0.41;
wall = perimeter*1.5;
height = 0;
trailing_edge_crop = 1;
blade_spine_rod_list = [
[-5, 0, 2.3],
[-10, 0, 2.3],
[10, 0, 2.3]
];

module blade_basic(){
    translate([-rotorblade_depth*.25, 0, 0])
    difference(){
        airfoil(naca = rotorblade_naca, L = rotorblade_depth, N= $preview? 100 : 300, h = airfoil_length, open = true);
        difference(){
            intersection(){
                difference(){
                    scale(0.97) // skalovani zde odstranuje nechtene artefakty po skalovani
                        airfoil(naca = rotorblade_naca, L = rotorblade_depth, N= $preview? 100 : 300, h = airfoil_length, open = true);
                    hollow_airfoil(naca= rotorblade_naca, L = rotorblade_depth, N =  $preview? 100 : 300, h = airfoil_length, open = true, wall_thickness = wall*2.5);
                }
                union(){
                    for(i = [-6: 20]){
                        translate([0, 0, i*space])
                            rotate([0, 45, 0])
                                cube([rotorblade_infill_space, 50, 200], center = true);

                        translate([0, 0, i*space])
                            rotate([0, -45, 0])
                                cube([rotorblade_infill_space, 50, 200], center = true);
                    }
                }
            }
        }

        translate([rotorblade_depth - trailing_edge_crop, -10, 0])
            cube([trailing_edge_crop+global_clearance, 20, airfoil_length]);

        // for(i=[1:8])
        //     translate([rotorblade_depth/4, 0, i*15])
        //         rotate([90, 0, 0])
        //             cylinder(d = 1.5, h=20, center=true, $fn = 15);

    }

}


module blade_basic_inner(){
    translate([-rotorblade_depth*.25, 0, 0])
        difference(){
            scale(0.97) // skalovani zde odstranuje nechtene artefakty po skalovani
               //cube(400, center = true);
               airfoil(naca = rotorblade_naca, L = rotorblade_depth, N= $preview? 100 : 300, h = airfoil_length, open = false);
               translate([-0.05, 0, 0]) hollow_airfoil(naca= rotorblade_naca, L = rotorblade_depth, N =  $preview? 100 : 300, h = airfoil_length, open = true, wall_thickness = wall*2);
        }
}


// modul tvorici otvory pro podelne vyztuhy
module blade_spine_holes(offset = 0){
    for (i=blade_spine_rod_list) {
        translate([i[0], i[1], 0])
            cylinder(d = i[2] + 2*offset, h = blade_length, $fn = $preview? 7 : 50);
    }

    for (i=[0, 1, 2])
      for (j=[5:30:blade_length-20])
        translate([blade_spine_rod_list[i][0], 0, j+i*10]){{
              rotate([90, 0, 0]) cylinder(d = 1.5, h = 20, center = true, $fn = $preview? 7 : 30);
        }
    }


}

module blade_root_holes(offset = 0){

    for(x=blade_root_holes_positions){
        translate([x[0], 50/2, x[1]+10])
            rotate([90, 0, 0])
                cylinder(d = M3_screw_diameter + 2*offset, h = 50, $fn = $preview? 7 : 50);
    }
}

module blade_root(){
    translate([-blade_root_depth*0.25, -blade_root_thickness/2, 0])
        cube([blade_root_depth, blade_root_thickness, blade_root_length]);
}


module blade_root_inner(){
    translate([-blade_root_depth*0.25 + wall*1.5, -blade_root_thickness/2 + wall*1.5, 0])
        cube([blade_root_depth - 3*wall, blade_root_thickness - 3*wall, blade_root_length]);
}



// funkce, ktera vytvari prechod mezi korenem listu a jeho airfoil
module blade_root2airfoil(){
        difference(){
        hull(){
            translate([-rotorblade_depth*.25, 0, blade_root_translation_length - 0.1])
                airfoil(naca = rotorblade_naca, L = rotorblade_depth, N= $preview? 100 : 300, h = 0.1, open = true);
            translate([-blade_root_depth*0.25, -blade_root_thickness/2, 0])
                cube([blade_root_depth, blade_root_thickness, 0.1]);
        }

        translate([rotorblade_depth - trailing_edge_crop - rotorblade_depth*.25, -10, 0])
            cube([trailing_edge_crop+global_clearance, 20, blade_root_translation_length+1]);
        }
}

// objekt, ve kterem se bude nachazet infill
module blade_root2airfoil_inner(){
    hull(){
        translate([-rotorblade_depth*.25, 0, blade_root_translation_length - 0.1])
            difference(){
                scale(0.97) // skalovani zde odstranuje nechtene artefakty po skalovani
                    airfoil(naca = rotorblade_naca, L = rotorblade_depth, N= $preview? 100 : 300, h = 0.1, open = true);
                hollow_airfoil(naca= rotorblade_naca, L = rotorblade_depth, N = $preview? 100 : 300, h = 0.1, open = true, wall_thickness = wall*2.5);
            }

        translate([-blade_root_depth*0.25 + wall, -blade_root_thickness/2 + wall, 0])
                cube([blade_root_depth - 2*wall, blade_root_thickness- 2*wall, 0.1]);

    }

}

//blade_basic_inner();
//blade_root_inner();

module blade_inner(){
    blade_root_inner();
    translate([0, 0, blade_root_length])
        blade_root2airfoil_inner();
    translate([0, 0, blade_root_length+blade_root_translation_length])
        blade_basic_inner();

}

module blade_infill_structure(){
    for(i=[0:blade_length]){

        if(i%30 == 0){
            translate([0, 0, i])
                rotate([0, 60, 0])
                    cube([100, 20, 0.09], center = true);
        }

        if(i%60 == 0){
            translate([0, 0, i])
                rotate([0, -60, 0])
                    cube([100, 20, 0.09], center = true);
        }

    }
}

//blade_inner();

module blade_infill(){
    intersection(){
        blade_inner();

        difference(){
            union(){
                blade_infill_structure();
                blade_spine_holes(0.1);
            }

            // Odebrani vyplne v okoli tycek pro vyztuhy
            /* difference(){
                blade_spine_holes(wall*2);
                blade_spine_holes(0);
            } */
        }
    }
}

//blade_infill();

module blade_outer(){
    blade_root();

    translate([0, 0, blade_root_length])
        blade_root2airfoil();

    translate([0, 0, blade_root_length+blade_root_translation_length])
        blade_basic();
}

//translate([0, 30, 0]) blade_infill();


module blade(){
    difference(){
        blade_outer();

        blade_root_holes(0);
        blade_spine_holes(0);
        blade_infill();

        translate([rotorblade_depth*0.75-2.5, -10, 0]) cube([20, 20, 1000]);
    }
}

module blade_printpart(part){
  height  = blade_print_cuts[part+1] - blade_print_cuts[part];

  translate([0, 0, blade_print_cuts[part+1]])
  rotate([180, 0, 0])
  intersection(){
    blade();
    translate([-50, -10, blade_print_cuts[part]])
      cube([100, 20, height]);
  }
}

blade();


if(true)
  for(h=blade_print_cuts){
      %translate([0, 0, h])
          square(200, center = true);
  }
