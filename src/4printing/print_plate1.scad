include <../../Parameters.scad>
use <../lib/shortcuts.scad>

use <../666_1004.scad>
use <../666_1006.scad>
use <../666_1014.scad>
use <../666_1017.scad>
use <../666_1026.scad>

draft = false;

place_in_rect(100, 100) // arange that stuff in a grid
{
    666_1004(coupling_wall_thickness, thickness_between_tubes);

    666_1006();
    666_1006();
    666_1006();
    666_1006();

    666_1014();
    666_1017();

    666_1026();
    666_1026();
}
