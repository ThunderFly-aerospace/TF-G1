	use <./lib/naca4.scad>
    use <666_1025.scad>
include <../Parameters.scad>

module 666_1032_A(){

    length_of_drop = 580;
    thickness = 0.8;
    y_size = 100;
    z_size = 150;
    x_size = 580;
    corner_radius = 4;
    airfoil_thickness= 35;
    scale_x = 1;
    scale_y = 1.5;
    scale_z = 1.5;

    beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
    trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
    echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 



    airfoil_thickness = 0030;
depth = main_tube_outer_diameter*5;
width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
height = depth;
thickness = 1;

/*ratio = (170*airfoil_thickness/100 - 2*thickness)/(170*airfoil_thickness/100);
echo(ratio);*/
//translate ([0,0,0])
    //666_1025();

beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 



    




//translate([180,0,0])
    //rotate ([-90,0,0])
        //airfoil(naca = airfoil_thickness, L = 170, N=101, h = 260, open = false);
            //translate ([thickness+180,0,0])
        //scale([ratio,ratio,210], auto=true) airfoil(naca = 0035, L = 170, N=101, h = 200, open = false);
                 //rotate([-90,0,0])
                     //resize([170 - thickness - trailing_wall*thickness,(170*airfoil_thickness/100)- 2*thickness,315], auto=true) airfoil(naca = airfoil_thickness, L = 170, N=101, h = 260, open = false);
difference (){
scale ([1,1,1.2])
    translate([180,0,0])
      rotate ([-90,0,0])
        airfoil(naca = airfoil_thickness, L = 170, N=101, h = 260, open = false);
            translate ([thickness+180,0,0])
        //scale([ratio,ratio,210], auto=true) airfoil(naca = 0035, L = 170, N=101, h = 200, open = false);
            scale ([1,1,1.2])     
                 rotate([-90,0,0])
                     resize([170 - thickness - trailing_wall*thickness,(170*airfoil_thickness/100)- 2*thickness,315], auto=true) airfoil(naca = airfoil_thickness, L = 170, N=101, h = 260, open = false);

    //pro otevření
    translate ([150+193,70,0])
        rotate([-90,0,0])    
            cube ([10,1,195]);

    translate ([35+180,+207,height/2+1.5])
        rotate ([-90,0,0]) 
            cube ([width*5,depth+6,height+3]);

//pro přesné odříznutí je zde hodní díl krytu
intersection () {
         translate([0,0,0])
                rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }

    scale ([scale_x,scale_y,scale_z]) 
                rotate ([0,90,0])           
                    rotate_extrude($fn = 100)
                        rotate([0,0,90])
                            difference()
                            {

                              polygon(points = airfoil_data(naca=airfoil_thickness, L =length_of_drop , N=100)); 
                              square(length_of_drop,length_of_drop); 
                            }
                    minkowski(){                   
            translate ([0,-(main_tube_outer_diameter/2)+1,-z_size/2])
                     cube ([x_size,y_size*scale_y,z_size]);
            
                rotate ([0,90,0])
                    cylinder (h = 1, r = corner_radius, $fn = 100);                   

                      }

    }


}







}
666_1032_A ();
