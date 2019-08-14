include <../parameters.scad>

//kloub stredná časť
module rotorhead_kardan_center_part() {
    a=60;
    b=14;

    outer_x = inner_x + 2*brit_width;
    outer_y = inner_y + 2*brit_width;
    outer_height = wall_height + plate_thickness;
    
    difference(){     
        translate ([0,0,outer_height/2]) {
            cube([outer_x,outer_y,outer_height],center = true);
            }
        translate([0,0,wall_height + plate_thickness]){
            cube([inner_x,inner_y,wall_height*2],center = true);
            }
        hull() {
            translate([-(inner_x/2 - hole_r),0,-outer_height]) {
                cylinder (h=outer_height*4, r=hole_r,$fn = 100);
                }
            translate([inner_x/2 - hole_r,0,-outer_height]) {
                cylinder (h=outer_height*4, r=hole_r,$fn = 100);
                }
            }
        translate([0,0,(a * sqrt(2) / 2) + plate_thickness+wall_height/2]) {
                rotate ([45,0,0]) {
                    cube([2*inner_x + 2 * brit_width, a,a],center=true);
                    }
                } 
        translate([0,-b/2-inner_y/2+kardan_clearance,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
            rotate ([0,45,0]){
                cube(b,center=true);
                }
            }
        translate([0,b/2+inner_y/2-kardan_clearance,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
            rotate ([0,45,0]){
                cube(b,center=true);
                }
            }           
        }
    }

rotorhead_kardan_center_part();
