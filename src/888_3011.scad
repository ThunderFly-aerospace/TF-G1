include <../Parameters.scad>

unasec_diameter = 10.5;
unasec_kuzel_diameter = 18;
unasec_wall = 6;
888_height = 40;
888_nut_distance = 888_height-15;


podlozka_vnitrni_prumer = 30;
podlozka_vnejsi_prumer = 70;
podlozka_diry_vzdalenost = 46;

module 888_3011(draft = true){
    difference(){
      hull(){
      	translate([0,0,888_height-0.05])
	      	cylinder(d=podlozka_vnejsi_prumer, h=0.1, $fn=draft?50:100);
  		cube([bearing_efsm_12_h+5, bearing_efsm_12_h+5, 0.1], center=true);
      }

      cube([bearing_efsm_12_h, bearing_efsm_12_h, bearing_efsm_12_a1*2], center=true);

      translate([bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0]){
      		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
      		rotate(0)translate([-M5_nut_diameter/2, -M5_nut_diameter/2, 888_nut_distance]) cube([M5_nut_diameter, 25, M5_nut_height]);
      	}

      translate([bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0]){
      		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
      		rotate(180)translate([-M5_nut_diameter/2, -M5_nut_diameter/2, 888_nut_distance]) cube([M5_nut_diameter, 25, M5_nut_height]);
      	}

      translate([-bearing_efsm_12_m/2, bearing_efsm_12_m/2, 0]){
      		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
      		rotate(0)translate([-M5_nut_diameter/2, -M5_nut_diameter/2, 888_nut_distance]) cube([M5_nut_diameter, 25, M5_nut_height]);
      	}

      translate([-bearing_efsm_12_m/2, -bearing_efsm_12_m/2, 0]){
      		cylinder(h=888_height+1, d=bearing_efsm_12_n, $fn=draft?50:100);
      		rotate(180)translate([-M5_nut_diameter/2, -M5_nut_diameter/2, 888_nut_distance]) cube([M5_nut_diameter, 25, M5_nut_height]);
      	}

      cylinder(h=888_height+1, d=bearing_efsm_12_db+1, $fn=draft?50:100);





      translate([0, podlozka_diry_vzdalenost/2, 10]){
          cylinder(h=888_height+1, d=M4_screw_diameter, $fn=draft?50:100);
          rotate(0)translate([-M4_nut_diameter/2, -M4_nut_diameter/2, 888_height-888_nut_distance-10]) cube([M4_nut_diameter, 25, M4_nut_height]);
        }

      translate([0, -podlozka_diry_vzdalenost/2, 10]){
          cylinder(h=888_height+1, d=M4_screw_diameter, $fn=draft?50:100);
          rotate(180)translate([-M4_nut_diameter/2, -M4_nut_diameter/2, 888_height-888_nut_distance-10]) cube([M4_nut_diameter, 25, M4_nut_height]);
        }

      //cylinder(h=888_height-unasec_wall, d2=unasec_kuzel_diameter, d1=unasec_kuzel_diameter+5);
    }
}
888_3011();