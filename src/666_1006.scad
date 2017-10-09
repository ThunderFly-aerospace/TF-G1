include <../Parameters.scad>
height = 40;

module 666_1006(){
difference (){

cylinder (h = height, r1 = main_tube_inner_diameter/2, r2 = main_tube_inner_diameter/2);
cylinder (h= height, r1 = tube_for_undercarriage_outer_diameter/2, r2 = tube_for_undercarriage_outer_diameter/2);

}
}
