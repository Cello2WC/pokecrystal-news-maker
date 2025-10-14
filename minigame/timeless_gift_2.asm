; Dice variant

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wPlayersRoll    EQU wNewsScratch0
DEF wChiekosRoll    EQU wNewsScratch1
DEF wQuizQuestionNo EQU wNewsScratch2
DEF wQuizScore      EQU wNewsScratch3

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
	;news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
	news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
	;news_menu  1, 10, 1, 1, 0, 0, $03, $00, $00, $00, $02, $01
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .aButton ; script pointer b button
	news_buttonscript          ; script pointer select button
	news_buttonscript .aButton ; script pointer start button
	news_buttonscript          ; script pointer right button
	news_buttonscript          ; script pointer left button
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
	
	
		
.retry
	; player's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wPlayersRoll, 1
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 3
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 4
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 5
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 6
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wPlayersRoll, .continue, .retry, .retry, 1, 6 ; retry if generated a 7 or 8
.continue
	nsc_add wPlayersRoll, 1
	
	
	
	;nsc_waitbutton
	nsc_page LuckTest
	nsc_ret
	
.menuItemText
	minigame_name
	db "@"
	
.menuItemScript
	nsc_textbox 1, 14, .maizieIntroText
	nsc_yesno 13, 7, .done, .quit
.done
	nsc_ret
.quit
	; quit text potentially goes here
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.menuItemDescription
	lang      J, "?"
	
	lang      E, "?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.maizieIntroText
	; TODO: PLACEHOLDER TEXT
	lang_text J, "チエコ『かくかくしかじか 　ヒワダ"
	lang_line J, "タウン　かくかくしかじか　ガンテツ"
	lang_cont J, "かくかくしかじか　タイムトラベル"
	
	lang_text E, "MAIZIE: something"
	lang_line E, "something AZALEA"
	lang_para E, "something some-"
	lang_line E, "thing KURT's"
	lang_cont E, "granddaughter"
	lang_para E, "something some-"
	lang_line E, "thing time travel"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done








	news_screen LuckTest, MUSIC_AZALEA_TOWN
	news_def_pals
	news_def_boxes
;	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	;news_box 0, 14, 20,  4, NEWSBORDER_GLOWY,  4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
;	news_box 4,  6, 12,  6, NEWSBORDER_BLOCKY, 5
	news_def_strings
	news_string 1, 2, ""
	
	; TODO: PLACEHOLDER TEXT
	
	nts_start
	nts_player_name 0
	nts_end
	lang J, "は　"
	lang      E, " rolled"
	lang_next E, "a"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	nts_start
	nts_number wPlayersRoll, 1, 2
	nts_end
	lang J,      "を"
	lang_next J, "だしました！"
	lang E, "!"
	lang D, "!"
	lang F, "!"
	lang I, "!"
	lang S, "!"
	
	lang_next J, "チエコの　ロール？"
	lang_next E, "MAIZIE will roll…"
	lang_next D, "?"
	lang_next F, "?"
	lang_next I, "?"
	lang_next S, "?"
	
	db "@"
	
	
	
	news_menu 2, 16,   2, 1,   8, 0,   -1, $00, $00, $00, $02, $01
	
	news_buttonscript .aButton    ; script pointer a button
	news_buttonscript .bButton    ; script pointer b button
	news_buttonscript             ; script pointer select button
	news_buttonscript .aButton    ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript ;.upButton   ; script pointer up button
	news_buttonscript ;.downButton ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 1, 1
	news_norankingstable
	
	news_menuitem_names   .menuHigherText,   .menuLowerText
	news_menuitem_scripts .menuHigherScript, .menuLowerScript
	news_menuitem_descs   .menuDummyDesc,    .menuDummyDesc ;.textYouRolled,    .textYouRolled

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.aButton
	nsc_playsound SFX_READ_TEXT
	
	
	
	
	nsc_clear 1, 15, 18, 2
	;nsc_clear 1,  2, 18, 12

	nsc_delay 20
	nsc_printstring 1, 8, .textDot
	nsc_delay 20
	nsc_printstring 2, 8, .textDot
	nsc_delay 20
	nsc_printstring 3, 8, .textDot
	
	nsc_delay 60
	
.retry2b
	; maizie's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wChiekosRoll, 1
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 3
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 4
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 5
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 6
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wChiekosRoll, .continue2b, .retry2b, .retry2b, 1, 6 ; retry if generated a 7 or 8
.continue2b
	nsc_add wChiekosRoll, 1
	nsc_printstring 1, 10, .textMaizieRolled
	
	
	;nsc_printstring 1, 2, .textMaizieRolled
	nsc_waitbutton
;	nsc_clear 1,  2, 17, 10
;	nsc_clear 1, 13, 18,  4
	nsc_clear 1,  2, 18, 10
	;nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	nsc_drawtrainer 6, 2, COOLTRAINERF, 7
	
	
	
	
	nsc_select
	
	
	
	nsc_ret
	
;.upButton
	;nsc_up
	;nsc_printstring 1, 14, .textYouRolled
	
.rightButton
	nsc_right
	nsc_ret
	
;.downButton
	;nsc_down
	;nsc_printstring 1, 14, .textYouRolled
.leftButton
	nsc_left
	nsc_ret
	
	
.menuHigherText
	lang J, "うえ"
	lang E, "HIGHER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuLowerText
	lang J, "した"
	lang E, "LOWER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
.menuDummyDesc
	db "@"
	
	
;.textYouRolled
;	nts_start
;	nts_player_name 0
;	nts_end
;	lang J, ""
;	lang E, " rolled"
;	lang_line E, "a "
;	lang D, "?"
;	lang F, "?"
;	lang I, "?"
;	lang S, "?"
;	nts_start
;	nts_switch wPlayersRoll, .one, .two, .three, .four, .five, .six
;	nts_end
;	db "@"


.menuHigherScript
	;nsc_playmusic MUSIC_RIVAL_BATTLE
	nsc_compareram wChiekosRoll, 1, wPlayersRoll, .jankenLose, .jankenTie, .jankenWin

.menuLowerScript
	;nsc_playmusic MUSIC_RIVAL_BATTLE
	nsc_compareram wChiekosRoll, 1, wPlayersRoll, .jankenWin, .jankenTie, .jankenLose
	
	
.textDot
	db "<DOT>"
	db "@"
	
	; BUG: sometimes maizie's roll doesnt print and i have no clue why
	;      please help it is the same exact code that prints the player's roll
.textMaizieRolled
	lang J, "チエコは　"
	lang      E, "MAIZIE rolled a"
	;lang_next E, "a"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	nts_start
	nts_number wChiekosRoll, 1, 2
	nts_end
	lang J,      "を"
	lang_next J, "だしました！"
	lang E, "!"
	lang D, "!"
	lang F, "!"
	lang I, "!"
	lang S, "!"
	
	db "@"
	
	
	
	
.jankenTie
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenTieText
	
.retry3
	; player's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wPlayersRoll, 1
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 3
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 4
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 5
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 6
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wPlayersRoll, .continue3, .retry3, .retry3, 1, 6 ; retry if generated a 7 or 8
.continue3
	nsc_add wPlayersRoll, 1
	
	
	
	nsc_waitbutton
	nsc_page LuckTest
	nsc_ret
	
	; TODO: PLACEHOLDER TEXT
.jankenTieText
	lang_text J, "チエコ『ひきわけ"
	lang_text E, "MAIZIE: We tied…"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.jankenLose
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenLoseText
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
	
	; TODO: PLACEHOLDER TEXT
.jankenLoseText
	lang_text J, "チエコ『あたしの　かち"
	lang_text E, "MAIZIE: I win!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
		
.jankenWin
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenWinText
	nsc_waitbutton
	nsc_page PokemonQuiz
	nsc_ret
	
	; TODO: PLACEHOLDER TEXT
.jankenWinText
	lang_text J, "チエコ『あなたの　かち"
	lang_text E, "MAIZIE: You win!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

	news_screen PokemonQuiz, MUSIC_TIN_TOWER

	news_def_pals

	news_def_boxes
	;news_box 0,  0, 20, 15, NEWSBORDER_BLOCKY, 1
	;news_box 0, 14, 20,  4, NEWSBORDER_BLOCKY, 5
	news_box 0, 14, 20,  4, NEWSBORDER_GLOWY,  4
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wQuizQuestionNo, \
		.question1Text, \
		.question2Text, \
		.question3Text, \
		.question4Text, \
		.question5Text, \
		.question6Text, \
		.question7Text, \
		.question8Text
	nts_end
	
	news_menu  2, 16, 3, 1, 5, 2, -1, $00, $00, $00, $00, $04
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .bButton ; script pointer b button
	news_buttonscript ; script pointer select button
	news_buttonscript .bButton ; script pointer start button
	news_buttonscript .rightButton ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
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

.rightButton
	nsc_right
	nsc_ret

.leftButton
	nsc_left
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
	
	quiz_answers 1,    1, 1, 1, 0, 0, 0, 0, 0
	quiz_answers 2,    0, 0, 0, 1, 1, 1, 1, 1
	

.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.dummyDescription
	db "@"
	
.question1Text
	lang J,      "コガネのちかつうろでしょうばいを"
	lang_next J, "しているひとはぜんぶで４にん？"
	
	lang E,      "Are there a total"
	lang_next E, "of four people"
	lang_next E, "doing business"
	lang_next E, "in the GOLDENROD"
	lang_next E, "UNDERGROUND?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"

	next "@"
	
.question2Text
	lang J,      "ラジオばんぐみ　アオイのあいことばに"
	lang_next J, "イトマルというあいことばはある？"

	lang E,      "Is SPINARAK one"
	lang_next E, "of the passwords"
	lang_next E, "in the radio show"
	lang_next E, "BUENA'S PASSWORD?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	lang J,      "しぜんこうえんに　はなが"
	lang_next J, "さいているところはある？"
	
	lang E,      "Are there any"
	lang_next E, "flowers in bloom"
	lang_next E, "at the NATIONAL"
	lang_next E, "PARK?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question4Text
	lang J,      "アサギの　とうだいで　アカリチャンが"
	lang_next J, "いるのはとうだいの５かい？"
	
	lang E,      "Is AMPHY found on"
	lang_next E, "OLIVINE LIGHTHOUSE"
	lang_next E, "5F?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question5Text
	lang J,      "いかりまんじゅうのねだんは４００円"
	
	lang E,      "Is the price of"
	lang_next E, "a RAGECANDYBAR"
	lang_next E, "¥400?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question6Text
	lang J,      "ロケットだんのアジトの　パスワードは"
	lang_next J, "ヤドンのしっぽ　と　オタチのしっぽ？"
	
	lang E,      "Are SLOWPOKETAIL"
	lang_next E, "and SENTRETTAIL"
	lang_next E, "the passwords"
	lang_next E, "used to access the"
	lang_next E, "boss's room in the"
	lang_next E, "ROCKET HIDEOUT?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question7Text
	lang J,      "たきのぼりをしたのちは"
	lang_next J, "うしろをむいている？"
	
	lang E,      "Do you face"
	lang_next E, "backwards after"
	lang_next E, "using WATERFALL?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question8Text
	lang J,      "ポケモンを４たいくりだしてくる"
	lang_next J, "ジムリーダーはマツバだけ？"
	
	lang E,      "Is MORTY the only"
	lang_next E, "GYM LEADER to use"
	lang_next E, "four #MON?"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"

	
	
	news_screen QuizScoreEvaluation, MUSIC_AZALEA_TOWN

	news_def_pals

	news_def_boxes
;	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,  4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
IF DEF(_LANG_J)
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
ELSE
	news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
ENDC
	
	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .aButton ; script pointer b button
	news_buttonscript          ; script pointer select button
	news_buttonscript .aButton ; script pointer start button
	news_buttonscript          ; script pointer right button
	news_buttonscript          ; script pointer left button
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
	nsc_compare wQuizScore, .fail, .pass, .pass, 1, 8
.fail
	nsc_textbox 1, 14, .textFail
	nsc_playsound SFX_DEX_FANFARE_LESS_THAN_20
	nsc_ret
.pass
	nsc_textbox 1, 14, .textPass
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_waitbutton
	
	nsc_compare sGSBallFlag, .noGSBall, .gift, .noGSBall, 1,    0
.gift
	nsc_set wNewsScratch5, 1
	nsc_ramcopy wNewsScratch5, sGSBallFlag, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
	
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift
	nsc_waitbutton

	;nsc_clear 1, 13, 18, 4
	;nsc_textbox 1, 14, .textFarewell
	;nsc_waitbutton
	
	nsc_page NewsRoot
	nsc_ret
	
.noGSBall
	nsc_compare_newsvar sMinigameFlag, .done, .TMgift, .done, 1, 0
.TMgift
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveTMGift
	nsc_giveitem TM_SOLARBEAM, .gotGift, .noGift
.gotGift
	nsc_playsound SFX_GET_TM
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.noGift
	nsc_waitbutton
.done
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
	; TODO: PLACEHOLDER TEXT
	lang_text J, "チエコ『すべる"
	
	lang_text E, "MAIZIE:"
	lang_line E, "quiz failed text"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done

	
.textPass
	; TODO: PLACEHOLDER TEXT
	lang_text J, "チエコ『ごうかく"
	
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
	
.textGiveTMGift
	lang_text J, "？"
	lang_para J, "わざマシン２２を　もらった！"
	
	lang_text E, "?"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM22."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

ENDC
