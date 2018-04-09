
    draft = false; 

    airfoil_NACA = 0016;    // typ použitého profilu
    airfoil_depth = 50; // hloubka profilu
    length = 970-1;       // celková délka polotovaru
    material_width = 70;
    core_thickness = 1.0;       // tloušťka jádra
    airfoil_thickness = 9; // vypočtená maximální tloušťka profilu
    bridge_thickness = 0.6;  // tloušťka spojení mezi rotorovým listem a rámečkem
    milling_cutter_radius = 1.5;


    difference (){      // odečet poloviny polotovaru a jádra v případě, že jde o jednostranný  polotovar

        minkowski()     // základní materiál
        {
            difference (){
                cube([material_width - 2*milling_cutter_radius, length, airfoil_thickness - 2*milling_cutter_radius], center = true);

                // odečet frézovaného objemu, pokud jde o jednostranný polotovar, tak musí být zanechán materiál pro přidržení rámečku materiálu.
                translate([airfoil_depth/2 + milling_cutter_radius, 0, airfoil_thickness/2 - milling_cutter_radius - core_thickness/2])
                    cube([4* milling_cutter_radius, 2*length, 2* milling_cutter_radius], center = true);

                translate([-airfoil_depth/2 + 0.1 - milling_cutter_radius, 0, airfoil_thickness/2 - milling_cutter_radius - core_thickness/2])
                    cube([4* milling_cutter_radius, 2*length, 2* milling_cutter_radius], center = true);
            }
            rotate([90,0,0])
                cylinder(r=milling_cutter_radius, h=1, $fn = draft ? 20 :50, center = true);
        }
                cylinder(r = milling_cutter_radius, h = 2*length, $fn = draft ? 20 :50, center = true);

    }