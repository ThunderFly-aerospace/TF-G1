diameter=25;	
wall_thickness=diameter/5;
width=diameter+2*wall_thickness;
depth=width;
height=diameter*1.8+diameter+wall_thickness;
radius=diameter/2;


difference () {
	translate([-(width/2),-(width/2),0])
	cube ([width,depth,height]);

	translate([0,radius+wall_thickness,diameter*1.8+radius])
    rotate([90,0,0])
    cylinder(h=width,r1=radius,r2=radius);

   cylinder(h=diameter*1.8,r1=radius,r2=radius);

   translate([wall_thickness,-(depth/2),height])
   rotate([0,45,0])
   cube([width/2,width,width/2]);

   translate([-wall_thickness,-(depth/2),height])
   rotate([0,-135,0])
   cube([width/2,width,width/2]);

   translate([width/2-0.5,-(width/2+1.415),0])
   rotate([0,0,45])
   cube([2.83,2,height]);

   translate([-(width/2+1.5),-(width/2-0.705),0])
   rotate([0,0,-45])
   cube([2.83,2,height]);

   translate([-width/2,(width/2-2.1225),0])
   rotate([0,0,45])
   cube([2.83,2,height]);

   translate([width/2-2.1225,width/2,0])
   rotate([0,0,-45])
   cube([2.83,2,height]);


   }    
