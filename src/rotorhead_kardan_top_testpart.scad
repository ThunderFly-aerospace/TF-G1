include <../parameters.scad>
use <./rotorhead_kardan_centerpart.scad>


draft=true;

module brit_oposit(lenght)
{
    ax_dst=wall_height/2+plate_thickness;

    difference(){
        translate([0,0,lenght/2-ax_dst])
            cube([lenght,brit_width+kardan_clearance,lenght], center=true);
        translate([0,0,-2*ax_dst/2*sqrt(2)])
            rotate([0,45,0])
                cube(2*ax_dst, center=true);
            
        } 
}

module rotorhead_kardan_top_testpart() {
    
    topplate_thickness=3;
    topplate_x=(inner_x+2*brit_width);
    topplate_y=inner_y+2*brit_width;
    rotor_ax_neck_diameter=bearing_d+2;
    rotor_ax_neck_height=top_brit_height-(bearing_efsm_12_ag-bearing_a_center_of_rotation);
    rotor_ax_bearing_ring_h=3;
    
    rotor_axis_diameter = 8.2;
    
    
    difference(){
        union(){
            translate([0,0,topplate_thickness/2])
                cube([topplate_x,topplate_y,topplate_thickness], center=true);
            
            translate([0,(topplate_y-brit_width)/2,topplate_thickness+top_brit_height/2])
                cube([topplate_x,brit_width,top_brit_height], center=true);
            
            
            translate([0,-(topplate_y-brit_width)/2,topplate_thickness+top_brit_height/2])
                cube([topplate_x,brit_width,top_brit_height], center=true);
            
            //ax_neck         
            translate([0, 0,topplate_thickness ])
                 cylinder(d = rotor_ax_neck_diameter , h = rotor_ax_neck_height);
            //bearing ring
            translate([0, 0,topplate_thickness ])
                 cylinder(d = bearing_d , h = rotor_ax_neck_height+rotor_ax_bearing_ring_h);
            }
        //otvor pro sroub rotoru
        translate([0, 0, -(rotor_ax_neck_height+rotor_ax_bearing_ring_h)/2])
            cylinder(d = rotor_axis_diameter, h = 2*(rotor_ax_neck_height+rotor_ax_bearing_ring_h), $fn = draft ? 20 : 80);
        
        //brity 
        translate([0,(inner_y+brit_width)/2,topplate_thickness+top_brit_height])
            rotate([0,pitch_stop,0])
                    brit_oposit(2*topplate_x);
            
        translate([0,(inner_y+brit_width)/2,topplate_thickness+top_brit_height])
            rotate([0,-pitch_stop,0])
                    brit_oposit(2*topplate_x);
            
        translate([0,-(inner_y+brit_width)/2,topplate_thickness+top_brit_height])
            rotate([0,pitch_stop,0])
                    brit_oposit(2*topplate_x);
            
        translate([0,-(inner_y+brit_width)/2,topplate_thickness+top_brit_height])
            rotate([0,-pitch_stop,0])
                    brit_oposit(2*topplate_x); 
            
        }


    }
    
    rotorhead_kardan_top_testpart();

