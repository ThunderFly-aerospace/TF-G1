// VRTACI PRIPRAVEK

include <../../parameters.scad>

//volba sroubu na provrtani (M3/M4)
    screw= M3_screw_diameter;
    //screw= M4_screw_diameter;

//prumer tyce (25mm/10mm)
    //diameter= main_tube_outer_diameter;
    diameter= carbon_pipe_10_outer_diameter;

drill_tool_lenght = 50;
drill_tool_thickness = diameter+20;


module drill_tool() {

    difference () {
        cube([drill_tool_lenght, drill_tool_thickness, drill_tool_thickness]);

        //tyc na provrtani
        translate ([-1, drill_tool_thickness/2, drill_tool_thickness/2])
            rotate ([0, 90, 0])
                cylinder (d= diameter, h= drill_tool_lenght+2, $fn= 50);

        // prostredni dira na vrtani
        translate ([drill_tool_lenght/2 + screw, drill_tool_thickness+1, drill_tool_thickness/2])
            rotate ([90, 0, 0])
                cylinder (d= screw, h= drill_tool_thickness+2, $fn= 50);

        //krajni diry na vrtani
        translate ([drill_tool_lenght/2 - screw, drill_tool_thickness+1, drill_tool_thickness/2 + diameter/2 - screw/2])
            rotate ([90, 0, 0])
                cylinder (d= screw, h= drill_tool_thickness+2, $fn= 50);

        translate ([drill_tool_lenght/2 - screw, drill_tool_thickness+1, drill_tool_thickness/2 - diameter/2 + screw/2])
            rotate ([90, 0, 0])
                cylinder (d= screw, h= drill_tool_thickness+2, $fn= 50);

        //stahovaci sroub
        translate ([drill_tool_lenght/2, drill_tool_thickness+1, drill_tool_thickness - (drill_tool_thickness-diameter)/4])
            rotate ([90, 0, 0])
                cylinder (d= M3_screw_diameter, h= drill_tool_thickness+2, $fn= 50);

        translate ([drill_tool_lenght/2, drill_tool_thickness+1, drill_tool_thickness - (drill_tool_thickness-diameter)/4])
            rotate([90, 0, 0])
                cylinder (d= M3_nut_diameter, h= M3_screw_head_height+1, $fn=50);

        translate([drill_tool_lenght/2, M3_nut_height + 5, drill_tool_thickness - (drill_tool_thickness-diameter)/4])
            rotate([90, 0, 0])
                cylinder (d= M3_nut_diameter, h= M3_nut_height+6, $fn=6);

        //mezera na stahovani
        translate ([-1, drill_tool_thickness/2, drill_tool_thickness/2])
            cube ([drill_tool_lenght+2, 1, drill_tool_thickness/2+1]);
    }
}

drill_tool();
