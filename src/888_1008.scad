
module 888_1008_A(){


    curvedPipe([[0,height_666_1026 + height_666_1004/2,131],        //body ohybu
                [radius_undercarriage + 45 - tube_for_undercarriage_outer_diameter/2,height_666_1026 + height_666_1004/2,131],
                [radius_undercarriage + 45 + vzdalenost_y,- vzdalenost_x + height_666_1026 + height_666_1004/2,0],
                [radius_undercarriage + 45 + vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [+ vzdalenost_y + 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);


}

module 888_1008_B(){

    curvedPipe([[0,height_666_1026 + height_666_1004/2,131],        //body ohybu
                [- radius_undercarriage - 45 + tube_for_undercarriage_outer_diameter/2,height_666_1026 + height_666_1004/2,131],
                [- radius_undercarriage - 45 - vzdalenost_y,- vzdalenost_x + height_666_1026 + height_666_1004/2,0],
                [- radius_undercarriage - 45 - vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [- vzdalenost_y - 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);


}

//plná trubka 888_1008_A

module 888_1008_C(){

                curvedPipe([[0,height_666_1026 + height_666_1004/2,131],        //body ohybu
                [radius_undercarriage + 45 - tube_for_undercarriage_outer_diameter/2,height_666_1026 + height_666_1004/4,131],
                [radius_undercarriage + 45 + vzdalenost_y,- vzdalenost_x + height_666_1026 + height_666_1004/2,0],
                [radius_undercarriage + 45 + vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [+ vzdalenost_y + 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
               0);

}


//plná trubka 888_1008_B

module 888_1008_D(){

    curvedPipe([[0,height_666_1026 + height_666_1004/2,131],        //body ohybu
                [- radius_undercarriage - 45 + tube_for_undercarriage_outer_diameter/2,height_666_1026 + height_666_1004/2,131],
                [- radius_undercarriage - 45 - vzdalenost_y,- vzdalenost_x + height_666_1026 + height_666_1004/2,0],
                [- radius_undercarriage - 45 - vzdalenost_y, second_undercarriage_hole - vzdalenost_x, 0],
                [- vzdalenost_y - 45, second_undercarriage_hole, 131],
                [0,second_undercarriage_hole, 131],
               ],

                5,
                [radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage,radius_undercarriage],     // radiusy
                tube_for_undercarriage_outer_diameter,
                0);




}

//správna trubka pro nový trojkolový model
module 888_1008_E(){


    curvedPipe([[0,0,200],        //body ohybu
                [radius_undercarriage + 230 - tube_for_undercarriage_outer_diameter/2,0,200],
                [radius_undercarriage + 230 + vzdalenost_y,+ vzdalenost_x,0], 
                [ +radius_undercarriage  + 230+ vzdalenost_y, 110 , 0],
                                ],

                3,
                [radius_undercarriage,radius_undercarriage/4],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);



}

//správná trubka pro nový trojkolový model

module 888_1008_F(){

    curvedPipe([[0,0,200],        //body ohybu
                [- radius_undercarriage - 230 + tube_for_undercarriage_outer_diameter/2,0,200],
                [- radius_undercarriage - 230 - vzdalenost_y,+ vzdalenost_x,0],
                [ -radius_undercarriage - 230 - vzdalenost_y, 110, 0],

               ],
                3,
                [radius_undercarriage,radius_undercarriage/4],     // radiusy
                tube_for_undercarriage_outer_diameter,
                8);


}


/*
translate([length_of_undercarriage_tube/2,0,0])
		888_1008_A();

translate([- length_of_undercarriage_tube/2,0,0])
		888_1008_B();

*/

//888_1008_E();
888_1008_F();


use <./lib/naca4.scad>
use <./lib/curvedPipe.scad>
include <../parameters.scad>