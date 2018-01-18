
//Main tube diameter - hole [mm]
main_tube_outer_diameter = 25.4;
main_tube_inner_diameter = 23.5;

//Tube for undercarriage - hole [mm]
tube_for_undercarriage_outer_diameter = 10.6;
tube_for_undercarriage_inner_diameter = 6;
global_clearance = 0.5;

// Parameters of cube couplings
coupling_wall_thickness = main_tube_outer_diameter/5;  //width of coupling walls 
thickness_between_tubes = main_tube_outer_diameter/10;    // minimum distance between tubes in couplings

//Screw diameter and nut for M4 [mm]
M4_screw_diameter=4.5;
Nut_height_M4 = 3.2;
Nut_diameter_M4 = 7.86;


//Screw diameter and nut for M3 [mm]
M3_screw_diameter = 3.2;
Nut_height_M3 = 1.7;	
Nut_diameter_M3 = 6.6; 


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
hull_airfoil_thickness= 35;  // thickness of drop generating airfoil in percent of lenght.
hull_scale_x = 1;
hull_scale_y = 1.5;
hull_scale_z = 1.5;

main_pilon_position = 170+68;

ribbon_width = 10; // šířka vyztužovacích lemů. 


//accumulator
//základní rozměry akumulátoru
width_of_accumulator = 129.4;//45+1;
depth_of_accumulator = 40.61;
height_of_accumulator = 43.65;
//Zapuštění akumulátoru
sink_of_accumulator = main_tube_outer_diameter/4 - Nut_height_M3*1.5;
//tloušťka hrany spojky
accumulator_holder_width = 18; 
accumulator_holder_thickness = 5; 
//posunutí akumálátoru na podložce
move_of_accumulator = 165;

width_of_engine_holder = 63;

//Top Cover Division - dělení horního krytu pro tisk
top_cover_division = [0, 50, 150, 280, 430, hull_x_size]; // upraveny seznam tak, aby deleni začinalo od nuly, což umožňí úplně automatické rozdělení.

//Bottom Cover Division - dělení dolního krytu pro tisk
bottom_cover_division = [0,100,250,380, 450, hull_x_size];

//Base Divison - dělení podložky
base_division = [0,150,300,420, hull_x_size];

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
