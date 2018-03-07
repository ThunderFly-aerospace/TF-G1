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

//bevel(10,10,10,20)airfoil(naca = 0015, L = 100, N = 100, h = 50, open = false);



//bevel(h,h_bevel,r_bevel,fn_bevel)part2();
//bevel(h,h_bevel,r_bevel,fn_bevel)part3();
part1();
//part1();
bevel(h,h_bevel,r_bevel,fn_bevel)part1();
//part4();
//part1();
//part_base();
