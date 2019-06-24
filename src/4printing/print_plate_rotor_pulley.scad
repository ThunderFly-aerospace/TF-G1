include <../../parameters.scad>

use <../rotor_pulley.scad>

rotate([0,180,0])
    rotor_pulley(draft = false);

