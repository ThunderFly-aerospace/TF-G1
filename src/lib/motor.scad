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


motor_prerotator();
