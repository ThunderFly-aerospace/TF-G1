include <../../Parameters.scad>
draft = true;

module tube_cutter(draft = true){

    coupling_width = coupling_width_666_1004;
    height=coupling_width;

    depth=main_tube_outer_diameter*3;
    
    difference(){

        translate([-depth/2, -depth/4,0])
              cube([depth,depth/2,2*height]);

        //tubes
        translate([0,0,- global_clearance/2])
                cylinder(h=2*height + global_clearance,d = main_tube_outer_diameter, $fn= draft ? 50 : 200);

        //cut
        translate([-depth/4, -depth/4,height])
              cube([depth,depth/2,1.5]);

                        
    }
}
rotate([0,-90,0])
tube_cutter(draft);
