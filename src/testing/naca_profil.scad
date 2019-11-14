// Návrh formy pro odlití listu


include <../../parameters.scad>
use  <../lib/naca4.scad>
$fn=100;

CP=2415; //číslo profilu NACA - první pouzite je 12
HP=50; //hloubka profilu tj, v ose x
DF=10; //délka formy tj, v ose z

airfoil(naca=CP, L = HP, N = 1000, h = DF, open = true);
