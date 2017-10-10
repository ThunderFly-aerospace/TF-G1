use <./lib/shortcuts.scad>

use <666_1004.scad>
use <666_1006.scad>
use <666_1014.scad>
use <666_1017.scad>
use <666_1026.scad>


place_in_rect(100, 100) // arange that stuff in a grid
{
666_1004();

rotate([0,180,0])
    666_1006();
rotate([0,180,0])
    666_1006();
rotate([0,180,0])
    666_1006();
rotate([0,180,0])
    666_1006();

666_1014();
666_1017();

666_1026();
666_1026();
}
