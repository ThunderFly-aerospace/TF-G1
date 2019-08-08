include <../../parameters.scad>
$fn=100;

difference(){
tube_diameter = tube_for_undercarriage_outer_diameter - global_clearance;
height = 100;

    cube([tube_diameter *3, tube_diameter *3, height], center = true );
    cylinder(d=tube_diameter, h=height, center = true);

    translate([0,tube_diameter/2, - height/5])
        rotate([0, 90, 0])
            cylinder(d=M3_screw_diameter, h=tube_diameter *3, center = true);

    translate([0,-tube_diameter/2, - height/5])
        rotate([0, 90, 0])
            cylinder(d=M3_screw_diameter, h=tube_diameter *3, center = true);

    translate([0,0, - height/2 + height/8])
        rotate([0, 90, 0])
            cylinder(d=M3_screw_diameter, h=tube_diameter *3, center = true);
}
