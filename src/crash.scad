


difference (){
    minkowski()     
    {
        difference ()
        {
            cube([68, 969, 3], center = true);
            translate([26, 0, 0.5])
                cube([4, 2*969, 2], center = true);
        }
        rotate([90,0,0])
            cylinder(r=1, h=1, center = true);
    }
    cylinder(r = 1, h = 2*969, center = true);
}