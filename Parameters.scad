
//Main tube diameter - hole [mm]
main_tube_outer_diameter = 25.4;
main_tube_inner_diameter = 23.25;

//Tube for undercarriage - rendered hole [mm]
tube_for_undercarriage_outer_diameter = 10.6;
tube_for_undercarriage_inner_diameter = 6;
global_clearance = 0.5;

// Nastavení parametrů rotoru

rotor_blade_AOA = 1.5;      // nastavení úhlu náběhu rotorového listu
rotor_blade_length = 970;   // délka rotorového listu
rator_blade_depth = 50;     // hloubka rotorového listu


// Parameters of tube couplings
coupling_wall_thickness = main_tube_outer_diameter/5;  //width of coupling walls 
thickness_between_tubes = main_tube_outer_diameter/10;    // minimum distance between tubes in couplings

coupling_wall_thickness_undercarriage = tube_for_undercarriage_outer_diameter/3;
thickness_between_tubes_undercarriage = tube_for_undercarriage_outer_diameter/10;

608_bearing_outer_diameter = 22;
608_bearing_thickness = 7.1;


// screw length step - minimum difference in length between two types of screws
basic_screw_length = 5;


//Screw diameter and nut for M6 [mm]
M6_screw_diameter=6.5;
Nut_height_M6 = 4.9;
Nut_diameter_M6 = 11.8;


//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
Nut_height_M4 = 3.2;
Nut_diameter_M4 = 8.4;
Screw_head_height_M4 = 4;

//Screw diameter and nut for M3 [mm]
M3_screw_diameter = 3.2;
Nut_height_M3 = 2.7;	
Nut_diameter_M3 = 6.6; 
Screw_head_height_M3 = 3;


//šroub servo
Servo_screw = 1.5;

//The tube for help
Help_main_tube_outer = 25;
Help_main_tube_inner = 23; 
Help_tube_for_undercarriage_outer = 10;
Help_tube_for_undercarriage_inner = 5;


//main hull parameters

hull_drop_length = 580;
hull_wall_thickness = 0.8;
hull_y_size = 120;
hull_z_size = 150;
hull_x_size = 580;
hull_corner_radius = 4;
hull_airfoil_thickness= 35;  // thickness of drop generating airfoil in percent of length.
hull_scale_x = 1;
hull_scale_y = 1.5;
hull_scale_z = 1.5;

main_pilon_position = 170+68+30;       // pozice rotorového pilonu měřená od přední části krytu
cover_pilon_position = 180;
height_of_vertical_tube = 275; //278mm je změřená délka trubky. 

//délka hlavní dlouhé trubky
length_of_main_tube = 820;
length_of_undercarriage_tube = 300;

ribbon_width = 5; // šířka vyztužovacích lemů. 

// šířka otvoru v přední části kapoty pro držák motoru.
width_of_engine_holder = 63;

//Top Cover Division - dělení horního krytu pro tisk
top_cover_division = [0, 50, 150, 280, 410, hull_x_size]; // upraveny seznam tak, aby deleni začinalo od nuly, což umožňí úplně automatické rozdělení.

//Bottom Cover Division - dělení dolního krytu pro tisk
bottom_cover_division = [0,100,232.5,365, 470, hull_x_size];
// zkrácená část pro payload pro testovací tisk
//bottom_cover_division = [0,200,250,365, 470, hull_x_size];





//Cover pilon division - na výšku (v ose Z)
cover_pilon_division = [0,170,height_of_vertical_tube + main_tube_outer_diameter + coupling_wall_thickness];

//pozice šroubů
	//horní kryt
top_screw_position = [0,
                    (top_cover_division[0] + top_cover_division[1])/2,
                    (top_cover_division[2] - top_cover_division[1])/2 + top_cover_division[1],
                    (top_cover_division[3] - top_cover_division[2])/2 + top_cover_division[2],
                    (top_cover_division[4] - top_cover_division[3])/8 + top_cover_division[3],
                    (top_cover_division[5] - top_cover_division[4])/2 + top_cover_division[4] - top_cover_division[1]/3];
	//spodní kryt
bottom_screw_position = [0,
                        (bottom_cover_division[0] + bottom_cover_division[1])*(2/6), 
                        bottom_cover_division[1]*(9/10), 
                        bottom_cover_division[3] + bottom_cover_division[1]*(1/10), 
                        bottom_cover_division[3] + bottom_cover_division[1]*(3/5)];




//šířka zámků
lock_width = 10;

//délka zámků
lock_length = 3;


//accumulator
//základní rozměry akumulátoru
width_of_accumulator = 129.4;//45+1;
depth_of_accumulator = 40.61;
height_of_accumulator = 43.65;
//Zapuštění akumulátoru
sink_of_accumulator = 5; //main_tube_outer_diameter/5 - Nut_height_M3*1.5;

//tloušťka hrany spojky
accumulator_holder_width = 18; 
accumulator_holder_thickness = 10; 

//posunutí akumálátoru na podložce
move_of_accumulator = 75;   // pozice akumulátoru (ovlivňuje těžiště)


////////////////
// Senzory
///////////////////

//opticalFlow
width_optical_flow_senzor = 45.5;
depth_optical_flow_senzor = 6;
height_optical_flow_senzor = 35;
sink_of_optical_flow_senzor = depth_optical_flow_senzor - 5; 
M3_optical_flow_senzor_Z = 30.4;
M3_optical_flow_senzor_X = 24;
M3_optical_flow_senzor_Z_alone = 9.1;
M3_optical_flow_senzor_X_alone = 16.7;

//GPS anténa
GPS_outer_length = 48.01;   //Vnější rozměr
GPS_inner_length = 37.48;   //Vnitřní rozměr
GPS_diameter = (GPS_outer_length - GPS_inner_length)/2;    //Průměr otvoru
GPS_middle_length = GPS_diameter + GPS_inner_length;      //Střední rozměr


////podzvozek

radius_undercarriage = 25;
vzdalenost_x = tan(20) * 131;
vzdalenost_y = (131 - radius_undercarriage)/tan(79);
uhel_y = 90 - 20;
uhel_x = 90 - 79;

maximum_printable_size = 150;


////Pitotova trubice
Pitot_tube_diameter = 4.02 + 1;
Distance_hole_from_tube = 11.92;  //vzdálenost otvoru pro připevnění od samotné trubičky


////směrové kormidlo
Rudder_length = 4*main_tube_outer_diameter;
Rudder_height = 2*main_tube_outer_diameter;
Rudder_depth = main_tube_outer_diameter/2;
gap_width = 2*hull_wall_thickness;      //šířka mezery mezi směrovkou a ocasní plochou
ruder_shaft_diameter = 2.6; //otočné uchycení směrovky - průměr 2 mm


/////spojka 666_1004

    width_666_1004 = (main_tube_outer_diameter+2*coupling_wall_thickness - Screw_head_height_M3)/basic_screw_length;
        echo("width_666_1004 is", width_666_1004);
    
        echo("ceil_666_1004 is", ceil(width_666_1004));

    coupling_screw_length_666_1004 = (ceil(width_666_1004)) * basic_screw_length;
        echo("coupling_screw_length_666_1004 is", coupling_screw_length_666_1004);

    coupling_width_666_1004 = coupling_screw_length_666_1004 + Screw_head_height_M3;
        echo("coupling_width_666_1004 is", coupling_width_666_1004);

    height_666_1004 = coupling_width_666_1004;
        echo("height_666_1004 is", height_666_1004);

    depth_666_1004 = main_tube_outer_diameter*2+2*coupling_wall_thickness+thickness_between_tubes;
        echo("depth_666_1004 is", depth_666_1004);

    depth_666_1004_drillhelper = main_tube_outer_diameter*3;

/////spojka 666_1026



    width_666_1026 = main_tube_outer_diameter + 2*thickness_between_tubes;
    
    depth_666_1026 = (main_tube_outer_diameter*2)/basic_screw_length;
        echo("depth_666_1026 is", depth_666_1026);
    
        echo("ceil_666_1026 is", ceil(depth_666_1026));

    coupling_screw_length_666_1026 = (ceil(depth_666_1026)) * basic_screw_length;
        echo("coupling_screw_length_666_1026 is", coupling_screw_length_666_1026);


thickness_of_plate = coupling_screw_length_666_1026 - Screw_head_height_M4 - 50; //50 mm je konstatní šířka spojky 666_1026
    echo("thickness_of_plate is", thickness_of_plate);

        coupling_depth_666_1026 = coupling_screw_length_666_1026 - Screw_head_height_M4 - thickness_of_plate;      //zde je odečten screw_head_height_M4 pro určení šířky, tak aby šroub přesahoval pro potřebnou matku
            echo("coupling_depth_666_1026 is", coupling_depth_666_1026);

    height_666_1026 = 2*main_tube_outer_diameter;
        echo("height_666_1026 is", height_666_1026);

//tloušťka plechu pro zajištění konstatní šířky spojky 50 mm

    width_666_1026_drillhelper = main_tube_outer_diameter*2; 

    depth_666_1026_drillhelper = main_tube_outer_diameter + 4*thickness_between_tubes;


////spojka 666_1017

    width_666_1017 = (main_tube_outer_diameter + 4*coupling_wall_thickness - Screw_head_height_M3)/basic_screw_length;
        echo("width_666_1017 is", width_666_1017);
    
        echo("ceil_666_1017 is", ceil(width_666_1017));

    coupling_screw_length_666_1017 = (ceil(width_666_1017)) * basic_screw_length;
        echo("coupling_screw_length_666_1017 is", coupling_screw_length_666_1017);

    coupling_width_666_1017 = coupling_screw_length_666_1017 + Screw_head_height_M3;
        echo("coupling_width_666_1017 is", coupling_width_666_1017);

    depth_666_1017 = coupling_width_666_1017;

    height_666_1017= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;

    width_666_1017_drillhelper = main_tube_outer_diameter+4*thickness_between_tubes;
    
    depth_666_1017_drillhelper = main_tube_outer_diameter*2;


////spojka 666_1014

    width_666_1014 = tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;

    depth_666_1014 = tube_for_undercarriage_outer_diameter + M3_screw_diameter + 2*coupling_wall_thickness_undercarriage + thickness_between_tubes_undercarriage;

    height_666_1014 = width_666_1014;


    width_666_1014_drillhelper = 2*tube_for_undercarriage_outer_diameter + 2*coupling_wall_thickness_undercarriage;






//umístění podvozkových trubek

second_undercarriage_hole =height_666_1026 + height_666_1004/2 + 170 + 160;


//Base Divison - dělení podložky
base_division = [0, 159, main_pilon_position + coupling_width_666_1017/2 + global_clearance/2, second_undercarriage_hole + coupling_width_666_1004/2 + global_clearance/2, hull_x_size];

// šrouby pro připevnění podložky k hlavní trubce
base_mounting_screw_length = 50;