            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry                 ; Application entry point
 
RAMStart    EQU  	$2000
RAMEnd     EQU       $3FFF
ROMStart    EQU       $8000  

   	ORG  	RAMStart
    ; Data definition goes here
            
TdegC ds.w 1

Entry:
_Startup:

TdegF EQU $88
           LDAA #-32    ;load accumulator A to neg 32
           ADDA #TdegF  ;add to Tdeg F
           BMI NEGRES
           
           LDAB #5      ;load accumulator B to 5
           MUL          ;multiply A x B - stored in D
           LDX #9       ;load register X with 9
           IDIV         ;divide D/X
           STX TdegC    ;store result in TdegC           
           
L1:        bra L1       ;end program
        
NEGRES:    LDAB #5      ;load accumulator B to 5
           MUL          ;multiply A x B - stored in D
           CLRA         ;clear accumulator A
           COMB         ;2s accumulator B 
           LDX #9       ;load register X with 9
           IDIV         ;divide D/X
           XGDX         ;swap X and D for EMUL
           LDY #-1      ;set Y to -1 to restore negative
           EMUL         ;multiply DxY - stored in D
           STD TdegC    ;store negative value in TdegC
                   
           bra L1
           
           

           
        
                               



;************************************************
;*                 Interrupt Vectors                          *
;************************************************
            ORG   		$FFFE
            DC.W  	Entry           ; Reset Vector                      
