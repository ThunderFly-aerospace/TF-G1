
/*
This is an OpenSCAD module that creates an inner bevel between any (convex) part and a plane at z=h. Please note that the part does not have to be perpendicular to the z-plane. The bevel will be h_bevel high and r_bevel wide. For h_bevel equal to r_bevel the bevel will have circular cross section in the plane(s) perpendicular to the z-plane.
The number of faces of the bevel along its cross section is given by fn_bevel. For fn_bevel=1 this will be a linear bevel. The 'roundness' of the bevel along the z-plane is given by $fn.
This module uses projection() to get the 2d shape of the part at a certain height. This shape is then minkowski()-ed with a circle with the radius of the width of the bevel at this height. In a last step hull() is applied to two layers of consecutive height.
Because of the use of the hull() command the shape of the part has to be convex (concave parts would be filled in from the hull() command).
Because of a limitation of the minkowski() command the part has to be simple: no holes and not comprised out of two disjoint shapes. 
*/


h=20;

h_bevel=6;
r_bevel=3;

function h_bev(i)=h_bevel*(1-cos(90*i));
function r_bev(i)=((i==1)?e:0)+r_bevel*(1-sin(90*i));


e=0.001;

fn_bevel=16 ;
$fn=32;

module part_base(){
	cube([60,30,20]);
}

module part1(){
	translate([25,15,20])
		rotate([0,0,0])
			cylinder(40,10,5,true,$fn=3);
}

module part2(){
	translate([25,15,20])
		difference(){
		rotate([90,0,0])
			rotate_extrude()translate([10,0,0])circle(5);
		rotate([0,45,0])translate([100,0,0])cube(200,true);
		}
}

module part3(){
	translate([25,15,20])
		rotate([0,135,0])
			translate([-10,0,0])
			linear_extrude(height=15+e,scale=[1,e])circle(5);
}


module part4(){
	translate([25,15,0])
			translate([-10,0,0])
			cube([10,10,100]);
			/*union(){
				airfoil(naca = 0015, L = 20, N = 100, h = 50, open = false);
			}*/
}

module slice(h){
	projection(cut=true)
		translate([0,0,-h])
			children(0);
}

module edge(){
	difference(){
		minkowski(){
			children(0);
			circle(e);
		}
		children(0);
	}
}

module bev(i){
	minkowski(){
		children(0);
		circle(r_bev(i));
	}
}

module extrude(){
	linear_extrude(height=e)children(0);
}

module bevel(h,h_bevel,r_bevel,fn_bevel){
	translate([0,0,h])
		for(i=[0:1/fn_bevel:1-1/fn_bevel]){
			hull(){
				translate([0,0,h_bev(i)])
					extrude()bev(i)edge()slice(h+h_bev(i))children(0);
				translate([0,0,h_bev(i+1/fn_bevel)])
					extrude()bev(i+1/fn_bevel)edge()slice(h+h_bev(i+1/fn_bevel))children(0);
			}
		}
}


use <./naca4.scad>

bevel(10,10,10,20)airfoil(naca = 0015, L = 100, N = 100, h = 50, open = false);



//bevel(h,h_bevel,r_bevel,fn_bevel)part2();
//bevel(h,h_bevel,r_bevel,fn_bevel)part3();
part1();
//part1();
bevel(h,h_bevel,r_bevel,fn_bevel)part1();
//part4();
//part1();
//part_base();
