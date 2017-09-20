difference (){
translate([-20,-20,0])
cube ([40,40,40]);
	
	cylinder(h=40,r1=12.5,r2=12.5);

	translate([16,20,35])
	rotate([90,0,0])
	cylinder(h=40,r1=2,r2=2);

	translate([-16,20,35])
	rotate([90,0,0])
	cylinder(h=40,r1=2,r2=2);

	translate([16,20,10])
	rotate([90,0,0])
	cylinder(h=40,r1=2,r2=2);


	translate([-16,20,10])
	rotate([90,0,0])
	cylinder(h=40,r1=2,r2=2);

	translate([20,19,0])
	rotate([0,0,45])
	cube([28.28,28.28,40]);

	translate([-20,19,0])
	rotate([0,0,45])
	cube([28.28,28.28,40]);

	translate([-20,-47.28,0])
	rotate([0,0,45])
	cube([20,20,40]);

	translate([20,-47.28,0])
	rotate([0,0,45])
	cube([20,20,40]);
}