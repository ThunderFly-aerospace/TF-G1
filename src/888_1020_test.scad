include <../Parameters.scad>

joint_size_x = 60; // delka dorazu podle osy x
joint_size_y = 45; //delka dorazu podle osy y

joint_wall_thickness = 5;




module base(){

    bearing_efsm_ag = bearing_efsm_12_ag;
    bearing_efsm_a1 = bearing_efsm_12_a1;
    bearing_efsm_h = bearing_efsm_12_h;

    difference(){
        union(){

            rotx = 20/2;
            roty = 10/2;

                difference(){
                intersection(){
                    rotate([0, 90, 0])
                        translate([0,0,-50])
                            cylinder(d=joint_size_y, h=100, $fn=60);

                    rotate([90, 0, 0])
                        translate([0, 0, -50])
                            cylinder(d=joint_size_x, h=100, $fn=60);

                    //translate([-joint_size_x/2, -joint_size_y/2, -20])
                    //    cube([joint_size_x, joint_size_y, 20]);
                }

        // plošky na svrchní straně
                for (i=[[rotx, 0, 0], [-rotx, 0, 0], [0, roty, 0], [0, -roty, 0],
                        [rotx, roty, 0], [-rotx, roty, 0], [rotx, roty, 0], [rotx, -roty, 0],
                        [rotx, -roty, 0], [-rotx, -roty, 0], [-rotx, roty, 0], [-rotx, -roty, 0]]) {
                    rotate(i)
                        translate([-50, -50, bearing_efsm_ag - bearing_efsm_a1 +1])
                            cube(100);
                }
            }


            x = joint_size_x + joint_wall_thickness*2;
            y = joint_size_y + joint_wall_thickness*2;

            difference(){
                translate([-x/2, -y/2, -20])
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

    translate([-x/2,-y/2,5])
        cube([x, y, 5]);
    difference(){
        translate([-x/2,-y/2,0])
            cube([x, y, 10]);

        translate([-joint_size_x/2, -joint_size_y/2, -0.1])
            cube([joint_size_x, joint_size_y, 10]);
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
    color([0.7, 0.5, 0.5, 0.5]) rotate([10, -0 , 0]) plate([5,5], 7);
}

//plate_part([-2,2], 7);
