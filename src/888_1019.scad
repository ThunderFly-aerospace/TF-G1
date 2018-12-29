include <../Parameters.scad>
draft = true;

accumulator_spacer_thickness = 22;  // 22mm napocitano na pouziti M3x30 sroubou
accumulator_spacer_sink = sink_of_accumulator;
accumulator_spacer_move = 40; // posuv smerem dopredu
accumulator_spacer_wall = 10;
accumulator_spacer_wall_end = 25;
accumulator_spacer_width = height_of_accumulator + 2*accumulator_spacer_wall;
accumulator_spacer_length = width_of_accumulator + accumulator_spacer_move + 2*accumulator_spacer_wall_end;

accumulator_threads_distance = (width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2)*2;


module 888_1019(draft){
rotate([0, 180, 180])
    difference(){
        translate([-accumulator_spacer_wall, -accumulator_spacer_wall, 0])
            cube([accumulator_spacer_length, accumulator_spacer_width, accumulator_spacer_thickness]);



      //akumulátor
      translate([accumulator_spacer_move + accumulator_threads_distance/2 - width_of_accumulator/2, 0, accumulator_spacer_thickness-accumulator_spacer_sink])
        cube([width_of_accumulator, height_of_accumulator, depth_of_accumulator]);


      //for(x=[0, accumulator_threads_distance, accumulator_spacer_move, accumulator_spacer_move + accumulator_threads_distance]){
      #translate([0, 0, 0])
          union (){

            //šrouby pro připevnění akumulátorů
            translate([0, height_of_accumulator/2, 0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

             // díry pro matky pro sroub drzici obruce pres baterie..
             translate([0, height_of_accumulator/2, accumulator_spacer_thickness])
                cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);
          }

    translate([accumulator_threads_distance, 0, 0])
        #union (){

            //šrouby pro připevnění akumulátorů
            translate([0, height_of_accumulator/2, 0])
                cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

              // díry pro matky pro sroub drzici obruce pres baterie..
              translate([0, height_of_accumulator/2, accumulator_spacer_thickness - accumulator_spacer_sink-1])
                  cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);
          }


          #translate([accumulator_spacer_move, 0, 0])
              union (){

                //šrouby pro připevnění akumulátorů
                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

                  //díry pro zapuštění hlaviček šroubů
                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

              // díry pro matky pro sroub drzici obruce pres baterie..
                  translate([0, height_of_accumulator/2, accumulator_spacer_thickness])
                      cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);
              }

          #translate([accumulator_spacer_move + accumulator_threads_distance, 0, 0])
              union (){

                //šrouby pro připevnění akumulátorů
                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);


                  //díry pro zapuštění hlaviček šroubů
                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

                  translate([0, height_of_accumulator/2, 0])
                      cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

              // díry pro matky pro sroub drzici obruce pres baterie..
                  translate([0, height_of_accumulator/2, accumulator_spacer_thickness])
                      cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);
              }




    }
}


888_1019(draft);
