module 666_1232(){

thickness = 20; 
	difference(){
        cube([70,35,thickness]);
        // díra pro domek
        translate([0,5 - 0.25, -1])
            cube([35,25.5,thickness + 2]);


        // díry pro čep
		translate([10,38,thickness/2])
            rotate([90,0,0])
                cylinder (h = 40, r = 4.1/2, $fn = 15);

        translate([52,35/2,0])
            cylinder (h = 40, d = 15, $fn = 15);
	}
}
666_1232();
