// Sampler.scad - library for parametric airfoils of 4 digit NACA series
// Code: Rudolf Huttary, Berlin 
// June 2015
// commercial use prohibited

 use <./lib/naca4.scad>
 
rotate_extrude($fn = 100)
rotate([0,0,90])
difference()
{
  polygon(points = airfoil_data(naca=0040, L = 150)); 
  square(200, 200); 
}



//airfoil(naca = 0008, L = 60, N=101, h = 30, open = false); 


