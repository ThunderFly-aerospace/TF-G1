include <../../Parameters.scad>
use <../333_1037.scad>

$vpd = 680;

module rotor_blade_double(draft)
{
    draft = false;        
    plywood_thickness = 4.5;
    core_thickness = 1.0;
    length = 974+5;       // celková délka polotovaru
    material_width = 50;
    side_margin = 10; 

    x_size = 2*material_width + 3*side_margin;
    y_size = length + 2*side_margin;
    translate([-x_size/2, -y_size/2,0])
        cube([x_size,y_size, plywood_thickness]);

    translate([- material_width/2 - side_margin/2, 0, plywood_thickness + core_thickness/2])
        333_1037(twosided = true, draft = draft);

    translate([material_width/2 + side_margin/2, 0, plywood_thickness + core_thickness/2])
        333_1037(twosided = true, draft = draft);
}

rotor_blade_double();


