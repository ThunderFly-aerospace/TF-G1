include <../../parameters.scad>
use <../666_1028.scad>

draft = false;

666_1028_body_middle(side_choose = 1, draft = draft);

// plochy pro zlepšení adheze k podložce při tisku
//translate ([120,-75,0])
//	cube ([30,150,0.3]);

//translate ([0,-35,0])
//	cube ([30,70,0.3]);

//modifiers---------------------------------------------

666_1028_modifiers_middle();
