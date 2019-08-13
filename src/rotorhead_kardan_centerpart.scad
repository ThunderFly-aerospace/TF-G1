//kloub stredná časť

inner_a = 40; //x
inner_height = 5;  //z
par_klb = 2; //výška str klbu nad podstavou
par_klb2 = 6;
pom1 = sqrt(inner_a * inner_a + par_klb * par_klb);
pom2 = inner_height * par_klb/(inner_a/2);
inner_b = pom1 + pom2; //y

brit = 5;
hrana = 5;
plate = 5;
a=60;
b=14;
outer_a = inner_a + 2*brit + 2*hrana;
outer_b = inner_b + 2*brit; // + 2*hrana;
outer_height = inner_height + plate;
inner_diameter = (inner_a/2 - par_klb2) * pom1 / (inner_a/2);

difference(){    
    translate ([0,0,outer_height/2]) {
        cube([outer_a,outer_b,outer_height],center = true);
        }
    translate([0,0,inner_height + plate]){
        cube([inner_a,inner_b,inner_height*2],center = true);
        }
    hull() {
        translate([-(inner_a/2 - inner_diameter/2),0,-outer_height]) {cylinder (h=outer_height*4, r=inner_diameter/2,$fn = 100);}
        translate([inner_a/2 - inner_diameter/2,0,-outer_height]) {cylinder (h=outer_height*4, r=inner_diameter/2,$fn = 100);}
        }
    translate([0,0,(a * sqrt(2) / 2) + plate]) {
            rotate ([45,0,0]) {
                cube([inner_a + 2 * brit, a,a],center=true);
                }
            } 
    translate([0,-b/2-outer_b/2+brit,-(b * sqrt(2) / 2) + plate]){
        rotate ([0,45,0]){
            cube(b,center=true);
    }
}
    translate([0,b/2+outer_b/2-brit,-(b * sqrt(2) / 2) + plate]){
        rotate ([0,45,0]){
            cube(b,center=true);
    }
}
           
}