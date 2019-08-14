include <./rotorhead_kardan_parameters.scad>
use <./rotorhead_kardan_centerpart.scad>

module mirror_copy(v = [1, 0, 0]) {
    children();
    mirror(v) children();
}

draft = true;

module rotorhead_kardan_bottom_testpart() {

    sokl_height=15;
    a=(brit_width + kardan_clearance)/(brit_width); //rozšíření o epsilon  do fce scale prepoč. na nasobky
     
    union(){
         mirror_copy([1,0,0]){
                //brit
                translate([(bearing_width+global_clearance)/2,0,0])
                    scale([a,1,1])
                        translate([-inner_x/2,0,0])
                            difference(){
                                //zakald britu
                                translate([inner_x/2+brit_width/2,0,sokl_height/2])
                                    cube([brit_width,bearing_h,sokl_height],center = true);
                                
                                translate([0,0,sokl_height])
                                    rotate([180-roll_stop,0,0])
                                        translate([0,0,-plate_thickness-wall_height/2])
                                            rotorhead_kardan_center_part();
                                
                                translate([0,0,sokl_height])
                                    rotate([180+roll_stop,0,0])
                                        translate([0,0,-plate_thickness-wall_height/2])
                                            rotorhead_kardan_center_part();
                                }
                
                //stop
                translate([(bearing_width+global_clearance)/2 +a*brit_width+britstop_thickness/2,0, sokl_height/2])
                    cube([britstop_thickness, bearing_h, sokl_height],center = true);
            }
            
         difference(){
            // základní tvar pro prirubu
            translate([0,0, sokl_height/2])
                cube([bearing_width+global_clearance, bearing_h, sokl_height],center = true);

            //uchycení a díra pro pohyb
            translate([0, 0, -sokl_height/2])
                cylinder(h=2*sokl_height, d=bearing_db);

            for (i=[[bearing_m/2, bearing_m/2, 0, 0],
                    [-bearing_m/2, bearing_m/2, 0, 0],
                    [-bearing_m/2, -bearing_m/2, 0, 1],
                    [bearing_m/2, -bearing_m/2, 0, 1]]) {
                translate(i+[0,0,-sokl_height/2])
                    cylinder(h = 2*sokl_height, d = M5_screw_diameter, $fn = draft ? 50 : 100);
                    
                }
                
            //místo pro ložisko
            translate([0,0, sokl_height/2+sokl_height-bearing_a_center_of_rotation])
                cube([bearing_width+global_clearance, bearing_h+1, sokl_height],center = true);
            
            }
        
        }
    }
    

rotorhead_kardan_bottom_testpart(); 
