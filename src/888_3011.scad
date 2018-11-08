include <../Parameters.scad>

unasec_diameter = 10;
unasec_kuzel_diameter = 18;
unasec_wall = 6;
888_height = 30;

module 888_3011(draft = true){
    difference(){
      hull(){
      	translate([0,0,888_height-0.05])
	      	cylinder(d=unasec_kuzel_diameter+5*2, h=0.1);
  		cube([bearing_efsm_08_h+4, bearing_efsm_08_h+4, 0.1], center=true);
      }

      translate([bearing_efsm_08_m/2, bearing_efsm_08_m/2, 0]){
      		cylinder(h=20, d=M3_screw_diameter);
      		rotate(45*3)translate([-M3_nut_diameter/2, -M3_nut_diameter/2, 7]) cube([M3_nut_diameter, 15, 3]);
      	}

      translate([bearing_efsm_08_m/2, -bearing_efsm_08_m/2, 0]){
      		cylinder(h=20, d=M3_screw_diameter);
      		rotate(45*1)translate([-M3_nut_diameter/2, -M3_nut_diameter/2, 7]) cube([M3_nut_diameter, 15, 3]);
      	}

      translate([-bearing_efsm_08_m/2, bearing_efsm_08_m/2, 0]){
      		cylinder(h=20, d=M3_screw_diameter);
      		rotate(45*5)translate([-M3_nut_diameter/2, -M3_nut_diameter/2, 7]) cube([M3_nut_diameter, 15, 3]);
      	}

      translate([-bearing_efsm_08_m/2, -bearing_efsm_08_m/2, 0]){
      		cylinder(h=20, d=M3_screw_diameter);
      		rotate(45*7)translate([-M3_nut_diameter/2, -M3_nut_diameter/2, 7]) cube([M3_nut_diameter, 15, 3]);
      	}

      cylinder(h=888_height+1, d=unasec_diameter);
      cylinder(h=888_height-unasec_wall, d2=unasec_kuzel_diameter, d1=unasec_kuzel_diameter+5);
      cube([bearing_efsm_08_h+1, bearing_efsm_08_h+1, bearing_efsm_08_a1*2], center=true);
    }
}
888_3011();