include <../Parameters.scad>


888_3010_prumer_vnitrni = M8_screw_diameter;
888_3010_prumer = 12-0.2;
888_3010_osazeni_prumer = 12+3;
888_3010_osazeni_vyska = 2;
888_3010_vyska = bearing_efsm_12_ag-bearing_efsm_12_a1-0.5;


module 888_3010(draft = true){
    translate([0, 0, 0]) difference(){
        union(){
            cylinder(h=888_3010_osazeni_vyska, d=888_3010_osazeni_prumer, $fn=draft?50:100);
            cylinder(h=888_3010_vyska, d=888_3010_prumer, $fn=draft?50:100);
        }
        cylinder(h=888_3010_vyska+0.1, d=888_3010_prumer_vnitrni, $fn=draft?50:100);
    }
}
888_3010();