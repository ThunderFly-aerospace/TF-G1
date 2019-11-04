include <../../parameters.scad>

use <../888_1004.scad>

draft = $preview;

for (i=[1:len(beam_division)-1]) {

    translate([(i-0.7)*(beam_thickness+2), 0, 0])
        difference(){
            rotate([0, -90, 0])
                intersection(){
                    translate([-beam_division[i-1], 0, 0])
                        888_1004(draft);
                    translate([0, -50, -50])
                        cube([beam_division[i]-beam_division[i-1], 100, 100]);

                }
            translate([0, 0, 0])
                mirror([1, 0, 0]) rotate([0, 0, -90])
                    linear_extrude(0.4, center = true)
                        text(str(i-1), valign = "center", halign = "center", size = 10);

            translate([0, 0, beam_division[i]-beam_division[i-1]])
                mirror([1, 0, 0]) rotate([0, 0, -90])
                    linear_extrude(0.4, center = true)
                        text(str(i), valign = "center", halign = "center", size = 10);
        }
}
