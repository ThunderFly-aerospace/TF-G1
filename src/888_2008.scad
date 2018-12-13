include <../Parameters.scad>

module 888_2008(draft = true){

    screw_length = 30;

    thickness = 50;
    width = height_of_accumulator*2 + 20;
    top_width = 60;
    height = 60;
    base_height = 10;

    screw_distance = 100;

    echo(str("desticka = ", main_tube_outer_diameter + thickness_between_tubes + coupling_wall_thickness ));

    difference(){
        union(){

            translate([-thickness/2, -width/2, 0])
                cube([thickness, width, base_height]);

            hull(){
                translate([-thickness/2, -width/2, 0])
                    cube([thickness, width, 0.1]);
                translate([-thickness/2, -top_width/2, 0])
                    cube([thickness, top_width, height]);
            }
        }

        for (i=[1,-1]) {
            translate([0, i*height_of_accumulator, 0])
                cylinder(d = M3_screw_diameter, h=base_height);
            translate([0, i*height_of_accumulator, base_height-global_clearance])
                cylinder(d1 = M3_screw_diameter+10, d2 = M3_screw_diameter+35, h=height);
        }

        // dira uprostred skrz
        translate([0, 0, 0])
            cylinder(d1=bearing_efsm_08_db+10, d2=bearing_efsm_08_db, h=100);

        // kostka pro EFSM
        translate([0,0,height-20 - bearing_efsm_08_B]){
            translate([-bearing_efsm_12_h/2, -bearing_efsm_12_h/2, 20])
                cube([bearing_efsm_12_h, bearing_efsm_12_h, 30]);

        // diry pro prisroubovani EFSM
            for (p=[[bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0], [bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0], [-bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0], [-bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0]]) {
                translate(p)
                    cylinder(d=5.5, h=100);
            }


            for (p=[[bearing_efsm_12_m/2, bearing_efsm_12_m/2, 180], [bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 180], [-bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0], [-bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0]]) {
                translate([p[0], p[1], height - 20 - bearing_efsm_08_B - 20 - M5_nut_height]){
                    rotate([0, 0, p[2]])
                        cylinder(d=M5_nut_diameter, h= M5_nut_height, $fn=6);
                    rotate([0, 0, p[2]+90])
                        translate([-M5_nut_pocket/2, 0, 0])
                        cube([M5_nut_pocket, 100, M5_nut_height]);
                    }
            }


        }
    }
}

888_2008();
