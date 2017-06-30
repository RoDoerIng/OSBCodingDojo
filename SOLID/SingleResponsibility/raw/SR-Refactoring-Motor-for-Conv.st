
//INTERFACE IStoppable
//
//METHOD stop
//END_METHOD
//
//END_INTERFACE

//INTERFACE IEStoppable
//
//METHOD executeEStop
//END_METHOD
//
//END_INTERFACE

//INTERFACE ITwoStageLinearDrive EXTENDS IStoppable
//
//METHOD fastForward
//END_METHOD
//
//METHOD forward
//END_METHOD
//
//METHOD fastBackward
//END_METHOD
//
//METHOD backward
//END_METHOD
//
//END_INTERFACE

//INTERFACE ITwoStageRotationDrive EXTENDS IStoppable
//
//METHOD fastClockwise
//END_METHOD
//
//METHOD clockwise
//END_METHOD
//
//METHOD fastCounterClockwise
//END_METHOD
//
//METHOD counterClockwise
//END_METHOD
//
//END_INTERFACE

//{info 'ACommonTwoStageDrive is just an abstract class'}
//FUNCTION_BLOCK ACommonTwoStageDrive IMPLEMENTS ITwoStageLinearDrive, ITwoStageRotationDrive, IEStoppable
//
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains	:BOOL; // initializing of retain-variable
//	bInCopyCode 	:BOOL; // instance is copied to copy-code
//END_VAR
//END_METHOD
//
//METHOD stop
//END_METHOD
//
//METHOD executeEStop
//END_METHOD
//
//METHOD fastForward
//END_METHOD
//
//METHOD forward
//END_METHOD
//
//METHOD fastBackward
//END_METHOD
//
//METHOD backward
//END_METHOD
//
//METHOD fastClockwise
//END_METHOD
//
//METHOD clockwise
//END_METHOD
//
//METHOD fastCounterClockwise
//END_METHOD
//
//METHOD counterClockwise
//END_METHOD
//
//END_FUNCTION_BLOCK

//FUNCTION_BLOCK Acme2StatgeDrive EXTENDS ACommonTwoStageDrive
//VAR
//	//CODESYS stuff
//	bInitRetains	:BOOL; // initializing of retain-variable
//	bInCopyCode 	:BOOL; // instance is copied to copy-code
//	//drive signals
//	cw				:REFERENCE TO BOOL; //run the motor clockwise, if it false the motor will run counter clockwise
//	fast			:REFERENCE TO BOOL; //run the motor fast, if it false will the motor running slow
//	start			:REFERENCE TO BOOL; //run start the motor
//	maskFwd			:BOOL; //mask to define forward or rather clockwise
//END_VAR
//
//METHOD FB_INIT
//VAR_INPUT
//	cw				:REFERENCE TO BOOL; //run the motor clockwise, if it false the motor will run counter clockwise
//	fast			:REFERENCE TO BOOL; //run the motor fast, if it false will the motor running slow
//	start			:REFERENCE TO BOOL; //run start the motor
//	maskFwd			:BOOL; //mask to define forward or rather clockwise
//END_VAR
//	THIS^.cw             REF= cw     ;
//	THIS^.fast           REF= fast   ;
//	THIS^.start          REF= start  ;
//	THIS^.maskFwd      	 :=   maskFwd;
//END_METHOD	

//METHOD stop
//	THIS^.start := FALSE;
//END_METHOD
//
//METHOD executeEStop
//	THIS^.stop();
//END_METHOD

//METHOD PROTECTED StartMotor
//VAR_INPUT
//	direction :BOOL; //direction flag
//	velocity: BOOL; //velocity flag
//END_VAR
//	THIS^.cw 	 	:= direction;
//	THIS^.fast   	:= velocity;
//	THIS^.start  	:= TRUE;
//END_METHOD

//METHOD fastForward
//	THIS^.StartMotor(direction := THIS^.maskFwd, velocity := TRUE);
//END_METHOD
//
//METHOD forward
//	THIS^.StartMotor(direction := THIS^.maskFwd, velocity := FALSE);
//END_METHOD
//
//METHOD fastBackward
//	THIS^.StartMotor(direction := (NOT THIS^.maskFwd), velocity := TRUE);
//END_METHOD
//
//METHOD backward
//	THIS^.StartMotor(direction := (NOT THIS^.maskFwd), velocity := FALSE);
//END_METHOD

//METHOD fastClockwise
//	THIS^.fastForward();
//END_METHOD
//
//METHOD clockwise
//	THIS^.forward();
//END_METHOD
//
//METHOD fastCounterClockwise
//	THIS^.fastBackward();
//END_METHOD
//
//METHOD counterClockwise
//	THIS^.backward();
//END_METHOD	
//
//END_FUNCTION_BLOCK