//========== SESTAVA PŘEDNÍHO PODVOZKU ==========//

include <../parameters.scad>

use <../888_2022.scad>
use <../888_2024.scad>
use <../888_2025.scad>

rotate([30, 0, 180])
    888_2022(true);

rotate([45, 0, 0])
    888_2024();

translate([chasis_fork_thickness+KBRM03_B/2+fork_wheel_width/2, 57, 22])
    rotate([0, 0, 0])
        888_2025();

translate([fork_wheel_width/2+chasis_fork_thickness+3, 57, 0])
    rotate([0, 0, 0])
        piston();

module piston() {
    #cylinder(d=12, h=48, $fn=40, center=true);
    #translate([0, 0, -48/2-25])
        cylinder(d=M3_screw_diameter, h=25, $fn=20);
}
