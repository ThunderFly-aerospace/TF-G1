include <../../Parameters.scad>
use <../666_1029.scad>
use <../666_1025.scad>

draft = true;


/*666_1029_B(draft);
translate([40,0,0])
    666_1029_C(draft);
*/

666_1025_part(1, draft);

translate([10,0,0])
666_1025_part(2, false);

translate([20,0,0])
666_1025_part(3, draft);

translate([30,0,0])
666_1025_part(4, draft);

translate([40,0,0])
666_1025_part(5, draft);
