include <../../parameters.scad>
use <../lib/stdlib/naca4.scad>

//rotorblade_naca = 4412;
rotorblade_naca = 0014;
echo(rotorblade_depth);
rotorblade_depth = 70;

length = 14*6;

rotorblade_infill_space = 0.01;
space = 15;
perimeter = 0.41;
height = 0;
trailing_edge_crop = 1;
rod = [
[rotorblade_depth/4, 0, 2.3],
[rotorblade_depth/4-rotorblade_depth*0.2, 0, 2.3],
[rotorblade_depth/4+rotorblade_depth*0.1, 0, 2.3]
];

module blade_basic(){
    difference(){
        airfoil(naca = rotorblade_naca, L = rotorblade_depth, N=500, h = 100, open = true);
        #difference(){
            intersection(){
                difference(){
                    scale(0.97) // skalovani zde odstranuje nechtene artefakty po skalovani
                        airfoil(naca = rotorblade_naca, L = rotorblade_depth, N=500, h = 500, open = true);
                    hollow_airfoil(naca= rotorblade_naca, L = rotorblade_depth, N = 500, h = 100, open = true, wall_thickness = perimeter*1.5);
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
            cube([trailing_edge_crop+global_clearance, 20, 100]);

        #for (i=rod) {
            translate([i[0], i[1], 0])
                cylinder(d = i[2], h = 100, $fn = 50);
        }

        for(i=[1:8])
            translate([rotorblade_depth/4, 0, i*15])
                rotate([90, 0, 0])
                    cylinder(d = 1.5, h=20, center=true, $fn = 15);

    }

}


blade_basic();
