
//INTERFACE IRunnable
//
//METHOD run
//END_METHOD
//
//END_INTERFACE

//FUNCTION_BLOCK Conveyor2ndTry IMPLEMENTS IRunnable
//VAR
//	//sensors
//	slowSensor			:ISensor; //sensor to slow down
//	stopSensor			:ISensor; //sensor to stop
//	//interfaces
//	senderInterface		:ISenderInterface; //interface to send
//	receiverInterface	:IReciverInterface; //interface to receive
//	//conveyor drive
//	drive 				:ITwoStageLinearDrive; //drive to run the conveyor
//	//machine state
//	machineState		:IMachineState; //just the machine state
//END_VAR
//
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains		:BOOL; // initializing of retain-variable
//	bInCopyCode 		:BOOL; // instance is copied to copy-code
//	//sensors
//	slowSensor			:ISensor; //sensor to slow down
//	stopSensor			:ISensor; //sensor to stop
//	//interfaces
//	senderInterface		:ISenderInterface; //interface to send
//	receiverInterface	:IReciverInterface; //interface to receive
//	//conveyor drive
//	drive 				:ITwoStageLinearDrive; //drive to run the conveyor
//	//machine state
//	machineState		:IMachineState; //just the machine state
//END_VAR
//	//sensors
//	THIS^.slowSensor	    := slowSensor; //sensor to slow down
//	THIS^.stopSensor	    := stopSensor; //sensor to stop
//	//interfaces
//	THIS^.senderInterface	:= senderInterface	; //interface to send
//	THIS^.receiverInterface	:= receiverInterface; //interface to receive
//	//conveyor drive
//	THIS^.drive 			:= drive; //drive to run the conveyor
//	//machine state
//	THIS^.machineState		:= machineState; //just the machine state
//END_METHOD	
	
//METHOD isEmpty	:BOOL
//	isEmpty := (THIS^.slowSensor.isFree() AND THIS^.stopSensor.isFree());
//END_METHOD
//
//METHOD isAligned :BOOL
//	isAligned := (THIS^.slowSensor.isOccupied() AND THIS^.stopSensor.isOccupied());
//END_METHOD
//
//METHOD isOccupiedInfeed :BOOL
//	isOccupiedInfeed := (THIS^.slowSensor.isOccupied() AND THIS^.stopSensor.isFree());
//END_METHOD
//
//METHOD isOccupiedOutfeed :BOOL
//	isOccupiedOutfeed := (THIS^.slowSensor.isFree() AND THIS^.stopSensor.isOccupied());
//END_METHOD
//
//METHOD run
//	(*recive part*)
//	IF (THIS^.receiverInterface.readExtCondition2Rec(receiveCondition := THIS^.isEmpty()).isReceiving()) THEN
//		THIS^.drive.fastForward();
//	(*send part*)
//	ELSIF (THIS^.senderInterface.readExtCondition2Snd(sendCondition := (THIS^.isAligned() OR THIS^.isOccupiedOutfeed())).isSending()) THEN
//		THIS^.drive.fastForward();
//	(*align part*)
//	ELSIF (THIS^.isOccupiedInfeed() AND THIS^.machineState.isMachineInAutomatic()) THEN
//		THIS^.drive.forward();
//	ELSE
//		THIS^.drive.stop();
//	END_IF
//END_METHOD
//
//END_FUNCTION_BLOCK