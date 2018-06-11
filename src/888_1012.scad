draft = true;

module 888_1012(){
module MG995()
{
  //Model for the TowerPro MG995 Servo

  translate([-9.75,8.5,-30]) //align the shaft to 0-0
  union()
  {
    color("Gray")
    {
      union()
      {
        //main box
        cube([19.5, 35 ,39.5]);

        //ears
        difference()
        {
            //slate
            translate([0,6,-7])
            cube([19.5, 2.5 ,54]);

            //hole in ears
            translate([4,9,-4])
            rotate([90,0,0])
            cylinder(r=2, h=4, $fn=100);

            translate([15.5,9,-4])
            rotate([90,0,0])
            cylinder(r=2, h=4, $fn=100);

            translate([4,9,43.5])
            rotate([90,0,0])
            cylinder(r=2, h=4, $fn=100);

            translate([15.5,9,43.5])
            rotate([90,0,0])
            cylinder(r=2, h=4, $fn=100);
        }


        //shaft plateou
        translate([0,-2.3,9.5])
        cube([19.5, 2.3 ,20]);

        //shaft plateou rounding
        translate([9.75,0,30])
        rotate([90,0,0])
        cylinder(r=9.75, h=2.3, $fn=100);

        //shaft circular frame
        translate([9.75,-2.3,30])
        rotate([90,0,0])
        cylinder(r=6, h=1, $fn=100);

        //shaft second circular frame
        translate([9.75,-3.3,30])
        rotate([90,0,0])
        cylinder(r=5.5, h=0.5, $fn=100);

      }
    }

    union()
    {
      //shaft
      translate([9.75,-3.3,30])
      rotate([90,0,0])
      cylinder(r=2.5, h=4.5, $fn=100);

      translate([9.75,-4.5,30])
      rotate([90,0,0])
      cylinder(r=3, h=4, $fn=100);
    }

  }
}

module MG995SingleHorn()
{
  //Model for the TowerPro MG995 Servo Single Horn
  color("Gray")
  {
    difference()
    {
      union()
      {
        cylinder(r=6.5, h=4.5, $fn=100);

        translate([0,0,4.5])
        cylinder(r1=5, r2=4.5, h=1.5, $fn=100);

        difference()
        {
          //horn arm
          translate([28,0,1])
          {
            cylinder(r=3.5, h=2.5, $fn=100);

            translate([0,-3.5,0])
            rotate([0,0,96])
            cube([7, 28,2.5]);

            translate([0,-3.5,0])
            rotate([0,0,84])
            cube([7, 28,2.5]);
          }

          //arm holes
          for(i=[0:5])
          {
            translate([28 - (i * 3),0,0])
            cylinder(r=0.7, h=8, $fn=100);
          }

        }

      }

      //hole and indentation for the shaft
      translate([0,0,-1])
      cylinder(r=1.5, h=8, $fn=100);

      translate([0,0,-1])
      cylinder(r=3.6, h=3, $fn=100);

      translate([0,0,3])
      cylinder(r=2.8, h=5, $fn=100);
    }
  }
}

module MG995HornArm(size=28,holes_count=6)
{
      difference()
      {
        translate([size,0,1])
        {
          cylinder(r=3.5, h=2.5, $fn=100);

          translate([0,-3.5,0])
          rotate([0,0,96])
          cube([7, size,2.5]);

          translate([0,-3.5,0])
          rotate([0,0,84])
          cube([7, size,2.5]);
        }

        //arm holes
        for(i=[0:(holes_count -1)])
        {
          translate([size - (i * 3),0,0])
          cylinder(r=0.7, h=8, $fn=100);
        }
      }
}

module MG995DoubleHorn()
{
  //Model for the TowerPro MG995 Servo Single Horn
  color("Gray")
  {
    difference()
    {
      union()
      {
        cylinder(r=6.5, h=4.5, $fn=100);

        translate([0,0,4.5])
        cylinder(r1=5, r2=4.5, h=1.5, $fn=100);

        //first horn arm
        MG995HornArm(26,5);

        //second horn arm
        rotate([0,0,180])
        MG995HornArm(26,5);

      }

      //hole and indentation for the shaft
      translate([0,0,-1])
      cylinder(r=1.5, h=8, $fn=100);

      translate([0,0,-1])
      cylinder(r=3.6, h=3, $fn=100);

      translate([0,0,3])
      cylinder(r=2.8, h=5, $fn=100);
    }
    
  }
}

module MG995WithSingleHorn(horn_angle=0)
{
  MG995();
  translate([0,-3,0])
  rotate([270,horn_angle,0])
  MG995SingleHorn();
}

module MG995WithDoubleHorn(horn_angle=0)
{
  MG995();
  translate([0,-3,0])
  rotate([270,horn_angle,0])
  MG995DoubleHorn();
}

MG995WithSingleHorn(45);

}


/////////////
//naše servo
module 888_1012_A(){
union(){
        //main box
    translate([-5,0,0])
        		cube([10, 19.3 ,22.6]);
        //ears
    difference(){
         	//slate
        translate([-5,4 - 2,-4.95])
        		color([0,0,0.5])
            		cube([10, 2 ,32.5]);

            //hole in ears
        translate([-3,6,-2.2])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);

        translate([3,6,-2.2])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);

        translate([0,6,-3])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);

        translate([-3,6,22.6 + 2.2])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);

        translate([3,6,22.6 + 2.2])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);

        translate([0,6,22.6 + 3])
            rotate([90,0,0])
            		cylinder(r=1, h=10, $fn=100);
    }

    translate([0,0, +22.6 - 3 - 1])
    	rotate([90,0,0])
    		color([0.5,0,0])
    			cylinder(h = 22.8 - 19.3, r = 3, $fn = draft ? 100 : 200);
    //táhlo
    
    translate([-20,0, +22.6 -6 - 1])
      rotate([90,0,0])
        color([0,0,0.5])
          cube([20,6,22.8-19.3 + 1]);

    translate([-4,19.3 - 3 - 1,22.6])
    		color([0.5,0,0])
    			cube([8,3,6]);

    difference(){
      	translate([-5,-3,0])
      			color([0.5,0,0])
      				cube([10,3,8.5]);
        translate([0,0,13.5 - 2])
        	rotate([90,45,0])
        			cube([10,5,10]);
    	mirror([1,0,0])
    	    translate([0,0,13.5 - 2])
    			rotate([90,45,0])
    					cube([10,5,10]);
    }

}

}

///upevnění serva +X
module 888_1012_B(){
	difference(){
		union(){
			//základní obrazec
			translate([5 - 0.5,- (22.8 - 19.3),-4.95 - 1])
					color([0,0.5,0])
						cube([2,22.8 + 2, 32.5 + 2]);
				difference(){
					//zobáček
					translate([-0.5,0,-5])
						color([0,0.5,0])
							%cube([5,1.8,4]);
					//otvor v zobáčku
					translate([-1 - 0.05 - 0.4,0.4 - 0.05,-5 + 0.5 - 0.05])
								%cube([1 + 1,1 + 0.1,3 + 0.1]);
				}

			translate([0,0,28.5])
				difference(){
					//zobáček
					translate([-0.5,0,-5])
						color([0,0.5,0])
							cube([5,1.8,4]);
					//otvor v zobáčku
					translate([-1 - 0.05 - 0.4,0.4 - 0.05,-5 + 0.5 - 0.05])
								cube([1 + 1,1 + 0.1,3 + 0.1]);
				}
			
			difference(){
				translate([-0.5,2 +0.2 + 2,-5])
						color([0,0.5,0])
							cube([5,1.8 + Servo_screw,4]);
				translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
					rotate([0,90,0])
							cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
			}

			translate([0,0,28.5])
				difference(){
					translate([-0.5,2 +0.2 + 2,-5])
							color([0,0.5,0])
								%cube([5,1.8 + Servo_screw,4]);
					translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
						rotate([0,90,0])
								cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
				}


		}

		translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
			rotate([0,90,0])
					cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
		translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1 + 28.5])
			rotate([0,90,0])
					cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);



		translate([-5,4 - 2,-4.95])
	            	cube([10, 2 ,32.5]);
	    
	    difference(){
		    	translate([-5,-3,0])
		    			color([0.5,0,0])
		    				cube([10,3 + 1 ,8.5]);
		        translate([0,0,13.5 - 2])
		        	rotate([90,45,0])
		        			cube([10,5,10]);
			mirror([1,0,0])
			    translate([0,0,13.5 - 2])
					rotate([90,45,0])
							cube([10,5,10]);
	    }
	    
	    translate([-4,19.3 - 3 - 1,22.6])
	    		color([0.5,0,0])
	    			cube([8,3,6]);
	}



}


//upevnění serva -X
module 888_1012_C(){
	difference(){
		union(){
			translate([-2 - 5 + 0.5,- (22.8 - 19.3),-4.95 - 1])
					color([0,0.5,0])
						cube([2,22.8 + 2 + 1, 32.5 + 2]);
				union(){
					//zobáček
					translate([-4.5,0,-5])
							color([0,0.5,0])
								cube([5,1.8,4]);
					//menší zobáček určený do otvoru
					translate([0.4,0.4,-5 + 0.5])
						color([0,0.5,0])
							cube([1,1,3]);
				}

			translate([0,0,28.5])
				union(){
					//zobáček
					translate([-4.5,0,-5])
								cube([5,1.8,4]);
					//menší zobáček určený do otvoru
					translate([0.4,0.4,-5 + 0.5])
							cube([1,1,3]);
				}
		
			difference(){
				translate([-4.5,2 +0.2 + 2,-5])
						color([0,0.5,0])
							cube([5,1.8 + Servo_screw,4]);
				translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
					rotate([0,90,0])
							cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
			}

			translate([-4.5,0,28.5])
				difference(){
					translate([0,2 +0.2 + 2,-5])
							color([0,0.5,0])
								cube([5,1.8 + Servo_screw,4]);
					translate([-5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
						rotate([0,90,0])
								cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
				}


		}

		translate([-5 - 5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1])
			rotate([0,90,0])
					cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);
		translate([-5 - 5, 2 + 2 + 1.8/2 + Servo_screw/2 + 0.2,-2  - 1 + 28.5])
			rotate([0,90,0])
					cylinder(h = 15, r = Servo_screw/2, $fn = draft ? 50 : 100);

		
		translate([-15,1,0])
	        		cube([30, 20 ,23]);	//základní otvor
		translate([-5,4 - 2,-4.95])
	            	cube([10, 2 ,32.5]);
	    /*
	    difference(){
		    	translate([-5,-3,0])
		    			color([0.5,0,0])
		    				cube([10,3 + 1 ,8.5]);
		        translate([0,2,13.5 - 2])
		        	rotate([90,45,0])
		        			cube([10,5,10]);
			mirror([1,0,0])
			    translate([0,2,13.5 - 2])
					rotate([90,45,0])
							cube([10,5,10]);
	    }
	    */

	    translate([-4,19.3 - 3 - 1,22.6])
	    		color([0.5,0,0])
	    			cube([8,3,6]);
//otvor pro táhlo
      translate([-20,-5,0])
           cube([20,7,22.6]);

	}

}

//pro vytvoření otvoru pro servo v dílu 666_1028, prozatím znázorněno v dílu 888_1010_A
module 888_1012_D(){

			translate([-13.5/2,- (22.8 - 19.3),-4.95 - 1])
					color([0.5,0,0])
						cube([13.5,22.8 + 2 + 1, 32.5 + 2]);

      translate([-20,-5,0])
        //rotate([90,0,0])
           cube([20,7,22.6]);


}

//náš servo motor
//translate([0,-50,0])
			888_1012_A();


//upevnění serva
translate([0.5,0,0])
			888_1012_B();

translate([-0.5,0,0])
		888_1012_C();



//translate([-(2+6+0.5 + 2 + 1),0,0])
 	//888_1012_D();

use <./lib/naca4.scad>
include <../Parameters.scad>
