include <../parameters.scad>

/*
bearing_efsm_12_width = 40+1;
bearing_efsm_12_h = bearing_efsm_12_width;
bearing_efsm_12_boltd = 28/2; // polovina vzdalenosti mezi srouby
bearing_efsm_12_m = bearing_efsm_12_boltd*2;
bearing_efsm_12_db = 25;
bearing_efsm_12_ag = 13;
bearing_efsm_12_a1 = 7;
bearing_efsm_12_n = M5_screw_diameter;
bearing_efsm_12_d = 12.15;
bearing_efsm_12_B = 10; // ball height
bearing_efsm_space = 1;
*/

roll_stop=10;//max roll angle
pitch_stop=15;//max pitch angle

wall_height=10;//height of side wall of center part
brit_width=5;
plate_thickness=3;
britstop_thickness=3;

kardan_clearance=1;

bearing_width=bearing_efsm_12_width;
bearing_h=bearing_efsm_12_h;
bearing_db=bearing_efsm_12_db;
bearing_m=bearing_efsm_12_m;
bearing_d=bearing_efsm_12_d;
bearing_a_center_of_rotation=7;

//computed parameters
inner_x=bearing_width+kardan_clearance; //center part
inner_y=2*(bearing_h/2*1/cos(roll_stop)+wall_height/2*tan(roll_stop)); //center part
hole_r=(bearing_db/2*1/cos(roll_stop));
top_brit_height=(wall_height/2+plate_thickness+(bearing_width/2+brit_width)*tan(pitch_stop))*cos(pitch_stop);

