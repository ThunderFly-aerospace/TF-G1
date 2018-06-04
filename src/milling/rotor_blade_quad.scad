include <../../Parameters.scad>

use <../666_1201.scad>

$vpd = 680;

module rotor_blade_quad(draft = true, base = true)
{
    plywood_thickness = 4;
    core_thickness = 1.0;        
    length = 970;       // celková délka polotovaru
    material_width = 50;
    side_margin = 10; 

    x_size = 4*material_width + 5*side_margin;
    y_size = length + 2*side_margin;

    if (base == true)
    translate([-x_size/2, -y_size/2,0])
        cube([x_size,y_size, plywood_thickness + core_thickness/2]);

    translate([- material_width/2 - side_margin/2, 0, plywood_thickness + core_thickness/2])
        666_1201(draft = draft, holes = true);

    translate([material_width/2 + side_margin/2, 0, plywood_thickness + core_thickness/2])
        666_1201(draft = draft, holes = true);

    translate([- material_width - 4*side_margin, 0, plywood_thickness + core_thickness/2])
        666_1201(draft = draft, holes = true);

    translate([material_width + 4*side_margin, 0, plywood_thickness + core_thickness/2])
        666_1201(draft = draft, holes = true);
}

/// pro  generování DXF výstupu

projection(cut = false) 
    rotor_blade_quad(draft = false, base = false);

/*projection(cut = true) 
    translate([0,0,0]) 
        rotor_blade_quad(draft = true, base = true);
*/