//========== SESTAVA PŘEDNÍHO PODVOZKU ==========//

include <../../parameters.scad>

use <../888_2022.scad>
use <../888_2024.scad>
use <../888_2025.scad>


translate([0, 0, -888_2024_joint_height])
rotate([888_2024_holder_angle, 0, 0])
translate([0, -888_2024_holder_length, -(696_bearing_outer_diameter+material_around_bearing*2)/2]) {
        888_2024();

        rotate([90, 0, 180])
            888_2022(true);

        translate([(KBRM03_B/2+chasis_fork_thickness-888_2025_distance_space+2+RT57208M25_EW/2)+696_bearing_thickness, 888_2024_holder_length, -696_bearing_outer_diameter/2-material_around_bearing])
            rotate([-40, 0, 0])
                888_2025(true);

        rotate([0, 0, 180])
        translate([(KBRM03_B/2+chasis_fork_thickness-888_2025_distance_space+2+RT57208M25_EW/2)+696_bearing_thickness, -888_2024_holder_length, -696_bearing_outer_diameter/2-material_around_bearing])
            rotate([40, 0, 0])
                888_2025(true);

}