//parametry pro serva
//značení parametrů: https://www.servocity.com/media/wysiwyg/products/servos/hitec-servos/standard_servos/31422S/Standard_Servo_Schematic_2_1_.jpg


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




module SB_2282()
{
  //Model for the Savox

  translate([-9.75,8.5,-30]) //align the shaft to 0-0
  union()
  {
    color("Gray")
    {
      union()
      {
        //main box
        cube([20.2, 40.3 ,38.7]);

        //ears
        difference()
        {
            //slate
            translate([0,6, -(54-40.3)/2])
            cube([20.2, 2.5 ,54]);

            //hole in ears
            translate([4,9,-(54-48)/2])
            rotate([90,0,0])
            cylinder(d=3, h=4, $fn=100);

            translate([15.5,9,-(54-48)/2])
            rotate([90,0,0])
            cylinder(d=3, h=4, $fn=100);

            translate([4,9,40.3+(54-48)/2])
            rotate([90,0,0])
            cylinder(d=3, h=4, $fn=100);

            translate([15.5,9, 40.3+(54-48)/2])
            rotate([90,0,0])
            cylinder(d=3, h=4, $fn=100);
        }


      }
    }

    union()
    {
      //shaft
      translate([9.75,0,30])
      rotate([90,0,0])
      cylinder(r=2.5, h=4, $fn=100);

    }

  }
}


translate([40, 0, 0]) SB_2282();





module LW_20MG()
{
  //Model for the POWER HD

  body_height = 39.5;
  body_thickness = 20.5;
  body_length = 40.7;

  ears_length = 54.5;
  ear_length = (ears_length - body_length)/2;
  holes_distance = 10;
  holes_ears_distance = 49.0;

  translate([-9.75,8.5,-30]) //align the shaft to 0-0
  union()
  {
    color("Gray")
    {
      union()
      {
        //main box
        cube([body_thickness, body_height ,body_length]);

        //ears
        difference()
        {
            //plate
            translate([0,6, -ear_length])
                cube([body_thickness, 2.5, ears_length]);

            //hole in ears
            translate([ body_thickness/2 + holes_distance/2,9, -(holes_ears_distance - body_length)/2])
            rotate([90,0,0])
            cylinder(d=4, h=4, $fn=100);

            translate([ body_thickness/2 - holes_distance/2,9,-(holes_ears_distance - body_length)/2])
            rotate([90,0,0])
            cylinder(d=4, h=4, $fn=100);

            translate([ body_thickness/2 + holes_distance/2,9, body_length+(holes_ears_distance - body_length)/2])
            rotate([90,0,0])
            cylinder(d=4, h=4, $fn=100);

            translate([ body_thickness/2 - holes_distance/2,9, body_length+(holes_ears_distance - body_length)/2])
            rotate([90,0,0])
            cylinder(d=4, h=4, $fn=100);
        }


      }
    }

    union()
    {
      //shaft
      translate([9.75,0,30])
      rotate([90,0,0])
      cylinder(r=2.5, h=4, $fn=100);

    }

  }
}



translate([80, 0, 0]) LW_20MG();
