use <./lib/naca4.scad>
include <../Parameters.scad>

difference (){

rotate_extrude($fn = 100)
rotate([0,0,90])
difference()
{

  polygon(points = airfoil_data(naca=0040, L = 150)); 
  square(200, 200); 

}
//tube
  cylinder (h = 90, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=100);
//screw
translate ([0,50,30])
rotate ([90,0,0])
cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

translate ([0,50,60])
rotate ([90,0,0])
cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

//for printing
translate([-0.1,-75,-10])
cube ([0.2,150,160]);

}