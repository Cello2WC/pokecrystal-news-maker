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
	textXX, .txt01, .txt02, .txt03, \
	.txt04, .txt05, .txt06, .txt07, \
	.txt08, .txt09, .txt10, .txt11, \
	.txt12, .txt13, .txt14, txtEND
	
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
	
	

.textMARILL
	lang J, "『マリル』"
	lang E, "MARILL"
	lang D, "MARILL"
	lang F, "MARILL"
	lang I, "MARILL"
	lang S, "MARILL"
	db "@"
.textMARILL_MA
	lang J, "マ"
	lang E, "MA"
	lang D, "MA"
	lang F, "MA"
	lang I, "MA"
	lang S, "MA"
	db "@"
.textMARILL_RI
	lang J, "リ"
	lang E, "RI"
	lang D, "RI"
	lang F, "RI"
	lang I, "RI"
	lang S, "RI"
	db "@"
.textMARILL_LL
	lang J, "ル"
	lang E, "LL"
	lang D, "LL"
	lang F, "LL"
	lang I, "LL"
	lang S, "LL"
	db "@"
	

.textMUUMA
	lang J, "『ムウマ』"
	lang E, "GASTLY"
	lang D, "?"
	lang F, "FEUFOREVE"
	lang I, "GASTLY"
	lang S, "GASTLY"
	db "@"
.textMUUMA_MU
	lang J, "ム"
	lang E, "GA"
	lang D, "1?"
	lang F, "FEU"
	lang I, "GA"
	lang S, "GA"
	db "@"
.textMUUMA_UU
	lang J, "ウ"
	lang E, "ST"
	lang D, "2?"
	lang F, "FOR"
	lang I, "ST"
	lang S, "ST"
	db "@"
.textMUUMA_MA
	lang J, "マ"
	lang E, "LY"
	lang D, "3?"
	lang F, "EVE"
	lang I, "LY"
	lang S, "LY"
	db "@"

.textMOKOKO
	lang J, "『モココ』"
	lang E, "RATTATA"
	lang D, "?"
	lang F, "RATTATA"
	lang I, "RATTATA"
	lang S, "RATTATA"
	db "@"
.textMOKOKO_MO
	lang J, "モ"
	lang E, "RAT"
	lang D, "1?"
	lang F, "RAT"
	lang I, "RAT"
	lang S, "RAT"
	db "@"
.textMOKOKO_KO
	lang J, "コ"
	lang E, "TA"
	lang D, "2?"
	lang F, "TA"
	lang I, "TA"
	lang S, "TA"
	db "@"
	
.textPUTERA
	lang J, "『プテラ』"
	lang E, "DODRIO"
	lang D, "?"
	lang F, "DODRIO"
	lang I, "DODRIO"
	lang S, "DODRIO"
	db "@"
.textPUTERA_PU
	lang J, "プ"
	lang E, "DO"
	lang D, "1?"
	lang F, "DO"
	lang I, "DO"
	lang S, "DO"
	db "@"
.textPUTERA_TE
	lang J, "テ"
	lang E, "DR"
	lang D, "2?"
	lang F, "DR"
	lang I, "DR"
	lang S, "DR"
	db "@"
.textPUTERA_RA
	lang J, "ラ"
	lang E, "IO"
	lang D, "3?"
	lang F, "IO"
	lang I, "IO"
	lang S, "IO"
	db "@"
	
.textPIPPI
	lang J, "『ピッピ』"
	lang E, "EEVEE"
	lang D, "PIEPI"
	lang F, "?"
	lang I, "EEVEE"
	lang S, "EEVEE"
	db "@"
.textPIPPI_PI
	lang J, "ピ"
	lang E, "EE"
	lang D, "PI"
	lang F, "1?"
	lang I, "EE"
	lang S, "EE"
	db "@"
.textPIPPI_PP
	lang J, "ッ"
	lang E, "V"
	lang D, "E"
	lang F, "2?"
	lang I, "V"
	lang S, "V"
	db "@"

DEF PUZZLE_COUNT = 0

MACRO define_puzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF PUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT 16 - 2
DEF PUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQU {PUZZLE{d:PUZZLE_COUNT}_MON_NAME}_\1
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

	define_puzzle .textMARILL,\
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
				
	define_puzzle .textMUUMA,\
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
				
	define_puzzle .textMOKOKO,\
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
				
	define_puzzle .textPUTERA,\
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
				
	define_puzzle .textPIPPI,\
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
	
	
	
		
		
; include puzzles that were defined earlier
DEF loopindex = 1
REPT 16 - 2
.txt{02d:loopindex}
	nts_start
	nts_switch wCurrentPuzzle, \
	PUZZLE1_GFX{02d:loopindex}, \
	PUZZLE2_GFX{02d:loopindex}, \
	PUZZLE3_GFX{02d:loopindex}, \
	PUZZLE4_GFX{02d:loopindex}, \
	PUZZLE5_GFX{02d:loopindex}
	nts_end
	db "@"
DEF loopindex = loopindex + 1
ENDR

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
	
	news_menuitem_names   \
	textXX, .txt01, .txt02, .txt03, .txt04, .txt05, .txt06, .txt07, .txt08, \
	.txt09, .txt10, .txt11, .txt12, .txt13, .txt14, .txt15, .txt16, .txt17, \
	.txt18, .txt19, .txt20, .txt21, .txt22, .txt23, .txt24, .txt25, .txt26, \
	.txt27, .txt28, .txt29, .txt30, .txt31, .txt32, .txt33, .txt34, .txt35, \
	.txt36, .txt37, .txt38, .txt39, .txt40, .txt41, .txt42, .txt43, txtEND
	
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
	lang_text J, "あおからメールを　もらった！"
	
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
.textPIKACHU_P
	lang J, "ピ"
	lang E, "P"
	lang D, "P"
	lang F, "P"
	lang I, "P"
	lang S, "P"
	db "@"
.textPIKACHU_I
	lang J, "カ"
	lang E, "I"
	lang D, "I"
	lang F, "I"
	lang I, "I"
	lang S, "I"
	db "@"
.textPIKACHU_C
	lang J, "チ"
	lang E, "C"
	lang D, "C"
	lang F, "C"
	lang I, "C"
	lang S, "C"
	db "@"
.textPIKACHU_H
	lang J, "ュ"
	lang E, "H"
	lang D, "H"
	lang F, "H"
	lang I, "H"
	lang S, "H"
	db "@"
.textPIKACHU_U
	lang J, "ウ"
	lang E, "U"
	lang D, "U"
	lang F, "U"
	lang I, "U"
	lang S, "U"
	db "@"
	
	

.textKIRINRIKI
	lang J, "『キリンリキ』"
	lang E, "HO-OH"
	lang D, "HO-OH"
	lang F, "HO-OH"
	lang I, "HO-OH"
	lang S, "HO-OH"
	db "@"
.textKIRINRIKI_H
	lang J, "キ"
	lang E, "H"
	lang D, "H"
	lang F, "H"
	lang I, "H"
	lang S, "H"
	db "@"
.textKIRINRIKI_O
	lang J, "リ"
	lang E, "O"
	lang D, "O"
	lang F, "O"
	lang I, "O"
	lang S, "O"
	db "@"
.textKIRINRIKI__
	lang J, "ン"
	lang E, "-"
	lang D, "-"
	lang F, "-"
	lang I, "-"
	lang S, "-"
	db "@"
	


.textYANMA
	lang J, "『ヤンヤンマ』"
	lang E, "MUMUK"
	lang D, "?"
	lang F, "?"
	lang I, "MUMUK"
	lang S, "MUMUK"
	db "@"
.textYANMA_M
	lang J, "ヤ"
	lang E, "M"
	lang D, "1"
	lang F, "1"
	lang I, "M"
	lang S, "M"
	db "@"
.textYANMA_U
	lang J, "ン"
	lang E, "U"
	lang D, "2"
	lang F, "2"
	lang I, "K"
	lang S, "K"
	db "@"
.textYANMA_K
	lang J, "マ"
	lang E, "K"
	lang D, "3"
	lang F, "3"
	lang I, "K"
	lang S, "K"
	db "@"
	

.textHARIISEN
	lang J, "『ハリーセン』"
	lang E, "ZUBAT"
	lang D, "ZUBAT"
	lang F, "?"
	lang I, "ZUBAT"
	lang S, "ZUBAT"
	db "@"
.textHARIISEN_Z
	lang J, "ハ"
	lang E, "Z"
	lang D, "Z"
	lang F, "1"
	lang I, "Z"
	lang S, "Z"
	db "@"
.textHARIISEN_U
	lang J, "リ"
	lang E, "U"
	lang D, "U"
	lang F, "2"
	lang I, "U"
	lang S, "U"
	db "@"
.textHARIISEN_B
	lang J, "ー"
	lang E, "B"
	lang D, "B"
	lang F, "3"
	lang I, "B"
	lang S, "B"
	db "@"
.textHARIISEN_A
	lang J, "セ"
	lang E, "A"
	lang D, "A"
	lang F, "4"
	lang I, "A"
	lang S, "A"
	db "@"
.textHARIISEN_T
	lang J, "ン"
	lang E, "T"
	lang D, "T"
	lang F, "5"
	lang I, "T"
	lang S, "T"
	db "@"
	

.textWINDY
	lang J, "『ウインディ』"
	lang E, "ARBOK"
	lang D, "ARBOK"
	lang F, "ARBOK"
	lang I, "ARBOK"
	lang S, "ARBOK"
	db "@"
.textWINDY_A
	lang J, "ウ"
	lang E, "A"
	lang D, "A"
	lang F, "A"
	lang I, "A"
	lang S, "A"
	db "@"
.textWINDY_R
	lang J, "イ"
	lang E, "R"
	lang D, "R"
	lang F, "R"
	lang I, "R"
	lang S, "R"
	db "@"
.textWINDY_B
	lang J, "ン"
	lang E, "B"
	lang D, "B"
	lang F, "B"
	lang I, "B"
	lang S, "B"
	db "@"
.textWINDY_O
	lang J, "デ"
	lang E, "O"
	lang D, "O"
	lang F, "O"
	lang I, "O"
	lang S, "O"
	db "@"
.textWINDY_K
	lang J, "ィ"
	lang E, "K"
	lang D, "K"
	lang F, "K"
	lang I, "K"
	lang S, "K"
	db "@"
	

DEF PUZZLE_COUNT = 0

MACRO define_hpuzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF HPUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT (5*9) - 2
DEF HPUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQU {HPUZZLE{d:PUZZLE_COUNT}_MON_NAME}_\1
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

	define_hpuzzle .textPIKACHU,\
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
				
	define_hpuzzle .textKIRINRIKI,\
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
				
	define_hpuzzle .textYANMA,\
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
				
	define_hpuzzle .textHARIISEN,\
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
				
	define_hpuzzle .textWINDY,\
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
DEF loopindex = 1
REPT (9*5) - 2
.txt{02d:loopindex}
	nts_start
	nts_switch wCurrentPuzzle, \
	HPUZZLE1_GFX{02d:loopindex}, \
	HPUZZLE2_GFX{02d:loopindex}, \
	HPUZZLE3_GFX{02d:loopindex}, \
	HPUZZLE4_GFX{02d:loopindex}, \
	HPUZZLE5_GFX{02d:loopindex}
	nts_end
	db "@"
DEF loopindex = loopindex + 1
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
	

	
textXX:
	db "×"
	db "@"
txtEND:
	db "!"
	db "@"
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
ENDC
