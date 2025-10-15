IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1
DEF NUM_MINIGAMES EQU 2

DEF wSolutionInvalid EQUS "wNewsScratch0"
DEF wCurrentMove     EQUS "wNewsScratch1"
DEF wCurrentPuzzle   EQUS "wNewsScratch2"

MACRO minigame_start

	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro



	nsc_set wSolutionInvalid, 0
	nsc_set wCurrentPuzzle, 0
	;nsc_set wQuizScore, 0
	nsc_page MinigameStart
	
	
	
.gameIntroText
	lang_text J, "じゅうじボタンを　つかって"
	lang_line J, "さんかく　の　カーソルを　うごかし"
	lang_cont J, "がめんに　ばらばらに　ならんだ"
	lang_cont J, "ポケモンの　なまえの　もじを"
	lang_cont J, "ただしい　なまえの　じゅんばんで"
	lang_cont J, "たどって　いきます"
	lang_para J, "なまえが　とちゅうで　きれたり"
	lang_line J, "おなじ　もじを　２ど　とおったり"
	lang_cont J, "しないように　ちゅうい　してね！"
	lang_para J, "スタートのマークの　×　から"
	lang_line J, "ゴールのマークの　！　に　いけたら"
	lang_cont J, "エーボタンを　おして"
	lang_cont J, "こたえあわせを　して　みよう"
	lang_cont J, "それでは　スタート！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Use the D-PAD to" ; would they have called it a D-PAD?
	lang_line E, "move the triangle"
	lang_cont E, "cursor across the"
	lang_cont E, "screen where parts"
	lang_cont E, "of #MON names"
	lang_cont E, "are scattered."
	lang_para E, "Trace them in"
	lang_line E, "order to spell the"
	lang_cont E, "#MON's name."
	lang_para E, "Don't go out of"
	lang_line E, "order, or use the"
	lang_cont E, "same tile twice!"
	lang_para E, "If you can get"
	lang_line E, "from the start"
	lang_cont E, "mark [×] to the"
	lang_cont E, "goal mark [!],"
	lang_cont E, "press the A BUTTON"
	lang_cont E, "to check your"
	lang_cont E, "answer!"
	lang_para E, "So, let's start!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

	
;	nsc_clear 1, 13, 18, 4
;	nsc_textbox 1, 14, PokemonMazeEasy.introText
ENDM

MACRO minigame_start_2
	nsc_set wSolutionInvalid, 0
	nsc_set wCurrentPuzzle, 0
	;nsc_set wQuizScore, 0
	nsc_page PokemonMazeHard
	
;	nsc_clear 1, 13, 18, 4
;	nsc_textbox 1, 14, PokemonMazeEasy.introText
ENDM

MACRO minigame_name
	lang J, "ポケモンもじめいろ　かんたん"
	lang E, "<PKMN> NAME MAZE EASY"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

MACRO minigame_name_2
	lang J, "ポケモンもじめいろ　むずかしい"
	lang E, "<PKMN> NAME MAZE HARD"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

MACRO minigame_desc
	lang      J, "？"
	
	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang S, "?"
ENDM

MACRO minigame_desc_2
	lang      J, "？"
	
	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang S, "?"
ENDM

ELSE




MinigameStart::
	news_screen PokemonMazeEasy, MUSIC_SHOW_ME_AROUND
	news_def_pals

	news_def_boxes
	news_box 0, 12, 20, 6, NEWSBORDER_GLOWY, 4
	
	
	news_def_strings
	news_string 0, 0, "@" ; potentially label or instructions here
	
IF DEF(_LANG_J)
	news_menu  6, 4, 4, 4, 2, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
ELSE
	news_menu  3, 4, 4, 4, 4, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
ENDC
	
	news_buttonscript .checkEasy   ; script pointer a button
	news_buttonscript Quit        ; script pointer b button
	news_buttonscript .resetPuzzle ; script pointer select button
	news_buttonscript .checkEasy   ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript .upButton    ; script pointer up button
	news_buttonscript .downButton  ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   \
	.puzzleGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX
	
	news_menuitem_scripts  \
	.scr00, .scr01, .scr02, .scr03, \
	.scr04, .scr05, .scr06, .scr07, \
	.scr08, .scr09, .scr10, .scr11, \
	.scr12, .scr13, .scr14, .checkAnswer
REPT 4 * 4
	news_menuitem_descs   .menuDescName
ENDR







.upButton
	nsc_compare wNewsMenuCursorY, .nothing, .nothing, .upButton_continue, 1, 1
.upButton_continue
	nsc_set wCurrentMove, UP
	nsc_select
	nsc_up
	nsc_ret
.downButton
	nsc_compare wNewsMenuCursorY, .downButton_continue, .nothing, .nothing, 1, 4
.downButton_continue
	nsc_set wCurrentMove, DOWN
	nsc_select
	nsc_down
	nsc_ret
.rightButton
	nsc_compare wNewsMenuCursorX, .rightButton_continue, .nothing, .nothing, 1, 4
.rightButton_continue
	nsc_set wCurrentMove, RIGHT
	nsc_select
	nsc_right
	nsc_ret
.leftButton
	nsc_compare wNewsMenuCursorX, .nothing, .nothing, .leftButton_continue, 1, 1
.leftButton_continue
	nsc_set wCurrentMove, LEFT
	nsc_select
	nsc_left
	nsc_ret


.resetPuzzle
	nsc_white
	nsc_playsound SFX_WARP_FROM
	nsc_set wSolutionInvalid, 0
	nsc_page currentScreen
	nsc_ret
	
.checkEasy
	nsc_compare wNewsMenuCursorX, .nothing, .checkAnswer, .nothing, 2, 4, 4
.checkAnswer
	;nsc_playsound SFX_TRANSACTION	
	nsc_compare wSolutionInvalid, .resetPuzzle, .pass, .resetPuzzle, 1, 0
.pass
	nsc_playsound SFX_TRANSACTION
	nsc_add wCurrentPuzzle, 1
	nsc_compare wCurrentPuzzle, .nextPuzzle, .gift, .gift, 1, 5 ; 5 easy puzzles
.nextPuzzle
	nsc_page currentScreen
.nothing
	nsc_ret
	
.gift
	nsc_bit_newsvar sMinigameFlag, 0, .noGift, .giveGift
.giveGift	
	;nsc_give_item BLUESKYMAIL, 3, 
	nsc_giveitem TM_ROLLOUT, .recordGift, .noGift
.recordGift
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .getGiftText
	nsc_flagop sMinigameFlag, 0, FLAG_SET
	nsc_playsound SFX_GET_TM
	nsc_waitbutton
.noGift
	nsc_page NewsRoot ; TODO: maze selection?
	
.getGiftText
	lang_text J, "わざマシン０４を　もらった！"
	
	lang_text E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM04."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
	
	
	
.scrUP
	; tile where correct direction is up
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, UP
.scrDN
	; tile where correct direction is down
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, DOWN
.scrLF
	; tile where correct direction is right
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, LEFT
.scrRT
	; tile where correct direction is left
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, RIGHT
	
	
.scrXX
	nsc_set wSolutionInvalid, 1
.valid
	; for fun!
	; but also audio feedback to let the player
	; know that the game is registering every
	; d-pad button press.
	nsc_playsound SFX_STOP_SLOT
	nsc_ret
	
MACRO lang_def
IF DEF(_LANG_\1)
DEF \2 EQUS \3
ENDC
ENDM

.textMARILL
	lang J, "『マリル』"
	lang E, "MARILL"
	lang D, "MARILL"
	lang F, "MARILL"
	lang I, "MARILL"
	lang S, "MARILL"
	db "@"
	
	lang_def J, MARILL_MA, "マ"
	lang_def E, MARILL_MA, "MA"
	lang_def D, MARILL_MA, "MA"
	lang_def F, MARILL_MA, "MA"
	lang_def I, MARILL_MA, "MA"
	lang_def S, MARILL_MA, "MA"
	
	lang_def J, MARILL_RI, "リ"
	lang_def E, MARILL_RI, "RI"
	lang_def D, MARILL_RI, "RI"
	lang_def F, MARILL_RI, "RI"
	lang_def I, MARILL_RI, "RI"
	lang_def S, MARILL_RI, "RI"

	lang_def J, MARILL_LL, "ル"
	lang_def E, MARILL_LL, "LL"
	lang_def D, MARILL_LL, "LL"
	lang_def F, MARILL_LL, "LL"
	lang_def I, MARILL_LL, "LL"
	lang_def S, MARILL_LL, "LL"
	

.textMUUMA
	lang J, "『ムウマ』"
	lang E, "GASTLY"
	lang D, "?"
	lang F, "FEUFOREVE"
	lang I, "GASTLY"
	lang S, "GASTLY"
	db "@"

	lang_def J, MUUMA_MU, "ム"
	lang_def E, MUUMA_MU, "GA"
	lang_def D, MUUMA_MU, "1?"
	lang_def F, MUUMA_MU, "FEU"
	lang_def I, MUUMA_MU, "GA"
	lang_def S, MUUMA_MU, "GA"

	lang_def J, MUUMA_UU, "ウ"
	lang_def E, MUUMA_UU, "ST"
	lang_def D, MUUMA_UU, "2?"
	lang_def F, MUUMA_UU, "FOR"
	lang_def I, MUUMA_UU, "ST"
	lang_def S, MUUMA_UU, "ST"

	lang_def J, MUUMA_MA, "マ"
	lang_def E, MUUMA_MA, "LY"
	lang_def D, MUUMA_MA, "3?"
	lang_def F, MUUMA_MA, "EVE"
	lang_def I, MUUMA_MA, "LY"
	lang_def S, MUUMA_MA, "LY"

.textMOKOKO
	lang J, "『モココ』"
	lang E, "RATTATA"
	lang D, "?"
	lang F, "RATTATA"
	lang I, "RATTATA"
	lang S, "RATTATA"
	db "@"

	lang_def J, MOKOKO_MO, "モ"
	lang_def E, MOKOKO_MO, "RAT"
	lang_def D, MOKOKO_MO, "1?"
	lang_def F, MOKOKO_MO, "RAT"
	lang_def I, MOKOKO_MO, "RAT"
	lang_def S, MOKOKO_MO, "RAT"

	lang_def J, MOKOKO_KO, "コ"
	lang_def E, MOKOKO_KO, "TA"
	lang_def D, MOKOKO_KO, "2?"
	lang_def F, MOKOKO_KO, "TA"
	lang_def I, MOKOKO_KO, "TA"
	lang_def S, MOKOKO_KO, "TA"
	
; old DODRIO version
;.textPUTERA
;	lang J, "『プテラ』"
;	lang E, "DODRIO"
;	lang D, "?"
;	lang F, "DODRIO"
;	lang I, "DODRIO"
;	lang S, "DODRIO"
;	db "@"
;.textPUTERA_PU
;	lang J, "プ"
;	lang E, "DO"
;	lang D, "1?"
;	lang F, "DO"
;	lang I, "DO"
;	lang S, "DO"
;	db "@"
;.textPUTERA_TE
;	lang J, "テ"
;	lang E, "DR"
;	lang D, "2?"
;	lang F, "DR"
;	lang I, "DR"
;	lang S, "DR"
;	db "@"
;.textPUTERA_RA
;	lang J, "ラ"
;	lang E, "IO"
;	lang D, "3?"
;	lang F, "IO"
;	lang I, "IO"
;	lang S, "IO"
;	db "@"

; new SUDOWOODO version
.textPUTERA
	lang J, "『プテラ』"
	lang E, "SUDOWOODO"
	lang D, "?"
	lang F, "?"
	lang I, "SUDOWOODO"
	lang S, "SUDOWOODO"
	db "@"
	
	lang_def J, PUTERA_PU, "プ"
	lang_def E, PUTERA_PU, "SUD"
	lang_def D, PUTERA_PU, "1?"
	lang_def F, PUTERA_PU, "1?"
	lang_def I, PUTERA_PU, "SUD"
	lang_def S, PUTERA_PU, "SUD"
	
	lang_def J, PUTERA_TE, "テ"
	lang_def E, PUTERA_TE, "OWO"
	lang_def D, PUTERA_TE, "2?"
	lang_def F, PUTERA_TE, "2?"
	lang_def I, PUTERA_TE, "OWO"
	lang_def S, PUTERA_TE, "OWO"
	
	lang_def J, PUTERA_RA, "ラ"
	lang_def E, PUTERA_RA, "ODO"
	lang_def D, PUTERA_RA, "3?"
	lang_def F, PUTERA_RA, "3?"
	lang_def I, PUTERA_RA, "ODO"
	lang_def S, PUTERA_RA, "ODO"
	
.textPIPPI
	lang J, "『ピッピ』"
	lang E, "EEVEE"
	lang D, "PIEPI"
	lang F, "?"
	lang I, "EEVEE"
	lang S, "EEVEE"
	db "@"
	
	lang_def J, PIPPI_PI, "ピ"
	lang_def E, PIPPI_PI, "EE"
	lang_def D, PIPPI_PI, "PI"
	lang_def F, PIPPI_PI, "1?"
	lang_def I, PIPPI_PI, "EE"
	lang_def S, PIPPI_PI, "EE"
	
	lang_def J, PIPPI_PP, "ッ"
	lang_def E, PIPPI_PP, "V"
	lang_def D, PIPPI_PP, "E"
	lang_def F, PIPPI_PP, "2?"
	lang_def I, PIPPI_PP, "V"
	lang_def S, PIPPI_PP, "V"

DEF PUZZLE_COUNT = 0

MACRO define_puzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF PUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS ".text\1"
DEF PUZZLE{d:PUZZLE_COUNT}_MON_NAME_2 EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT 16 - 2
DEF PUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQUS "{PUZZLE{d:PUZZLE_COUNT}_MON_NAME_2}_\1"
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
DEF loopindex = 0
REPT 16 - 1
DEF PUZZLE{d:PUZZLE_COUNT}_ANSWER{02d:loopindex} EQU .scr\1
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
ENDM

	define_puzzle MARILL,\
				\
				    LL, MA, MA, \
				MA, RI, RI, LL, \
				LL, RI, RI, MA, \
				LL, MA, LL, \
				\
				DN, RT, DN, XX, \
				RT, UP, RT, DN, \
				XX, XX, DN, LF, \
				XX, XX, RT
				
	define_puzzle MUUMA,\
				\
				    MU, UU, MA, \
				MU, MA, MA, MU, \
				MA, UU, MU, UU, \
				MU, UU, MA, \
				\
				RT, RT, DN, XX, \
				XX, XX, DN, XX, \
				DN, LF, LF, XX, \
				RT, RT, RT
				
	define_puzzle MOKOKO,\
				\
				    MO, MO, KO, \
				KO, KO, KO, KO, \
				MO, KO, KO, MO, \
				KO, MO, KO, \
				\
				RT, DN, RT, DN, \
				XX, RT, UP, DN, \
				XX, XX, DN, LF, \
				XX, XX, RT
				
	define_puzzle PUTERA,\
				\
					RA, PU, TE, \
				PU, TE, TE, RA, \
				PU, RA, TE, RA, \
				TE, RA, PU, \
				\
				DN, XX, XX, XX, \
				RT, DN, XX, XX, \
				DN, LF, RT, DN, \
				RT, RT, UP
				
	define_puzzle PIPPI,\
				\
				    PI, PP, PI, \
				PI, PP, PI, PP, \
				PI, PI, PP, PP, \
				PP, PI, PI, \
				\
				RT, DN, XX, XX, \
				DN, LF, XX, XX, \
				DN, RT, DN, XX, \
				RT, UP, RT
	
	
	
	
	
					
				
.menuDescName
	nts_start
	nts_switch wCurrentPuzzle, PUZZLE1_MON_NAME, PUZZLE2_MON_NAME, PUZZLE3_MON_NAME, PUZZLE4_MON_NAME, PUZZLE5_MON_NAME
	nts_end
	db "@"
	
	
;textXX:
;	db "×"
;	db "@"
;txtEND:
;	db "!"
;	db "@"
		
		
; include puzzles that were defined earlier

;DEF loopindex = 1
.puzzleGFX
	nts_start
	nts_switch wCurrentPuzzle, \
	.puzzle1GFX, \
	.puzzle2GFX, \
	.puzzle3GFX, \
	.puzzle4GFX, \
	.puzzle5GFX
	nts_end
.dummyGFX
	db "@"



DEF puzzleindex = 1
REPT 5
.puzzle{d:puzzleindex}GFX
DEF loopindex = 1
IF DEF(_LANG_J)
	db "× "
ELSE
	db "×   "
ENDC
REPT (4*4) - 2
	db "{{PUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}"
IF loopindex % 4 != 3
IF DEF(_LANG_J)
	db " "
ELSE
REPT 4 - STRLEN("{{PUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}")
	db " "
ENDR
ENDC
ELSE
	next
ENDC
	DEF loopindex = loopindex + 1
ENDR
	db "!"
	db "@"
DEF puzzleindex = puzzleindex + 1
ENDR
;REPT 16 - 2
;.txt{02d:loopindex}
;	nts_start
;	nts_switch wCurrentPuzzle, \
;	PUZZLE1_GFX{02d:loopindex}, \
;	PUZZLE2_GFX{02d:loopindex}, \
;	PUZZLE3_GFX{02d:loopindex}, \
;	PUZZLE4_GFX{02d:loopindex}, \
;	PUZZLE5_GFX{02d:loopindex}
;	nts_end
;	db "@"
;DEF loopindex = loopindex + 1
;ENDR

DEF loopindex = 0
REPT 16 - 1
.scr{02d:loopindex}
	nsc_compare wCurrentPuzzle, PUZZLE1_ANSWER{02d:loopindex}, PUZZLE2_ANSWER{02d:loopindex}, .scr{02d:loopindex}greater, 1, 1
.scr{02d:loopindex}greater
	nsc_compare wCurrentPuzzle, PUZZLE3_ANSWER{02d:loopindex}, PUZZLE4_ANSWER{02d:loopindex}, PUZZLE5_ANSWER{02d:loopindex}, 1, 3
DEF loopindex = loopindex + 1
ENDR

	




	news_screen PokemonMazeHard, MUSIC_SHOW_ME_AROUND
	news_def_pals

	news_def_boxes
	news_box 0, 12, 20, 6, NEWSBORDER_GLOWY, 4
	
	
	news_def_strings
	news_string 0, 0, "@" ; potentially label or instructions here
	
	news_menu  2, 2, 9, 5, 2, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	
	news_buttonscript .checkHard   ; script pointer a button
	news_buttonscript Quit        ; script pointer b button
	news_buttonscript .resetPuzzle ; script pointer select button
	news_buttonscript .checkHard   ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript .upButton    ; script pointer up button
	news_buttonscript .downButton  ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names .puzzleGFX
REPT 9*5 - 1
	news_menuitem_names .dummyGFX
ENDR
	
	news_menuitem_scripts  \
	.scr00, .scr01, .scr02, .scr03, .scr04, .scr05, .scr06, .scr07, .scr08, \
	.scr09, .scr10, .scr11, .scr12, .scr13, .scr14, .scr15, .scr16, .scr17, \
	.scr18, .scr19, .scr20, .scr21, .scr22, .scr23, .scr24, .scr25, .scr26, \
	.scr27, .scr28, .scr29, .scr30, .scr31, .scr32, .scr33, .scr34, .scr35, \
	.scr36, .scr37, .scr38, .scr39, .scr40, .scr41, .scr42, .scr43, .checkAnswer
REPT 9 * 5
	news_menuitem_descs   .menuDescName
ENDR







.upButton
	nsc_compare wNewsMenuCursorY, .nothing, .nothing, .upButton_continue, 1, 1
.upButton_continue
	nsc_set wCurrentMove, UP
	nsc_select
	nsc_up
	nsc_ret
.downButton
	nsc_compare wNewsMenuCursorY, .downButton_continue, .nothing, .nothing, 1, 5
.downButton_continue
	nsc_set wCurrentMove, DOWN
	nsc_select
	nsc_down
	nsc_ret
.rightButton
	nsc_compare wNewsMenuCursorX, .rightButton_continue, .nothing, .nothing, 1, 9
.rightButton_continue
	nsc_set wCurrentMove, RIGHT
	nsc_select
	nsc_right
	nsc_ret
.leftButton
	nsc_compare wNewsMenuCursorX, .nothing, .nothing, .leftButton_continue, 1, 1
.leftButton_continue
	nsc_set wCurrentMove, LEFT
	nsc_select
	nsc_left
	nsc_ret


.resetPuzzle
	nsc_white
	nsc_playsound SFX_WARP_FROM
	nsc_set wSolutionInvalid, 0
	nsc_page currentScreen
	nsc_ret
	
.checkHard
	nsc_compare wNewsMenuCursorX, .nothing, .checkAnswer, .nothing, 2, 9, 5
.checkAnswer
	;nsc_playsound SFX_TRANSACTION	
	nsc_compare wSolutionInvalid, .resetPuzzle, .pass, .resetPuzzle, 1, 0
.pass
	nsc_playsound SFX_TRANSACTION
	nsc_add wCurrentPuzzle, 1
	nsc_compare wCurrentPuzzle, .nextPuzzle, .gift, .gift, 1, 5 ; 5 easy puzzles
.nextPuzzle
	nsc_page currentScreen
.nothing
	nsc_ret
	
.gift
	nsc_bit_newsvar sMinigameFlag, 1, .noGift, .giveGift
.giveGift	
	nsc_giveitem BLUESKY_MAIL, 3, .recordGift, .noGift
.recordGift
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .getGiftText
	nsc_flagop sMinigameFlag, 1, FLAG_SET
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.noGift
	nsc_page NewsRoot ; TODO: maze selection?
	
.getGiftText
	; TODO: potentially the wrong string? plz check
	lang_text J, "あおそらメールを　もらった！"
	
	lang_text E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BLUESKY MAIL."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
	
	
	
.scrUP
	; tile where correct direction is up
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, UP
.scrDN
	; tile where correct direction is down
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, DOWN
.scrLF
	; tile where correct direction is right
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, LEFT
.scrRT
	; tile where correct direction is left
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, RIGHT
	
	
.scrXX
	nsc_set wSolutionInvalid, 1
.valid
	; for fun!
	; but also audio feedback to let the player
	; know that the game is registering every
	; d-pad button press.
	nsc_playsound SFX_STOP_SLOT
	nsc_ret
	
	

.textPIKACHU
	lang J, "『ピカチュウ』"
	lang E, "PICHU"
	lang D, "PICHU"
	lang F, "PICHU"
	lang I, "PICHU"
	lang S, "PICHU"
	db "@"
	
	lang_def J, PIKACHU_P, "ピ"
	lang_def E, PIKACHU_P, "P"
	lang_def D, PIKACHU_P, "P"
	lang_def F, PIKACHU_P, "P"
	lang_def I, PIKACHU_P, "P"
	lang_def S, PIKACHU_P, "P"
	
	lang_def J, PIKACHU_I, "カ"
	lang_def E, PIKACHU_I, "I"
	lang_def D, PIKACHU_I, "I"
	lang_def F, PIKACHU_I, "I"
	lang_def I, PIKACHU_I, "I"
	lang_def S, PIKACHU_I, "I"
	
	lang_def J, PIKACHU_C, "チ"
	lang_def E, PIKACHU_C, "C"
	lang_def D, PIKACHU_C, "C"
	lang_def F, PIKACHU_C, "C"
	lang_def I, PIKACHU_C, "C"
	lang_def S, PIKACHU_C, "C"
	
	lang_def J, PIKACHU_H, "ュ"
	lang_def E, PIKACHU_H, "H"
	lang_def D, PIKACHU_H, "H"
	lang_def F, PIKACHU_H, "H"
	lang_def I, PIKACHU_H, "H"
	lang_def S, PIKACHU_H, "H"
	
	lang_def J, PIKACHU_U, "ウ"
	lang_def E, PIKACHU_U, "U"
	lang_def D, PIKACHU_U, "U"
	lang_def F, PIKACHU_U, "U"
	lang_def I, PIKACHU_U, "U"
	lang_def S, PIKACHU_U, "U"
	
	

.textKIRINRIKI
	lang J, "『キリンリキ』"
	lang E, "HO-OH"
	lang D, "HO-OH"
	lang F, "HO-OH"
	lang I, "HO-OH"
	lang S, "HO-OH"
	db "@"

	lang_def J, KIRINRIKI_H, "キ"
	lang_def E, KIRINRIKI_H, "H"
	lang_def D, KIRINRIKI_H, "H"
	lang_def F, KIRINRIKI_H, "H"
	lang_def I, KIRINRIKI_H, "H"
	lang_def S, KIRINRIKI_H, "H"
	
	lang_def J, KIRINRIKI_O, "リ"
	lang_def E, KIRINRIKI_O, "O"
	lang_def D, KIRINRIKI_O, "O"
	lang_def F, KIRINRIKI_O, "O"
	lang_def I, KIRINRIKI_O, "O"
	lang_def S, KIRINRIKI_O, "O"
	
	lang_def J, KIRINRIKI__, "ン"
	lang_def E, KIRINRIKI__, "-"
	lang_def D, KIRINRIKI__, "-"
	lang_def F, KIRINRIKI__, "-"
	lang_def I, KIRINRIKI__, "-"
	lang_def S, KIRINRIKI__, "-"
	


.textYANMA
	lang J, "『ヤンヤンマ』"
	lang E, "DODUO"
	lang D, "?"
	lang F, "DODUO"
	lang I, "DODUO"
	lang S, "DODUO"
	db "@"
	
	lang_def J, YANMA_M, "ヤ"
	lang_def E, YANMA_D, "D"
	lang_def D, YANMA_D, "1"
	lang_def F, YANMA_D, "D"
	lang_def I, YANMA_D, "D"
	lang_def S, YANMA_D, "D"
	
	lang_def J, YANMA_U, "ン"
	lang_def E, YANMA_O, "O"
	lang_def D, YANMA_O, "2"
	lang_def F, YANMA_O, "O"
	lang_def I, YANMA_O, "O"
	lang_def S, YANMA_O, "O"
	
	lang_def J, YANMA_K, "マ"
	lang_def E, YANMA_U, "U"
	lang_def D, YANMA_U, "3"
	lang_def F, YANMA_U, "U"
	lang_def I, YANMA_U, "U"
	lang_def S, YANMA_U, "U"
	

.textHARIISEN
	lang J, "『ハリーセン』"
	lang E, "ZUBAT"
	lang D, "ZUBAT"
	lang F, "?"
	lang I, "ZUBAT"
	lang S, "ZUBAT"
	db "@"
	
	lang_def J, HARIISEN_Z, "ハ"
	lang_def E, HARIISEN_Z, "Z"
	lang_def D, HARIISEN_Z, "Z"
	lang_def F, HARIISEN_Z, "1"
	lang_def I, HARIISEN_Z, "Z"
	lang_def S, HARIISEN_Z, "Z"
	
	lang_def J, HARIISEN_U, "リ"
	lang_def E, HARIISEN_U, "U"
	lang_def D, HARIISEN_U, "U"
	lang_def F, HARIISEN_U, "2"
	lang_def I, HARIISEN_U, "U"
	lang_def S, HARIISEN_U, "U"
	
	lang_def J, HARIISEN_B, "ー"
	lang_def E, HARIISEN_B, "B"
	lang_def D, HARIISEN_B, "B"
	lang_def F, HARIISEN_B, "3"
	lang_def I, HARIISEN_B, "B"
	lang_def S, HARIISEN_B, "B"
	
	lang_def J, HARIISEN_A, "セ"
	lang_def E, HARIISEN_A, "A"
	lang_def D, HARIISEN_A, "A"
	lang_def F, HARIISEN_A, "4"
	lang_def I, HARIISEN_A, "A"
	lang_def S, HARIISEN_A, "A"
	
	lang_def J, HARIISEN_T, "ン"
	lang_def E, HARIISEN_T, "T"
	lang_def D, HARIISEN_T, "T"
	lang_def F, HARIISEN_T, "5"
	lang_def I, HARIISEN_T, "T"
	lang_def S, HARIISEN_T, "T"
	

.textWINDY
	lang J, "『ウインディ』"
	lang E, "ARBOK"
	lang D, "ARBOK"
	lang F, "ARBOK"
	lang I, "ARBOK"
	lang S, "ARBOK"
	db "@"
.text
	lang_def J, WINDY_A, "ウ"
	lang_def E, WINDY_A, "A"
	lang_def D, WINDY_A, "A"
	lang_def F, WINDY_A, "A"
	lang_def I, WINDY_A, "A"
	lang_def S, WINDY_A, "A"
	
	lang_def J, WINDY_R, "イ"
	lang_def E, WINDY_R, "R"
	lang_def D, WINDY_R, "R"
	lang_def F, WINDY_R, "R"
	lang_def I, WINDY_R, "R"
	lang_def S, WINDY_R, "R"
	
	lang_def J, WINDY_B, "ン"
	lang_def E, WINDY_B, "B"
	lang_def D, WINDY_B, "B"
	lang_def F, WINDY_B, "B"
	lang_def I, WINDY_B, "B"
	lang_def S, WINDY_B, "B"
	
	lang_def J, WINDY_O, "デ"
	lang_def E, WINDY_O, "O"
	lang_def D, WINDY_O, "O"
	lang_def F, WINDY_O, "O"
	lang_def I, WINDY_O, "O"
	lang_def S, WINDY_O, "O"
	
	lang_def J, WINDY_K, "ィ"
	lang_def E, WINDY_K, "K"
	lang_def D, WINDY_K, "K"
	lang_def F, WINDY_K, "K"
	lang_def I, WINDY_K, "K"
	lang_def S, WINDY_K, "K"
	

DEF PUZZLE_COUNT = 0

MACRO define_hpuzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF HPUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS ".text\1"
DEF HPUZZLE{d:PUZZLE_COUNT}_MON_NAME_2 EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT (5*9) - 2
DEF HPUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQUS "{HPUZZLE{d:PUZZLE_COUNT}_MON_NAME_2}_\1"
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
DEF loopindex = 0
REPT (5*9) - 1
DEF HPUZZLE{d:PUZZLE_COUNT}_ANSWER{02d:loopindex} EQU .scr\1
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
ENDM

	define_hpuzzle PIKACHU,\
				\
				   P, I, C, H, U, P, I, C,\
				C, I, U, H, P, C, H, U, U,\
				H, H, U, P, P, I, P, P, H,\
				U, C, C, I, U, C, C, I, U,\
				P, I, U, C, H, U, H, U,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				DN, LF, XX, XX, XX, RT, RT, DN, XX, \
				DN, RT, RT, DN, RT, UP, XX, DN, XX, \
				DN, UP, XX, DN, UP, XX, DN, LF, XX, \
				RT, UP, XX, RT, UP, XX, RT, RT
				
	define_hpuzzle KIRINRIKI,\
				\
				   H, O, _, H, O, H, H, O,\
				_, O, _, O, O, _, H, _, H,\
				O, _, O, H, H, _, _, _, O,\
				H, O, O, _, _, H, H, O, H,\
				H, H, H, O, _, O, _, _,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, XX, XX, XX, XX, XX, RT, DN, \
				XX, DN, XX, XX, XX, RT, RT, UP, DN, \
				XX, RT, RT, RT, RT, UP, XX, XX
				
IF DEF(_LANG_J)
	define_hpuzzle YANMA,\
				\
				   M, U, U, M, U, M, U, K,\
				M, K, M, U, K, M, U, M, U,\
				U, M, U, K, M, K, U, M, K,\
				M, M, U, M, K, U, M, U, K,\
				U, K, K, U, K, U, K, M,\
				\
				RT, RT, DN, XX, XX, XX, XX, XX, XX, \
				XX, XX, RT, RT, RT, RT, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, DN, LF, LF, \
				XX, XX, XX, XX, XX, XX, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, XX, XX
ELSE
	define_hpuzzle YANMA,\
				\
				   D, O, O, D, O, D, U, O, \
				D, U, D, U, O, D, O, D, U, \
				O, D, U, O, D, O, O, D, O, \
				D, D, O, D, O, U, D, U, O, \
				U, O, O, U, O, U, O, D, \
				\
				RT, RT, DN, XX, XX, XX, XX, XX, XX, \
				XX, XX, RT, RT, RT, RT, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, DN, LF, LF, \
				XX, XX, XX, XX, XX, XX, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, XX, XX
ENDC
				
	define_hpuzzle HARIISEN,\
				\
				   Z, A, T, Z, B, A, T, Z,\
				Z, U, B, U, Z, U, U, Z, U,\
				U, A, T, A, T, A, B, A, Z,\
				B, U, Z, B, Z, T, B, A, T,\
				A, T, Z, U, Z, Z, U, Z,\
				\
				DN, XX, XX, XX, XX, RT, RT, DN, XX, \
				DN, XX, XX, XX, RT, UP, DN, LF, XX, \
				DN, XX, XX, RT, UP, DN, LF, XX, XX, \
				DN, XX, XX, UP, XX, DN, RT, RT, DN, \
				RT, RT, RT, UP, XX, RT, UP, XX
				
	define_hpuzzle WINDY,\
				\
				   A, K, B, O, K, A, R, B,\
				B, R, K, A, R, B, O, R, A,\
				O, B, O, R, R, O, R, A, K,\
				K, B, R, K, A, K, B, O, K,\
				A, R, B, O, R, A, R, R,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, RT, RT, RT, DN, XX, XX, XX, \
				XX, RT, UP, XX, XX, DN, XX, XX, XX, \
				XX, XX, XX, XX, XX, DN, RT, RT, DN, \
				XX, XX, XX, XX, XX, RT, UP, XX
	
	
	
	
	
					
				
.menuDescName
	nts_start
	nts_switch wCurrentPuzzle, HPUZZLE1_MON_NAME, HPUZZLE2_MON_NAME, HPUZZLE3_MON_NAME, HPUZZLE4_MON_NAME, HPUZZLE5_MON_NAME
	nts_end
	db "@"
	
	
	
		
		
; include puzzles that were defined earlier
;DEF loopindex = 1
;REPT (9*5) - 2
;.txt{02d:loopindex}
;	nts_start
;	nts_switch wCurrentPuzzle, \
;	HPUZZLE1_GFX{02d:loopindex}, \
;	HPUZZLE2_GFX{02d:loopindex}, \
;	HPUZZLE3_GFX{02d:loopindex}, \
;	HPUZZLE4_GFX{02d:loopindex}, \
;	HPUZZLE5_GFX{02d:loopindex}
;	nts_end
;	db "@"
;DEF loopindex = loopindex + 1
;ENDR


.puzzleGFX
	nts_start
	nts_switch wCurrentPuzzle, \
	.puzzle1GFX, \
	.puzzle2GFX, \
	.puzzle3GFX, \
	.puzzle4GFX, \
	.puzzle5GFX
	nts_end
.dummyGFX
	db "@"



DEF puzzleindex = 1
REPT 5
.puzzle{d:puzzleindex}GFX
DEF loopindex = 1
	db "× "
REPT (9*5) - 2
	db "{{HPUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}"
;REPT 4 - STRLEN(PUZZLE{d:puzzleindex}_GFX{02d:loopindex})
IF loopindex % 9 != 8
	db " "
;ENDR
;ENDR
ELSE
	next
ENDC
	DEF loopindex = loopindex + 1
ENDR
	db "!"
	db "@"
DEF puzzleindex = puzzleindex + 1
ENDR


DEF loopindex = 0
REPT (9*5) - 1
.scr{02d:loopindex}
	nsc_compare wCurrentPuzzle, HPUZZLE1_ANSWER{02d:loopindex}, HPUZZLE2_ANSWER{02d:loopindex}, .scr{02d:loopindex}greater, 1, 1
.scr{02d:loopindex}greater
	nsc_compare wCurrentPuzzle, HPUZZLE3_ANSWER{02d:loopindex}, HPUZZLE4_ANSWER{02d:loopindex}, HPUZZLE5_ANSWER{02d:loopindex}, 1, 3
DEF loopindex = loopindex + 1
ENDR

	
	
	
	
	
	
	
	
	
	
	
	
Quit:
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	

	
;textXX:
;	db "×"
;	db "@"
;txtEND:
;	db "!"
;	db "@"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
ENDC
