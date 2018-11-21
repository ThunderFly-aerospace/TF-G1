include <../Parameters.scad>
draft = true;

accumulator_plate_thickness = 20;
accumulator_plate_length = width_of_accumulator + accumulator_holder_width*3;
accumulator_plate_accumulator_axis_offset = 100; // how far from autogyro center pipe center of battery is.
accumulator_plate_move = -20; // posuv akumulatoru dozadu
accumulator_plate_width = accumulator_plate_accumulator_axis_offset + depth_of_accumulator;


module 888_1018(draft){
    difference(){

      hull(){
        translate([-accumulator_plate_length/2, -accumulator_plate_width, 0])
            cube([accumulator_plate_length, accumulator_plate_width, accumulator_plate_thickness]);
        translate([-accumulator_plate_length/2 + accumulator_plate_move, -accumulator_plate_width, 0])
            cube([accumulator_plate_length, accumulator_plate_width, accumulator_plate_thickness]);
      }

      union (){
      //šrouby pro připevnění k letadlu
          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -height_of_accumulator, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -height_of_accumulator, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

      // odecteni kostky, v miste, kde je pripevnene kolecko
          translate([height_666_1026 - move_of_accumulator - width_of_accumulator/2 - 5, -5 - height_666_1004/2, - hull_y_size/2])
                 cube([coupling_width_666_1004 + global_clearance + 10, height_666_1004+10, hull_y_size]);
      }

      translate([accumulator_plate_move, 0, 0])
      union (){
        //akumulátor
          translate([-width_of_accumulator/2, -accumulator_plate_accumulator_axis_offset-depth_of_accumulator/2, accumulator_plate_thickness - sink_of_accumulator])
              cube([width_of_accumulator, depth_of_accumulator, height_of_accumulator]);

        //šrouby pro připevnění akumulátorů
          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

          translate([- width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);


          //díry pro zapuštění hlaviček šroubů
          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2 - accumulator_plate_move, -height_of_accumulator, 0])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2 - accumulator_plate_move, -height_of_accumulator, 0])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, 0])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, 0])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

      // díry pro matky pro sroub drzici obruce pres baterie..
          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, accumulator_plate_thickness])
              cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);

          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -accumulator_plate_accumulator_axis_offset, accumulator_plate_thickness])
              cylinder(h = 5, d = M3_nut_diameter, $fn = 6, center = true);


        }

        // Srouby pro sesroubovani skrz....

        for (i=[accumulator_plate_length/2 - 10, accumulator_plate_length/6, -accumulator_plate_length/6, - accumulator_plate_length/2 + accumulator_plate_move + 10]) {
          translate([i, 0, accumulator_plate_thickness/2])
            union(){
              rotate([90,0,0])
                cylinder(d= M3_screw_diameter, h= 200);

            translate([0, -35/2, 0])
              rotate([90,0,0])
                cylinder(d= M3_nut_diameter, h= 200, $fn= 6);
            }
        }

        for (i=[-35, -accumulator_plate_width/2, -accumulator_plate_width+10]) {
          translate([0, i, accumulator_plate_thickness/2])
            union(){
              translate([-150, 0, 0])
                rotate([0,90,0])
                  cylinder(d= M3_screw_diameter, h= 300);

              translate([35/2, 0, 0])
                rotate([0,90,0])
                  cylinder(d= M3_nut_diameter, h= 200, $fn= 6);

              translate([-35/2 - 200, 0, 0])
                rotate([0,90,0])
                  cylinder(d= M3_nut_diameter, h= 200, $fn= 6);
            }
        }


    }
}


888_1018(draft);
mirror([0,1,0])
    888_1018(draft);
