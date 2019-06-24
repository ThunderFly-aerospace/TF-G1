use <./lib/naca4.scad>
include <../parameters.scad>


module 666_1207(draft = true){
    import("../STL/666_1207.stl", convexity=10);
}
666_1207();
