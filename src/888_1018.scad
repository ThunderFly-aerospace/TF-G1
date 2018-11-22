include <../Parameters.scad>
draft = true;

accumulator_plate_thickness = 20;
accumulator_plate_length = width_of_accumulator + accumulator_holder_width*3;
accumulator_plate_accumulator_axis_offset = 100; // how far from autogyro center pipe center of battery is.
accumulator_plate_move = -25; // posuv akumulatoru dozadu
accumulator_plate_width = accumulator_plate_accumulator_axis_offset + depth_of_accumulator;
accumulator_plate_bearing_sink = 6.4; // Jak moc bude zapuštěno ložisko pro připevnění na střechu auta.
//  cover_pilon_position
module 888_1018(draft){
  posun = move_of_accumulator + accumulator_holder_width/2 + accumulator_holder_thickness/2 + height_666_1026 + global_clearance/2;

rotate([0, 180, 180])
  translate([posun, 0, 0])
    difference(){

      hull(){
        translate([-accumulator_plate_length/2, -accumulator_plate_width, 0])
            cube([accumulator_plate_length, accumulator_plate_width, accumulator_plate_thickness]);
        translate([-accumulator_plate_length/2 + accumulator_plate_move, -accumulator_plate_width, 0])
            cube([accumulator_plate_length, accumulator_plate_width, accumulator_plate_thickness]);
      }

      #union (){
      //šrouby pro připevnění k letadlu
          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -height_of_accumulator, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -height_of_accumulator, 0])
              cylinder(h = 100, r = M3_screw_diameter/2, $fn = draft ? 10 : 20, center = true);

      //Zapuštění hlav šroubů pro připevnění k letadlu
          translate([-width_of_accumulator/2 - accumulator_holder_width/2 - accumulator_holder_thickness/2, -height_of_accumulator, accumulator_plate_thickness])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

          translate([width_of_accumulator/2 + accumulator_holder_width/2 + accumulator_holder_thickness/2, -height_of_accumulator, accumulator_plate_thickness])
              cylinder(h = M3_screw_head_height, d = M3_nut_diameter, $fn = draft ? 10 : 20, center = true);

      // odecteni kostky, v miste, kde je pripevnene kolecko
          translate([height_666_1026 - move_of_accumulator - width_of_accumulator/2 - 5, -5 - height_666_1004/2, - hull_y_size/2])
                 cube([coupling_width_666_1004 + 10, height_666_1004 + 10, hull_y_size]);
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

        for (i=[accumulator_plate_length/2 - 20, accumulator_plate_length/7, -accumulator_plate_length/6, - accumulator_plate_length/2 + accumulator_plate_move + 10]) {
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


    // pro přidělání příruby ložiska
    translate([-posun+center_of_gravity_position[0],center_of_gravity_position[1],-global_clearance/2]){
      cylinder(d = bearing_efsm_10_db+1, h=accumulator_plate_thickness + global_clearance);

      translate([- bearing_efsm_10_h / 2, - bearing_efsm_10_h / 2, accumulator_plate_thickness-accumulator_plate_bearing_sink])
        cube(bearing_efsm_10_h);

      for (i=[[1, 1], [-1, 1], [1, -1], [-1, -1]]) {
        translate([i[0]*bearing_efsm_10_m/2, i[1]*bearing_efsm_10_m/2, 0]){
          cylinder(d = bearing_efsm_10_n, h=accumulator_plate_thickness + global_clearance);
          rotate([0,0,-i[0]*15])
            cylinder(d = M5_nut_diameter, h= M5_head_height+1, $fn=6);
        }
      }
    }

    }
}


888_1018(draft);
mirror([0,1,0])
    888_1018(draft);
