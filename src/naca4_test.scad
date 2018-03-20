use <./lib/naca4.scad>



draft = true;   // sets rendering quality to draft.
$fs = draft ? 5 : 0.5;
$fa = 10;


    airfoil_thickness = 0030;

    hollow_airfoil(naca = airfoil_thickness, L = 170, N = 100, h = 100, open = true,  wall_thickness = 1);

    echo(surface_distance());
    echo(surface_angle());
