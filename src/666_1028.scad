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
  cylinder (h = 90, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn=200);
//screw
translate ([-150*0.4,0,150*0.4/2])
rotate ([0,90,0])
cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

translate ([-150*0.4,0,150*0.4])
rotate ([0,90,0])
cylinder (h = 100, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);

//nut
translate([-150*0.4/2,0,150*0.4])
rotate([0,90,0])
cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);


translate([-150*0.4/2,0,150*0.4/2])
rotate([0,90,0])
cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

//translate([0,-150*0.4/2+3+Nut_height_M3,150*0.4/2])
//rotate([90,0,0])
//cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

//translate([0,(150*0.4/2),150*0.4/2])
//rotate([90,0,0])
//cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);




//for printing
translate([-0.1,-75,-10])
cube ([50,150,170]);

}



c = 150*150+75*75;
uhlopricka = sqrt(c);

//////

union (){
	
	difference(){
	//triangle profile
translate([0,0,0])
rotate([0,0,155])
airfoil(naca = 0008, L = uhlopricka, N=101, h = 150, open = false);

translate([0,0,-15])
cylinder (h = 105, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

//for printing
translate([-0.1,-75,-10])
cube ([50,150,170]);

}
}
union (){
	
	difference(){
translate([-150,75,0])
rotate([0,0,-25])
airfoil(naca = 0008, L = uhlopricka, N=101, h = 150, open = false);

translate([0,0,-15])
cylinder (h = 105, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

//for printing
translate([-0.1,-75,-10])
cube ([50,150,170]);



}
}
//////


////////////
union (){
	difference(){


translate([0,0,0])
rotate([0,0,-155])
airfoil(naca = 0008, L =uhlopricka, N=101, h = 150, open = false);

translate([0,0,-15])
cylinder (h = 105, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

//for printing
translate([-0.1,-75,-10])
cube ([50,150,170]);


}
}

union (){
	difference(){

translate([-150,-75,0])
rotate([0,0,25])
airfoil(naca = 0008, L =uhlopricka, N=101, h = 150, open = false);

translate([0,0,-15])
cylinder (h = 105, r1 = main_tube_outer_diameter/2, r2 = main_tube_outer_diameter/2, $fn = 200);

//for printing
translate([-0.1,-75,-10])
cube ([50,150,170]);


}
}

////////////

//////////////////
union(){

translate([-150,75,0])
rotate([0,0,-90])
airfoil(naca = 0008, L = 150, N=101, h = 150, open = false);

translate([-150,-75,0])
rotate([0,0,90])
airfoil(naca = 0008, L = 150, N=101, h = 150, open = false);
}
/////////////////





//translate([-130,0,0])
//rotate([0,0,360])
//airfoil(naca = 0120, L = 120, N=101, h = 150, open = false);
	//translate ([-((150/2)*sqrt(3)),0,0])
//cylinder (h = 150, r1 = (150/2)*sqrt(3), r2 = (150/2)*sqrt(3), $fn = 3);

//translate ([-((150/2)*sqrt(3)),0,-5])
//cylinder (h = 160, r1 = (130/2)*sqrt(3), r2 = (130/2)*sqrt(3), $fn = 3);

//hole for tube




