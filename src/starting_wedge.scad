
module starting_wedge(){

width = 40;
	//difference(){
        translate([-width/2, 0, 0])
            %cube([width,120,90]);
        sphere(110);
	//}
}

starting_wedge();

include <../parameters.scad>