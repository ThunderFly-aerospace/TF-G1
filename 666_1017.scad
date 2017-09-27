include <./Parameters.scad>

wall_thickness=main_tube_outer_diameter/5;
width=main_tube_outer_diameter+2*wall_thickness;
depth=width;
height=main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;
radius=main_tube_outer_diameter/2;


difference () {
	translate([-(width/2),-(width/2),0])
	cube ([width,depth,height]);

	translate([0,radius+wall_thickness,main_tube_outer_diameter*1.8+radius])
    rotate([90,0,0])
    cylinder(h=width,r1=radius,r2=radius);

   cylinder(h=main_tube_outer_diameter*1.8,r1=radius,r2=radius);

   translate([0,-(depth/2),height+sqrt(2)*wall_thickness])
   rotate([0,45,0])
   cube([width,width,width]);

   translate([-width/2-(sqrt(2)*wall_thickness),-(depth/2),height-wall_thickness-radius])
   rotate([0,-45,0])
   cube([width,width,width]);

   translate([-width+2,0,0])
   rotate([0,0,225])
   cube([height,height,height]);

   translate([-width+2,0,0])
   rotate([0,0,45])
   cube([height,height,height]);

   translate([+width-2,0,0])
   rotate([0,0,45])
   cube([height,height,height]);

   translate([0,-width+2,0])
   rotate([0,0,-45])
   cube([height,height,height]);


   }    
