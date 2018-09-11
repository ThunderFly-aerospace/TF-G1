include <../../Parameters.scad>

use <../milling/rotor_pulley.scad>

rotate([0,180,0])
    rotor_pulley(draft = false);

