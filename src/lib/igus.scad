include <../../parameters.scad>


module efsm_12(){
    translate([0, 0, -(bearing_efsm_12_ag - bearing_efsm_12_B/2)]){
        translate([-bearing_efsm_12_h/2, -bearing_efsm_12_h/2, 0])
            cube([bearing_efsm_12_h, bearing_efsm_12_h, bearing_efsm_12_a1]);
        difference(){
            union(){
                intersection(){
                    translate([0,0, bearing_efsm_12_ag - bearing_efsm_12_B/2])
                        sphere(d=18, $fn = 50);
                    translate([0,0,-15])
                        cylinder(h = 30, d = 20);
                }
            }
            translate([0, 0, -15])
                cylinder(h=30, d=12);
        }
    }
}


module efsm_8(){
    translate([-33/2, -33/2, 0])
        cube([33, 33, 5.5]);
    translate([0,0,8.5])
        cylinder(h = 2, d1 = 18, d2 = 15);
    translate([0,0,6.5])
        cylinder(h = 7.94/2, d = 2);
    translate([0, 0, 6.5])
        sphere(r=3, $fn = 50);
}
