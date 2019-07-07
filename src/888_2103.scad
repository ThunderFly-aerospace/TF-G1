// sestava podvozkoveho kola


include <../parameters.scad>
use <888_2011.scad>
use <888_2012.scad>
use <888_2014.scad>

module wheel_tire(){
    rotate([90, 0, 0]){
        rotate_extrude($fn=200)
        hull(){
            translate([wheel_inner_diameter/2, -wheel_inner_thickness/2+wheel_disc_upper_thickness, 0])
                square([3, wheel_inner_thickness-wheel_disc_upper_thickness*2]);
            translate([wheel_outer_diameter/2 - wheel_inner_thickness, 0, 0])
            scale([1.3, 1.1]) circle(wheel_inner_thickness/2, $fn=100);
        }
    }
}

wheel_tire();
translate([0, wheel_inner_thickness/2+wheel_disc_upper_thickness, 0]) rotate([90, 0, 0]) 888_2011(true);
translate([0, -wheel_inner_thickness/2-wheel_disc_upper_thickness, 0]) rotate([-90, 0, 0]) 888_2011(false);
translate([0, wheel_inner_thickness/2+wheel_disc_upper_thickness+1.5, 0]) rotate([90, 0, 0]) 888_2012();
translate([0, -wheel_inner_thickness/2-wheel_disc_upper_thickness-1.5, 0]) rotate([-90, 0, 0]) 888_2012();

//vidlice
    888_2014() ;
