			       //improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

//sestava listy, závaží, kování

module 666_2300(draft){

delka_listu = 970;
sirka_listu = 50;
uchytna_cast = 100;

translate([sirka_listu/2 + 3.5,7,0])
union(){
	translate([-sirka_listu/2, delka_listu/2,6])
		rotate([0,0,0])
				import ("D:/GIT/TF-G1/STL/666_1201.stl");


translate([-35/4,0,0])
	rotate([0,0,90])
		color([0,0,1])
			import ("D:/GIT/TF-G1/STL/666_1247.stl");
translate([-33.5 - 33.5/3.4 - 0.6,-15 + 1,0])
	rotate([180,0,90])
		color([1,0,0])
			import ("D:/GIT/TF-G1/STL/666_1206.stl");

}

translate([-sirka_listu/2,-7,0])	
rotate([0,0,180])
	union(){
	translate([-sirka_listu/2, delka_listu/2,6])
		rotate([0,0,0])
				import ("D:/GIT/TF-G1/STL/666_1201.stl");


translate([-35/4,0,0])
	rotate([0,0,90])
		color([0,0,1])
			import ("D:/GIT/TF-G1/STL/666_1247.stl");

translate([-33.5 - 33.5/3.4 - 0.6,-15 + 1,0])
	rotate([180,0,90])
		color([1,0,0])
			import ("D:/GIT/TF-G1/STL/666_1206.stl");

}
}


666_2300(draft);

use <./../lib/naca4.scad>
include <../../Parameters.scad>