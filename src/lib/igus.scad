include <../../parameters.scad>


module efsm_12(){
    translate([0, 0, -(bearing_efsm_12_ag - bearing_efsm_12_B/2)]){
        translate([-bearing_efsm_12_h/2, -bearing_efsm_12_h/2, 0])
            cube([bearing_efsm_12_h, bearing_efsm_12_h, bearing_efsm_12_a1]);
        difference(){
            union(){
                intersection(){
                    translate([0,0, bearing_efsm_12_ag - bearing_efsm_12_B/2])
                        sphere(d=18, $fn = 50);
                    translate([0,0,-15])
                        cylinder(h = 30, d = 20);
                }
            }
            translate([0, 0, -15])
                cylinder(h=30, d=12);
        }
    }
}


module efsm_8(){
    translate([-33/2, -33/2, 0])
        cube([33, 33, 5.5]);
    translate([0,0,8.5])
        cylinder(h = 2, d1 = 18, d2 = 15);
    translate([0,0,6.5])
        cylinder(h = 7.94/2, d = 2);
    translate([0, 0, 6.5])
        sphere(r=3, $fn = 50);
}


module kstm_05(){
    import("../../STL/external/igus/KSTM_05_1.stl", convexity = 5);
}

module kstm_06(){
    import("../../STL/external/igus/KSTM_06_2.stl", convexity = 5);
}

module kstm_08(){
    import("../../STL/external/igus/KSTM_08_3.stl", convexity = 5);
}

module kstm_10(){
    import("../../STL/external/igus/KSTM_10_4.stl", convexity = 5);
}


data_kstm_center_height = [["5",7],["6",10],["8",10],["10",14]];
function kstm_center_height(type) = data_kstm_center_height[search(type, data_kstm_center_height)[0]][1];

data_kstm_hole_distance = [["5",25], ["6",33], ["8",33], ["10",46], , ["12",46]];
function kstm_hole_distance(type) = data_kstm_hole_distance[search(type, data_kstm_hole_distance)[0]][1];

data_kstm_thickness = [["5",25], ["6",33], ["8",33], ["10",46], , ["12",46]];
function kstm_thickness(type) = data_kstm_thickness[search(type, data_kstm_thickness)[0]][1];

/*
translate([0, 0,  kstm_center_height("5")]) kstm_05();
translate([0, 20, kstm_center_height("6")]) kstm_06();
translate([0, 40, kstm_center_height("8")]) kstm_08();
translate([0, 60, kstm_center_height("10")]) kstm_10(); */
