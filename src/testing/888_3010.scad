include <../Parameters.scad>


888_3010_prumer_vnitrni = 9.2;
888_3010_prumer = 12.05;
888_3010_osazeni_prumer = 888_3010_prumer + 3;
888_3010_osazeni_vyska = 2;
888_3010_vyska = 10.1/2;


module 888_3010(draft = true){
    difference(){
        union(){
            cylinder(h = 888_3010_osazeni_vyska, d = 888_3010_osazeni_prumer, $fn = 50);
            translate([0,0,888_3010_osazeni_vyska])
                cylinder(h = 888_3010_vyska, d = 888_3010_prumer, $fn = 50);
        }
        cylinder(h = 2 * 888_3010_vyska , d = 888_3010_prumer_vnitrni, $fn = 50);
    }
}
888_3010();