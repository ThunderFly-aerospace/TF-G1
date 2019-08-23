include <../parameters.scad>

draft=true;

//kloub stredná časť
module 888_1022(draft) {
    a=60;
    b=14;

    hole_r=(rotor_head_bearing_db/2*1/cos(rotor_head_roll_stop));

    inner_x=rotor_head_kardan_inner_x;
    inner_y=rotor_head_kardan_inner_y;
    plate_thickness=rotor_head_plate_thickness;
    brit_width=rotor_head_brit_width;
    wall_height=rotor_head_wall_height;
    kardan_clearance=rotor_head_cardan_clearance;
    
    outer_x = inner_x + 2*brit_width;
    outer_y = inner_y + 2*brit_width;
    outer_height = wall_height + plate_thickness ;
    
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
        translate([0,0,(a/ 2 * sqrt(2) ) + plate_thickness+wall_height/2]) {
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

888_1022(draft);
