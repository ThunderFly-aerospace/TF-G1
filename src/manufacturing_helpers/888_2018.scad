include <../../parameters.scad>

difference(){
    hull(){
        translate([-25, -20, 0]) cube([50, 40, 0.1]);
        translate([-37/2, -10, 25]) cube([37, 20, 0.1]);
}
    translate([-10, 0, 0]){
        cylinder(d = M3_nut_diameter, h = 25-5, $fn = 50);
        cylinder(d = M3_screw_diameter, h = 32, $fn = 50);
    }
    translate([10, 0, 0]){
        cylinder(d = M3_nut_diameter, h = 25-5, $fn = 50);
        cylinder(d = M3_screw_diameter, h = 32, $fn = 50);
    }
}
