use <./lib/naca4.scad>



draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;

/*cylinder_position = 0.6;

    airfoil_thickness = 0030;

    hollow_airfoil(naca = airfoil_thickness, L = 170, N = 100, h = 100, open = true,  wall_thickness = 1);

    distance = surface_distance(x = cylinder_position, naca=airfoil_thickness, open = false);
    angle = surface_angle(x = cylinder_position, naca=airfoil_thickness, open = false);
    echo("surface distance is:", distance);
    echo("angle of surface is:", angle);

translate([170*cylinder_position,170*distance,50])
    rotate([0,90,angle])
        cylinder(d=10, h = 30, $fn = 20, center = true);
*/

module drop_skin(wall_thickness = 1, draft = true){

            difference(){
                polygon(points = airfoil_data(naca, L, N, open));
                offset(delta = - wall_thickness) polygon(points = airfoil_data(naca, L, N, open = false));
            }    
}
