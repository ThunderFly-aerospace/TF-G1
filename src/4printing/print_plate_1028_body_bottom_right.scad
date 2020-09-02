include <../../parameters.scad>
use <../666_1028.scad>

draft = false;

rotate([180,0,45])
    666_1028_body_bottom(side_choose = -1, draft = draft);

//modifiers

rotate([180,0,45])
    666_1028_modifiers_bottom();
