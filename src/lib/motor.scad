
include <../../parameters.scad>


module motor_prerotator(){
    body_height = 60;
    body_diameter = 40;
    body_bevel = 10;
    axis_diameter = 5;
    axis_length = 30;

    cylinder(d = axis_diameter, h = axis_length);

        translate([0, 0, -body_bevel/2])
            cylinder(h = body_bevel/2, d1 = body_diameter, d2 = body_diameter-body_bevel);

        translate([0, 0, -body_height + body_bevel/2])
            cylinder(h = body_height - body_bevel, d = body_diameter);

        translate([0, 0, -body_height])
            cylinder(h = body_bevel/2, d2 = body_diameter, d1 = body_diameter-body_bevel);
}



module motor_main(){
    diameter = engine_diameter - 5;
    length = 60;
    ramp = 10;

    translate([0, 0, -30])
        cylinder(h = 30+length+1, d = 5, $fn = 50);

    cylinder(d = diameter-15, h = length, $fn = 80);

    cylinder(d2 = diameter, d1 = diameter - 15, h = ramp/2, $fn = 80);
    
    translate([0, 0, ramp/2])
        cylinder(d = diameter, h = ramp/2, $fn = 150);

    translate([0, 0, ramp+0.5])
        cylinder(d = diameter, h = length-1-ramp*2, $fn = 150);

    translate([0, 0, length-ramp])
        cylinder(d = diameter, h = 5, $fn = 150);


    translate([0, 0, length-ramp/2])
        cylinder(d1 = diameter, d2 = diameter-15, h = ramp/2, $fn = 150);
}



motor_main();

//motor_prerotator();
