 use <./lib/naca4.scad>
include <../Parameters.scad>

difference (){
intersection () {
 translate([0,0,0])
     rotate ([0,90,0])           
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0045, L = 600)); 
                          square(600, 600); 
                        }

     translate ([0,0,-150])
     cube ([570,75,270]);                   

}
translate ([0,0,0])
scale ([0.996,0.996,0.996])
intersection () {
 translate([0,0,0])
     rotate ([0,90,0])           
                rotate_extrude($fn = 100)
                    rotate([0,0,90])
                        difference()
                        {

                          polygon(points = airfoil_data(naca=0045, L = 600)); 
                          square(600, 600); 
                        }

     translate ([0,0,-150])
     cube ([570,75,270]);                   

}
translate ([-2,1,-25])
cube ([52,76,50]);

}