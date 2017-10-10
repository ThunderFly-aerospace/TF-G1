include <../Parameters.scad>

module 666_1006(height = 45, height_of_mini_cylinder = 2){
	difference (){

cylinder (h = height, r1 = (main_tube_inner_diameter-0.4)/2, r2 = (main_tube_inner_diameter-0.4)/2, $fn=200); //ubrala jsem na průměru 0.4, aby se ta vložka vešla do vnitřku té hlavní trubky

translate([0,0,-3])
cylinder (h= height+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2,$fn=100);

//screw
translate([-main_tube_inner_diameter/2-3,0,height/2])
rotate([0,90,0])
cylinder(h = main_tube_inner_diameter + 6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
}
union (){
	
	difference(){

translate([0,0,height])
cylinder(h = height_of_mini_cylinder, r1 = main_tube_outer_diameter/2, r2 = (main_tube_inner_diameter)/2, $fn = 200);

translate ([0,0,height-3])
cylinder (h=height_of_mini_cylinder+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2, $fn = 100);

		}
	}
}

666_1006();
