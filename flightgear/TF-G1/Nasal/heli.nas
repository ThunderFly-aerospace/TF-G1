
var def_look_angle= 0;


var init = func {
	
	def_look_angle=getprop("sim/current-view/pitch-offset-deg");
	print("Init Nasal Heli Ground ...done");
	main_loop();
}

# Setup listener call to start update loop once the fdm is initialized
setlistener("sim/signals/fdm-initialized", init);

var reinit = func {

	print("ReInit Nasal Heli Ground ...done");
	
}
setlistener("/sim/signals/reinit", reinit);


#main loop
var main_loop = func {

	check_gear();
	settimer(main_loop, 0);
}


var check_gear = func{
	
	var wow0 = getprop("gear/gear[0]/wow");
	var wow1 = getprop("gear/gear[1]/wow");
	var wow2 = getprop("gear/gear[2]/wow");
	
	var kias = getprop("velocities/airspeed-kt");
	var rotrpm = getprop("rotors/main/rpm");
	
	
	if (rotrpm<450) 
	{
		var wght = 70;
		
		#scale weight depending on airspeed
		#important if sliding forward on the ground
		
		if (rotrpm>0)
		{
		wght = wght* ( 1 - (rotrpm/450) );
		}
		
		if (wght<0) {wght=0;}
		
		#minimum for grass
		wght =wght+ 10;
		
		
		if (wow0==1) 
		{
			setprop("/sim/weight[0]/weight-lb",wght);
		}
		else
		{
			setprop("/sim/weight[0]/weight-lb",0);
		
		}
		
		if  ( (wow1==1) or (wow2==1) )
		{
			setprop("/sim/weight[1]/weight-lb",wght);
			setprop("/sim/weight[2]/weight-lb",wght);
		}
		else
		{
			setprop("/sim/weight[1]/weight-lb",0);
			setprop("/sim/weight[2]/weight-lb",0);
		
		}
		
		
	}
	else 
	{
		setprop("/sim/weight[0]/weight-lb",0);
		setprop("/sim/weight[1]/weight-lb",0);
		setprop("/sim/weight[2]/weight-lb",0);
	
	}
	
}


#view 
var	look_up = func{
	
	if (getprop("sim/current-view/internal"))
	{
		var angle= getprop("sim/current-view/goal-pitch-offset-deg");
		if (angle==def_look_angle+24) {
			angle=angle-24;
			setprop("sim/current-view/goal-pitch-offset-deg", angle);
		} 
		else {
			angle=def_look_angle+24;
			setprop("sim/current-view/goal-pitch-offset-deg", angle);
		}
	}	
}


var	look_down = func{
	
	if (getprop("sim/current-view/internal"))
	{
		var angle= getprop("sim/current-view/goal-pitch-offset-deg");
		if (angle==def_look_angle-24) {
			angle=angle+24;
			setprop("sim/current-view/goal-pitch-offset-deg", angle);
			
		} 
		else {
			angle=def_look_angle-24;
			setprop("sim/current-view/goal-pitch-offset-deg", angle);
		}
	}	
	
}

# vne 110 mph
# 110 mph = 95.5873866 kts
# max rotor = 600 rpm
# engine max 60 kw
# fuel tank 50 lit = kg#
# cruse 70-80 kts
# Max Rate Of Climb: 3 m/s (590 fpm)
# Service Ceiling (estimated): 4000 m (13000 ft)
# Minimum Speed: 40 kmh (22 mph) 19 kts

