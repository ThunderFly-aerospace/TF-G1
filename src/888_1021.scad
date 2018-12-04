include <../Parameters.scad>



/*

Tento dil patri mezi remenici na ose rotoru a "vytisteny plech".
Slouzi k vymezeni mezeri mezi krouzkem plechem. Tento krouzek by
se mel dotykat plechu a nahoře statické části ložisek.
*/


rotor_bearing_spacer_height = 3;
rotor_bearing_spacer_rim_height = 0.4;
rotor_bearing_spacer_diameter = 18-1;
rotor_bearing_spacer_rim_diameter = 12;
rotor_bearing_space_axis_diameter = M8_screw_diameter; //TODO: Není tento parametr nějak moc velký???


module 888_1021(){
    difference(){
        union(){
            cylinder(d = rotor_bearing_spacer_diameter, rotor_bearing_spacer_height - rotor_bearing_spacer_rim_height );
            cylinder(d = rotor_bearing_spacer_rim_diameter, h = rotor_bearing_spacer_height);
        }
    translate([0,0,-1])
        cylinder(d = 8, h = rotor_bearing_spacer_height+2);
    }
}



888_1021();
