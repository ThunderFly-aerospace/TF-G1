diameter=25;		
wall_thickness=diameter/5;
thickness_between_tubes=diameter/10;			
width=diameter+2*wall_thickness;
depth=diameter*2+2*wall_thickness+thickness_between_tubes;
height=width;
radius=diameter/2;

difference(){

translate([-(width/2),-(depth-radius-wall_thickness),0])
cube([width,depth,height]);

    cylinder(h=height,r1=radius,r2=radius);

    translate([-(radius+wall_thickness),-(diameter+thickness_between_tubes),radius+wall_thickness])
    rotate([0,90,0])
    cylinder(h=height,r1=radius,r2=radius);
    
    translate([width/2,wall_thickness,0])
    rotate([0,0,45])
    cube([width/2,radius+wall_thickness,height]);
    
    translate([-(width/2),wall_thickness,0])
    rotate([0,0,45])
    cube([width/2,radius+wall_thickness,height]); 
    
    translate([-(width/2),-(depth-wall_thickness),0])
    rotate([-45,0,0])
    cube([width,radius+wall_thickness,height/2]);
   
    translate([-(width/2), -depth + height/2 - sqrt(2) * wall_thickness,height/2])  // protoze kostka je otocena, tak je potreba ji posunout o nasobek odmocniny ze dvou. Jde o uhlopricku ctverce.
    rotate([45,0,0])
    cube([width,height,height]); // tady jsem si zvetsil rozmery kostky, abych ji ji mohl posunout doprostred vysky a byla symetricka. Pak se mi to lepe predstavuje. 
    
    }
