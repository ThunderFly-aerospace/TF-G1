DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>
include <../parameters.scad>
use <./lib/stdlib/naca4.scad>
use <./lib/stdlib/sweep.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;
DIM_SPACE = .1 * DOC_SCALING_FACTOR;


Rudder_shaft_outside_max_diameter = tail_length * surface_distance(x = Rudder_shaft_x_position / tail_length, naca = 0010, open = false) * 2;
Rudder_shaft_outside_min_diameter = tail_length * surface_distance(x = Rudder_shaft_x_position / tail_length, naca = 0005, open = false) * 2;

draft = $preview;

module 666_1028_rudder_shape(draft = true) {
  N = 40;
  sweep(gen_dat(M=tail_height / 2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( L = extra_length(i))
    let( af = vec3D(
        airfoil_data([0,0,0.05+thickness(i)], L=tail_length+extra_length(i), N = N)))
    T_(0, 0, (i)*2, af)];  // translate airfoil

  function thickness(i) = gauss(i,0.05,(tail_bottom_height + Rudder_height / 2) / 2,15);
  function extra_length(i) = gauss(i,50,(tail_bottom_height + Rudder_height / 2) / 2,23);
}

module 666_1028_rudder_shape_inside(drift = true) {
  //TODO: wall thickness repair
  N = 40;
  sweep(gen_dat(M=tail_height / 2 - Rudder_wall_thickness / 2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( L = extra_length(i))
    let( af = vec3D(
        airfoil_data([0,0,0.05+thickness(i)], L=tail_length+extra_length(i)-Rudder_wall_thickness*2, N = N)))
    T_(Rudder_wall_thickness, 0, (i)*2 + Rudder_wall_thickness, af)];  // translate airfoil

  function thickness(i) = gauss(i,0.05,(tail_bottom_height + Rudder_height / 2 - Rudder_wall_thickness / 2) / 2,15);
  function extra_length(i) = gauss(i,50,(tail_bottom_height + Rudder_height / 2 - Rudder_wall_thickness / 2) / 2,23);
}

// side_choose -tvar A levá (- 1) nebo pravá (1) strana (ve směru letu)

module 666_1028_body_bottom(side_choose = 1, draft = true) {
    difference(){
	union(){
	    //Main Wall-------------------------------------------------
		intersection(){	    
			666_1028_rudder_shape();
			translate([tail_length, 0, tail_bottom_height / 2])
			cube([tail_length * 2, tail_length, tail_bottom_height], center = true);
		}

		intersection(){
		    translate ([tail_length/2, 0, -25])
			cube([tail_length, 50, 50], center = true);

		    rotate([0,90,0])
			rotate_extrude($fn = draft ? 50 : 200)
			    rotate([0,0,90])
				difference(){
				  polygon(points = airfoil_data(naca = 0005, L = tail_length, N = draft ? 50 : 100, open = false));
				  square(tail_length);
				}
		}
	}
    //Removing material-----------------------------------------

    //Holes for rudder shaft------------------------------------
    translate([Rudder_shaft_x_position, 0, 1])
        cylinder(d = Rudder_shaft_diameter, h = tail_bottom_height + 2, $fn = draft ? 10 : 50);


    }
}


//Rudder_shaft_outside_shape--------------------------------

module 666_1028_rudder_shaft_shape(draft = true){
  N = 40;
  sweep(gen_dat(M=tail_height / 2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( af = vec3D(circle_data(r=Rudder_shaft_outside_min_diameter/2+thickness(i), N=50)))
    T_(0, 0, (i)*2, af)];

  function thickness(i) = gauss(i,(Rudder_shaft_outside_max_diameter-Rudder_shaft_outside_min_diameter),(tail_bottom_height+Rudder_height/2)/2,15);
}

//Rudder_shaft_inside_shape---------------------------------

module 666_1028_rudder_shaft_shape_inside(draft = true){
  N = 40;
  sweep(gen_dat(M=tail_height/2-Rudder_wall_thickness/2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( af = vec3D(circle_data(r=Rudder_shaft_outside_min_diameter/2+thickness(i)-Rudder_wall_thickness, N=50)))
    T_(0, 0, (i)*2+Rudder_wall_thickness, af)];

  function thickness(i) = gauss(i,(Rudder_shaft_outside_max_diameter-Rudder_shaft_outside_min_diameter),(tail_bottom_height+Rudder_height/2)/2,15);
}

//Rudder_shaft_cutting_shape-------------------------------

module 666_1028_rudder_shaft_shape_cutting(draft = true) {
  N = 40;
  sweep(gen_dat(M=tail_height / 2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( af = vec3D(circle_data(r=Rudder_shaft_outside_min_diameter/2+thickness(i)+Rudder_gap_width, N=50)))
    T_(0, 0, (i)*2, af)];

  function thickness(i) = gauss(i,(Rudder_shaft_outside_max_diameter-Rudder_shaft_outside_min_diameter),(tail_bottom_height+Rudder_height/2)/2,15);
}


module 666_1028_body_middle(side_choose = 1, draft = true) {
	union(){
		difference(){
				//Main shape-------------------------------------------------

				intersection(){
					translate([0 ,0 ,-tail_bottom_height])
					666_1028_rudder_shape();
					translate([tail_length, 0, Rudder_height / 2])
					cube([tail_length * 2, tail_length, Rudder_height], center = true);
				}


				//Removing material-----------------------------------------

			//Hole for rudder-------------------------------------------

			translate([Rudder_shaft_x_position, - tail_depth/2, -1])
			cube([tail_length*2, tail_depth, Rudder_height+2]);

			//Rudder shaft hole-----------------------------------------

			translate([Rudder_shaft_x_position, 0, -tail_bottom_height])
			666_1028_rudder_shaft_shape_cutting();


			//Removing material for mount and servo---------------------

			translate([(tail_tube_mount_length) / 2, 0, tail_pipe_z_position - tail_bottom_height])
			union() {

				//Hole for servo------------------------------------
				//TODO: Y axis not dynamic

				translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length)/2+Rudder_infill_wall_thickness, side_choose *  tail_servo_wall_and_screws_y_position, - tail_servo_height / 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
				cube([tail_servo_length_inside, Rudder_depth * 2, tail_servo_height], center = true);

				//Servo mount walls---------------------------------

				translate([(tail_tube_mount_length + tail_servo_length) / 2 + Rudder_infill_wall_thickness, - side_choose * (- Rudder_depth + tail_servo_wall_y_offset), - tail_servo_height / 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
				cube([tail_servo_length, Rudder_depth * 2, tail_servo_height], center = true);

				//Servo screw holes---------------------------------
				//TODO: Y axis not dynamic

				translate([(tail_tube_mount_length + tail_servo_length + tail_servo_screws_gap) / 2 + Rudder_infill_wall_thickness, side_choose * tail_servo_wall_and_screws_y_position, - Rudder_infill_wall_thickness - tail_servo_z_offset - tail_servo_screws_z_position])
				rotate([90, 0, 0])
				cylinder(h = Rudder_depth * 2, d = tail_servo_screws_diameter, $fn = draft ? 10 : 50, center = true);

				translate([(tail_tube_mount_length + tail_servo_length - tail_servo_screws_gap) / 2 + Rudder_infill_wall_thickness, side_choose *  tail_servo_wall_and_screws_y_position, - Rudder_infill_wall_thickness - tail_servo_z_offset - tail_servo_screws_z_position])
				rotate([90, 0, 0])
				cylinder(h = Rudder_depth * 2, d = tail_servo_screws_diameter, $fn = draft ? 10 : 50, center = true);

				//Hole for tube-------------------------------------

				translate([-1-Rudder_infill_wall_thickness/2, 0, 0])
				cube([tail_tube_mount_length + 2, Rudder_depth * 4, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);

				//Hole for wires------------------------------------

				translate([(tail_tube_mount_length+tail_servo_wire_hole_length)/2-Rudder_wall_thickness, 0, -(tube_for_undercarriage_outer_diameter+(global_clearance+Rudder_infill_wall_thickness)*2-tail_servo_wire_hole_height)/2])
				cube([tail_servo_wire_hole_length, tail_servo_wire_hole_width, tail_servo_wire_hole_height], center = true);

				//Hole for wings------------------------------------

				translate([-1-Rudder_infill_wall_thickness/2, 0, 0])
				cube([tail_tube_mount_length+2, tail_tube_mount_wings_thickness+global_clearance*2, tail_tube_mount_height+global_clearance*2], center = true);

				//Front side cut------------------------------------

				translate([- tail_tube_mount_length+tail_front_mount_edge_cut_x_position, 0, 0])
				cube([tail_tube_mount_length, Rudder_depth*2, tail_tube_mount_height+global_clearance*2], center=true);

				//Hole for tube mount screws------------------------

				translate([tail_tube_mount_screws_x_position, -side_choose*(Rudder_depth+1) , tail_tube_mount_screws_z_position])
				rotate([-side_choose*90, 0, 0])
				union() {
					cylinder(h=Rudder_depth*2+2, d=M3_screw_diameter, $fn = draft ? 10 : 50);
					difference() {
						union() {
							cylinder(h=Rudder_depth+1, d=M3_nut_diameter, $fn = draft ? 10 : 50);
							cylinder(h=Rudder_depth*2+2, d=M3_nut_diameter, $fn = 6);
						}
						translate([-2-Rudder_infill_wall_thickness/2, 0, Rudder_depth+1])
						rotate([90, 0, 0])
						cube([tail_tube_mount_length+2, tail_tube_mount_wings_thickness+(global_clearance+tail_tube_mount_screws_wall_thickness)*2, tail_tube_mount_height+global_clearance*2], center=true);
					}
				}

				//-------------------------------------------------

				translate([-tail_tube_mount_screws_x_position, -side_choose*(Rudder_depth+1) , tail_tube_mount_screws_z_position])
				rotate([-side_choose*90, 0, 0])
				union() {
					cylinder(h=Rudder_depth*2+2, d=M3_screw_diameter, $fn = draft ? 10 : 50);
					difference() {
						union() {
							cylinder(h=Rudder_depth+1, d=M3_nut_diameter, $fn = draft ? 10 : 50);
							cylinder(h=Rudder_depth*2+2, d=M3_nut_diameter, $fn = 6);
						}
						translate([-2-Rudder_infill_wall_thickness/2, 0, Rudder_depth+1])
						rotate([90, 0, 0])
						cube([tail_tube_mount_length+2, tail_tube_mount_wings_thickness+(global_clearance+tail_tube_mount_screws_wall_thickness)*2, tail_tube_mount_height+global_clearance*2], center=true);
					}
				}

				//-------------------------------------------------

				translate([tail_tube_mount_screws_x_position, -side_choose*(Rudder_depth+1) , -tail_tube_mount_screws_z_position])
				rotate([-side_choose*90, 0, 0])
				union() {
					cylinder(h=Rudder_depth*2+2, d=M3_screw_diameter, $fn = draft ? 10 : 50);
					difference() {
						union() {
							cylinder(h=Rudder_depth+1, d=M3_nut_diameter, $fn = draft ? 10 : 50);
							cylinder(h=Rudder_depth*2+2, d=M3_nut_diameter, $fn = 6);
						}
						translate([-2-Rudder_infill_wall_thickness/2, 0, Rudder_depth+1])
						rotate([90, 0, 0])
						cube([tail_tube_mount_length+2, tail_tube_mount_wings_thickness+(global_clearance+tail_tube_mount_screws_wall_thickness)*2, tail_tube_mount_height+global_clearance*2], center=true);
					}
				}

				//-------------------------------------------------

				translate([-tail_tube_mount_screws_x_position, -side_choose*(Rudder_depth+1) , -tail_tube_mount_screws_z_position])
				rotate([-side_choose*90, 0, 0])
				union() {
					cylinder(h=Rudder_depth*2+2, d=M3_screw_diameter, $fn = draft ? 10 : 50);
					difference() {
						union() {
							cylinder(h=Rudder_depth+1, d=M3_nut_diameter, $fn = draft ? 10 : 50);
							cylinder(h=Rudder_depth*2+2, d=M3_nut_diameter, $fn = 6);
						}
						translate([-2-Rudder_infill_wall_thickness/2, 0, Rudder_depth+1])
						rotate([90, 0, 0])
						cube([tail_tube_mount_length+2, tail_tube_mount_wings_thickness+(global_clearance+tail_tube_mount_screws_wall_thickness)*2, tail_tube_mount_height+global_clearance*2], center=true);
					}
				}

				//-------------------------------------------------

			}
		}

		//Printing support--------------------------------------------
		// (not dynamic at all)

		translate([tail_tube_mount_length / 2 + 2, 0, tail_pipe_z_position-tail_bottom_height])
		difference() {
			cube([tail_tube_mount_length - 7, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2,tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2], center = true);
			cube([tail_tube_mount_length - 8, tail_tube_mount_wings_thickness + (global_clearance + tail_tube_mount_screws_wall_thickness) * 2 - 2, tube_for_undercarriage_outer_diameter + (global_clearance + Rudder_infill_wall_thickness) * 2 + 2], center = true);
		}

		//------------------------------------------------------------
	}
}

module 666_1028_body_top(side_choose = 1, draft = true) {
    difference(){
            //Main Wall-------------------------------------------------
		intersection(){
			translate([0, 0, tail_top_height - tail_height])	    
			666_1028_rudder_shape();
			translate([tail_length, 0, tail_top_height / 2])
			cube([tail_length * 2, tail_length, tail_top_height], center = true);
		}

        //Removing material-----------------------------------------

        //Holes for rudder shaft------------------------------------
        translate([Rudder_shaft_x_position, 0, - 1])
            cylinder(d = Rudder_shaft_diameter, h = tail_height - tail_bottom_height - Rudder_height + 2, $fn = draft ? 10 : 50);

        //Cut to make shape A angle---------------------------------
        translate([tail_length / 2, side_choose * (sqrt(pow(tail_depth, 2) * 2) / 2 - tail_shape_A_cutter_y_offset), tail_height - tail_bottom_height - Rudder_height + tail_shape_A_cutter_z_offset])
            rotate([-side_choose * (90 - tail_angle / 2), 0, 0])
                union() {
                    cube([tail_length * 2, tail_depth, tail_depth], center = true);
                    translate([0, - side_choose * (tail_depth - 15), - tail_depth / 2])
                        cube([tail_length * 2, tail_depth, tail_depth], center = true);
                }

        //Holes for shape A holding screws--------------------------
        //TODO: check if they are dynamic

        translate([tail_A_shape_screw_x_position_1, 0, tail_A_shape_screw_y_pisition])
            rotate([- side_choose * (90 - tail_angle / 2), 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
		    translate([0, 0, - tail_A_shape_screw_depth])
                        if(side_choose == 1) {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 6, center = true);
                        } else {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 50, center = true);
                        }
                }

        translate([tail_A_shape_screw_x_position_2, 0, tail_A_shape_screw_y_pisition])
            rotate([- side_choose * (90 - tail_angle / 2), 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
		    translate([0, 0, - tail_A_shape_screw_depth])
                        if(side_choose == 1) {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 6, center = true);
                        } else {
                            cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 50, center = true);
                        }
                }
                
        //Holes for top passive rudder holding screws--------------------------
        //TODO: check if they are dynamic

        translate([tail_top_passive_rudder_screw_x_position_1, 0, tail_top_passive_rudder_screw_y_pisition])
            rotate([- side_choose * (- tail_angle / 2), 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
                    translate([0, 0, - Rudder_depth])
                        cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 50, center = true);
                }

        translate([tail_top_passive_rudder_screw_x_position_2, 0, tail_top_passive_rudder_screw_y_pisition])
            rotate([- side_choose * (- tail_angle / 2), 0, 0])
                union(){
                    cylinder(d = M3_screw_diameter, h = Rudder_depth * 4, $fn = draft ? 10 : 50, center = true);
                    translate([0, 0, - Rudder_depth])
                        cylinder(d = M3_nut_diameter, h = Rudder_depth * 2, $fn = 50, center = true);
                }
         //----------------------------------------------------------
    }
}

module 666_1028_tube_mount(draft = true) {
    difference() {
       union() {
            intersection() {
                //main body
                translate([- tail_tube_mount_length / 2, 0, - tail_pipe_z_position])
			666_1028_rudder_shape();
                cube([tail_tube_mount_length - global_clearance, Rudder_depth * 2, tail_tube_mount_height], center = true);
            }
            //tube wall
            rotate([0, 90, 0])
                cylinder(d = tube_for_undercarriage_outer_diameter + Rudder_wall_thickness * 2, h = tail_tube_mount_length - global_clearance, center = true, $fn = draft ? 10 : 50);
        }

        //tube hole
        rotate([0, 90, 0])
            cylinder(d = tube_for_undercarriage_outer_diameter, h = tail_tube_mount_length + 2, center = true, $fn = draft ? 10 : 50);

        //tube mount screws
        translate([tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([- tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);
        translate([- tail_tube_mount_screws_x_position + global_clearance / 2, Rudder_depth + 1  , - tail_tube_mount_screws_z_position])
            rotate([90, 0, 0])
                cylinder(h = Rudder_depth * 2 + 2, d = M3_screw_diameter, $fn = draft ? 10 : 50);

        //wings cut
        difference() {
            union() {
                translate([0, (Rudder_depth + tail_tube_mount_wings_thickness) / 2, (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 + Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, (Rudder_depth + tail_tube_mount_wings_thickness) / 2, - (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 - Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, - (Rudder_depth + tail_tube_mount_wings_thickness) / 2, (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 + Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
                translate([0, - (Rudder_depth + tail_tube_mount_wings_thickness) / 2, - (tail_tube_mount_height +  tube_for_undercarriage_outer_diameter) / 2 - Rudder_infill_wall_thickness])
                    cube([tail_tube_mount_length + 2, Rudder_depth, tail_tube_mount_height], center = true);
            }

            //front side cut
            translate([- tail_tube_mount_length + tail_front_mount_edge_cut_x_position, 0, 0])
                cube([tail_tube_mount_length, Rudder_depth * 2, tail_tube_mount_height + global_clearance * 2], center = true);
        }
    }
}

module 666_1028_rudder(side_choose = 1, draft = true) {
	difference(){
		//Main rudder material-----------------------------

		union(){

			//Main rudder shape---------------------------

			intersection(){
				translate([0 ,0 ,-tail_bottom_height-global_clearance])
				666_1028_rudder_shape();
				translate([Rudder_shaft_x_position, -tail_length/2, 0])
				cube([tail_length*2, tail_length, Rudder_height-global_clearance*2]);
			}			
			

			//Front shaft shape---------------------------

			intersection(){
				translate([Rudder_shaft_x_position ,0 ,-tail_bottom_height-global_clearance])
				666_1028_rudder_shaft_shape();
				translate([0, -tail_length/2, 0])
				cube([tail_length*2, tail_length, Rudder_height-global_clearance*2]);
			}			

                    //Washer like material on top---------------------

                    translate([Rudder_shaft_x_position, 0, 0])
                        cylinder(d = M3_nut_diameter, h = 1, $fn = draft ? 10 : 50, center = true);
		}
	

        //Shaft hole--------------------------------

        translate([Rudder_shaft_x_position, 0, Rudder_height / 2])
        cylinder(d = Rudder_shaft_diameter, h = Rudder_height * 2, $fn = draft ? 10 : 50, center = true);

        //Cutting front side of servo arm holder to make it square and same position as servo----------------

        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, - tail_servo_rudder_arm_depth / 2 - tail_servo_rudder_arm_y_offset, tail_servo_rudder_arm_z_position])
            union() {
                cube([tail_servo_rudder_arm_side_size, tail_servo_rudder_arm_depth, tail_servo_rudder_arm_side_size], center = true);
                translate([- 2.35 / 2, 0, 0])
                    cube([tail_servo_rudder_arm_side_size + 2.35, tail_servo_rudder_arm_depth, 5], center = true);
            }

        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, tail_servo_rudder_arm_depth / 2 + tail_servo_rudder_arm_y_offset, tail_servo_rudder_arm_z_position])
            union() {
                cube([tail_servo_rudder_arm_side_size, tail_servo_rudder_arm_depth, tail_servo_rudder_arm_side_size], center = true);
                translate([- 2.35 / 2, 0, 0])
                    cube([tail_servo_rudder_arm_side_size + 2.35, tail_servo_rudder_arm_depth, 5], center = true);
            }

	//Holes for servo arm------------------------------------------------------------------------------

        height = 10;
        lenght = 11;

        // vypocet pozice sroubu
        // roztec sroubu pres uhlopricku
        screws_distance = (11+7.5)/2;

        // výpočet úhlopříčky základny páky
        diagonal = sqrt(height*height+lenght*lenght);


        // šrouby leží na úhlopříčce základny a je známá vzdálenost mezi šrouby
        // pozice šroubů se proto spočítají z podobnosti trojúhelníků
        screw_xposition = (lenght/diagonal)*(screws_distance/2);
        screw_yposition = (height/diagonal)*(screws_distance/2);

        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, 0, tail_servo_rudder_arm_z_position]){
            translate([screw_xposition, 0, screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([-screw_xposition, 0, -screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([screw_xposition, 0, -screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);

            translate([-screw_xposition, 0, screw_yposition])
                rotate([90,0,0])
                    cylinder(h = 100, d = 2.3, $fn = 10, center = true);


	}
	
	//--------------------------------------------------------------------------------------

	}
}

//Shape for top passive rudder------------------------------

module 666_1028_passive_rudder_shape(draft = true){
  N = 40;
  sweep(gen_dat(M=tail_top_passive_rudder_height / 2, dz=1,N=N), showslices = false);

  // specific generator function
  function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
    let( L = extra_length(i))
    let( af = vec3D(
        airfoil_data([0,0,0.05+thickness(i)], L=tail_length-extra_length(i)-25, N = N)))
    T_(0, 0, (i)*2, af)];  // translate airfoil

  function thickness(i) = gauss(i,0.00, 0, 15);
  function extra_length(i) = gauss(i,300,tail_top_passive_rudder_height / 2 + 20,15);
}

module 666_1028_passive_rudder_shape_inside(){
	//TODO: wall thickness repair
	N = 40;
	sweep(gen_dat(M=tail_top_passive_rudder_height / 2 - Rudder_wall_thickness / 2, dz=1,N=N), showslices = false);

	// specific generator function
	function gen_dat(M=10,dz=0.1,N=10) = [for (i=[0:dz:M])
	let( L = extra_length(i))
	let( af = vec3D(
		airfoil_data([0,0,0.05+thickness(i)], L=tail_length-extra_length(i)-25-Rudder_wall_thickness*2, N = N)))
	T_(Rudder_wall_thickness, 0, (i)*2 + Rudder_wall_thickness, af)];  // translate airfoil

	function thickness(i) = gauss(i,0.00, 0, 15);
	function extra_length(i) = gauss(i,300,tail_top_passive_rudder_height / 2 + 20 - Rudder_wall_thickness,15);
}



//Top passive rudder----------------------------------------

module 666_1028_top_passive_rudder(side_choose = 1, draft = true) {
    difference() {
	    //Main Wall-------------------------------------------------
		translate([3, 0, 0])
		666_1028_passive_rudder_shape();    


	    intersection() {
		translate([3, 0, 0])
		666_1028_passive_rudder_shape_inside();

		difference(){
			union(){

				//Holes for top passive rudder holding screws--------------------------
				//TODO: check if they are dynamic

				translate([tail_top_passive_rudder_screw_x_position_1, 0, 0])
					union(){
					cylinder(d = M3_screw_diameter + Rudder_wall_thickness * 2, h = Rudder_depth * 2 + Rudder_wall_thickness * 2, $fn = draft ? 10 : 50, center = true);
					translate([0, 0, 10])
						union() {
						cylinder(d = M3_nut_diameter + global_clearance * 2 + Rudder_wall_thickness, h = M3_nut_height + global_clearance * 2 + Rudder_wall_thickness * 2, $fn = 6, center = true);
						translate([0, - Rudder_depth / 2, 0])
							cube([M3_nut_diameter + global_clearance * 2 + Rudder_wall_thickness * 2, Rudder_depth, M3_nut_height + global_clearance * 2 + Rudder_wall_thickness * 2], center = true);
						}
			    }

			translate([tail_top_passive_rudder_screw_x_position_2, 0, 0])
			    union(){
				cylinder(d = M3_screw_diameter + Rudder_wall_thickness * 2, h = Rudder_depth * 2 + Rudder_wall_thickness * 2, $fn = draft ? 10 : 50, center = true);
				translate([0, 0, 10])
				    union() {
					cylinder(d = M3_nut_diameter + global_clearance * 2 + Rudder_wall_thickness, h = M3_nut_height + global_clearance * 2 + Rudder_wall_thickness * 2, $fn = 6, center = true);
					translate([0, - Rudder_depth / 2, 0])
					    cube([M3_nut_diameter + global_clearance * 2 + Rudder_wall_thickness * 2, Rudder_depth, M3_nut_height + global_clearance * 2 + Rudder_wall_thickness * 2], center = true);
				    }
			    }
			 //----------------------------------------------------------

			}
		}
	    }
                
        //Holes for top passive rudder holding screws--------------------------
        //TODO: check if they are dynamic

        translate([tail_top_passive_rudder_screw_x_position_1, 0, 0])
            union(){
                cylinder(d = M3_screw_diameter, h = Rudder_depth * 2, $fn = draft ? 10 : 50, center = true);

                translate([0, 0, 10])
				union() {
					cylinder(d = M3_nut_diameter + global_clearance * 2, h = M3_nut_height + global_clearance * 2, $fn = 6, center = true);
					translate([0, - Rudder_depth / 2, 0])
						cube([M3_nut_diameter + global_clearance * 2, Rudder_depth, M3_nut_height + global_clearance * 2], center = true);
				}
            }

        translate([tail_top_passive_rudder_screw_x_position_2, 0, 0])
            union(){
                cylinder(d = M3_screw_diameter, h = Rudder_depth * 2, $fn = draft ? 10 : 50, center = true);
                translate([0, 0, 10])
                    union() {
                        cylinder(d = M3_nut_diameter + global_clearance * 2, h = M3_nut_height + global_clearance * 2, $fn = 6, center = true);
                        translate([0, - Rudder_depth / 2, 0])
                            cube([M3_nut_diameter + global_clearance * 2, Rudder_depth, M3_nut_height + global_clearance * 2], center = true);
                    }
            }
         //----------------------------------------------------------
    }
}

// tyc ke smerovce
module 666_1028_pipe(){
    translate([0, 0, tail_pipe_z_position])
        rotate([0, -90, 0])
            translate([0, 0, -tail_tube_mount_length])
                difference(){
                    cylinder(d = tube_for_undercarriage_outer_diameter, h = 1000, $fn = 40);
                    cylinder(d = tube_for_undercarriage_outer_diameter-3, h = 1000, $fn = 40);
                }

}

module 666_1028_modifiers(side_choose = 1) {
	
	//Rudder modifiers------------------------------------
	translate([0, 0, tail_bottom_height-global_clearance])
	union(){

		//Front shaft shape-------------------------------

		intersection(){
			translate([Rudder_shaft_x_position ,0 , -tail_bottom_height-global_clearance])
			666_1028_rudder_shaft_shape();
			translate([0, -tail_length/2, 0])
			cube([tail_length*2, tail_length, Rudder_height-global_clearance*2]);
		}			

		//Washer like material on bottom------------------

		translate([Rudder_shaft_x_position, 0, 0])
		cylinder(d = M3_nut_diameter, h = 1, $fn = draft ? 10 : 50, center = true);

		//Servo arm cube----------------------------------
		
        translate([Rudder_shaft_x_position + 4.35 + Rudder_arm_x_offset, 0, tail_servo_rudder_arm_z_position])
		cube([tail_servo_rudder_arm_side_size+4, 50, tail_servo_rudder_arm_side_size+4], center = true);
	}

	//Top part modifiers----------------------------------
	translate([0, 0, tail_bottom_height + Rudder_height])
	union() {

        //Modifier for rudder shaft-----------------------

        translate([Rudder_shaft_x_position, 0, (tail_height - tail_bottom_height - Rudder_height)/2])
		cube([Rudder_shaft_outside_min_diameter,50,tail_height - tail_bottom_height - Rudder_height], center = true);
		
		//Modifier for A shape screws--------------------

        translate([tail_A_shape_screw_x_position_1, 0, (tail_height - tail_bottom_height - Rudder_height)/2])
		cube([M3_nut_diameter+4,50,tail_height - tail_bottom_height - Rudder_height], center = true);

        translate([tail_A_shape_screw_x_position_2, 0, (tail_height - tail_bottom_height - Rudder_height)/2])
		cube([M3_nut_diameter+4,50,tail_height - tail_bottom_height - Rudder_height], center = true);
	
		//Modifier for passive rudder screws------------

        translate([tail_top_passive_rudder_screw_x_position_1, 0, (tail_height - tail_bottom_height - Rudder_height)/2])
		cube([M3_nut_diameter+4,50,tail_height - tail_bottom_height - Rudder_height], center = true);

        translate([tail_top_passive_rudder_screw_x_position_2, 0, (tail_height - tail_bottom_height - Rudder_height)/2])
		cube([M3_nut_diameter+4,50,tail_height - tail_bottom_height - Rudder_height], center = true);


	}

	//Middle part modifiers-----------------------------
	translate([(tail_tube_mount_length) / 2, 0, tail_pipe_z_position])
	union() {

		//Modifier for servo hole-----------------------

		translate([(tail_tube_mount_length + Rudder_infill_wall_thickness + tail_servo_length)/2+Rudder_infill_wall_thickness, 0, - tail_servo_height / 2 + 2 - Rudder_infill_wall_thickness - tail_servo_z_offset])
		cube([tail_servo_length+4, 50, tail_servo_height+4], center = true);

		//Modifier for tube mount-----------------------
	
		translate([-3-Rudder_infill_wall_thickness/2, 0, 0])
		cube([tail_tube_mount_length+6, 50, tail_tube_mount_height+global_clearance*2+4], center = true);
	}

	//Bottom part modifiers-----------------------------
	union(){
		//Main Wall-------------------------------------
		intersection(){	    
			666_1028_rudder_shape();
			translate([tail_length, 0, tail_bottom_height / 2])
			cube([tail_length * 2, tail_length, tail_bottom_height], center = true);
		}

		intersection(){
			translate ([tail_length/2, 0, -25])
			cube([tail_length, 50, 50], center = true);

			rotate([0,90,0])
			rotate_extrude($fn = draft ? 50 : 200)
				rotate([0,0,90])
				difference(){
				  polygon(points = airfoil_data(naca = 0005, L = tail_length, N = draft ? 50 : 100, open = false));
				  square(tail_length);
				}
		}
	}

	//Passive rudder modifiers-------------------------
	666_1028_modifiers_passive_rudder(side_choose);
	
	
}

module 666_1028_modifiers_passive_rudder(side_choose = - 1) {

	//Modifier for passive rudder screws------------
	translate([0, side_choose * (- 1.6), tail_height - 13])
	rotate([- side_choose * (- tail_angle / 2), 0, 0])
	union(){

        translate([tail_top_passive_rudder_screw_x_position_1, 0, Rudder_depth/2 - 2])
		cube([M3_nut_diameter+4,50,Rudder_depth * 2 + 4], center = true);

        translate([tail_top_passive_rudder_screw_x_position_2, 0, Rudder_depth/2 - 2])
		cube([M3_nut_diameter+4,50,Rudder_depth * 2 + 4], center = true);

	}
}

module 666_1028(side_choose = 1, rudder = true, rudder_angle = 15, pipe = false, draft = true, modifiers = false){
    666_1028_body_bottom(side_choose);

	translate([0, 0, tail_bottom_height])
	666_1028_body_middle(side_choose);

    if(rudder)
        translate([Rudder_shaft_x_position, 0, tail_bottom_height + global_clearance])
        //rotate([0, 0, rudder_angle])
        translate([-Rudder_shaft_x_position, 0, 0])
        666_1028_rudder(side_choose);

	translate([tail_tube_mount_length / 2 - global_clearance / 2, 0, tail_pipe_z_position])
	666_1028_tube_mount(side_choose);

	translate([0, 0, tail_bottom_height + Rudder_height])
	666_1028_body_top(side_choose);
    
	translate([0, side_choose * (- 1.6), tail_height - 13])
	rotate([- side_choose * (- tail_angle / 2), 0, 0])
	666_1028_top_passive_rudder(side_choose);

	if(pipe)
		666_1028_pipe(side_choose);

	if(modifiers)
		666_1028_modifiers(side_choose);
}

/*
difference(){
666_1028(side_choose = - 1, draft = true, modifiers = true);
translate([250,-250,249])
cube([500,500,500],true);
}
*/


666_1028(side_choose = - 1, draft = true, modifiers = false);


echo("vzdálenost tyci:", tail_pipe_distance);
