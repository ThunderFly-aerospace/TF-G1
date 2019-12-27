include <../../parameters.scad>

$fn = 90;

module 888_9001(){
    wall = 4;
    height = 10;

    difference(){
        hull(){
            cylinder(d=carbon_pipe_10_outer_diameter+2*wall, h = height);
            translate([0, 15, 0])
                cylinder(d=carbon_pipe_10_outer_diameter+2*wall, h = height);
        }

        translate([-25, 15, 0]) cube([50, 30, 11]);
        translate([0, 10, 0]) cube([50, 30, 11]);

        hull(){
            cylinder(d=carbon_pipe_10_outer_diameter, h = height+1);
            translate([0, 15, 0])
                cylinder(d=carbon_pipe_10_outer_diameter, h = height+1);
        }
    }

    difference(){
        hull(){
            translate([-carbon_pipe_10_outer_diameter/2-wall/2, 15, 0])
                cylinder(d = wall, h = 10);

            translate([0, 30, 0])
                cylinder(d = wall*2+M4_screw_diameter, h = 10);
        }
        translate([0, 30, 0])
            cylinder(d = M4_screw_diameter, h = 11);

    }
    translate([carbon_pipe_10_outer_diameter/2 + wall/2 - 1.5, 8.5, 0])
        cylinder(d = 3, h = 10);
}

//translate([0, 12, 0]) cylinder(d = 10, h = 11);

888_9001();
