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


difference ()
{ union () {
    difference ()
    { union () {cube ([SF,VF,DF]);
        translate ([-dXPri,-dYPri,0]) cube ([SPri,DPri,VPri]);
        translate ([-dXPri,-dYPri,dZPri]) cube ([SPri,DPri,VPri]);
    };
          translate ([dX,dY,-5])     airfoil(naca=CP, L = HP, N = 1000, h = DF+10, open = true);
          translate ([LDOK,50,VPri+10]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);
          translate ([LDOK,50,DF-(VPri+10)]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);
          translate ([LDOK,50,DF/2]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);
          translate ([SF-LDOK,50,DF/2]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);
          translate ([SF-LDOK,50,VPri+10]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);
          translate ([SF-LDOK,50,DF-(VPri+10)]) rotate ([90,0,0])   cylinder (h=100,d=M4_screw_diameter);

    // díry v přírubách
    for (i=[x1,x2])
        for (j=[y1,y2])
            for (k=[z1,z2])
                translate ([i,j,k])
                    cylinder (h=30,d=M4_screw_diameter);
    for (i=[x1,x2])
        for (j=[y1,y2])
            for (k=[3])
                translate ([i,j,k])
                    cylinder (h=30,d=M4_nut_diameter, $fn = 6);


     }
// žebra

 TlZ=1.6;
 HlZ=(DPri-VF)/2;
 VyZ=DF;

    for (j=[-20,25])
        for (i=[0:3])
            translate ([i*(SF-TlZ)/3,j,0])
                cube ([TlZ,HlZ,VyZ]);

}
//translate ([0,dY,0]) cube ([SPri,DPri,DF]);};// rozdílová kostka
}}

module Forma_stred_HP () {

  difference ()
  {Forma_stred ();
    translate ([0,dY,0]) cube ([SPri,DPri,DF]);}// rozdílová kostka
  };

  module Forma_stred_SP () {

    difference ()
    {Forma_stred ();
      translate ([0,dY-DPri,0]) cube ([SPri,DPri,DF]);}// rozdílová kostka
    };


translate ([0,5,00])  Forma_stred_SP ();
translate ([0,0,00])  Forma_stred_HP ();
