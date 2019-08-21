// sestava podvozkoveho kola


include <../parameters.scad>
use <888_2011.scad>
use <888_2012.scad>
use <888_2021.scad>

module wheel_tiere(){
     rotate([90, 0, 0]){
        rotate_extrude($fn=200)
        hull(){
            translate([wheel_inner_diameter/2, -wheel_inner_thickness/2+wheel_disc_upper_thickness, 0])
                square([4, wheel_inner_thickness-wheel_disc_upper_thickness*2]);
            translate([19+wheel_outer_diameter/2 - wheel_inner_thickness, 0, 0])
            scale([0.7, 1.3]) circle(wheel_inner_thickness/2, $fn=100);
        }
    }
}

wheel_tiere();
//rotate([90, 0, 0]) cylinder(h = 20, d = 110);
translate([0, wheel_inner_thickness/2+4.6, 0]) rotate([90, 0, 0]) 888_2011(true);
translate([0, -wheel_inner_thickness/2-4.6, 0]) rotate([-90, 0, 0]) 888_2011(false);
translate([0, wheel_inner_thickness/2+6.8, 0]) rotate([90, 0, 0]) 888_2012();
translate([0, -wheel_inner_thickness/2-6.8, 0]) rotate([-90, 0, 0]) 888_2012();

//vidlice
translate ([0, 0, 0])
    888_2021() ;
