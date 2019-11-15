include <../../parameters.scad>
use <../666_1028.scad>

draft = false;

rotate([180,0,0])
    666_1028_rudder(side_choose = -1, draft = draft);
