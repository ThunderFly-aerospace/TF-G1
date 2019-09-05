include <../../parameters.scad>
use <../888_2016.scad>

translate([0, -35, 0])
    888_2016_drill(draft=false);

translate([0, 35, 0])
    888_2016_drill(draft=false);

888_2016_drill_center(draft=false);
