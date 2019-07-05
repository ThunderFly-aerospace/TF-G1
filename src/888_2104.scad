include <../parameters.scad>
use <888_2013.scad>
use <888_2016.scad>
use <lib/igus.scad>
use <666_1027.scad>

color([0.2, 0.4, 0.4, 0.5]) translate([-second_undercarriage_hole,0,main_tube_outer_diameter/2+2]) rotate([90,0,0]) 666_1027();


module bearing_set(){
    translate([chassis_top_bearing_position_x, chassis_top_bearing_position_y, -kstm_ball_height(8)]){
            rotate([-chassis_top_bearing_rotation[2],  180-chassis_top_bearing_rotation[0], 90])
                888_2013();

            rotate([180, 0, 90])
                kstm_08();
    }
}


mirror([0, 0, 0])
    #bearing_set();
mirror([1, 0, 0])
    bearing_set();
mirror([0, 1, 0])
    bearing_set();
mirror([1, 0, 0])
    mirror([0, 1, 0])
        bearing_set();

translate([0, chassis_suspension_basewidth/2, -main_tube_outer_diameter/2])
    rotate([0, 0, 90])
        888_2016();

translate([0, -chassis_suspension_basewidth/2, -main_tube_outer_diameter/2])
    rotate([0, 0, 90])
        888_2016();

translate([0, -chassis_suspension_basewidth/2, -main_tube_outer_diameter - 10 - kstm_ball_height(10)])
    rotate([0, 180, 90])
        kstm_10();

translate([0, chassis_suspension_basewidth/2, -main_tube_outer_diameter - 10 - kstm_ball_height(10)])
    rotate([0, 180, 90])
        kstm_10();
