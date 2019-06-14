// sestava podvozkoveho kola


include <../Parameters.scad>
use <888_1029.scad>
//use <888_2006.scad>

module wheel_tiere(){
    rotate([90, 0, 0]){
        rotate_extrude()
        hull(){
            translate([wheel_inner_diameter/2, -wheel_inner_thickness/2+wheel_disc_upper_thickness, 0])
                square([3, wheel_inner_thickness-wheel_disc_upper_thickness*2]);
            translate([wheel_outer_diameter/2 - wheel_inner_thickness, 0, 0])
            scale([0.8, 1]) circle(wheel_inner_thickness/2);
        }
    }
}

wheel_tiere();
translate([0, wheel_inner_thickness/2, 0]) rotate([90, 0, 0]) 888_1029(true);
translate([0, -wheel_inner_thickness/2, 0]) rotate([-90, 0, 0]) 888_1029(false);
