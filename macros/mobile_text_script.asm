

;DEF nts_start_command EQU $15
MACRO nts_start
	db "<MOBILE>"
ENDM

;DEF nts_end_command EQU $50
MACRO nts_end
	db "@"
ENDM

	const_def $01
	
	const nts_ranking_number_command ; 01
	; \1: offset
	; \2: Bits 0-4 = # bytes
	;     Bit 7 = set if leading zeroes
	; \3: Number of digits
	; \4: Horizontal space
	; \5: Separator place
	; \6: Separator char
MACRO nts_ranking_number
	db nts_ranking_number_command
	dw \1
	db \2, \3
IF _NARG < 4
	db \3
ELSE
	db \4
ENDC
IF _NARG < 6
	db 0, 0
ELSE
	db \5, \6
ENDC
	
ENDM

	const nts_ranking_string_command ; 02
	; \1: offset
	; \2: len
	; \3: horiz. space
MACRO nts_ranking_string
	db nts_ranking_string_command
	dw \1
	db \2
	db \3
ENDM

	const nts_ranking_ezchat_command ; 03
	; \1: offset
MACRO nts_ranking_ezchat
	db nts_ranking_ezchat_command
	dw \1
ENDM

	const nts_ranking_region_command ; 04
	; \1: offset
	; \2: horiz. space
MACRO nts_ranking_region
	db nts_ranking_region_command
	dw \1
	db \2
ENDM

	const nts_ranking_pokemon_command ; 05
	; \1: offset
	; \2: horiz. space
MACRO nts_ranking_pokemon
	db nts_ranking_pokemon_command
	dw \1
	db \2
ENDM

	const nts_ranking_gender_command ; 06
	; \1: offset
	; \2: horiz. space
MACRO nts_ranking_gender
	db nts_ranking_gender_command
	dw \1
	db \2
ENDM

	const nts_ranking_item_command ; 07
	; \1: offset
	; \2: horiz. space
MACRO nts_ranking_item
	db nts_ranking_item_command
	dw \1
	db \2
ENDM

	const nts_placement_command ; 08
	; \1: num. digits
	; \2: horiz. space
MACRO nts_placement
	db nts_placement_command
	db \1
	db \2
ENDM

	const nts_player_name_command ; 09
	; \1 = blank space left after name???
MACRO nts_player_name
	db nts_player_name_command
	db \1
ENDM

	DEF NTS_USEBACKUP EQU $80
	const nts_player_region_command ; 0a
	; \1 = whether to grab from SRA1 (bit 7 unset) or SRA5 (bit 7 set)
MACRO nts_player_region
	db nts_player_region_command
IF _NARG > 0
	db \1
ELSE
	db 0
ENDC
ENDM

MACRO nts_player_region_backup
	db nts_player_region_command
	db NTS_USEBACKUP
ENDM

	const nts_player_zip_command ; 0b
	; \1 = whether to grab from SRA1 (bit 7 unset) or SRA5 (bit 7 set)
	; \1 = space after zip (lower 4 bits)
MACRO nts_player_zip
	db nts_player_zip_command
	db \1
ENDM

MACRO nts_player_zip_backup
	db nts_player_zip_command
	db \1 | NTS_USEBACKUP
ENDM

	const nts_player_ezchat_command ; 0c
MACRO nts_player_ezchat
	db nts_player_ezchat_command
ENDM

	const nts_switch_command ; 0d
	; match {\1} {
	;     0 => {\2}	
	;     1 => {\3}	
	;     2 => {\4}	
	;     3 => {\5}
	;     ...
	; }
MACRO nts_switch
	db nts_switch_command
	db _NARG - 1
	dw \1
REPT _NARG - 1
	dw \2 - currentScreen
	shift 1
ENDR
ENDM

	const nts_next_command ; 0e
	; \1 = horiz. space
MACRO nts_next
	db nts_next_command
	db \1
ENDM

	const nts_number_command ; 0f
	; \1: Symbol
	; \2: Bits 0-4 = # bytes
	;     Bit 7 = set if leading zeroes 
	;     ^ possibly bugged? not checked for high bit when 
	;       used for length for copying to ram....
	; \3: Number of digits
	; \4: Horizontal space
	; \5: Separator place
	; \6: Separator char
MACRO nts_number
	db nts_number_command
	db BANK(\1)
	dw \1
	db \2, \3
IF _NARG < 4
	db \3
ELSE
	db \4
ENDC
IF _NARG < 6
	db 0, 0
ELSE
	db \5, \6
ENDC
	
ENDM

	const nts_number_dupe_command ; 00
MACRO nts_number_dupe
	db nts_number_dupe_command
	db BANK(\1)
	dw \1
	db \2, \3
IF _NARG < 4
	db \3
ELSE
	db \4
ENDC
IF _NARG < 6
	db 0, 0
ELSE
	db \5, \6
ENDC
ENDM