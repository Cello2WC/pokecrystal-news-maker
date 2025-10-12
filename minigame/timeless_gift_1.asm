IF DEF(_MINIGAME_H)

MACRO minigame_start
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page MinigameStart
ENDM

MACRO minigame_name
	lang J, "ときをこえたプレゼント"
	lang E, "A TIMELESS GIFT"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

MACRO minigame_desc
	lang      J, "?"
	
	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
ENDM

ELSE
MinigameStart::
	news_screen PokemonQuizIntro, MUSIC_AZALEA_TOWN;MUSIC_DANCING_HALL;MUSIC_SAGE_ENCOUNTER

	news_def_pals

	news_def_boxes
	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
	news_menu  2, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
	;news_menu  1, 10, 1, 1, 0, 0, $03, $00, $00, $00, $02, $01
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .aButton ; script pointer b button
	news_buttonscript          ; script pointer select button
	news_buttonscript .aButton ; script pointer start button
	news_buttonscript          ; script pointer left button
	news_buttonscript          ; script pointer right button
	news_buttonscript          ; script pointer up button
	news_buttonscript          ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuItemText
	news_menuitem_scripts .menuItemScript
	news_menuitem_descs   .menuItemDescription
	
.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 2, COOLTRAINERF, 7
	nsc_select
	nsc_waitbutton
	nsc_page LuckTest ; should be janken or dice, _then_ quiz
	nsc_ret
	
.menuItemText
	minigame_name
	db "@"
	
.menuItemScript
	nsc_textbox 1, 14, .greenIntroText
	nsc_ret

.menuItemDescription
	lang      J, "?"
	
	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.greenIntroText
	lang_text J, "チエコ『?"
	
	lang_text E, "MAIZIE: ?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done








	news_screen LuckTest, MUSIC_AZALEA_TOWN
	news_def_pals
	news_def_boxes
	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	news_box 4,  4, 12,  8, NEWSBORDER_BLOCKY, 5
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	news_menu 6, 6,   1, 3,   0, 2,   -1, $00, $00, $00, $02, $01
	
	news_buttonscript .aButton    ; script pointer a button
	news_buttonscript .bButton    ; script pointer b button
	news_buttonscript             ; script pointer select button
	news_buttonscript .aButton    ; script pointer start button
	news_buttonscript             ; script pointer left button
	news_buttonscript             ; script pointer right button
	news_buttonscript .upButton   ; script pointer up button
	news_buttonscript .downButton ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuRockText,   .menuPaperText,   .menuScissorsText
	news_menuitem_scripts .menuRockScript, .menuPaperScript, .menuScissorsScript
	news_menuitem_descs   .menuDummyDesc,  .menuDummyDesc,   .menuDummyDesc

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1,  2, 17, 10
	nsc_clear 1, 13, 18,  4
	nsc_drawtrainer 6, 2, COOLTRAINERF, 7
	
.retry
	; CHIE's choice
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wMinigameRam0, 1
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 2
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 3
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 4
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 5
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 6
	nsc_flagop wMinigameRam0, FLAG_CLEAR, 7 ; wMinigameRam0 &= %00000011
	nsc_compare wMinigameRam0, .continue, .retry, .retry, 1, 3 ; retry if generated a 3
.continue
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .textChieDeclare
	nsc_waitbutton
	nsc_select
	nsc_ret
	
.upButton
	nsc_up
	nsc_ret
	
.downButton
	nsc_down
	nsc_ret
	
	
.menuRockText
	lang J, "グー"
	lang E, "ROCK"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuPaperText
	lang J, "パー"
	lang E, "PAPER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuScissorsText
	lang J, "チョキ"
	lang E, "SCISSORS"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
.menuDummyDesc
	db "@"
	
	
.textChieDeclare
	nts_start
	nts_switch wMinigameRam0, .textChieRock, .textChiePaper, .textChieScissors
	nts_end
	done
	
.textChieRock
	lang J, "チエコ『グー"
	lang E, "MAIZIE: ROCK"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.textChiePaper
	lang J, "チエコ『パー"
	lang E, "MAIZIE: PAPER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.textChieScissors
	lang J, "チエコ『チョキ"
	lang E, "MAIZIE: SCISSORS"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuRockScript
	nsc_compare wMinigameRam0, .jankenTie, .jankenLose, .jankenWin, 1, 1

.menuPaperScript
	nsc_compare wMinigameRam0, .jankenWin, .jankenTie, .jankenLose, 1, 1

.menuScissorsScript
	nsc_compare wMinigameRam0, .jankenLose, .jankenWin, .jankenTie, 1, 1
	
.jankenTie
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenTieText
	nsc_waitbutton
	nsc_page LuckTest
	nsc_ret
.jankenTieText
	lang_text J, "?"
	lang_text E, "MAIZIE: We tied…"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.jankenLose
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenLoseText
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
.jankenLoseText
	lang_text J, "?"
	lang_text E, "MAIZIE: I win!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
		
.jankenWin
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenWinText
	nsc_waitbutton
	nsc_page PokemonQuiz
	nsc_ret
.jankenWinText
	lang_text J, "?"
	lang_text E, "MAIZIE: You win!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

	news_screen PokemonQuiz, MUSIC_TIN_TOWER

	news_def_pals

	news_def_boxes
	news_box 0,  0, 20, 15, NEWSBORDER_BLOCKY, 1
	news_box 0, 14, 20,  4, NEWSBORDER_BLOCKY, 5
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wQuizQuestionNo, \
		.question1Text, \
		.question2Text, \
		.question3Text, \
		.question4Text, \
		.question5Text
	nts_end
	
	news_menu  2, 16, 3, 1, 5, 2, -1, $00, $00, $00, $00, $04
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .bButton ; script pointer b button
	news_buttonscript ; script pointer select button
	news_buttonscript .bButton ; script pointer start button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript .rightButton ; script pointer right button
	news_buttonscript ; script pointer up button
	news_buttonscript ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuItemYesText,   .menuItemNoText,   .menuItemQuitText
	news_menuitem_scripts .menuItemAnswer1Script, .menuItemAnswer2Script, .menuItemQuitScript
	news_menuitem_descs   .dummyDescription,  .dummyDescription, .dummyDescription

.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret

.leftButton
	nsc_left
	nsc_ret

.rightButton
	nsc_right
	nsc_ret

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.menuItemYesText
	lang J, "はい"
	lang E, "YES"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuItemNoText
	lang J, "いいえ"
	lang E, "NO"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuItemQuitText
	lang J, "やめる"
	lang E, "QUIT"
	lang D, "ZUR."
	lang F, "RET"
	lang I, "ESCI"
	lang S, "?"
	db "@"

	
	
MACRO quiz_answers
DEF _ANSWER_NUMBER = \1
.menuItemAnswer\1Script
DEF _QUESTION_NUMBER = 1
	nsc_add wQuizQuestionNo, 1
REPT _NARG - 1
	nsc_compare wQuizQuestionNo, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, 1, {_QUESTION_NUMBER}

.answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}
IF \2 != 0
	nsc_add wQuizScore, \2;1
ENDC
SHIFT
IF _NARG == 1
	nsc_page QuizScoreEvaluation
ELSE
	nsc_page PokemonQuiz
ENDC
	nsc_ret
	
.answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}
DEF _QUESTION_NUMBER = _QUESTION_NUMBER + 1
ENDR
	nsc_ret
ENDM
	
	quiz_answers 1,    1, 1, 1, 0, 0
	quiz_answers 2,    0, 0, 0, 1, 1
	

.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.dummyDescription
	db "@"
	
.question1Text
	lang J,      "ポケモンはしたし　いがいのひとでも"
	lang_next J, "まもった りすけたり　してくれる？"
	
	lang E,      "Can #MON help"
	lang_next E, "and protect people" 
	lang_next E, "other than their"
	lang_next E, "<TRAINER>S?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"

	next "@"
	
.question2Text
	lang J,      "にんげんを　こわがる"
	lang_next J, "ポケモンがいれば"
	lang_next J, "それはにんげんのせい？"

	lang E,      "If #MON are"
	lang_next E, "afraid of humans,"
	lang_next E, "is that the fault"
	lang_next E, "of humans?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	lang J,      "ポケモンをすきなひとが"
	lang_next J, "ポケモントレーナー　いがいに"
	lang_next J, "めざすものはある？"
	
	lang E,      "Can people who"
	lang_next E, "love #MON be"
	lang_next E, "something aside"
	lang_next E, "from a #MON"
	lang_next E, "<TRAINER>?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question4Text
	lang J,      "こどものトレーナーは"
	lang_next J, "やっぱりおとなのトレーナー"
	lang_next J, "より　よわい？"
	
	lang E,      "Are young <TRAINER>S"
	lang_next E, "weaker than adult "
	lang_next E, "<TRAINER>S?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question5Text
	lang J,      "むかしからの　いいつたえは"
	lang_next J, "すべてウソだとおもう？"
	
	lang E,      "Do you think the" 
	lang_next E, "legends of old"
	lang_next E, "are made-up?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"

	
	
	news_screen QuizScoreEvaluation, MUSIC_AZALEA_TOWN

	news_def_pals

	news_def_boxes
	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .aButton ; script pointer b button
	news_buttonscript          ; script pointer select button
	news_buttonscript .aButton ; script pointer start button
	news_buttonscript          ; script pointer left button
	news_buttonscript          ; script pointer right button
	news_buttonscript          ; script pointer up button
	news_buttonscript          ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuItemText ; pointers to text for each menu item
	news_menuitem_scripts .menuItemScript ; pointers to script for each menu item
	news_menuitem_descs   .menuItemDescription ; pointers to description text for each menu item
	
.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 2, COOLTRAINERF, 7
	nsc_select
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textNotAllCorrect
	nsc_yesno 13, 7, .restartQuiz, .giveUp
;	nsc_page NewsRoot
;	nsc_ret

.restartQuiz
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textTryAgain
	nsc_waitbutton
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page PokemonQuiz

.giveUp
	nsc_page NewsRoot
	nsc_ret
	
.menuItemText
	lang J, "チエコのひょうか"
	lang E, "MAIZIE's RATING"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuItemScript
	nsc_textbox 1, 14, .textScoreIntro
	nsc_compare wQuizScore, .fail, .pass, .pass, 1, 5
.fail
	nsc_textbox 1, 14, .textFail
	nsc_playsound SFX_DEX_FANFARE_LESS_THAN_20
	nsc_ret
.pass
	nsc_textbox 1, 14, .textPass
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_waitbutton
	
	nsc_compare sGSBallFlag, .done, .gift, .done, 1,    0
.gift
	nsc_set wGSBallFlagRam, 1
	nsc_ramcopy wGSBallFlagRam, sGSBallFlag, $0001
	
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift
	nsc_waitbutton
.done
	;nsc_clear 1, 13, 18, 4
	;nsc_textbox 1, 14, .textFarewell
	;nsc_waitbutton
	
	nsc_page NewsRoot
	nsc_ret


.menuItemDescription
	lang      J, "？"

	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"
	
.textScoreIntro
	lang_text J, "チエコ『？"
	
	lang_text E, "MAIZIE: ?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	para "<……>　<……>　<……>"
	para ""
	done
.textFail
	lang_text J, "チエコ『？"
	
	lang_text E, "MAIZIE:"
	lang_line E, "quiz failed text"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done

	
.textPass
	lang_text J, "チエコ『？"
	
	lang_text E, "MAIZIE:"
	lang_line E, "quiz passed text"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textNotAllCorrect
	lang_text J, "？"
	
	lang_text E, "?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textTryAgain
	lang_text J, "チエコ『？"
	lang_text E, "MAIZIE: ?"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textGiveGift
	lang_text J, "？"
	
	lang_text E, "?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

ENDC
