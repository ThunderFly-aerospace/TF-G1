//========== SESTAVA PŘEDNÍHO PODVOZKU ==========//

include <../../parameters.scad>

use <../888_2022.scad>
use <../888_2024.scad>
use <../888_2025.scad>

pistons = true;
damper_position = 100;  //udava se v procentech (0 - 100)

module 888_2105(){
mount_piston_bottom_distance = sqrt( pow((888_2022_front_fork_length+888_2022_piston_mount_offset), 2) + pow(screw_spring_distance, 2) );
mount_piston_top_distance = sqrt( pow(888_2024_holder_length, 2) + pow((696_bearing_outer_diameter/2+material_around_bearing), 2) );
piston_module_length = RT57208M25_XC-RT57208M25_LB+RT57208M25_A + (RT57208M25_MR+RT57208M25_LB+888_2025_wall_thickness+M6_screw_diameter/2+888_2025_wall_thickness+888_2025_height) + RT57208M25_stroke*damper_position/100 + (KBRM03_h1 - KBRM03_l1);

888_2022_mount_piston_bottom_angle = atan(screw_spring_distance/(888_2022_front_fork_length-888_2022_piston_mount_offset));
888_2024_mount_piston_top_angle = atan((696_bearing_outer_diameter/2+material_around_bearing)/888_2024_holder_length);

888_2025_base_angle = 90 + 888_2024_mount_piston_top_angle;

piston_angle = acos(( pow((piston_module_length), 2) + pow((mount_piston_top_distance), 2) - pow((mount_piston_bottom_distance), 2) )/( 2*piston_module_length*mount_piston_top_distance));
main_angle = acos(( pow((mount_piston_top_distance), 2) + pow((mount_piston_bottom_distance), 2) - pow((piston_module_length), 2))/(2*mount_piston_top_distance*mount_piston_bottom_distance));

translate([0, 0, -888_2024_joint_height])
rotate([888_2024_holder_angle, 0, 0])
translate([0, -888_2024_holder_length, -(696_bearing_outer_diameter+material_around_bearing*2)/2]) {
        888_2024();

        rotate([888_2022_mount_piston_bottom_angle+888_2024_mount_piston_top_angle+main_angle, 0, 180])
            888_2022(true);

        translate([(KBRM03_B/2+chasis_fork_thickness-888_2025_distance_space+2+RT57208M25_EW/2)+696_bearing_thickness, 888_2024_holder_length, -696_bearing_outer_diameter/2-material_around_bearing])
            rotate([-888_2025_base_angle+piston_angle, 0, 0])
                888_2025(pistons, damper_position);

        rotate([0, 0, 180])
        translate([(KBRM03_B/2+chasis_fork_thickness-888_2025_distance_space+2+RT57208M25_EW/2)+696_bearing_thickness, -888_2024_holder_length, -696_bearing_outer_diameter/2-material_around_bearing])
            rotate([888_2025_base_angle-piston_angle, 0, 0])
                888_2025(pistons, damper_position);

}}


888_2105();
