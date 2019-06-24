include <../../parameters.scad>

unasec_diameter = 10.5;
unasec_kuzel_diameter = 18;
unasec_wall = 6;
888_height = 20;
888_nut_distance = 888_height-7.5;


podlozka_vnitrni_prumer = 30;
podlozka_vnejsi_prumer = 70;
podlozka_diry_vzdalenost = 46;

module 888_3011(draft = true){
    difference(){
        translate([0,0,global_clearance])hull(){
            translate([0,0,888_height-0.05])
            	cylinder(d=podlozka_vnejsi_prumer, h=0.1, $fn=draft?50:100);
            cube([bearing_efsm_12_h+5, bearing_efsm_12_h+5, 0.1], center=true);  
        }

        // Centralni dira
        cylinder(h=888_height+1, d=bearing_efsm_12_db+1, $fn=draft?50:100);


        // diry pro srouby skrz lozisko

        translate([bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0])
        {
            cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
      
            rotate(30)
                translate([0, 0, 888_nut_distance])
                    cylinder(h=M5_nut_height+0.5 , d=M5_nut_diameter, $fn=6);

            translate([-M5_nut_pocket/2, 0, 888_nut_distance])
                cube([M5_nut_pocket, 25, M5_nut_height+0.5 ]);
        }

        translate([bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0])
        {
    		cylinder(h = 888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);

            rotate(30)
                translate([0, 0, 888_nut_distance])
                    cylinder(h = M5_nut_height+0.5 , d = M5_nut_diameter, $fn = 6);

        	rotate(180)
                translate([-M5_nut_pocket/2, 0, 888_nut_distance]) 
                    cube([M5_nut_pocket, 25, M5_nut_height+0.5 ]);
    	}

        translate([-bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0])
        {
    		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);

            translate([-M5_nut_pocket/2, 0, 888_nut_distance])
                cube([M5_nut_pocket, 25, M5_nut_height+0.5 ]);
            rotate(30)
                translate([0, 0, 888_nut_distance])
                    cylinder(h=M5_nut_height+0.5 , d=M5_nut_diameter, $fn=6);
        }

        translate([-bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0])
        {
    		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
		    
            rotate(180)
                translate([-M5_nut_pocket/2, 0, 888_nut_distance])
                    cube([M5_nut_pocket, 25, M5_nut_height+0.5 ]);

            rotate(30)
                translate([0, 0, 888_nut_distance])
                    cylinder(h = M5_nut_height+0.5 , d = M5_nut_diameter, $fn = 6);
    	}


        // Diry pro srouby skrz podlozku
        translate([0, podlozka_diry_vzdalenost/2, 0])
        {
            cylinder(h=888_height+1, d=M4_screw_diameter, $fn=draft?50:100);

            translate([-M4_nut_pocket/2, 0, 888_height-888_nut_distance]) 
                cube([M4_nut_pocket, 25, M4_nut_height+0.5 ]);

            rotate(30)
              translate([0, 0, 888_height-888_nut_distance])
                cylinder(h = M4_nut_height+0.5 , d = M4_nut_diameter, $fn = 6);
        }

        translate([0, -podlozka_diry_vzdalenost/2, 0])
        {
            cylinder(h=888_height+1, d=M4_screw_diameter, $fn=draft?50:100);
            rotate(180)
                translate([-M4_nut_pocket/2, 0, 888_height-888_nut_distance]) 
                    cube([M4_nut_pocket, 25, M4_nut_height+0.5]);

            rotate(30)
                translate([0, 0, 888_height-888_nut_distance])
                    cylinder(h = M4_nut_height+0.5, d = M4_nut_diameter, $fn = 6);
        }
      
        translate([0, 0, 888_height/2])
            rotate([0, 90, 0])
                cylinder(h = podlozka_vnejsi_prumer, d = 5, center = true);
    }
}
888_3011();