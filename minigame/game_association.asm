IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wHint1 EQUS "wNewsScratch0"
DEF wHint2 EQUS "wNewsScratch1"
DEF wHint3 EQUS "wNewsScratch2"
DEF wCorrectAnswer EQUS "wNewsScratch3"
DEF wChain EQUS "wNewsScratch4"

MACRO minigame_start
	nsc_set wChain, 0
	
	
	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro
	
	; TODO: this is a bodge...
	nsc_ramcopy hRandomAdd, wHint1, 1
	nsc_flagop wHint1, 3, FLAG_CLEAR
	nsc_flagop wHint1, 4, FLAG_CLEAR
	nsc_flagop wHint1, 5, FLAG_CLEAR
	nsc_flagop wHint1, 6, FLAG_CLEAR
	nsc_flagop wHint1, 7, FLAG_CLEAR
	
	nsc_compare wHint1, .preset1, .preset2, .presetGreater, 1, 1
.presetGreater
	nsc_compare wHint1, .preset3, .preset4, .presetGreater2, 1, 3
.presetGreater2
	nsc_compare wHint1, .preset5, .preset6, .presetGreater3, 1, 5
.presetGreater3
	nsc_compare wHint1, .preset7, .preset8, .preset8, 1, 7
.preset1
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset1, wHint1, 4
	nsc_set wHint1, 3
	nsc_set wHint2, 0
	nsc_set wHint3, 7
	nsc_set wCorrectAnswer, TAUROS
	nsc_page ChainQuiz
.preset2
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset2, wHint1, 4
	nsc_set wHint1, 1
	nsc_set wHint2, 2
	nsc_set wHint3, 0
	nsc_set wCorrectAnswer, TOTODILE
	nsc_page ChainQuiz
.preset3
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset3, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 0
	nsc_set wHint3, 0
	nsc_set wCorrectAnswer, SNEASEL
	nsc_page ChainQuiz
.preset4
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset4, wHint1, 4
	nsc_set wHint1, 2
	nsc_set wHint2, 1
	nsc_set wHint3, 7
	nsc_set wCorrectAnswer, SANDSHREW
	nsc_page ChainQuiz
.preset5
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset5, wHint1, 4
	nsc_set wHint1, 3
	nsc_set wHint2, 4
	nsc_set wHint3, 9
	nsc_set wCorrectAnswer, MAROWAK
	nsc_page ChainQuiz
.preset6
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset6, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 5
	nsc_set wHint3, 5
	nsc_set wCorrectAnswer, HYPNO
	nsc_page ChainQuiz
.preset7
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset7, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 7
	nsc_set wHint3, 10
	nsc_set wCorrectAnswer, SLOWPOKE
	nsc_page ChainQuiz
.preset8
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset8, wHint1, 4
	nsc_set wHint1, 2
	nsc_set wHint2, 6
	nsc_set wHint3, 11
	nsc_set wCorrectAnswer, FARFETCH_D
	nsc_page ChainQuiz
	
	
.gameIntroText
	; Japanese
	lang_text J, "がめんの　ひだりがわに"
	lang_line J, "３つの　ヒントが　でます"
	
	lang_para J, "ヒントに　あてはまる　ポケモンを"
	lang_line J, "がめんの　みぎがわから　えらんで"
	lang_cont J, "エーボタンで　こたえて　ください"
	
	lang_para J, "５もん　つづけて　あたれば　クリア！"
	lang_line J, "それでは　はじめよう！"
	
	; English
	lang_text E, "Three hints will"
	lang_line E, "appear at the top"
	lang_cont E, "of the screen."
	
	lang_para E, "Pick the #MON"
	lang_line E, "that fits the"
	lang_cont E, "hints."
	
	lang_para E, "Choose from the" 
	lang_line E, "bottom and Press A"
	lang_cont E, "to answer."	
	
	lang_para E, "Get five right in"
	lang_line E, "a row to clear"
	lang_cont E, "the quiz!"
	
	lang_para E, "Let's get started!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
ENDM

MACRO minigame_name
	; Japanese
	lang J, "#　れんそうクイズ！"
	
	; English
	lang E, "#MON WORD QUIZ"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

; deprecating this, at least for now, 
; as it seems it might not have existed.

;MACRO minigame_desc
;ENDM

ELSE
MinigameStart::
	news_screen ChainQuiz, MUSIC_GAME_CORNER
	news_def_pals
	
	news_def_boxes
	;news_box  0,  0, 20, 18, {NEWS_MAIN_BORDER}
;	news_box  0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	
IF DEF(_LANG_J)
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wHint1, .textHintA1, .textHintA2, .textHintA3, .textHintA4
	nts_end
	;next
	news_string 1, 4, ""
	nts_start
	nts_switch wHint2, .textHintB1, .textHintB2, .textHintB3, .textHintB4,\
					   .textHintB5, .textHintB6, .textHintB7, .textHintB8
	nts_end
	;next
	news_string 1, 6, ""
	nts_start
	nts_switch wHint3, .textHintC01, .textHintC02, .textHintC03, .textHintC04,\
	                   .textHintC05, .textHintC06, .textHintC07, .textHintC08,\
	                   .textHintC09, .textHintC10, .textHintC11, .textHintC12
	nts_end
	;db "@"
	
	news_menu 13, 2, 1, 8, 0, 2, 5, 1, 16, 8, 0, 8
	;news_menu 11, 2, 1, 8, 0, 2, 5, 4, 7, 4, 0, 4
	;news_menu 2, 5, 1, 4, 0, 2, 16, $04, $07, $04, SHOW_ARROWS | SHOW_DESCRIPTIONS, $04
ELSE
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wHint1, .textHintA1, .textHintA2, .textHintA3, .textHintA4
	nts_end
	;next
	news_string 1, 4, ""
	nts_start
	nts_switch wHint2, .textHintB1, .textHintB2, .textHintB3, .textHintB4,\
					   .textHintB5, .textHintB6, .textHintB7, .textHintB8
	nts_end
	;next
	news_string 1, 6, ""
	nts_start
	nts_switch wHint3, .textHintC01, .textHintC02, .textHintC03, .textHintC04,\
	                   .textHintC05, .textHintC06, .textHintC07, .textHintC08,\
	                   .textHintC09, .textHintC10, .textHintC11, .textHintC12
	nts_end
	;db "@"
	
	news_menu 5, 10, 1, 4, 0, 2, 10, 9, 7, 3, SHOW_ARROWS, 8
	;news_menu 2, 5, 1, 4, 0, 2, 16, $04, $07, $04, SHOW_ARROWS | SHOW_DESCRIPTIONS, $04
ENDC
	
	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript 
	news_buttonscript .generate_question;.start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	
	news_norankingstable
	
	news_menuitem_names   .answer1Name,   .answer2Name,   .answer3Name,   .answer4Name,   .answer5Name,   .answer6Name,   .answer7Name,   .answer8Name
	news_menuitem_scripts .answer1Script, .answer2Script, .answer3Script, .answer4Script, .answer5Script, .answer6Script, .answer7Script, .answer8Script
	news_menuitem_descs   .answer1Desc,   .answer2Desc,   .answer3Desc,   .answer4Desc,   .answer5Desc,   .answer6Desc,   .answer7Desc,   .answer8Desc
	
.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_drawbox 0, 12, 20, 6, NEWSBORDER_GLOWY, 4
	nsc_select
	nsc_ret
.up_button
	nsc_up
	nsc_ret
.down_button
	nsc_down
	nsc_ret
.b_button
.start_button
	nsc_playsound SFX_MENU
.menuCancelScript
	nsc_page NewsRoot
	nsc_ret

	
.chainComplete
	nsc_compare_newsvar sMinigameFlag, .secondPrize, .firstPrize, .secondPrize, 1, 0
.firstPrize
	nsc_textbox 1, 14, .textChainComplete
	nsc_giveitem TM_SLEEP_TALK, .firstPrizeContinue, .firstPrizeDone
.firstPrizeContinue
	nsc_playsound SFX_GET_TM
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.firstPrizeDone
	nsc_waitbutton
	nsc_page NewsRoot
.secondPrize
	nsc_textbox 1, 14, .textChainComplete2
	nsc_giveitem HYPER_POTION, .secondPrizeContinue, .secondPrizeDone
.secondPrizeContinue
	nsc_playsound SFX_ITEM
.secondPrizeDone
	nsc_waitbutton
	nsc_page NewsRoot
	
	
.answer1Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, TAUROS
.answer2Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, TOTODILE
.answer3Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SNEASEL
.answer4Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SANDSHREW
.answer5Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, MAROWAK
.answer6Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, HYPNO
.answer7Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SLOWPOKE
.answer8Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, FARFETCH_D
.fail
	nsc_set wChain, 0
	
	nsc_playsound SFX_WRONG
	nsc_textbox 1, 14, .textWrongAnswer
	nsc_waitbutton
	
	nsc_bit wChain, 0, .generate_question, .generate_question

.pass
	nsc_add wChain, 1
	
	nsc_playsound SFX_LEVEL_UP
	
	
	nsc_compare wChain, .nextQuestion, .chainComplete, .chainComplete, 1, 5
.nextQuestion
	
	nsc_textbox 1, 14, .textRightAnswer
	nsc_waitbutton
	
	;nsc_bit wChain, 0, .generate_question, .generate_question
	; fall thru



MACRO define_answers
DEF hintA = \1
DEF hintB = \2
SHIFT 2
DEF hintC = 1
REPT 12
DEF ANSWER_{d:hintA}_{d:hintB}_{d:hintC} EQUS "\1"
DEF hintC = hintC + 1
SHIFT
ENDR
ENDM

define_answers 1, 1, SNEASEL, INVALID, SNEASEL, INVALID, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL
define_answers 1, 2, INVALID, HYPNO, SNEASEL, INVALID, SANDSHREW, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 1, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 1, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 1, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 1, 6, INVALID, INVALID, INVALID, INVALID, MAROWAK, HYPNO, HYPNO, MAROWAK, INVALID, INVALID, INVALID, INVALID
define_answers 1, 7, SNEASEL, INVALID, SNEASEL, INVALID, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL
define_answers 1, 8, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID

define_answers 2, 1, SNEASEL, TAUROS, INVALID, INVALID, TAUROS, SNEASEL, INVALID, INVALID, INVALID, INVALID, TAUROS, SNEASEL
define_answers 2, 2, INVALID, HYPNO, SNEASEL, INVALID, SANDSHREW, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 2, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 2, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 2, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 2, 6, INVALID, INVALID, INVALID, INVALID, MAROWAK, HYPNO, HYPNO, MAROWAK, INVALID, INVALID, INVALID, INVALID
define_answers 2, 7, SNEASEL, TAUROS, INVALID, INVALID, TAUROS, SNEASEL, INVALID, INVALID, INVALID, INVALID, TAUROS, SNEASEL
define_answers 2, 8, INVALID, INVALID, INVALID, SANDSHREW, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

define_answers 3, 1, INVALID, TAUROS, TAUROS, INVALID, TAUROS, INVALID, INVALID, TAUROS, INVALID, TAUROS, TAUROS, INVALID
define_answers 3, 2, SANDSHREW, HYPNO, INVALID, INVALID, SANDSHREW, HYPNO, HYPNO, SANDSHREW, INVALID, INVALID, INVALID, INVALID
define_answers 3, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 3, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 3, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 3, 6, FARFETCH_D, INVALID, INVALID, INVALID, MAROWAK, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 3, 7, FARFETCH_D, TAUROS, TAUROS, FARFETCH_D, TAUROS, FARFETCH_D, INVALID, INVALID, INVALID, INVALID, TAUROS, FARFETCH_D
define_answers 3, 8, INVALID, INVALID, INVALID, INVALID, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

define_answers 4, 1, INVALID, TAUROS, TAUROS, INVALID, TAUROS, INVALID, INVALID, TAUROS, INVALID, TAUROS, TAUROS, INVALID
define_answers 4, 2, SANDSHREW, HYPNO, INVALID, INVALID, SANDSHREW, HYPNO, HYPNO, SANDSHREW, INVALID, INVALID, INVALID, INVALID
define_answers 4, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 4, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 4, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 4, 6, FARFETCH_D, INVALID, INVALID, INVALID, MAROWAK, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 4, 7, FARFETCH_D, TAUROS, TAUROS, FARFETCH_D, TAUROS, FARFETCH_D, INVALID, INVALID, INVALID, INVALID, TAUROS, FARFETCH_D
define_answers 4, 8, INVALID, INVALID, INVALID, INVALID, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

MACRO answer_check_2
.hintA\1B\2
	nsc_compare wHint3, .answer{ANSWER_\1_\2_1}, .answer{ANSWER_\1_\2_2}, .answer_\1_\2_greater, 1, 1
.answer_\1_\2_greater
	nsc_compare wHint3, .answer{ANSWER_\1_\2_3}, .answer{ANSWER_\1_\2_4}, .answer_\1_\2_greater2, 1, 3
.answer_\1_\2_greater2
	nsc_compare wHint3, .answer{ANSWER_\1_\2_5}, .answer{ANSWER_\1_\2_6}, .answer_\1_\2_greater3, 1, 5
.answer_\1_\2_greater3
	nsc_compare wHint3, .answer{ANSWER_\1_\2_7}, .answer{ANSWER_\1_\2_8}, .answer_\1_\2_greater4, 1, 7
.answer_\1_\2_greater4
	nsc_compare wHint3, .answer{ANSWER_\1_\2_9}, .answer{ANSWER_\1_\2_10}, .answer_\1_\2_greater5, 1, 9
.answer_\1_\2_greater5
	nsc_compare wHint3, .answer{ANSWER_\1_\2_11}, .answer{ANSWER_\1_\2_12}, .answerINVALID, 1, 11
ENDM

MACRO answer_check
.hintA\1
	nsc_compare wHint2, .hintA\1B1, .hintA\1B2, .hintA\1BGreater, 1, 1
.hintA\1BGreater
	nsc_compare wHint2, .hintA\1B3, .hintA\1B4, .hintA\1BGreater2, 1, 3
.hintA\1BGreater2
	nsc_compare wHint2, .hintA\1B5, .hintA\1B6, .hintA\1BGreater3, 1, 5
.hintA\1BGreater3
	nsc_compare wHint2, .hintA\1B7, .hintA\1B8, .hintA\1B8, 1, 7

	answer_check_2 \1, 1
	answer_check_2 \1, 2
	answer_check_2 \1, 3
	answer_check_2 \1, 4
	answer_check_2 \1, 5
	answer_check_2 \1, 6
	answer_check_2 \1, 7
	answer_check_2 \1, 8
ENDM

.answerINVALID
.generate_question
	
	nsc_ramcopy hRandomAdd, wHint1, 2
	nsc_flagop wHint1, 2, FLAG_CLEAR
	nsc_flagop wHint1, 3, FLAG_CLEAR
	nsc_flagop wHint1, 4, FLAG_CLEAR
	nsc_flagop wHint1, 5, FLAG_CLEAR
	nsc_flagop wHint1, 6, FLAG_CLEAR
	nsc_flagop wHint1, 7, FLAG_CLEAR
	nsc_flagop wHint2, 3, FLAG_CLEAR
	nsc_flagop wHint2, 4, FLAG_CLEAR
	nsc_flagop wHint2, 5, FLAG_CLEAR
	nsc_flagop wHint2, 6, FLAG_CLEAR
	nsc_flagop wHint2, 7, FLAG_CLEAR
	; wait for new RNG rolls
	nsc_delay 1
	nsc_ramcopy hRandomAdd, wHint3, 1
	nsc_flagop wHint3, 4, FLAG_CLEAR
	nsc_flagop wHint3, 5, FLAG_CLEAR
	nsc_flagop wHint3, 6, FLAG_CLEAR
	nsc_flagop wHint3, 7, FLAG_CLEAR


.getAnswer

	nsc_compare wHint1, .hintA1, .hintA2, .hintAGreater, 1, 1
.hintAGreater
	nsc_compare wHint1, .hintA3, .hintA4, .hintA4, 1, 3

	answer_check 1
	answer_check 2
	answer_check 3
	answer_check 4
	
.answerTAUROS
	nsc_set wCorrectAnswer, TAUROS ; using species ID because... why not i guess?
	nsc_page ChainQuiz
.answerTOTODILE
	nsc_set wCorrectAnswer, TOTODILE
	nsc_page ChainQuiz
.answerSNEASEL
	nsc_set wCorrectAnswer, SNEASEL
	nsc_page ChainQuiz
.answerSANDSHREW
	nsc_set wCorrectAnswer, SANDSHREW
	nsc_page ChainQuiz
.answerMAROWAK
	nsc_set wCorrectAnswer, MAROWAK
	nsc_page ChainQuiz
.answerHYPNO
	nsc_set wCorrectAnswer, HYPNO
	nsc_page ChainQuiz
.answerSLOWPOKE
	nsc_set wCorrectAnswer, SLOWPOKE
	nsc_page ChainQuiz
.answerFARFETCH_D
	nsc_set wCorrectAnswer, FARFETCH_D
	nsc_page ChainQuiz

.answer1Name
	lang J, "ケンタロス"
	lang E, "TAUROS"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
.answer1Desc
.answer2Desc
.answer3Desc
.answer4Desc
.answer5Desc
.answer6Desc
.answer7Desc
.answer8Desc
	db "@"
	
.answer2Name
	lang J, "ワニノコ"
	lang E, "TOTODILE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer3Name
	lang J, "ニューラ"
	lang E, "SNEASEL"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer4Name
	lang J, "サンド"
	lang E, "SANDSHREW"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer5Name
	lang J, "ガラガラ"
	lang E, "MAROWAK"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer6Name
	lang J, "スリーパー"
	lang E, "HYPNO"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer7Name
	lang J, "ヤドン"
	lang E, "SLOWPOKE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.answer8Name
	lang J, "カモネギ"
	lang E, "FARFETCH'D"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
; this is a bodge...
;.questionPreset1
;	db 3, 0,  7, TAUROS
;.questionPreset2
;	db 1, 2,  0, TOTODILE
;.questionPreset3
;	db 0, 0,  0, SNEASEL
;.questionPreset4
;	db 2, 1,  7, SANDSHREW
;.questionPreset5
;	db 3, 4,  9, MAROWAK
;.questionPreset6
;	db 0, 5,  5, HYPNO
;.questionPreset7
;	db 0, 7, 10, SLOWPOKE
;.questionPreset8
;	db 2, 6, 11, FARFETCH_D



.textHintA1
	; Japanese
	lang J, "ノーマル　ではない"
	lang E, "Not NORMAL type."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintA2
	; Japanese
	lang J, "ひこう　ではない"
	
	; English
	lang E, "Not FLYING type."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintA3
	; Japanese
	lang J, "こおり　ではない"
	
	; English
	lang E, "Not ICE type."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintA4
	; Japanese
	lang J, "あく　ではない"
	
	; English
	lang E, "Not DARK type."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.textHintB1
	; Japanese
	lang J, "しっぽが　わかれてる"
	
	; English
	lang E, "Its tail is split."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB2
	; Japanese
	lang J, "みみが　とがっている"
	
	; English
	lang E, "Has pointy ears."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB3
	; Japanese
	lang J, "きばが　ある"
	
	; English
	lang E, "Has pointy teeth."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB4
	; Japanese
	lang J, "しんか　できる"
	
	; English
	lang E, "It evolves."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB5
	; Japanese
	lang J, "なにか　かぶっている"
	
	; English
	lang E, "Wears a headpiece."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB6
	; Japanese
	lang J, "なにか　もっている"
	
	; English
	lang E, "Holds something."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB7
	; Japanese
	lang J, "おでこにワンポイント"
	
	; English
	lang E, "Has forehead mark."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintB8
	; Japanese
	lang J, "タマゴから　うまれる"
	
	; English
	lang E, "Comes from an EGG."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.textHintC01
	; Japanese
	lang J, "いあいぎり　できる"
	
	; English
	lang E, "Can use CUT."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC02 ; NOTE: Not recorded as existing
	; Japanese
	lang J, "いあいぎり　できない"
	
	; English
	lang E, "Can't use CUT."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC03
	; Japanese
	lang J, "なみのり　できる"
	
	; English
	lang E, "Can use SURF."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC04
	; Japanese
	lang J, "なみのり　できない"
	
	; English
	lang E, "Can't use SURF."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC05
	; Japanese
	lang J, "かいりき　できる"
	
	; English
	lang E, "Can use STRENGTH."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC06
	; Japanese
	lang J, "かいりき　できない"
	
	; English
	lang E, "Can't use STRENGTH."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC07
	; Japanese
	lang J, "フラッシュ　できる"
	
	; English
	lang E, "Can use FLASH."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC08
	; Japanese
	lang J, "フラッシュ　できない"
	
	; English
	lang E, "Can't use FLASH."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC09
	; Japanese
	lang J, "うずしお　できる"
	
	; English
	lang E, "Can use WHIRLPOOL."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC10 ; NOTE: Not recorded as existing
	; Japanese
	lang J, "うずしお　できない"
	
	; English
	lang E, "Can't use"
	lang_next E, "WHIRLPOOL."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC11
	; Japanese
	lang J, "たいあたり　できる"
	
	; English
	lang E, "Can use TACKLE."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.textHintC12 ; NOTE: Not recorded as existing
	; Japanese
	lang J, "たいあたり　できない"
	
	; English
	lang E, "Can't use TACKLE."
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
	
	
.textWrongAnswer
	; Japanese
	lang_text J, "ざんねん！　はずれだよ…"
	
	; English	
	lang_text E, "Too bad…"
	lang_line E, "That was wrong!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
.textRightAnswer
	; Japanese
	lang_text J, "せいかい！"
	lang_line J, "つぎの　もんだい　だよ"
	
	; English
	lang_text E, "Correct! "
	lang_line E, "Next question!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
.textChainComplete
	; Japanese
	lang_text J, "５もんせいかい　おめでとう！"
	lang_line J, "わざマシン３５を　プレゼント！"
	lang_para J, "わざマシン３５を　もらった！"
	
	; English
	lang_text E, "Five in a row!"
	lang_line E, "Congratulations!"
	
	lang_para E, "Here's TM35 as"
	lang_line E, "a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM35."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textChainComplete2
	; Japanese
	lang_text J, "５もんせいかい　おめでとう！"
	lang_line J, "すごいキズぐすりを　プレゼント！"
	lang_para J, "すごいキズぐすりを　もらった！"
	
	; English
	lang_text E, "Five in a row!"
	lang_line E, "Congratulations!"
	
	lang_para E, "Here's a HYPER"
	lang_line E, "POTION as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "HYPER POTION."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
ENDC