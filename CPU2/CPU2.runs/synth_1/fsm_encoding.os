
 add_fsm_encoding \
       {counter4.count} \
       { }  \
       {{0000 000100} {0111 100000} {1011 010000} {1101 001000} {1110 000010} }

 add_fsm_encoding \
       {ControlUnit.presentState} \
       { }  \
       {{000 000010} {001 000001} {010 010000} {011 001000} {100 100000} }

 add_fsm_encoding \
       {ControlUnit.nextState} \
       { }  \
       {{000 000010} {001 000001} {010 010000} {011 001000} {100 100000} }
