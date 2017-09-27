include <./Parameters.scad>
		
wall_thickness= tube_for_undercarriage_outer_diameter/5;
thickness_between_tubes=tube_for_undercarriage_outer_diameter/10;			
width=tube_for_undercarriage_outer_diameter+2*wall_thickness;
depth=tube_for_undercarriage_outer_diameter+M4_screw_diameter+2*wall_thickness+thickness_between_tubes;
height=width;
radius=tube_for_undercarriage_outer_diameter/2;

//mirror ([1,0,0])

difference(){

translate([-(width/2),-(depth-radius-wall_thickness),0])
cube([width,depth,height]);

    translate ([0,0,0])
    cylinder(h=height,r1=radius,r2=radius);

    translate([-width/2,-(thickness_between_tubes+tube_for_undercarriage_outer_diameter/2+ M4_screw_diameter/2),radius+wall_thickness])
    rotate([0,90,0])
    cylinder(h=height,r1=M4_screw_diameter/2,r2=M4_screw_diameter/2);
    
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

    translate ([width/2,-radius - thickness_between_tubes - M4_screw_diameter - wall_thickness,0])
    rotate ([0,0,90])
    cube ([depth,width/2,height]);

    }