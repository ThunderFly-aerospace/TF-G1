include <../../parameters.scad>
use <../lib/shortcuts.scad>

use <../666_1004.scad>
use <../666_1006.scad>
use <../666_1014.scad>
use <../666_1017.scad>
use <../666_1026.scad>

draft = false;

place_in_rect(30, 30) // arange that stuff in a grid
{
    666_1006(draft = draft);
    666_1006(draft = draft);
    666_1006(draft = draft);
    666_1006(draft = draft);
}
