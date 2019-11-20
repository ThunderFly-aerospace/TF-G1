include <../../parameters.scad>


module efsm_04(){
    import("../../STL/external/igus/EFSM_04.stl", convexity = 5);
}
module efsm_05(){
    import("../../STL/external/igus/EFSM_05.stl", convexity = 5);
}
module efsm_06(){
    import("../../STL/external/igus/EFSM_06.stl", convexity = 5);
}
module efsm_08(){
    import("../../STL/external/igus/EFSM_08.stl", convexity = 5);
}
module efsm_10(){
    import("../../STL/external/igus/EFSM_10.stl", convexity = 5);
}
module efsm_12(){
    import("../../STL/external/igus/EFSM_12.stl", convexity = 5);
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


data_kstm_ball_height = [[5,7],[6,10],[8,10],[10,14]];
function kstm_ball_height(type) = data_kstm_ball_height[search(type, data_kstm_ball_height)[0]][1];

data_kstm_flange_holes_distance = [[5,25], [6,33], [8,33], [10,46], [12,46]];
function kstm_flange_holes_distance(type) = data_kstm_flange_holes_distance[search(type, data_kstm_flange_holes_distance)[0]][1];

data_kstm_flange_length = [[5,34], [6,43], [8,47], [10,62], [12,65]];
function kstm_flange_length(type) = data_kstm_flange_length[search(type, data_kstm_flange_length)[0]][1];

data_kstm_flange_thickness = [[5,6], [6,7], [8,9], [10,10.5], [12,12]];
function kstm_flange_width(type) = data_kstm_flange_thickness[search(type, data_kstm_flange_thickness)[0]][1];

data_kstm_ball_thickness = [[5,25], [6,33], [8,33], [10,46], [12,46]];
function kstm_ball_thickness(type) = data_kstm_ball_thickness[search(type, data_kstm_ball_thickness)[0]][1];


module kbrm_03() {
    import("../../STL/external/igus/KBRM_03_1.stl", convexity = 5);
}
module kbrm_06(){
    import("../../STL/external/igus/KBRM_06_2.stl", convexity = 5);
}
module kbrm_08(){
    import("../../STL/external/igus/KBRM_08_1.stl", convexity = 5);
}



distance = 50;

translate([0, 0*distance,  kstm_ball_height(5)]) kstm_05();
translate([0, 1*distance, kstm_ball_height(6)]) kstm_06();
translate([0, 2*distance, kstm_ball_height(8)]) kstm_08();
translate([0, 3*distance, kstm_ball_height(10)]) kstm_10();


translate([80, 0*distance, 0]) efsm_04();
translate([80, 1*distance, 0]) efsm_05();
translate([80, 2*distance, 0]) efsm_06();
translate([80, 3*distance, 0]) efsm_08();
translate([80, 4*distance, 0]) efsm_10();
translate([80, 5*distance, 0]) efsm_12();
