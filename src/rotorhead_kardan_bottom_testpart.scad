include <./rotorhead_kardan_parameters.scad>

include <./rotorhead_kardan_centerpart.scad>


draft = true;


sokl_height=20;
 
difference(){
    // základní tvar pro prirubu
    translate([0,0, sokl_height/2])
        cube([bearing_width+2*brit_width+2*britstop_thickness, bearing_h, sokl_height],center = true);

    //uchycení a díra pro pohyb
    translate([0, 0, -sokl_height/2])
        cylinder(h=2*sokl_height, d=bearing_db);

    for (i=[[bearing_m/2, bearing_m/2, 0, 0],
            [-bearing_m/2, bearing_m/2, 0, 0],
            [-bearing_m/2, -bearing_m/2, 0, 1],
            [bearing_m/2, -bearing_m/2, 0, 1]]) {
        translate(i+[0,0,-sokl_height/2]){
            cylinder(h = 2*sokl_height, d = M5_screw_diameter, $fn = draft ? 50 : 100);
            }
        }
        
    //místo pro ložisko
    translate([0,0, sokl_height/2+sokl_height-bearing_a_center_of_rotation]){
        cube([bearing_width+global_clearance, bearing_h+1, sokl_height],center = true);
        }

    //vyříznutí trnu středním dílem
    translate([0,0,sokl_height])
        rotate([180-roll_stop,0,0])
            translate([0,0,-plate_thickness-wall_height/2])
                rotorhead_kardan_center_part();
        
    translate([0,0,sokl_height])
        rotate([180+roll_stop,0,0])
            translate([0,0,-plate_thickness-wall_height/2])
                rotorhead_kardan_center_part(); 
        
    }
     
 
    