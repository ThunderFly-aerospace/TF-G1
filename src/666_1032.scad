use <./lib/naca4.scad>
include <../Parameters.scad>
use <666_1026.scad>

airfoil_thickness = 0030;
depth = main_tube_outer_diameter*2;
width = main_tube_outer_diameter + 2*(main_tube_outer_diameter/10);
height = depth;
thickness = 1;

/*ratio = (170*airfoil_thickness/100 - 2*thickness)/(170*airfoil_thickness/100);
echo(ratio);*/
translate ([50,0,0])
    666_1026();

beta = 90 - trailing_edge_angle(naca = airfoil_thickness); // calculate the angle of trailing edge
trailing_wall= 1/(cos(beta)); //calculate lenght of wall cut relative to wall thickness
echo(trailing_wall); // print a relative thickness of material at traling edge to wall thickness. 


difference (){

	airfoil(naca = airfoil_thickness, L = 170, N=101, h = 195, open = false);
	translate ([thickness,0,-5])
        //scale([ratio,ratio,210], auto=true) airfoil(naca = 0035, L = 170, N=101, h = 200, open = false);
        resize([170 - thickness - trailing_wall*thickness,(170*airfoil_thickness/100)- 2*thickness,210], auto=true) airfoil(naca = airfoil_thickness, L = 170, N=101, h = 200, open = false);


	//pro otevření
	translate ([150,-0.5,-3])
	cube ([10,1,201]);

	translate ([35,-depth/2-3,195-height])
	cube ([width*5,depth+6,height+3]);

}


//translate ([0,depth/2,0])
//cube ([100,3,10]);

//translate ([0,-3-depth/2,0])
//cube ([100,3,10]);