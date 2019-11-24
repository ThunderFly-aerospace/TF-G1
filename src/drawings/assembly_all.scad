include <../lib/assembly.scad>

$vpr = [55.00, 0.00, 25.00];
$vpd = 3962.06;


rotor = true;
nosnik = true;
predni_podvozek = true;
zadni_podvozek = true;
mechova_kolecka = true;
limec = true;
cover = true;
pilon_mount = true;
rotor_head = true;
rotor_head_pulley_motor = true;
rotor_head_pulley_rotor = true;
rotor_head_plate = true;
rotor_head_prerotator = true;
motor = true;
tail = true;
battery = true;
propeller = true;


print = true;
alu = true;
piston = true;
carbon = true;
other = true;


assembly();
