use <igus.scad>

module RT_S57220_M_80(stroke = 1){
    cylinder(d = 16, h = 158);
    translate([0, 0, 13])
        cylinder(d = 21.5, h = 133);

    cylinder(d = 5, h = 158+stroke*80+5);

}


use <../888_2019.scad>

module chassis_piston_assembly( stroke = 1){
    c = [35, 0, -8];

    translate(c + [0, 0, -13])
        RT_S57220_M_80(stroke);
    translate(c)
        rotate([180, 0, 0])
        888_2019();
    translate(c+[0, 0, 135+stroke*80+47])
        kbrm_08();


            translate(c+[0, 0, 135+0*80+47])
                rotate([90, 0, 0])
                    cylinder(d = 3, h = 20, center = true);
            translate(c+[0, 0, 135+0.5*80+47])
                rotate([90, 0, 0])
                    cylinder(d = 3, h = 20, center = true);
            translate(c+[0, 0, 135+1*80+47])
                rotate([90, 0, 0])
                    cylinder(d = 3, h = 20, center = true);

}

chassis_piston_assembly();
//RT_S57220_M_80();
