module 666_1211(){

union (){
	difference (){
	
	cylinder (h = 14, r1 = 84/2, r2 = 84/2,$fn = 200);
		
		//vnitřní díra
		translate ([0,0,-3])
		cylinder (h = 14+6, r1 = 42/2, r2 = 42/2, $fn = 200);		

			//žlábek
			difference(){
			translate ([0,0,0])
			cylinder (h = 13+4, r1 = 75/2, r2 = 75/2, $fn = 200);

			translate([0,0,0])
			cylinder (h = 20, r1 = 50/2, r2 = 50/2, $fn = 200);
			}

				// vnější sražení horní
				difference (){
				translate ([0,0,13.5])
				cylinder (h = 1, r1 = 85/2, r2 = 85/2, $fn = 200);
				translate ([0,0,13.5])
				cylinder (h = 1, r1 = 84/2, r2 = 83/2, $fn = 200);
				}
		
				// vnější sražení spodní
				difference(){
				translate ([0,0,-0.5])
				cylinder (h = 1, r1 = 85/2, r2 = 85/2, $fn = 200);
				translate ([0,0,-0.5])
				cylinder (h = 1, r1 = 83/2, r2 = 84/2, $fn = 200);
				}

				// vnitřní sražení horní
				difference (){
				translate ([0,0,13.5])
				cylinder (h = 1, r1 = 42/2, r2 = 43/2, $fn = 200);
				}
				
				
				//vnitřní sražení dolní	
				difference(){
				translate ([0,0,-0.5])
				cylinder (h = 1, r1 = 43/2, r2 = 42/2, $fn = 200);
				}
		

		%cube ([100,100,100]);

	}
 
//límec
difference (){
cylinder (h = 1, r1 = 120/2, r2 = 120/2, $fn = 200);
translate ([0,0,-1])
cylinder (h = 3, r1 = 42/2, r2 = 42/2, $fn = 200 );
				
			//vnitřní sražení dolní
				difference(){
				translate ([0,0,-0.5])
				cylinder (h = 1, r1 = 43/2, r2 = 42/2, $fn = 200);
				}


}  	//difference

} 	//union

}	//module
666_1211();

