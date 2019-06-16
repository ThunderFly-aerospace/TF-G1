include <../Parameters.scad>

column_upper_diameter = 60;
column_lower_diameter = 608_bearing_outer_diameter*2;
column_height = 80;

difference() {

    //sloupek
    cylinder (h=column_height, d1=column_lower_diameter, d2=column_upper_diameter, $fn=50);

    //diry na M4 srouby, spojujici sloupek s 888_1026
    translate ([column_upper_diameter/2-15, 0, column_height-19])
        cylinder (h=21, d=M4_screw_diameter, $fn=50);
    translate ([-column_upper_diameter/2+15, 0, column_height-19])
        cylinder (h=21, d=M4_screw_diameter, $fn=50);

    //kapsy pro M4 matice
    translate([column_upper_diameter/2-15, -M4_nut_pocket/2, column_height-15])
        hull() {
            translate([0,M4_nut_pocket/2,0]) cylinder(h=M4_nut_height, d=M4_nut_diameter, $fn=6);
            cube ([column_upper_diameter/2, M4_nut_pocket, M4_nut_height ]);
        }
    mirror([1, 0, 0]) {
      translate([column_upper_diameter/2-15, -M4_nut_pocket/2, column_height-15])
          hull() {
              translate([0,M4_nut_pocket/2,0]) cylinder(h=M4_nut_height, d=M4_nut_diameter, $fn=6);
              cube ([column_upper_diameter/2, M4_nut_pocket, M4_nut_height ]);
          }
    }

    //dira pro hlavni M5 osou
    translate([0, 0, -1])
        cylinder(h=column_height-20, d=M5_screw_diameter, $fn=50);

    //kapsa pro M5 matici
    rotate([0, 0, 90])
        translate([0, -M5_nut_pocket/2, column_height/2])
            hull() {
                translate([0,M5_nut_pocket/2,0]) cylinder(h=M5_nut_height, d=M5_nut_diameter, $fn=6);
                cube ([column_upper_diameter/2, M5_nut_pocket, M5_nut_height ]);
            }

    //diry pro M3 srouby


    //kapsy pro M3 matice
}
