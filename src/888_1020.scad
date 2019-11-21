include <../parameters.scad>

module kardan_center_part_model()
{
    b=3*rotor_head_wall_height;

    inner_x=rotor_head_kardan_inner_x;
    inner_y=rotor_head_kardan_inner_y;
    plate_thickness=rotor_head_plate_thickness;
    brit_width=rotor_head_brit_width;
    wall_height=rotor_head_wall_height;
    kardan_clearance=rotor_head_cardan_clearance;

    outer_x = inner_x + 2*brit_width;
    outer_y = inner_y + 2*brit_width+kardan_clearance;
    outer_height = wall_height + plate_thickness +10;

    translate([0,0,-plate_thickness-wall_height/2])
        difference(){
            translate ([0,0,outer_height/2]) {
                cube([outer_x,outer_y,outer_height],center = true);
                }

            translate([0,-b/2-inner_y/2+0.01,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
                rotate ([0,45,0]){
                    cube(b,center=true);
                    }
                }
            translate([0,b/2+inner_y/2-0.01,-(b * sqrt(2) / 2) + plate_thickness+wall_height/2]){
                rotate ([0,45,0]){
                    cube(b,center=true);
                    }
                }
            }
}


module 888_1020(draft = true){


    hall_distance = 35; // distance between axis and magnet

    hall_length = 16;
    hall_length_offset = (11/2-2); // positiv is further from axis
    hall_width = 25+2;
    hall_thickness = 3;

    rotor_ax_neck_diameter = 14.3;


    // 666_1236
    // 666_1007
    // 666_1212
    motor_distance = rotor_head_prerotator_distance; // vzdalenost prerotatoru od hlavni pos_y
    motor_diameter = 35+2;
    motor_axis_diameter = 6.3;
    motor_puller_diameter = 20;
    motor_screw_diameter = M3_screw_diameter;
    motor_mounting_diameter = 25; // vzdalenost protejsich sroubu pro pridelani prerotatoru
    motor_sink = 9.5; // pro zapusteni bez podlozek na motoru...

    plate_overlap =  30; // jak moc velký má být přesah směrem k motoru..

    servo_join_y = 78; // vzdalenost kloubu pro servo
    servo_join_x = 45; // vzdalenost kloubku od osy rotoru
    servo_join_size = 10;
    servo_joint_z = 10; // jak moc nizko bude kloubek
    servo_joint_d =M4_screw_diameter;
    servo_joint_nut_d=M4_nut_diameter;
    servo_joint_nut_h=M4_nut_height;
    servo_join_nut_pocket=M4_nut_pocket;
    servo_join_nut_pocket_h=M3_nut_height;

    wall_thickness=4;

    //brit_height=(rotor_head_wall_height/2+rotor_head_plate_thickness+(rotor_head_bearing_width/2+rotor_head_brit_width+rotor_head_cardan_clearance)*tan(rotor_head_pitch_stop))*cos(rotor_head_pitch_stop);
    brit_height=rotorhead_neck_height+(rotor_head_bearing_ag-rotor_head_bearing_a_center_of_rotation)+rotor_head_kardan_prestress;

    plate_size_y = rotor_head_kardan_inner_y+2*rotor_head_brit_width+2*wall_thickness;
    plate_size_x = plate_overlap + motor_distance + motor_diameter/2;
    plate_size_z = 4;
    echo("Sirka dilu je:", plate_size_y);
    echo("Delka dilu je:", plate_size_x);
    echo("Vyška břitu je:", brit_height);

    back_part_crop = 27;

    zebra_inplate=plate_size_z-3*layer;
    zebra_x=(rotor_head_kardan_inner_x )/2;
    zebra_y=rotor_head_kardan_inner_y/2;
    zebra_th=2;

    difference(){
        union(){
            hull()union(){
                translate([ ( back_part_crop)/2,0, plate_size_z/2])
                    cube([plate_size_x - motor_diameter - back_part_crop, plate_size_y, plate_size_z],center=true);
                // cast nad motorem
                translate([motor_distance, 0, 0])
                    cylinder(d = motor_diameter+10, h=plate_size_z, $fn = draft ? 10 : 100);

                //ramecek pro kardan
                translate([ ( back_part_crop)/2+5,0, brit_height+plate_size_z/2])
                    cube([plate_size_x - motor_diameter - back_part_crop+5, plate_size_y, plate_size_z],center=true);

                cylinder(d = rotorhead_neck_plate_diameter+2, h = rotorhead_desk_thickness);

            }

            // rameno, na kterem jsou kloubky pro servo
            hull()union(){
                    translate([servo_join_x-servo_join_size/2, -servo_join_y/2, 0])
                        cube([servo_join_size, servo_join_y/4 ,servo_joint_z + 5]);
                    translate([0, -plate_size_y/2, 0])
                        cube([plate_size_x - motor_diameter - 1.5*back_part_crop, plate_size_y ,plate_size_z]);
                }

            translate([servo_join_x, -servo_join_y/2 - 1.5, servo_joint_z ])
                rotate([-90, 0, 0])
                    cylinder(d1 = M4_screw_diameter+1, d2 = M4_screw_diameter+5.5, h=1.5, $fn = 30);

            // rameno, na kterem jsou kloubky pro servo
            hull()union(){
                translate([servo_join_x-servo_join_size/2, servo_join_y/2 - servo_join_y/5, 0])
                    cube([servo_join_size, servo_join_y/5 ,servo_joint_z + 5]);
                translate([0, -plate_size_y/2, 0])
                    cube([plate_size_x - motor_diameter - 1.5*back_part_crop, plate_size_y ,plate_size_z]);
            }

            translate([servo_join_x, servo_join_y/2, servo_joint_z ])
                rotate([-90, 0, 0])
                    cylinder(d2 = servo_joint_d+1, d1 = servo_joint_d+5.5, h=1.5, $fn = 50);


    // Vymezovaci podlozka pod motor, misto hlinikove 6.5mm silne podlozky
            /* translate([motor_distance, 0, 0])
                hull(){
                    rotate([180, 0, 0])
                        cylinder(d = motor_diameter, h=6.5, $fn = draft ? 20 : 50);

                    rotate([180, 0, 0])
                        cylinder(d = motor_diameter+10, h=0.1, $fn = draft ? 20 : 50);
                } */


            // Otvory pro pridelani motoru
            translate([motor_distance, 0, -global_clearance/2 ])
                rotate([0,0,45]){
                    for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                        translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, plate_size_z]){
                                cylinder(d1 = M3_screw_diameter*4, d2 = M3_screw_diameter*2, h = motor_sink, $fn = draft?10:60);
                        }
                    }
                }
        }

        // otvor pro osu motoru
        translate([motor_distance, 0, -global_clearance/2-10])
            cylinder(d = motor_axis_diameter, h = 50, $fn = draft ? 10 : 100);

        // otvor pro remenici
        translate([motor_distance, 0, -global_clearance/2-10])
            cylinder(d = motor_puller_diameter, h = 50, $fn = draft ? 10 : 100);

        //misto pro motor
        translate([motor_distance,0,plate_size_z+motor_sink])
            cylinder(d=motor_diameter, h=20,$fn = draft ? 10 : 100);

        // Otvory pro pridelani motoru
        translate([motor_distance, 0, -global_clearance/2 ])
            rotate([0,0,45]){
                for (i=[[0,1],[0,-1],[1,0], [-1,0]]) {
                    translate([i[0]*motor_mounting_diameter/2, i[1]*motor_mounting_diameter/2, 0]){
                        translate([0,0,M3_screw_head_height+global_clearance+0.03])
                            cylinder(d = motor_screw_diameter, h = 50, , $fn = draft ? 10 : 50);
                        cylinder(d = M3_nut_diameter, h = M3_screw_head_height+ global_clearance, $fn = draft ? 10 : 50);
                    }
                }
            }

        // diry pro pripojeni tahla k servu
        translate([servo_join_x, -servo_join_y/2 + 20, servo_joint_z])
            rotate([90, 0, 0])
                cylinder(d = servo_joint_d, h=50, $fn = draft ? 10 : 30);

        translate([servo_join_x, -servo_join_y/2 + 5, servo_joint_z ])
            rotate([-90, 0, 0])
                cylinder(d = servo_joint_nut_d, h=servo_joint_nut_h, $fn = 6);


        translate([servo_join_x, -servo_join_y/2 + 5,  -servo_join_nut_pocket/2 + servo_joint_z])
            cube([plate_size_z*5, servo_join_nut_pocket_h, servo_join_nut_pocket]);

        translate([servo_join_x, servo_join_y/2 - 20, servo_joint_z])
            rotate([-90, 0, 0])
                cylinder(d = servo_joint_d, h=50, $fn = draft ? 10 : 30);

        translate([servo_join_x, servo_join_y/2 - servo_joint_nut_h - 5, servo_joint_z])
            rotate([-90, 0, 0])
                cylinder(d = servo_joint_nut_d, h=servo_joint_nut_h, $fn = 6);

        translate([servo_join_x, servo_join_y/2 - servo_join_nut_pocket_h - 5, -servo_join_nut_pocket/2 + servo_joint_z])
            cube([plate_size_z*5, servo_join_nut_pocket_h, servo_join_nut_pocket]);

        //Otvor na hallovu sondu
        translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, -global_clearance/2])
            cube([hall_length, hall_width, hall_thickness+global_clearance]);

        difference(){
            translate([hall_distance+hall_length_offset+hall_length/2, 0, hall_thickness])
                rotate([0,10,0])
                    translate([-1.5,0,0])
                        cube([3, 6, 50], center=true);

            translate([hall_distance - hall_length/2 + hall_length_offset, -hall_width/2, 0])
                cube([hall_length, hall_width, hall_thickness+global_clearance]);
        }

       //otvor por kardan
       translate([0,0,brit_height+plate_size_z])
            cube([rotor_head_kardan_inner_x+2*rotor_head_brit_width,
                  rotor_head_kardan_inner_y,
                  2*brit_height],center=true);

        //brity
        translate([0,0,plate_size_z+brit_height])
            rotate([0,rotor_head_pitch_stop,0])
                kardan_center_part_model();

       translate([0,0,plate_size_z+brit_height])
            rotate([0,-rotor_head_pitch_stop,0])
                kardan_center_part_model();



        xdst=(rotor_head_kardan_inner_x/2+rotor_head_brit_width-(rotor_head_wall_height/2+rotor_head_plate_thickness)*tan(rotor_head_pitch_stop))*cos(rotor_head_pitch_stop);
        xsize=(plate_size_x - motor_diameter)/2-(rotor_head_kardan_inner_x/2+rotor_head_brit_width)-global_clearance;

        translate([xdst+(zebra_x+rotor_ax_neck_diameter/2-xdst)/2,
                    0,
                    15+plate_size_z])
                cube([(zebra_x+rotor_ax_neck_diameter/2-xdst),
                    rotor_head_kardan_inner_y+2*rotor_head_brit_width+rotor_head_cardan_clearance,
                    30], center=true);


        //zkoseni zadní časti
        translate([zebra_x+rotor_ax_neck_diameter/2,0,2*sqrt(2)*brit_height+plate_size_z])
            rotate([0,45,0])
                cube([4*brit_height,
                rotor_head_kardan_inner_y+2*(rotor_head_brit_width+rotor_head_cardan_clearance),
                4*brit_height],center=true);


        //otvor pro soustružený krček
        translate([0, 0, -brit_height])
            cylinder(d = rotor_ax_neck_diameter, h = 2*brit_height, $fn = draft ? 20 : 80);

        //sražení hran otvoru krčku
            cylinder(d1 = rotor_ax_neck_diameter + 2*global_clearance, d2 = rotor_ax_neck_diameter, h = 2*global_clearance, $fn = draft ? 20 : 80);

        translate([0, 0, wall_thickness - 2*global_clearance])
            cylinder(d1 = rotor_ax_neck_diameter, d2 = rotor_ax_neck_diameter + 2*global_clearance, h = 2*global_clearance, $fn = draft ? 20 : 80);


         //žebra
         for(i=[45,135,225,315]){
            translate([0,0,plate_size_z-zebra_inplate])
                rotate([0,0,i])
                        difference(){
                            translate([rotor_ax_neck_diameter/2,-zebra_th/2,0])
                                cube([1.0*(zebra_x),zebra_th,brit_height]);
                            for(j=[0:1:10])
                                translate([rotor_ax_neck_diameter/2+zebra_th/2+j*3*zebra_th,0,brit_height])
                                    cube([zebra_th,2*zebra_th,2*brit_height],center=true);
                        }
         }

         for(i=[0,90,180,270]){
            translate([0,0,plate_size_z-zebra_inplate])
                rotate([0,0,i])
                    difference(){
                        translate([rotor_ax_neck_diameter/2,-zebra_th/2,0])
                            cube([zebra_x-rotor_head_brit_width-0.5*rotor_head_cardan_clearance,zebra_th,brit_height]);
                            for(j=[0:1:10])
                                translate([rotor_ax_neck_diameter/2+zebra_th/2+j*3*zebra_th,0,brit_height])
                                    cube([zebra_th,2*zebra_th,2*brit_height],center=true);
                        }
         }

        // Otvory pro dotahovani kuloveho loziska
        for (i=[1:4]) {
            rotate([0, 0, 45+90*i])
                translate([rotorhead_neck_plate_diameter/2+2, 0, 0])
                    cylinder(d = 4.5, h = 20, $fn = 20);
        }
     }
}

module position_888_1020(enable = true){

        translate(enable? [main_pilon_position + rotor_head_bearing_x_shift, 0, height_of_vertical_tube + rotor_head_height] :  [0,0,0])
          rotate(enable? [0, 9+rotor_head_pitch, rotor_head_roll] : [0,0,0])
          //translate([0,0,0])
            children();
}

888_1020(false);
//translate([0,0,40])
   // kardan_center_part_model();
