include <../parameters.scad>



module 888_2019(support = true, draft = true, rotate = false){
    piston_out_d = 21.5;

    piston_screw_d = 16 + 0.3;
    piston_screw_t = 12 + 0.5;

    bearing_distance = 15;
    shoulder_screw_length = 20;
    bearing_screw_length = 17;

    screw_length = 25;
    screw_length_total = screw_length + M3_screw_head_height+1;
    screw_length_thread = screw_length - M3_nut_height*1.5;

    screw_position = [-36, 0, 15-17/2- bearing_distance];



vect_data = [(screw_length_total/2 - screw_position[0]), 0, -( screw_position[2]-5)];
vect_val = vect_data[2]/vect_data[0];
rot = rotate? atan(vect_val) : 0;

difference(){
    rotate([0, rot, 0])
        union(){
        difference(){
            union(){

                hull(){
                    //translate([0, 0, 10])
                    //    #cube([screw_length_total, screw_length_total, 20+10], center = true);

                    translate([0, 0, -5])
                        cylinder(d = screw_length_total, h = 13+3+5, $fn = $preview? 10:80);

                    translate(screw_position)
                        rotate([90, 0, 0])
                            cylinder(d = 15, h = screw_length_total, center = true, $fn = $preview? 10:80);

                }



            }

          translate([0, 0, -5])
            rotate([0, -atan(vect_val), 0])
              translate([-50, -20, -30])
                cube([100, 40, 30]);


    // Vyrez pro pist
            translate([0, 0,-global_clearance])
                intersection(){
                    cylinder(d = piston_screw_d, h = 13.5, $fn = 80);
                    cube([piston_screw_t, 50, 50], center = true);
                }

    // Srouby skre pist
            translate([0, 0, 10-3])
                rotate([0, 90, 0]){
                    cylinder(d = M6_screw_diameter, h = bearing_screw_length + 15, center = true, $fn = 80);
                    translate([0, 0, bearing_screw_length/2]) cylinder(d = M6_nut_diameter, h = 30);
                    translate([0, 0, -bearing_screw_length/2-30]) cylinder(d = M6_nut_diameter, h = 30, $fn = 6);
                }


    // Vyrez pro telo pistu
            translate([0, 0, -20])
                cylinder(d = piston_out_d + 1.5, h = 20, $fn = 80);

            translate([0, 0, -7.5-1.5])
            rotate([90, 0, 0])
                cylinder(d = 15, h = 50, center = true, $fn = $preview? 10:80);


    // Otvor na Srouby do loziska

            translate(screw_position)
                rotate([90, 0, 0]){

                    //translate([0, 0, -screw_length_thread/2+layer]) cylinder(d = M4_screw_diameter, h = 10, $fn = 60);
                    //translate([0, 0, +12.5/2+layer]) cylinder(d = M4_screw_diameter, h = 10, $fn = 60);
                    translate([0, 0, -15]) cylinder(d = M4_screw_diameter, h = 30, $fn = 60);
                    translate([0, 0, screw_length_thread/2]) cylinder(d = M4_nut_diameter, h = 30, $fn = 60);
                    translate([0, 0, -screw_length_thread/2-30]) cylinder(d = M4_nut_diameter, h = 30, $fn = 6);
                }

    // Vyrez pro kulove lozisko
            translate(screw_position){
                cube([30, 12.5, 80], center = true);

                translate([15, 0, 0])
                  cylinder(d=12.5, h = 50, center = true, $fn = $preview? 10:80);
            }

            // popisek data
            translate([9, 0, 16-0.3])
                rotate([0, 0, 90])
                    linear_extrude(1)
                        text(str(week), valign = "center", halign = "center", size = 7);
                        //text(str(59), valign = "center", halign = "center", size = 7);
        }


        // podpora
        if(support){
            translate(screw_position)
                rotate([90, 0, layer]) difference(){
                    translate([0, 0, -12.5/2]) cylinder(d = M4_screw_diameter+perimeter, h = 12.5-layer,  $fn = 80);
                    translate([0, 0, -12.5/2-0.1]) cylinder(d = M4_screw_diameter, h = 12.5,  $fn = 80);
                }


            translate(screw_position)
                rotate([90, 0, +layer]) difference(){
                    translate([0, 0, -12.5/2]) cylinder(d = 30, h = 12.5-layer, $fn = 80);
                    translate([0, 0, -12.5/2-0.1]) cylinder(d = 30 - perimeter*2, h = 12.5, $fn = 80);
                }
        }
    }

    // orez pro tisk
    if(rotate)
    translate([-80, -50, -100-10+1])
        cube(100);
}
}


888_2019(support = false, draft = $preview, rotate = false);
