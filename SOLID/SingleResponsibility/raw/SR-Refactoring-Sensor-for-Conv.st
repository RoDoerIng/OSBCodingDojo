
//INTERFACE ISensor
//
//METHOD isOccupied :BOOL
//END_METHOD
//
//METHOD isFree :BOOL
//END_METHOD
//
//END_INTERFACE

//INTERFACE IEdge
//
//METHOD isRising	:BOOL
//END_METHOD
//
//METHOD isFalling :BOOL
//END_METHOD
//
//END_INTERFACE


//FUNCTION_BLOCK DebouncedDigitalSensor IMPLEMENTS ISensor, IEdge
//VAR
//	diSensor			:REFERENCE TO BOOL; //reference to the digital input
//	maskOccupied		:BOOL; //mask for the state occupied
//	debouncer			:TON; //ton to debounce the sensor signal
//	debounceTime		:TIME; //debounce time
//	state				:BOOL; //sensor state 
//END_VAR
//
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains	:BOOL; // initializing of retain-variable
//	bInCopyCode 	:BOOL; // instance is copied to copy-code
//	//the sensor
//	diSensor		:REFERENCE TO BOOL; //reference to the digital input
//	maskOccupied	:BOOL; //mask for the state occupied
//END_VAR
//	THIS^.diSensor		REF=diSensor; 
//	THIS^.maskOccupied	:= maskOccupied;
//	THIS^.debounceTime	:= T#30ms;
//	THIS^.state			:= (THIS^.diSensor = THIS^.maskOccupied);
//END_METHOD

//PROTECTED METHOD isSensorInState :BOOL
//VAR_INPUT
//	state :BOOL; //requeseted sensor state
//END_VAR
//	THIS^.debouncer(IN := (THIS^.diSensor = state), PT := THIS^.debounceTime, Q => isSensorInState);
//END_METHOD
//
//METHOD isOccupied :BOOL
//	isOccupied := isSensorInState(state := THIS^.maskOccupied);
//END_METHOD
//
//METHOD isFree :BOOL
//	isFree := isSensorInState(state := (NOT THIS^.maskOccupied));
//END_METHOD

//PROTECTED METHOD updateState
//	THIS^.state := THIS^.isOccupied();
//END_METHOD

//METHOD isRising	:BOOL
//	isRising 	:= (THIS^.isOccupied() AND (NOT THIS^.state));
//	THIS^.updateState();
//END_METHOD
//
//METHOD isFalling :BOOL
//	isFalling 	:= (THIS^.isFree() AND THIS^.state);
//	THIS^.updateState();
//END_METHOD
//
//END_FUNCTION_BLOCK