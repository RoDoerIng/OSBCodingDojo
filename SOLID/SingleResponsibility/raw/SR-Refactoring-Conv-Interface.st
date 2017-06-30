
//INTERFACE IMachineState
//(*Init mode for first init cycle during start-up*)
//METHOD isMachineInInitMode :BOOL
//END_METHOD
//
//(*Idle means machine is ready to change to setup or automatic mode*)
//METHOD isMachineInIdle :BOOL
//END_METHOD
//
//(*setup is for manually operated actions*)
//METHOD isMachineInSetup :BOOL
//END_METHOD
//
//(*automatic means machine is running in production*)
//METHOD isMachineInAutomatic :BOOL
//END_METHOD
//
//(*e-stop means machine is in e-stop*)
//METHOD isMachineInEstop :BOOL
//END_METHOD
//
//END_INTERFACE

//INTERFACE IReciverInterface
//(*inject conditions for ready to receive*)
//METHOD readExtCondition2Rec :IReciverInterface
//VAR
//	receiveCondition	:BOOL; //condition 4 ready to receive
//END_VAR
//END_METHOD
//
//METHOD isReceiving	:BOOL
//END_METHOD
//
//END_INTERFACE

//INTERFACE ISenderInterface
//(*inject conditions for ready to receive*)
//METHOD readExtCondition2Snd :ISenderInterface
//VAR
//	sendCondition	:BOOL; //condition 4 ready 2 send
//END_VAR
//END_METHOD
//
//METHOD isSending	:BOOL
//END_METHOD
//
//END_INTERFACE


//INTERFACE ISmema
//
//METHOD setCondition
//VAR_INPUT
//	smemaCondition	:BOOL //must be ture to activate the smema interface
//END_VAR
//END_METHOD
//
//METHOD isTransferActive	:BOOL
//END_METHOD
//
//END_INTERFACE

//FUNCTION_BLOCK SmemaInterface IMPLEMENTS ISmema
//VAR
//	machineStateHndl	:IMachineState; //machine state handler to check if receiving is allowed	
//	partnerIsRdy	    :REFERENCE TO BOOL; //ready signal from the interface partner
//	weAreRdy			:REFERENCE TO BOOL; //ready signal to the interface partner
//	transferCondition	:BOOL; //external condition for transfer is possible
//	maskPartnerIsRdy	:BOOL; //bitmask for partner is ready
//	maskWeAreRdy		:BOOL; //bitmask for we are ready	
//END_VAR
//
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains			:BOOL; // initializing of retain-variable
//	bInCopyCode 			:BOOL; // instance is copied to copy-code
//	//interface signals
//	partnerIsRdy	        :REFERENCE TO BOOL; //ready signal from the interface partner
//	weAreRdy			    :REFERENCE TO BOOL; //ready signal to the interface partner
//	//bit masks
//	maskPartnerIsRdy		:BOOL; //bitmask for partner is ready
//	maskWeAreRdy			:BOOL; //bitmask for we are ready	
//	//machine state
//	machineStateHndl		:IMachineState; //the machine is in machine state automatic
//END_VAR
//	THIS^.partnerIsRdy	    REF= partnerIsRdy;
//	THIS^.weAreRdy		    REF= weAreRdy;
//	THIS^.machineStateHndl	:= 	 machineStateHndl;
//	THIS^.transferCondition	:=	 FALSE;
//	THIS^.maskPartnerIsRdy	:=   maskPartnerIsRdy;
//	THIS^.maskWeAreRdy		:=	 maskWeAreRdy;
//END_METHOD

//METHOD setCondition
//VAR_INPUT
//	transferCondition	:BOOL; //must be ture to activate the smema interface
//END_VAR
//	THIS^.transferCondition	:= transferCondition;
//	IF (NOT THIS^.transferCondition) THEN
//		THIS^.weAreRdy := (NOT THIS^.maskWeAreRdy);
//	END_IF;
//END_METHOD
//
//METHOD isTransferActive	:BOOL
//
//	IF (THIS^.transferCondition AND THIS^.machineStateHndl.isMachineInAutomatic()) THEN
//		THIS^.weAreRdy := THIS^.maskWeAreRdy;
//	ELSE
//		THIS^.weAreRdy := (NOT THIS^.maskWeAreRdy);
//	END_IF;		
//	isTransferActive	  := ((THIS^.weAreRdy = THIS^.maskWeAreRdy) AND (THIS^.maskPartnerIsRdy = THIS^.maskPartnerIsRdy));
//
//END_METHOD
//
//END_FUNCTION_BLOCK

//FUNCTION_BLOCK SmemaReceiver IMPLEMENTS IReciverInterface
//VAR
//	smeaInterface :ISmema; //smema interface for the receiver
//END_VAR
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains			:BOOL; // initializing of retain-variable
//	bInCopyCode 			:BOOL; // instance is copied to copy-code
//	//smems interface
//	smeaInterface :ISmema; //smema interface for the receiver
//END_VAR
//	THIS^.smeaInterface	:= 	 smeaInterface ;
//END_METHOD	

//METHOD readExtCondition2Rec :IReciverInterface
//VAR
//	receiveCondition	:BOOL; //condition 4 ready to receive
//END_VAR
//	THIS^.smeaInterface.setCondition(transferCondition := receiveCondition);
//	readExtCondition2Rec	:= THIS^;
//END_METHOD
//
//METHOD isReceiving	:BOOL
//	isReceiving	  := (THIS^.smeaInterface.isTransferActive();
//END_METHOD
//
//END_FUNCTION_BLOCK

//FUNCTION_BLOCK SmemaSender IMPLEMENTS ISenderInterface
//VAR
//	smeaInterface :ISmema; //smema interface for the sender
//END_VAR
//METHOD FB_INIT
//VAR_INPUT
//	//CODESYS stuff
//	bInitRetains			:BOOL; // initializing of retain-variable
//	bInCopyCode 			:BOOL; // instance is copied to copy-code
//	//smems interface
//	smeaInterface :ISmema; //smema interface for the sender
//END_VAR
//	THIS^.smeaInterface	:= 	 smeaInterface ;
//END_METHOD	
//
//METHOD readExtCondition2Snd :ISenderInterface
//VAR
//	sendCondition	:BOOL; //condition 4 ready 2 send
//END_VAR
//	THIS^.smeaInterface.setCondition(transferCondition := sendCondition);
//	readExtCondition2Snd := THIS^;
//END_METHOD
//
//(*Error*)
//METHOD isSending	:BOOL
//	THIS^.rdy2Snd := (THIS^.sendCondition AND THIS^.machineStateHndl.isMachineInAutomatic());
//	isSending 	  := (THIS^.rdy2Snd AND THIS^.nextConRdy2Rec);
//	isSending	  := (THIS^.smeaInterface.isTransferActive();
//END_METHOD
//
//END_FUNCTION_BLOCK
//