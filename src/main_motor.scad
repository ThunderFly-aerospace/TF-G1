include <../parameters.scad>
use <lib/motor.scad>

module position_main_motor(){
		translate([-engine_offset*2.2, 0, engine_offset])
		rotate([0, 90+engine_angle, 0])
		children();
}

position_main_motor()
motor_main();