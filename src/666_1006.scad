include <../Parameters.scad>

module 666_1006(height = 45, height_of_mini_cylinder = 2){
	difference (){

translate([0,0,+height_of_mini_cylinder])
cylinder (h = height, r1 = (main_tube_inner_diameter-0.4)/2, r2 = (main_tube_inner_diameter-0.4)/2, $fn=200); //ubrala jsem na průměru 0.4, aby se ta vložka vešla do vnitřku té hlavní trubky

translate([0,0,+height_of_mini_cylinder-3])
cylinder (h= height+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2,$fn=100);

//screw
translate([-main_tube_inner_diameter/2-3,0,height/2+height_of_mini_cylinder])
rotate([0,90,0])
cylinder(h = main_tube_inner_diameter + 6, r1 = M3_screw_diameter/2, r2 = M3_screw_diameter/2, $fn = 20);
}
union (){
	
	difference(){

translate([0,0,height_of_mini_cylinder])
rotate([0,180,0])
cylinder(h = height_of_mini_cylinder, r1 = main_tube_outer_diameter/2, r2 = (main_tube_inner_diameter)/2, $fn = 200);

translate ([0,0,-3])
cylinder (h=height_of_mini_cylinder+6, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2, $fn = 100);

		}
	}
}


module 666_1006_drillhelper(height = 45, height_of_mini_cylinder = 2){

radius=main_tube_outer_diameter/2;
wall_thickness=main_tube_outer_diameter/10;
width=main_tube_outer_diameter+2*wall_thickness;    
depth=main_tube_outer_diameter*2;
//height=depth;


c_na_druhou=width*width+width*width;
uhlopricka=sqrt(c_na_druhou);
c2_na_druhou=(depth/2*depth/2)+(depth/2*depth/2);
uhlopricka_2=sqrt(c2_na_druhou);

M3_screw_radius=M3_screw_diameter/2;
wall_thickness_M3_cylinder_X = M3_screw_radius;
stred_M4_cylinder_X = width/2 - M3_screw_radius * 2;
stred_M4_cylinder_Z_horni = height - M3_screw_radius - M3_screw_diameter*0.75;
stred_M4_cylinder_Z_dolni = M3_screw_radius + M3_screw_diameter*2;

difference (){

translate([-(width/2),-(depth/2),0])
    cube ([width,depth,height]);
        
        //tube
        translate([0,0,height_of_mini_cylinder])
            cylinder(h=height+6,r1=radius,r2=radius,$fn=200);

        //screw
        translate([0,depth/2+3,height/2+height_of_mini_cylinder])
            rotate([90,0,0])
                cylinder(h=depth+6, r = M3_screw_radius, $fn=20);
        
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


rotate([0,0,90])
    666_1006();

translate([2*main_tube_outer_diameter,0,0])
    666_1006_drillhelper();
