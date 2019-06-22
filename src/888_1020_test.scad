include <../Parameters.scad>

joint_size_x = 60; // delka dorazu podle osy x
joint_size_y = 45; //delka dorazu podle osy y

rotx = 20/2;
roty = 20/2;

joint_wall_thickness = 5;




module base(){

    bearing_efsm_ag = bearing_efsm_12_ag;
    bearing_efsm_a1 = bearing_efsm_12_a1;
    bearing_efsm_h = bearing_efsm_12_h;

    difference(){
        union(){


                difference(){
                intersection(){
                    rotate([0, 90, 0])
                        translate([0,0,-50])
                            cylinder(d=joint_size_y, h=100, $fn=200);

                    rotate([90, 0, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_x, h=100, $fn=200);


                    rotate([90+rotx/2, 0, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_x, h=100, $fn=200);


                    rotate([90+rotx, 0, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_x, h=100, $fn=200);


                    rotate([90-rotx, 0, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_x, h=100, $fn=200);


                    rotate([0, 90+roty, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_y, h=100, $fn=200);

                    rotate([0, 90-roty, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_y, h=100, $fn=200);

                }

        // plošky na svrchní straně
                for (i=[[rotx, 0, 0], [-rotx, 0, 0], [0, roty, 0], [0, -roty, 0],
                        [rotx, roty, 0], [-rotx, roty, 0], [rotx, roty, 0], [rotx, -roty, 0],
                        [rotx, -roty, 0], [-rotx, -roty, 0], [-rotx, roty, 0], [-rotx, -roty, 0]]) {
                    rotate(i)
                        translate([-50, -50, bearing_efsm_ag - bearing_efsm_a1 + 5])
                            cube(100);
                }
            }


            x = joint_size_x + joint_wall_thickness*2;
            y = joint_size_y + joint_wall_thickness*2;

            difference(){
                translate([-x/2, -y/2, -25])
                    cube([x, y, 40]);

                // plošky na svrchní straně
                translate([0,0,0])
                for (i=[[rotx, 0, 0], [-rotx, 0, 0], [0, roty, 0], [0, -roty, 0],
                        [rotx, roty, 0], [-rotx, roty, 0], [rotx, roty, 0], [rotx, -roty, 0],
                        [rotx, -roty, 0], [-rotx, -roty, 0], [-rotx, roty, 0], [-rotx, -roty, 0]]) {
                    rotate(i)
                        translate([-40, -40, 0])
                            cube(80);
                }
            }


        }

        translate([-bearing_efsm_h/2, -bearing_efsm_h/2, -bearing_efsm_a1])
            cube([bearing_efsm_h, bearing_efsm_h, 100]);

        translate([0, 0, -50])
            cylinder(h=100, d=bearing_efsm_12_db);
    }
}



module plate(angle = [10, 10], depth = 5){
    x = joint_size_x + joint_wall_thickness*2;
    y = joint_size_y + joint_wall_thickness*2;
    wall = 2;


    difference(){
        union(){
            translate([-x/2,-y/2, -depth+7])
                cube([x-8, y, depth + wall + 2+5]);

        }
        //#translate([-joint_size_x/2, -joint_size_y/2, -0.1])
        //    cube([joint_size_x, joint_size_y, 10]);

        intersection(){

            translate([-x/2,-y/2, -depth/2-3+5])
                cube([x, y, depth+5]);

            rotate([0, 90, 0])
                translate([0,0,-50])
                    cylinder(d=joint_size_y + 0.8, h=100, $fn=200);

            rotate([90, 0, 0])
                translate([0, 0, -50])
                    cylinder(d=joint_size_x + 0.8, h=100, $fn=200);
        }
    }
}


module plate_part(rotation, depth){

    x = rotation[0];
    y = rotation[1];

    sphere(r=5);

    intersection(){
        hull(){
            rotate([x, y, 0])
            translate([0,0,depth])
                intersection(){
                    rotate([0, 90, 0])
                        translate([0,0,-50])
                            cylinder(d=50, h=100);
                    translate([-50, -50, 0])
                        cube([100, 100, 30]);
                }
            }
        }
}




union(){
    base();
      difference(){
        color([0.7, 0.5, 0.5, 0.85]) rotate([0, 0 , 0]) plate([5,5], 20);
        //translate([28, -50, -10]) cube(100);
        //translate([-50, 20, -10]) cube(100);
    }
}

//plate_part([-2,2], 7);
