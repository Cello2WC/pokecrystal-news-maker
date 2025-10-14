;include "news_macros.asm"
	const_def

	const nsc_nop_command	; 00
MACRO nsc_nop
	db nsc_nop_command
ENDM

		; page address
	const nsc_page_command	; 01
MACRO nsc_page
	db nsc_page_command
	dw \1 - openingScreen
ENDM

		; music id
	const nsc_playmusic_command	; 02
MACRO nsc_playmusic
	db nsc_playmusic_command
	db \1
ENDM

		; sfx id
	const nsc_playsound_command	; 03
MACRO nsc_playsound
	db nsc_playsound_command
	db \1
ENDM

		; cry id
	const nsc_playcry_command	; 04
MACRO nsc_playcry
	db nsc_playcry_command
	db \1
ENDM

DEF NEWSBORDER_NONE     EQU 0
DEF NEWSBORDER_STRIPED  EQU 1
DEF NEWSBORDER_GLOWY    EQU 2
DEF NEWSBORDER_BLOCKY   EQU 3
DEF NEWSBORDER_BUBBLE   EQU 4
DEF NEWSBORDER_INVERTED EQU 5
		; x, y, w, h, border
	const nsc_drawbox_command	; 05
MACRO nsc_drawbox
	db nsc_drawbox_command
	db \1, \2, \3, \4, \5
ENDM

	const nsc_printstring_command	; 06
MACRO nsc_printstring
	db nsc_printstring_command
	news_coord \1, \2
	relativepointer \3
ENDM
	
	const nsc_printezchat_command	; 07
MACRO nsc_printezchat
	db nsc_printezchat_command
	news_coord \1, \2
	dw \3
ENDM

	const nsc_08_command	; 08
MACRO nsc_08 ; 
	db nsc_08_command
	; TODO
	; copy null-terminated stream from w4_d000 + \1 to wcc60
	; i believe this should be the offset of an ASCII URL
	; the downloaded file is expected to be 512 bytes or less, saved to w3_de00
	dw \1
IF _NARG > 1
	db BANK(\2) ; [W/S]RAM bank, $FF to disable \2 to wc608 transfer
	dw \2 ; addr
	db \3 ; len to copy from \2 to wc608
ELSE
	db $FF, $00, $00, $00
ENDC
	; then copies same length of data from wc608 to w3_d000, if \2 to wc608 transfer occurred
	; (in short, \2[0..\3] ends up at w3_d000)
	; this length is saved to wcd3b
	; cf66 is set to 0
	
	; and all of this seems to be to get this data in front of Function118329
	; whatever this does involves the pichu animation
	
	; calls Function17e349 on success (mobileerrorcode $0 or $A), Function17e309 on error
ENDM
	
	const nsc_09_command	; 09
MACRO nsc_09
	db nsc_09_command
	; TODO
	dw \1	; offset from w4_d000 of an ASCII URL to copy to wcc60
	; ends up calling HttpGetIndexFile
	
ENDM
	
		; x, y, pic id, anim type, pal id
	const nsc_drawmon_command	; 0a
MACRO nsc_drawmon
	db nsc_drawmon_command
	news_coord \1, \2
	db \3, \4, \5
ENDM

		; x, y, pic id, pal id
	const nsc_drawtrainer_command	; 0b
MACRO nsc_drawtrainer
	db nsc_drawtrainer_command
	news_coord \1, \2
	db \3, \4
ENDM

		; from, to_symb, size
	const nsc_ramcopy_command	; 0c
MACRO nsc_ramcopy
	db nsc_ramcopy_command
	dw \1, \2
	db BANK(\2)
	dw \3
ENDM

MACRO nsc_ramcopy_newsvar
	db nsc_ramcopy_command
	dw \1, \2+$A000
	db 6
	dw \3
ENDM

DEF FLAG_SET EQU 0
DEF FLAG_CLEAR EQU %1000_0000
		; symbol, flag, operation
	const nsc_flagop_command	; 0d
MACRO nsc_flagop
	db nsc_flagop_command
	dw \1
	db BANK(\1), (\2) | (\3)
ENDM

	const nsc_up_command	; 0e
MACRO nsc_up
	db nsc_up_command
ENDM

	const nsc_down_command	; 0f
MACRO nsc_down
	db nsc_down_command
ENDM

	const nsc_right_command	; 10
MACRO nsc_right
	db nsc_right_command
ENDM

	const nsc_left_command	; 11
MACRO nsc_left
	db nsc_left_command
ENDM

	; 12 and 13 move the cursor, but im not entirely sure how
	const nsc_12_command	; 12
MACRO nsc_12
	db nsc_12_command
	; TODO
ENDM

	const nsc_13_command	; 13
MACRO nsc_13
	db nsc_13_command
	; TODO
ENDM

		; x, y, yesptr, noptr
	const nsc_yesno_command	; 14
MACRO nsc_yesno
	db nsc_yesno_command
	db \1, \2
	relativepointer \3, \4
ENDM

	const nsc_black_command	; 15
MACRO nsc_black
	db nsc_black_command
ENDM

	const nsc_white_command	; 16
MACRO nsc_white
	db nsc_white_command
ENDM

	const nsc_select_command	; 17
MACRO nsc_select
	db nsc_select_command
ENDM

		; x, y, ptr
	const nsc_textbox_command	; 18
MACRO nsc_textbox
	db nsc_textbox_command
	news_coord \1, \2
	relativepointer \3
ENDM

		; x, y, w, h
	const nsc_clear_command	; 19
MACRO nsc_clear
	db nsc_clear_command
	news_coord \1, \2
	db \3, \4
ENDM

		; string, lessptr, equptr, gtrptr, len, string
	const nsc_compare_command	; 1a
MACRO nsc_compare
	db nsc_compare_command
	db BANK(\1)
	dw \1
	relativepointer \2, \3, \4
	db \5
	;db \6
REPT _NARG - 5
	db \6
	shift 1
ENDR
ENDM

		; string, lessptr, equptr, gtrptr, len, string
MACRO nsc_compare_newsvar
	db nsc_compare_command
	db 6
	dw \1 + $A000
	relativepointer \2, \3, \4
	db \5
	;db \6
REPT _NARG - 5
	db \6
	shift 1
ENDR
ENDM

		; symbol, bit, trueptr, falseptr
	const nsc_bit_command	; 1b
MACRO nsc_bit
	db nsc_bit_command
	db BANK(\1)
	dw \1
	db \2
	relativepointer \3, \4
ENDM

		; symbol, bit, trueptr, falseptr
MACRO nsc_bit_newsvar
	db nsc_bit_command
	db 6
	dw \1 + $A000
	db \2
	relativepointer \3, \4
ENDM

		; stringptr, lessptr, equptr, gtrptr, len, string
	const nsc_localcompare_command	; 1c
MACRO nsc_localcompare
	db nsc_localcompare_command
	dw \1
	relativepointer \2, \3, \4
	db \5
REPT _NARG - 5
	db \6
	shift 1
ENDR
ENDM

		; address, bit, trueptr, falseptr
	const nsc_localbit_command	; 1d
MACRO nsc_localbit
	db nsc_localbit_command
	dw \1
	db \2
	relativepointer \3, \4
ENDM

DEF GIVEMON_NONE EQUS ""
DEF GIVEMON_NOBOX  EQU 0
DEF GIVEMON_CANBOX EQU %00000001
DEF GIVEMON_NICK   EQU %00000010
DEF GIVEMON_OT     EQU %00000100
DEF GIVEMON_OTID   EQU %00001000
DEF GIVEMON_DV     EQU %00010000
DEF GIVEMON_ITEM   EQU %00100000
DEF GIVEMON_MOVES  EQU %01000000
		; there are 31 bytes of arguments....
		;  1   : species
		;  2   : level
		;  3   : flags
		;  4-10: nickname  (skipped over if NICK flag unset)
		; 11-17: OT name   (skipped over if OT flag unset)
		; 18   : OT gender (skipped over if OT flag unset)
		; 19-20: OT ID     (skipped over if OTID flag unset)
		; 21-22: DVs       (skipped over if DV flag unset)
		; 23   : held item (skipped over if ITEM flag unset)
		; 24-27: moves     (skipped over if MOVES flag unset)
		; 28-29: partied pointer
		; 30-31: boxed or failed pointer (?????)
		
		; \1  - species
		; \2  - level
		; \3  - flags (user only has to worry about GIVEMON_CANBOX)
		; \4  - nickname,   or GIVEMON_NONE
		; \5  - OT name,    or GIVEMON_NONE
		; \6  - OT gender,  or GIVEMON_NONE
		; \7  - OT ID,      or GIVEMON_NONE
		; \8  - DVs,        or GIVEMON_NONE
		; \9  - held item,  or GIVEMON_NONE
		; \10 - move 1,     or GIVEMON_NONE
		; \11 - move 2
		; \12 - move 3
		; \13 - move 4
		; \14 - partied pointer
		; \15 - boxed or failed pointer
		
		; example:
		; nsc_givemon CELEBI, 100, GIVEMON_CANBOX, "ONION", "TIMEMAN", MALE, 01234, $FAAA, POKE_FLUTE, GIVEMON_NONE, GIVEMON_NONE, GIVEMON_NONE, GIVEMON_NONE, .success, .boxed_or_fail
	const nsc_givemon_command	; 1e
MACRO nsc_givemon
	db nsc_givemon_command
	
	db \1
	db \2
DEF _GIVEMON_FLAGS = \3

DEF _GIVEMON_NICK = \4
IF \4 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_NICK
ENDC

DEF _GIVEMON_OT = \5
IF \5 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_OT
DEF _GIVEMON_GENDER = \6
ELSE
DEF _GIVEMON_GENDER = 0
ENDC

IF \7 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_OTID
DEF _GIVEMON_OTID = \7
ELSE
DEF _GIVEMON_OTID = 0
ENDC

IF \8 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_DV
DEF _GIVEMON_DVS = \8
ELSE
DEF _GIVEMON_DVS = 0
ENDC

IF \9 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_ITEM
DEF _GIVEMON_ITEM = \9
ELSE
DEF _GIVEMON_ITEM = NO_ITEM
ENDC

SHIFT 9

IF \1 != GIVEMON_NONE
DEF _GIVEMON_FLAGS = _GIVEMON_FLAGS | GIVEMON_MOVES
DEF _GIVEMON_MOVE_1 = \1
DEF _GIVEMON_MOVE_2 = \2
DEF _GIVEMON_MOVE_3 = \3
DEF _GIVEMON_MOVE_4 = \4
ELSE
DEF _GIVEMON_MOVE_1 = NO_MOVE
DEF _GIVEMON_MOVE_2 = NO_MOVE
DEF _GIVEMON_MOVE_3 = NO_MOVE
DEF _GIVEMON_MOVE_4 = NO_MOVE
ENDC


	db _GIVEMON_FLAGS
PURGE _GIVEMON_FLAGS
	
	db _GIVEMON_NICK
IF DEF(_LANG_J)
REPT NAME_LENGTH_JAPANESE - CHARLEN(_GIVEMON_NICK)
	db "@"
ENDR
ELSE
REPT NAME_LENGTH - CHARLEN(_GIVEMON_NICK)
	db "@"
ENDR
ENDC
	
	db _GIVEMON_OT
IF DEF(_LANG_J)
REPT NAME_LENGTH_JAPANESE - CHARLEN(_GIVEMON_NICK)
	db "@"
ENDR
ELSE
REPT PLAYER_NAME_LENGTH - CHARLEN(_GIVEMON_OT)
	db "@"
ENDR
ENDC
	db _GIVEMON_GENDER
PURGE _GIVEMON_GENDER
	dw _GIVEMON_OTID
PURGE _GIVEMON_OTID
	dw _GIVEMON_DVS
PURGE _GIVEMON_DVS
	db _GIVEMON_ITEM
PURGE _GIVEMON_ITEM
	db _GIVEMON_MOVE_1
	db _GIVEMON_MOVE_2
	db _GIVEMON_MOVE_3
	db _GIVEMON_MOVE_4
PURGE _GIVEMON_MOVE_1
PURGE _GIVEMON_MOVE_2
PURGE _GIVEMON_MOVE_3
PURGE _GIVEMON_MOVE_4

	relativepointer \5, \6

ENDM

		; item, quantity, trueptr, falseptr
	const nsc_giveitem_command	; 1f
MACRO nsc_giveitem
	db nsc_giveitem_command
IF _NARG == 3
	db \1, 1
	relativepointer \2, \3
ELSE
	db \1, \2
	relativepointer \3, \4
ENDC
ENDM

		; species, trueptr, falseptr
	const nsc_checkmon_command	; 20
MACRO nsc_checkmon
	db nsc_checkmon_command
	db \1
	relativepointer \2, \3
ENDM

		; item, trueptr, falseptr
	const nsc_checkitem_command	; 21
MACRO nsc_checkitem
	db nsc_checkitem_command
	db \1
	relativepointer \2, \3
ENDM

		; str1, len, str2, lessptr, equptr, gtrptr
	const nsc_compareram_command	; 22
MACRO nsc_compareram
	db nsc_compareram_command
	db BANK(\1)
	dw \1
	db \2
	
	db BANK(\3)
	dw \3
	
	relativepointer \4, \5, \6
ENDM

		; addr, val
	const nsc_set_command	; 23
MACRO nsc_set
	db nsc_set_command
	dw \1
	db \2
ENDM

		; addr, val
	const nsc_add_command	; 24
MACRO nsc_add
	db nsc_add_command
	dw \1
	db \2
ENDM

		; addr, val
	const nsc_sub_command	; 25
MACRO nsc_sub
	db nsc_sub_command
	dw \1
	db \2
ENDM

		; addr, addr
	const nsc_addram_command	; 26
MACRO nsc_addram
	db nsc_addram_command
	dw \1
	dw \2
ENDM

		; addr, addr
	const nsc_subram_command	; 27
MACRO nsc_subram
	db nsc_subram_command
	dw \1
	dw \2
ENDM

	const nsc_update_rankings_command	; 28
MACRO nsc_update_rankings
	db nsc_update_rankings_command
ENDM

	const nsc_save_command	; 29
MACRO nsc_save
	db nsc_save_command
ENDM

	const nsc_savetrade_command	; 2a
MACRO nsc_savetrade
	db nsc_savetrade_command
ENDM

	const nsc_savebox_command	; 2b
MACRO nsc_savebox
	db nsc_savebox_command
ENDM

	const nsc_savechecksum_command	; 2c
MACRO nsc_savechecksum
	db nsc_savechecksum_command
ENDM

	const nsc_saverankchecksum_command	; 2d
MACRO nsc_saverankchecksum
	db nsc_saverankchecksum_command
ENDM

	const nsc_delay_command	; 2e
MACRO nsc_delay
	db nsc_delay_command
	db \1
ENDM

	const nsc_waitbutton_command	; 2f
MACRO nsc_waitbutton
	db nsc_waitbutton_command
ENDM

	const nsc_exit_command	; 30
MACRO nsc_exit
	db nsc_exit_command
ENDM
	
; any non-FF command ID after this point results in a freeze due to....
; bounds checking?? in MY game freak code???

DEF nsc_ret_command EQU $FF
MACRO nsc_ret
	db nsc_ret_command
ENDM
