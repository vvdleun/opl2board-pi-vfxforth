
\ Constants

0 CONSTANT SPI-CHANNEL
8000000 CONSTANT SPI-SPEED

0 CONSTANT MODULATOR
1 CONSTANT CARRIER
0 CONSTANT OPERATOR-0
1 CONSTANT OPERATOR-1

0 CONSTANT MELODIC
1 CONSTANT RHYTHM

CREATE OPL2-CHANNEL-OFFSETS 0 C, 1 C, 2 C, 8 C, 9 C, $A C, $10 C, $11 C, $12 C,

343 CONSTANT NOTE-C
363 CONSTANT NOTE-C#
385 CONSTANT NOTE-D
408 CONSTANT NOTE-D#
432 CONSTANT NOTE-E
458 CONSTANT NOTE-F
485 CONSTANT NOTE-F#
514 CONSTANT NOTE-G
544 CONSTANT NOTE-G#
577 CONSTANT NOTE-A
611 CONSTANT NOTE-A#
647 CONSTANT NOTE-B

\ Variables

CREATE opl2-registers 256 ALLOT

VARIABLE opl2-temp-value

\ Low-level core functions

: opl2-write {: value reg --  :}
	PIN_ADDR LOW digitalWrite

	reg opl2-temp-value C!

	SPI-CHANNEL opl2-temp-value 1 wiringPiSPIDataRW DROP
	PIN_LATCH LOW digitalWrite
	1 delayMicroseconds
	PIN_LATCH HIGH digitalWrite
	4 delayMicroseconds

	PIN_ADDR HIGH digitalWrite	

	value opl2-temp-value C!

	SPI-CHANNEL opl2-temp-value 1 wiringPiSPIDataRW DROP
	PIN_LATCH LOW digitalWrite
	1 delayMicroseconds
	PIN_LATCH HIGH digitalWrite
	23 delayMicroseconds
;

: opl2-get-register ( reg -- value )
	opl2-registers + C@
;

: opl2-set-register ( value reg -- )
	2DUP opl2-registers + C!
	opl2-write
;

: opl2-register-number ( channel operator baseReg -- reg )
	-ROT 
	SWAP OPL2-CHANNEL-OFFSETS + C@
	SWAP IF 3 + THEN
	+
;

\ Initialization

: opl2-reset ( -- )
	PIN_RESET LOW digitalWrite
	1 MS
	PIN_RESET HIGH digitalWrite

	256 0 DO 0 I opl2-set-register LOOP
;

: opl2-init ( -- )
	wiringPiSetup DROP
	SPI-CHANNEL SPI-SPEED wiringPiSPISetup DROP

	PIN_LATCH OUTPUT pinMode
	PIN_ADDR OUTPUT pinMode
	PIN_RESET OUTPUT pinMode

	PIN_LATCH HIGH digitalWrite
	PIN_RESET HIGH digitalWrite
	PIN_ADDR LOW digitalWrite

	opl2-reset
;

\ OPL2 individual parameters

: opl2-enable-ws ( flag -- )
	1 opl2-get-register
	SWAP IF	$20 OR ELSE	$DF AND THEN
	1 opl2-set-register
;

: opl2-set-multi ( value channel operator -- )
	$20 opl2-register-number >R 
	R@ opl2-get-register $F0 AND SWAP $F AND OR
	R> opl2-set-register
;

: opl2-set-ksr ( value channel operator -- )
	$20 opl2-register-number >R
	R@ opl2-get-register SWAP IF $10 OR ELSE $EF AND THEN
	R> opl2-set-register
;

: opl2-set-eg-typ ( value channel operator -- )
	$20 opl2-register-number >R
	R@ opl2-get-register SWAP IF $20 OR ELSE $DF AND THEN
	R> opl2-set-register
;

: opl2-set-vib ( value channel operator -- )
	$20 opl2-register-number >R
	R@ opl2-get-register SWAP IF $40 OR ELSE $BF AND THEN
	R> opl2-set-register
;

: opl2-set-am ( value channel operator -- )
	$20 opl2-register-number >R
	R@ opl2-get-register SWAP IF $80 OR ELSE $7F AND THEN
	R> opl2-set-register
;

: opl2-set-tl ( value channel operator -- )
	$40 opl2-register-number >R 
	R@ opl2-get-register $C0 AND SWAP $3F AND OR
	R> opl2-set-register
;

: opl2-set-ksl ( value channel operator -- )
	$40 opl2-register-number >R 
	R@ opl2-get-register $3F AND
	SWAP $3 AND $6 LSHIFT OR
	R> opl2-set-register
;

: opl2-set-dr ( value channel operator -- )
	$60 opl2-register-number >R 
	R@ opl2-get-register $F0 AND SWAP $F AND OR
	R> opl2-set-register
;

: opl2-set-ar ( value channel operator -- )
	$60 opl2-register-number >R 
	R@ opl2-get-register $F AND
	SWAP $F AND $4 LSHIFT OR
	R> opl2-set-register
;

: opl2-set-rr ( value channel operator -- )
	$80 opl2-register-number >R 
	R@ opl2-get-register $F0 AND SWAP $F AND OR
	R> opl2-set-register
;

: opl2-set-sl ( value channel operator -- )
	$80 opl2-register-number >R 
	R@ opl2-get-register $F AND
	SWAP $F AND $4 LSHIFT OR
	R> opl2-set-register
;

: opl2-set-ws ( value channel operator -- )
	$E0 opl2-register-number >R 
	R@ opl2-get-register $FC AND SWAP $3 AND OR
	R> opl2-set-register
;

: opl2-set-fm ( value channel -- )
	$C0 + >R
	R@ opl2-get-register SWAP IF $1 OR ELSE $FE AND THEN
	R> opl2-set-register
;

: opl2-set-feedback ( value channel -- )
	$C0 + >R
	R@ opl2-get-register $F1 AND
	SWAP $7 AND $1 LSHIFT OR
	R> opl2-set-register
;

: opl2-set-f-number ( value channel -- )
	>R

	DUP $FF AND $A0 R@ + opl2-set-register

	$B0 R@ + opl2-get-register $FC AND
	SWAP $300 AND $8 RSHIFT OR
	$B0 R> + opl2-set-register
;

: opl2-set-block ( value channel -- )
	$B0 + >R
	R@ opl2-get-register $E3 AND
	SWAP $7 AND $2 LSHIFT OR
	R> opl2-set-register
;

: opl2-set-key ( value channel -- )
	$B0 + >R
	R@ opl2-get-register SWAP IF $20 OR ELSE $DF AND THEN
	R> opl2-set-register
;

: opl2-set-hh ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $1 OR ELSE $FE AND THEN
	R> opl2-set-register
;

: opl2-set-cy ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $2 OR ELSE $FD AND THEN
	R> opl2-set-register
;

: opl2-set-tom ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $4 OR ELSE $FB AND THEN
	R> opl2-set-register
;

: opl2-set-sd ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $8 OR ELSE $F7 AND THEN
	R> opl2-set-register
;

: opl2-set-bd ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $10 OR ELSE $EF AND THEN
	R> opl2-set-register
;

: opl2-set-mode ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $20 OR ELSE $DF AND THEN
	R> opl2-set-register
;

: opl2-set-vib-depth ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $40 OR ELSE $8F AND THEN
	R> opl2-set-register
;

: opl2-set-am-depth ( value -- )
	$BD >R
	R@ opl2-get-register SWAP IF $80 OR ELSE $7F AND THEN
	R> opl2-set-register
;