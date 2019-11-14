// Návrh formy pro odlití listu


include <../../parameters.scad>
use  <../lib/naca4.scad>
$fn=100;

CP=2415; //číslo profilu NACA - první pouzite je 12
HP=50; //hloubka profilu tj, v ose x
DF=100; //délka formy tj, v ose z
VF=25; //výška formy tj, v ose y
SF=HP+40; //šířka formy tj, v ose x
//poloměr vodící trubky
R1=2.5;
R2=0.8;

// airfoil(naca = 0012, L = 50, N=1001, h = 200, open = true);
// zatím zkrácené verze jednotlivých dílů
// výpočet posunu profilu ve formě
dX=(SF-HP)/2;
dY=VF/2;
LDOK=10; // vzdálenost díry pro spojení polovin forem k sobě od kraje formy

//příruby formy
// rozměry příruby
SPri=SF+0; // v ose x
DPri=VF+40;// v ose y
VPri=6;
//posuny příruby
dXPri=(SPri-SF)/2;
dYPri=(DPri-VF)/2;
dZPri=DF-VPri;
// posuny děr v přírubě
LDOKPri=10;
x1=-dXPri+LDOKPri;
x2=-dXPri+SPri-LDOKPri;
y1=-dYPri+LDOKPri;
y2=-dYPri+DPri-LDOKPri;
z1=-5;
z2=DF-VPri+layer_thickness;

module Forma_stred () {


difference (){
union (){
    difference (){
        union(){
            translate([0, dY - DPri/2, 0]) cube ([SPri,DPri,7]);
        }

    translate([dX, dY, 7-2]){
        translate([2.5, 0.2, 0]) cylinder(d = 2.5, h = 10);
        translate([6, 0.5, 0]) cylinder(d = 2.5, h = 10);
        //translate([9, 0.7, 0]) cylinder(d = 2.5, h = 10);
        translate([24, 1, 0]) cylinder(d = 5.5, h = 10);
        translate([29.5, 1, 0]) cylinder(d = 3.5, h = 10);
        translate([34, 0.8, 0]) cylinder(d = 3.5, h = 10);;
        translate([38, 0.7, 0]) cylinder(d = 2.5, h = 10);
    }
    // díry v přírubách
    for (i=[x1,x2])
        for (j=[y1,y2])
            for (k=[z1,z2])
                translate ([i,j,0]){
                    translate([0, 0, 4+0.3]) cylinder (h=30, d=M4_screw_diameter);
                    cylinder (h=4, d=M4_nut_diameter);
                }



     }

}
%translate ([dX,dY,-5])     airfoil(naca=CP, L = HP, N = 1000, h = DF+10, open = true);
//translate ([0,dY,0]) cube ([SPri,DPri,DF]);};// rozdílová kostka
}}


Forma_stred();
