include <../../Parameters.scad>

module 666_1004(){

wall_thickness=main_tube_outer_diameter/5;
thickness_between_tubes=main_tube_outer_diameter/10;
width=main_tube_outer_diameter+2*wall_thickness;
depth=main_tube_outer_diameter*2+2*wall_thickness+thickness_between_tubes;
height=width;
radius=main_tube_outer_diameter/2;


difference(){

translate([-(width/2),-(depth-radius-wall_thickness),0])
cube([width,depth,height]);

    //tube

    translate([0,0,-3])
    cylinder(h=height+6,r1=radius,r2=radius,$fn=200);

    translate([-(radius+wall_thickness)-3,-(main_tube_outer_diameter+thickness_between_tubes),radius+wall_thickness])
    rotate([0,90,0])
    cylinder(h=height+6,r1=radius,r2=radius, $fn = 200);
    
    //bevelled edge

    translate([width/2+sqrt(2)*wall_thickness,0,-3])
    rotate([0,0,45])
    cube([width, width,height+6]);
    
    translate([-(width/2)-sqrt(2)*wall_thickness,0,-3])
    rotate([0,0,45])
    cube([width, width,height+6]); 
    
    translate([-(width/2)-3,- depth + height/2-sqrt(2)*wall_thickness,-height+(sqrt(2)*wall_thickness)/2])
    rotate([45,0,0])
    cube([width+6,height,height]);
   
    translate([-(width/2)-3, -depth + height/2-sqrt(2)*wall_thickness,height/2])  
    rotate([45,0,0])
    cube([width+6,height,height]);  

   	//screw

   	translate([-width/2,0,height/2])
	rotate ([0,90,0])   
    cylinder(h = width, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);

    translate ([0,- (main_tube_outer_diameter+thickness_between_tubes),0])
    cylinder (h = height, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15);
			
    //nut

    translate([-width/2-3,0, height/2])
    rotate ([0,90,0])
    cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2 ,r2 = Nut_diameter_M3/2, $fn = 6);

    translate([0, -(main_tube_outer_diameter+thickness_between_tubes),-3])
    cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);

    translate([width/2 - Nut_height_M3,0,height/2])
	rotate ([0,90,0])
    cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2 ,r2 = Nut_diameter_M3/2, $fn = 6);

    translate([0,-(main_tube_outer_diameter+thickness_between_tubes),height - Nut_height_M3])
    cylinder (h = Nut_height_M3+3, r1 = Nut_diameter_M3/2, r2 = Nut_diameter_M3/2, $fn = 6);    


    }
}




module 666_1006(height = 25, height_of_mini_cylinder = 2){
	difference (){

cylinder (h = height, r1 = (main_tube_inner_diameter-0.4)/2, r2 = (main_tube_inner_diameter-0.4)/2, $fn=200); //ubrala jsem na průměru 0.4, aby se ta vložka vešla do vnitřku té hlavní trubky

translate([0,0,-3])
cylinder (h= height+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2,$fn=100);

//screw
translate([-main_tube_inner_diameter/2-3,0,height/2])
rotate([0,90,0])
cylinder(h = main_tube_inner_diameter + 6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
}
union (){
	
	difference(){

translate([0,0,height])
cylinder(h = height_of_mini_cylinder, r1 = main_tube_outer_diameter/2, r2 = (main_tube_inner_diameter)/2, $fn = 200);

translate ([0,0,height-3])
cylinder (h=height_of_mini_cylinder+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2, $fn = 100);

		}
	}
}
		

module 666_1014(){

wall_thickness= tube_for_undercarriage_outer_diameter/3;
thickness_between_tubes=tube_for_undercarriage_outer_diameter/10;			
width=tube_for_undercarriage_outer_diameter+2*wall_thickness;
depth=tube_for_undercarriage_outer_diameter+M3_screw_diameter+2*wall_thickness+thickness_between_tubes;
height=width;
radius=tube_for_undercarriage_outer_diameter/2;

difference(){

translate([-(width/2),-(depth-radius-wall_thickness),0])
cube([width,depth,height]);

	//tube
    
    translate ([0,0,-3])
    cylinder(h=height+6,r1=radius,r2=radius, $fn = 200);

    //bevelled edge
    
    translate([width/2+sqrt(2)*wall_thickness,0,-3])
    rotate([0,0,45])
    cube([width,width,height+6]);
    
    translate([-(width/2)-sqrt(2)*wall_thickness,0,-3])
    rotate([0,0,45])
    cube([width, width,height+6]); 
    
    translate([-(width/2)-3,- depth + height/2-sqrt(2)*wall_thickness,-height+(sqrt(2)*wall_thickness)/2])
    rotate([45,0,0])
    cube([width+6,height,height]);
   
    translate([-(width/2)-3, -depth + height/2-sqrt(2)*wall_thickness,height/2])  
    rotate([45,0,0])
    cube([width+6,height,height]);  

    //for mirror
    translate ([-0.1,-depth+radius+wall_thickness-3,-3])
    cube ([width,depth+6,height+6]);

    //screw

    translate([-width/2,-(thickness_between_tubes+tube_for_undercarriage_outer_diameter/2+ M4_screw_diameter/2),radius+wall_thickness])
    rotate([0,90,0])
    cylinder(h=width,r1=M4_screw_diameter/2,r2=M4_screw_diameter/2, $fn = 20);

    translate([-width/2,0,height/2])
    rotate ([0,90,0])
    cylinder(h = width, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 15 );

	//nut

	translate([-width/2-3,0,height/2])
	rotate([0,90,0])
	cylinder (h = Nut_height_M3 + 3, r1 = Nut_diameter_M3/2 ,r2 = Nut_diameter_M3/2, $fn = 6);

	translate([-width/2-3,-(thickness_between_tubes+tube_for_undercarriage_outer_diameter/2+ M4_screw_diameter/2),radius+wall_thickness])
	rotate([0,90,0])
	cylinder (h = Nut_height_M4 + 3, r1 = Nut_diameter_M4/2 ,r2 = Nut_diameter_M4/2, $fn = 6);
    
    }
}

module 666_1017() {

wall_thickness=main_tube_outer_diameter/5;
width=main_tube_outer_diameter+2*wall_thickness;
depth=width;
height= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;
radius=main_tube_outer_diameter/2;


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


module 666_1026(){

radius=main_tube_outer_diameter/2;
wall_thickness=main_tube_outer_diameter/10;
width=main_tube_outer_diameter+2*wall_thickness;	
depth=main_tube_outer_diameter*2;
height=depth;


c_na_druhou=width*width+width*width;
uhlopricka=sqrt(c_na_druhou);
c2_na_druhou=(depth/2*depth/2)+(depth/2*depth/2);
uhlopricka_2=sqrt(c2_na_druhou);

M4_screw_radius=M4_screw_diameter/2;
wall_thickness_M4_cylinder_X = M4_screw_radius;
stred_M4_cylinder_X = width/2 - M4_screw_radius * 2;
stred_M4_cylinder_Z_horni = height - M4_screw_radius - M4_screw_diameter*0.75;
stred_M4_cylinder_Z_dolni = M4_screw_radius + M4_screw_diameter*2;

difference (){

translate([-(width/2),-(depth/2),0])
cube ([width,depth,height]);
	
	//tube
	translate([0,0,-3])
	cylinder(h=height+6,r1=radius,r2=radius,$fn=200);

	//screw
	translate([0,depth/2+3,7.5])
	rotate([90,0,0])
	cylinder(h=depth+6, r1=M4_screw_radius, r2 = M4_screw_radius, $fn=20);


	translate([0,depth/2+3,42.5])
	rotate([90,0,0])
	cylinder(h=depth+6, r1=M4_screw_radius, r2 = M4_screw_radius, $fn=20);
	
	//bevelled edge

	translate([width/2,depth/2-1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([-(width/2),depth/2-1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([-(width/2),-uhlopricka_2-depth/2+1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);

	translate([width/2,-uhlopricka_2-depth/2+1,-3])
	rotate([0,0,45])
	cube([depth/2,depth/2,height+6]);
}
}


