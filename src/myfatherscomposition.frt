INCLUDE "config.frt"
INCLUDE "include/wiringpi.frt"
INCLUDE "include/opl2.frt"

opl2-init

1 opl2-enable-ws

MELODIC opl2-set-mode

0 0 opl2-set-fm

: play-chord ( note1 oct1 note2 oc2 note3 oc3 delay -- )
	>R

	3 0 DO
		I opl2-set-block
		I opl2-set-f-number
		1 I opl2-set-key
	LOOP

	R> MS

	3 0 DO
		0 I opl2-set-key
	LOOP
;

: song

	8 0 DO
		15 I CARRIER opl2-set-ar
		1 I CARRIER opl2-set-dr
		15 I CARRIER opl2-set-sl
		5 I CARRIER opl2-set-rr
		1 I CARRIER opl2-set-eg-typ
		1 I CARRIER opl2-set-ksr
		1 I CARRIER opl2-set-multi
		1 I CARRIER opl2-set-vib
		0 I CARRIER opl2-set-tl
		1 I CARRIER opl2-set-ksl
		0 I CARRIER opl2-set-am
		0 I CARRIER opl2-set-ws
		
		8 I MODULATOR opl2-set-ar
		1 I MODULATOR opl2-set-dr
		15 I MODULATOR opl2-set-sl
		3 I MODULATOR opl2-set-rr
		1 I MODULATOR opl2-set-eg-typ
		0 I MODULATOR opl2-set-ksr
		51 I MODULATOR opl2-set-multi
		1 I opl2-set-feedback
		1 I MODULATOR opl2-set-vib
		18 I MODULATOR opl2-set-tl
		3 I MODULATOR opl2-set-ksl
		0 I MODULATOR opl2-set-am
		0 I MODULATOR opl2-set-ws
	LOOP

	4 0 DO

		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		
		500 MS
		
		NOTE-D 3 NOTE-F 3 NOTE-A 3 500 play-chord
		NOTE-D 3 NOTE-F 3 NOTE-A 3 500 play-chord
		NOTE-D 3 NOTE-F 3 NOTE-A 3 500 play-chord
		
		500 MS
		
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		
		NOTE-B 2 NOTE-D 3 NOTE-F 3 500 play-chord
		NOTE-B 2 NOTE-D 3 NOTE-F 3 500 play-chord
		
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		NOTE-C 3 NOTE-E 3 NOTE-G 3 500 play-chord
		NOTE-C 3 NOTE-E 3 NOTE-G 3 1000 play-chord
	LOOP

	BYE
;

song
