include <../Parameters.scad>

wall_thickness=main_tube_outer_diameter/5;
width=main_tube_outer_diameter+2*wall_thickness;
depth=width;
height= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;
radius=main_tube_outer_diameter/2;

module 666_1017 () {
difference () {
	translate([-(width/2),-(width/2),0])
	cube ([width,depth,height]);

	//main tube
	translate([0,radius+wall_thickness+3, height-radius-wall_thickness])    //main_tube_outer_diameter*1.8+radius])
    rotate([90,0,0])
    cylinder(h=depth+6,r1=radius,r2=radius, $fn = 200);

   //vertical tube
   
   translate ([0,0,-1])
   cylinder(h= height-main_tube_outer_diameter-wall_thickness,r1=radius,r2=radius, $fn=200);

   				//translate([-width/2,0,0])
   				//cube([width,depth, height+6]);

   	//screw
   	translate ([-width/2-3,10-M3_screw_diameter/2,height-wall_thickness-radius])
   	rotate ([0,90,0])
 	cylinder (h=width+6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

 	translate([-width/2-3,-10+M3_screw_diameter/2,height-wall_thickness-radius])
 	rotate([0,90,0])
 	cylinder(h=width+6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

 	translate([-width/2-3,0,27.5])
 	rotate([0,90,0])
 	cylinder(h=width+6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

 	translate([-width/2-3,0,7.5])
 	rotate([0,90,0])
 	cylinder(h=width+6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

 	//nut
 	translate ([-width/2-3,10-M3_screw_diameter/2,height-wall_thickness-radius])
   	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
	
	translate([-width/2-3,-10+M3_screw_diameter/2,height-wall_thickness-radius])
 	rotate([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

	translate ([width/2-Nut_height_M3,10-M3_screw_diameter/2,height-wall_thickness-radius])
   	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);
	
	translate([width/2-Nut_height_M3,-10+M3_screw_diameter/2,height-wall_thickness-radius])
 	rotate([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

 	translate([-width/2-3,0,27.5])
 	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

 	translate([-width/2-3,0,7.5])
 	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2-Nut_height_M3,0,27.5])
 	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

 	translate([width/2-Nut_height_M3,0,7.5])
 	rotate ([0,90,0])
 	cylinder (h=Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

   //horizontal bevelled edge

   translate([0,-(depth/2)-3,height+sqrt(2)*wall_thickness])
   rotate([0,45,0])
   cube([width,width+6,width]);

   translate([-width/2-(sqrt(2)*wall_thickness),-(depth/2)-3,height-wall_thickness-radius])
   rotate([0,-45,0])
   cube([width,width+6,width]);

   //vertical bevelled edge
   
   translate([-width+2,0,-3])
   rotate([0,0,225])
   cube([height,height,height+6]);

   translate([-width+2,0,-3])
   rotate([0,0,45])
   cube([height,height,height+6]);

   translate([+width-2,0,-3])
   rotate([0,0,45])
   cube([height,height,height+6]);

   translate([0,-width+2,-3])
   rotate([0,0,-45])
   cube([height,height,height+6]);


   }    
}
