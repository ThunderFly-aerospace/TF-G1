include <../../parameters.scad>
use <../666_1201.scad>

$vpd = 680;

draft = false;        
plywood_thickness = 4;
thickness = 30;
core_thickness = 1.0;
length = 970;       // celková délka polotovaru
material_width = 50;
side_margin = 10; 

difference()
{
    x_size = 2*material_width + 3*side_margin;
    y_size = length + 2*side_margin;
    translate([-x_size/2, -y_size/2, 0])
        cube([x_size,y_size, thickness]);

    translate([0, 0, thickness])
    {
        rotate([0,180,0])
        {
            translate([- material_width/2 - side_margin/2, 0, 0])
                666_1201(holes = false, draft = draft);

            translate([material_width/2 + side_margin/2, 0, 0])
                666_1201(holes = false, draft = draft);
        }

        translate([- material_width/2 - side_margin/2, -length/2 + 60, 0])
            cube([55, 120, 8.096], center = true);

        translate([material_width/2 + side_margin/2, -length/2 + 60, 0])
            cube([55, 120, 8.096], center = true);
    }
}



