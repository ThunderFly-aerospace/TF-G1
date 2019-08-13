include <../parameters.scad>
draft = true;
vyska = 20;

    bearing_efsm_a1 = bearing_efsm_12_a1;
    bearing_efsm_h = bearing_efsm_12_h;
    bearing_efsm_m = bearing_efsm_12_m;
    bearing_efsm_db = bearing_efsm_12_db;


 
difference(){
                // základní tvar pro prirubu
                translate([-bearing_efsm_h/2, -bearing_efsm_h/2, -bearing_efsm_a1])
                    cube([bearing_efsm_h, bearing_efsm_h, vyska]);

                translate([0, 0, -18+0.3])
                    cylinder(h=35 + global_clearance, d=bearing_efsm_db);

                for (i=[[bearing_efsm_m/2, bearing_efsm_m/2, -25, 0], [-bearing_efsm_m/2, bearing_efsm_m/2, -25, 0], [-bearing_efsm_m/2, -bearing_efsm_m/2, -25, 1], [bearing_efsm_m/2, -bearing_efsm_m/2, -25, 1]]) {
                    translate(i+[0,0,10]){
                        cylinder(h = 30, d = M5_screw_diameter, $fn = draft ? 50 : 100);
                       
                       

                    }
                }

                

            }
        