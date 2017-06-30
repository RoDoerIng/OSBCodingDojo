FUNCTION_BLOCK Conveyor
VAR
	//sensors
	slowSensor		:REFERENCE TO BOOL; //sensor to slow down
	stopSensor		:REFERENCE TO BOOL; //sensor to stop
	//conveyor interface
	prevConRdy2Snd	:REFERENCE TO BOOL; //previous conveyor is ready to send
	nextConRdy2Rec	:REFERENCE TO BOOL; //next conveyor is ready to receive
	rdy2Rec			:REFERENCE TO BOOL; //signal to the previous conveyor: ready to receive
	rdy2Snd			:REFERENCE TO BOOL; //signal to the next conveyor: ready to send
	//drive signales
	cw				:REFERENCE TO BOOL; //run the motor clockwise, if it false the motor will run counter clockwise
	fast			:REFERENCE TO BOOL; //run the motor fast, if it false will the motor running slow
	start			:REFERENCE TO BOOL; //run start the motor
	//machine state
	automatic		:REFERENCE TO BOOL; //the machine is in machine state automatic
END_VAR

METHOD FB_INIT
VAR_INPUT
	//CODESYS stuff
	bInitRetains	:BOOL; // initializing of retain-variable
	bInCopyCode 	:BOOL; // instance is copied to copy-code
	//sensors
	slowSensor		:REFERENCE TO BOOL; //sensor to slow down
	stopSensor		:REFERENCE TO BOOL; //sensor to stop
	//conveyor interface
	prevConRdy2Snd	:REFERENCE TO BOOL; //previous conveyor is ready to send
	nextConRdy2Rec	:REFERENCE TO BOOL; //next conveyor is ready to receive
	rdy2Rec			:REFERENCE TO BOOL; //signal to the previous conveyor: ready to receive
	rdy2Snd			:REFERENCE TO BOOL; //signal to the next conveyor: ready to send
	//drive signales
	cw				:REFERENCE TO BOOL; //run the motor clockwise, if it false the motor will run counter clockwise
	fast			:REFERENCE TO BOOL; //run the motor fast, if it false will the motor running slow
	start			:REFERENCE TO BOOL; //run start the motor
	//machine state
	automatic		:REFERENCE TO BOOL; //the machine is in machine state automatic
END_VAR
	THIS^.slowSensor     REF= slowSensor    ;
	THIS^.stopSensor     REF= stopSensor    ;
	THIS^.prevConRdy2Snd REF= prevConRdy2Snd;
	THIS^.nextConRdy2Rec REF= nextConRdy2Rec;
	THIS^.rdy2Rec        REF= rdy2Rec       ;
	THIS^.rdy2Snd        REF= rdy2Snd       ;
	THIS^.cw             REF= cw            ;
	THIS^.fast           REF= fast          ;
	THIS^.start          REF= start         ;
	THIS^.automatic      REF= automatic     ;
END_METHOD	
	
METHOD isEmpty	:BOOL
	isEmpty := (NOT(THIS^.slowSensor OR THIS^.stopSensor));
END_METHOD

METHOD isAligned :BOOL
	isAligned := (THIS^.slowSensor AND THIS^.stopSensor);
END_METHOD

METHOD isOccupiedInfeed :BOOL
	isOccupiedInfeed := (THIS^.slowSensor AND (NOT THIS^.stopSensor));
END_METHOD

METHOD isOccupiedOutfeed :BOOL
	isOccupiedOutfeed := ((NOT THIS^.slowSensor) AND THIS^.stopSensor);
END_METHOD

METHOD fastForward	
   THIS^.cw 	:= TRUE;
   THIS^.fast	:= TRUE;
   THIS^.start	:= TRUE;
END_METHOD

METHOD slowForward	
   THIS^.cw 	:= TRUE;
   THIS^.fast	:= FALSE;
   THIS^.start	:= TRUE;
END_METHOD

METHOD fastBackward	
   THIS^.cw 	:= FALSE;
   THIS^.fast	:= TRUE;
   THIS^.start	:= TRUE;
END_METHOD

METHOD slowBackward	
   THIS^.cw 	:= FALSE;
   THIS^.fast	:= FALSE;
   THIS^.start	:= TRUE;
END_METHOD

METHOD stop
	THIS^.start	:= FALSE;
END_METHOD

METHOD run
	THIS^.rdy2Rec := (THIS^.isEmpty() AND THIS^.automatic);
	THIS^.rdy2Snd := ((THIS^.isAligned() OR THIS^.isOccupiedOutfeed()) AND THIS^.automatic);
	(*recive part*)
	IF (THIS^.rdy2Rec AND THIS^.prevConRdy2Snd) THEN
		THIS^.fastForward();
	(*send part*)
	ELSIF (THIS^.rdy2Snd AND THIS^.nextConRdy2Rec) THEN
		THIS^.fastForward();
	(*align part*)
	ELSIF (THIS^.isOccupiedInfeed() AND THIS^.automatic) THEN
		THIS^.slowForward();
	ELSE
		THIS^.stop();
	END_IF;
END_METHOD