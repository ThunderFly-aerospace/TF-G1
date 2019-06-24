include <../../parameters.scad>
use <../888_1019.scad>

draft = false;

difference(){
    888_1019(1, draft);
  #translate([(width_of_accumulator+40+40)/2-500, -200, -200])
    cube(500);
}
