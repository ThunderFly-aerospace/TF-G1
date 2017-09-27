include <./Parameters.scad>
		
wall_thickness=main_tube_outer_diameter/5;
thickness_between_tubes=main_tube_outer_diameter/10;			
width=main_tube_outer_diameter+2*wall_thickness;
depth=main_tube_outer_diameter*2+2*wall_thickness+thickness_between_tubes;
height=width;
radius=main_tube_outer_diameter/2;

difference(){

translate([-(width/2),-(depth-radius-wall_thickness),0])
cube([width,depth,height]);

    cylinder(h=height,r1=radius,r2=radius);

    translate([-(radius+wall_thickness),-(main_tube_outer_diameter+thickness_between_tubes),radius+wall_thickness])
    rotate([0,90,0])
    cylinder(h=height,r1=radius,r2=radius);
    
    translate([width/2+sqrt(2)*wall_thickness,0,0])
    rotate([0,0,45])
    cube([width,width,height]);
    
    translate([-(width/2)-sqrt(2)*wall_thickness,0,0])
    rotate([0,0,45])
    cube([width, width,height]); 
    
    translate([-(width/2),- depth + height/2-sqrt(2)*wall_thickness,-height+(sqrt(2)*wall_thickness)/2])
    rotate([45,0,0])
    cube([width,height,height]);
   
    translate([-(width/2), -depth + height/2-sqrt(2)*wall_thickness,height/2])  
    rotate([45,0,0])
    cube([width,height,height]);  

    }