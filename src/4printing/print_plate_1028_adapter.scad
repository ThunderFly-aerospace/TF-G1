include <../../parameters.scad>
use <../666_1028.scad>

draft = false;


rotate([0, 90, 0]){
    666_1028_mount(side_choose = 1, draft = draft);
    translate([0, 20, 0])
        666_1028_mount(side_choose = -1, draft = draft);
}
