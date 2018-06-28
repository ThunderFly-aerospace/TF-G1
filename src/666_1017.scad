
DOC_SCALING_FACTOR = 100;
DOC_HEIGHT = 50;

include <./lib/dimlines.scad>

DIM_LINE_WIDTH = .025 * DOC_SCALING_FACTOR;  
DIM_SPACE = .1 * DOC_SCALING_FACTOR;  


//improving rendering speed.
draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

module 666_1017(draft) {

width=main_tube_outer_diameter+2*coupling_wall_thickness;

material_plus = 10;

bevelled_width = main_tube_outer_diameter + 2*coupling_wall_thickness;


difference () {
    translate([-(coupling_width_666_1017/2),- depth_666_1017/2,0])
      cube ([coupling_width_666_1017,depth_666_1017,height_666_1017 + material_plus]);

    //middle cut
    translate ([-1,-depth_666_1017/2 - global_clearance/2,- global_clearance/2])
       cube ([2,depth_666_1017 + global_clearance,height_666_1017 + material_plus + global_clearance]);

    //main tube
    translate([0,depth_666_1017/2 + global_clearance/2, height_666_1017 - main_tube_outer_diameter/2 - coupling_wall_thickness])   
        rotate([90,0,0])
           cylinder(h = depth_666_1017 + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0, - thickness_between_tubes])
        cylinder(h = height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

            

    //screws
    translate ([- coupling_width_666_1017/2 - global_clearance/2,10 - M4_screw_diameter/2,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate ([0,90,0])
           cylinder (h = coupling_width_666_1017 + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width_666_1017/2 - global_clearance/2,- 10 + M4_screw_diameter/2,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder(h = coupling_width_666_1017 + global_clearance, r = M4_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width_666_1017/2 - global_clearance/2,0,27.5])
        rotate([0,90,0])
            cylinder(h = coupling_width_666_1017 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width_666_1017/2 - global_clearance/2,0,7.5])
        rotate([0,90,0])
            cylinder(h = coupling_width_666_1017 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);
   
   //šroub úplně navrchu
    translate([- coupling_width_666_1017/2 - global_clearance/2,0,height_666_1017 + material_plus/4])
        rotate([0,90,0])
           cylinder(h = coupling_width_666_1017 + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    //nut
    translate ([- coupling_width_666_1017/2 - global_clearance,10 - M4_screw_diameter/2,height_666_1017- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M4 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
    
    translate([- coupling_width_666_1017/2 - global_clearance,- 10 + M4_screw_diameter/2,height_666_1017 - coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Screw_head_height_M4 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);

    translate ([coupling_width_666_1017/2 - Screw_head_height_M4,10 - M4_screw_diameter/2,height_666_1017- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M4 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
    
    translate([coupling_width_666_1017/2 - Screw_head_height_M4,- 10 + M4_screw_diameter/2,height_666_1017- coupling_wall_thickness - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder (h = Screw_head_height_M4 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);

    translate([- coupling_width_666_1017/2 - global_clearance,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([- coupling_width_666_1017/2 - global_clearance,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([coupling_width_666_1017/2 - Screw_head_height_M3,0,27.5])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([coupling_width_666_1017/2 - Screw_head_height_M3,0,7.5])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M3 + global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([coupling_width_666_1017/2  - sqrt(2)*coupling_wall_thickness,0,height_666_1017 + material_plus/4])
        rotate ([0,90,0])
            cylinder (h = Screw_head_height_M3 *3+ global_clearance, r = Nut_diameter_M3/2, $fn = 6);

    translate([-3*Screw_head_height_M3 - coupling_width_666_1017/2 +   sqrt(2)*coupling_wall_thickness,0,height_666_1017 + material_plus/4])
        rotate ([0,90,0])
           cylinder (h = Screw_head_height_M3 *3+ global_clearance, r = Nut_diameter_M3/2, $fn = 6);


    //horizontal bevelled edge
        translate([0,-(depth_666_1017/2) - global_clearance/2,height_666_1017 + material_plus+sqrt(2)*coupling_wall_thickness])
            rotate([0,45,0])
               cube([bevelled_width,coupling_width_666_1017 + global_clearance,bevelled_width]);

    mirror([1,0,0])
        translate([0,-(depth_666_1017/2) - global_clearance/2,height_666_1017 + material_plus+sqrt(2)*coupling_wall_thickness])
            rotate([0,45,0])
               cube([bevelled_width,coupling_width_666_1017 + global_clearance,bevelled_width]);

    //vertical bevelled edge

        translate([-coupling_width_666_1017 + 2,0,- global_clearance/2])
            rotate([0,0,45])
               cube([height_666_1017 + material_plus,height_666_1017 + material_plus,height_666_1017 + material_plus + global_clearance]);

    mirror([1,0,0])
        translate([-coupling_width_666_1017 + 2,0,- global_clearance/2])
            rotate([0,0,45])
                cube([height_666_1017 + material_plus,height_666_1017 + material_plus,height_666_1017 + material_plus + global_clearance]);

    mirror([0,1,0])
        translate([-coupling_width_666_1017 + 2,0,- global_clearance/2])
            rotate([0,0,45])
                cube([height_666_1017 + material_plus,height_666_1017 + material_plus,height_666_1017 + material_plus + global_clearance]);

    mirror([0,1,0])
        mirror([1,0,0])
            translate([-coupling_width_666_1017 + 2,0,- global_clearance/2])
                rotate([0,0,45])
                    cube([height_666_1017 + material_plus,height_666_1017 + material_plus,height_666_1017 + material_plus + global_clearance]);
    }    
}

module 666_1017_drillhelper(height = 70 - coupling_wall_thickness + main_tube_outer_diameter/2, height_of_cap_cylinder = 2){

width=main_tube_outer_diameter+4*thickness_between_tubes;
depth=main_tube_outer_diameter*2;



width_666_1017 = (main_tube_outer_diameter+2*coupling_wall_thickness - Screw_head_height_M3)/basic_screw_length;
        echo("width is", width);
    
        echo("ceil is", ceil(width_666_1017));

coupling_screw_length = (ceil(width_666_1017)) * basic_screw_length;
        echo("coupling_screw_length is", coupling_screw_length);

coupling_width = coupling_screw_length + Screw_head_height_M3;
        echo("coupling_width is", coupling_width);



difference () {

    translate([-(width/2),-(depth/2),0])
    color([1,0,0])
       cube ([width,depth,height]);


    //main tube
    translate([0,main_tube_outer_diameter + coupling_wall_thickness + global_clearance/2, height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])   
        rotate([90,0,0])
            cylinder(h = main_tube_outer_diameter*3 + global_clearance, r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

    //vertical tube
    translate ([0,0, - thickness_between_tubes])
        cylinder(h = height - main_tube_outer_diameter/2 - main_tube_outer_diameter,r = main_tube_outer_diameter/2, $fn = draft ? 100 : 200);

            

    //screws
    translate ([- coupling_width/2 - global_clearance/2,10 - M3_screw_diameter/2,height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])
        rotate ([0,90,0])
            cylinder (h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width/2 - global_clearance/2,- 10 + M3_screw_diameter/2,height - main_tube_outer_diameter/2 - main_tube_outer_diameter/2])
        rotate([0,90,0])
            cylinder(h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width/2 - global_clearance/2,0,27.5])
        rotate([0,90,0])
            cylinder(h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    translate([- coupling_width/2 - global_clearance/2,0,7.5])
        rotate([0,90,0])
            cylinder(h = coupling_width + global_clearance, r = M3_screw_diameter/2, $fn = draft ? 10 : 20);

    //prořezy pro zajištění
    translate([- (3*global_clearance)/2,-depth/2 - global_clearance,height - main_tube_outer_diameter/2 - global_clearance])
           cube([3*global_clearance,depth + 2*global_clearance, main_tube_outer_diameter]);
    translate([-(3*global_clearance)/2, -2*main_tube_outer_diameter, -global_clearance])
            cube([3*global_clearance, 4*main_tube_outer_diameter, 1.5*main_tube_outer_diameter]);
    //šrouby
        translate([0,0,70 - thickness_between_tubes/2])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
        
        translate([0,main_tube_outer_diameter/2 + 2*thickness_between_tubes,main_tube_outer_diameter*(2/3)])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }
        mirror([0,1,0])
                translate([0,main_tube_outer_diameter/2 + 2*thickness_between_tubes,main_tube_outer_diameter*(2/3)])
            rotate([0,90,0])
                union(){ 
                       cylinder(h = 50, r = M4_screw_diameter/2, $fn = draft ? 10 : 20, center = true);
                translate([0,0, main_tube_outer_diameter/2 + 2*thickness_between_tubes - 2*Nut_height_M4])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                translate([0,0, - main_tube_outer_diameter/2 - 2*thickness_between_tubes - global_clearance])
                        cylinder(h = Nut_height_M4*2 + global_clearance, r = Nut_diameter_M4/2, $fn = 6);
                }


    }

}


module 666_1017_drillhelper_doc(){
width=main_tube_outer_diameter+2*coupling_wall_thickness;
depth=width;
height= 70; //main_tube_outer_diameter*1.8+main_tube_outer_diameter+wall_thickness;


    color("Black")
        union(){
            //screw
            translate ([7.5,0,main_tube_outer_diameter])
                rotate ([0,0,0])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

            translate ([27.5,0,main_tube_outer_diameter])
                rotate ([0,0,0])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

            translate ([height - main_tube_outer_diameter + 7.65,10 - M3_screw_diameter/2,main_tube_outer_diameter])
                rotate ([0,0,0])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

            translate ([height - main_tube_outer_diameter + 7.65,- width/2 + 9.5,main_tube_outer_diameter])
                rotate ([0,0,0])
                    circle_center(radius=main_tube_outer_diameter/4, size=DIM_HOLE_CENTER, line_width=DIM_LINE_WIDTH);

        }
}

//666_1017_drillhelper_doc();


rotate([90,0,0])
    666_1017(draft);

translate([70,0,0])

rotate([90,0,0])
666_1017_drillhelper();

include <../Parameters.scad>
