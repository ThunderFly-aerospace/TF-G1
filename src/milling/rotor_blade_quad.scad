include <../../Parameters.scad>
use <../333_1037.scad>

use <rotor_blade_double.scad>

$vpd = 680;

    draft = false;        
    plywood_thickness = 4;
    core_thickness = 1.0;
    length = 970;       // celková délka polotovaru
    material_width = 70;
    side_margin = 10; 

    x_size = 2*material_width + 3*side_margin;
    y_size = length + 2*side_margin;

    translate([- x_size/2 + side_margin/2, 0, 0])
        rotor_blade_double();

    translate([x_size/2 - side_margin/2, 0, 0])
        rotor_blade_double();



