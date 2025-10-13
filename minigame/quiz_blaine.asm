IF DEF(_MINIGAME_H)

MACRO minigame_start
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page MinigameStart
ENDM

MACRO minigame_name
	lang J, "ポケモンクイズ！"
	lang E, "#MON QUIZ!"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

MACRO minigame_desc
	lang      J, "これまで<NO>ぼうけん<WO>どこまで"
	lang_line J, "おもいだせるか　テストします！"
	
	lang      E, "Test your memory"
	lang_line E, "of your adventure!"
	
	lang      D, "Erinnerst du dich"
	lang_line D, "an dein Abenteuer?"
	
	lang      F, "Testez vos souve-"
	lang_line F, "nirs d'aventures!"
	
	lang      I, "Quiz dei ricordi"
	lang_line I, "sull'avventura!"
	
	lang S, "?"
ENDM

ELSE
MinigameStart::
	news_screen PokemonQuizIntro, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box 0, 12, 20, 6, NEWSBORDER_GLOWY, 4
	
	
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
	nsc_drawtrainer 6, 2, BLAINE, 7
	nsc_select
	nsc_waitbutton
	nsc_page PokemonQuiz
	nsc_ret
	
.menuItemText
	lang J, "ポケモンクイズ！"
	lang E, "#MON QUIZ!"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuItemScript
	nsc_textbox 1, 14, .blaineIntroText
	nsc_ret

.menuItemDescription
	; TODO: this is the wrong text. i dont think the right text was preserved....
	lang      J, "クイズ　しゅうりょう"
	lang_line J, "ひょうか<WO>うけて　ください！"

	lang      E, "Take the QUIZ to"
	lang_line E, "receive a rating!"
	
	lang      D, "Die Bewertung"
	lang_line D, "deiner Antworten!"
	
	lang      F, "Faites le quiz et"
	lang_line F, "recevez un Avis!"
	
	lang      I, "Fai il quiz per"
	lang_line I, "una valutazione!"
	
	lang S, "?"
	
	db "@"

.blaineIntroText
	lang_text J, "カツラ『うおおーす！"
	lang_line J, "わしは　ねっけつ　クイズ　おやじ！"
	lang_para J, "グレン…　いや　ふたごじまの"
	lang_line J, "リーダー　カツラなのだー！"
	lang_para J, "いままで　なんで　わしの　でばんが"
	lang_line J, "なかったのか　ふしぎな　くらい！"
	lang_para J, "やっぱり　クイズと　いえば　わし！"
	lang_line J, "もえる　おとこの　クイズ"
	lang_cont J, "いくぞー！　うおおーす！！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK.
	lang_text E, "BLAINE: Hah!"
	lang_line E, "I'm the hotheaded"
	lang_cont E, "quiz master!"
	
	lang_para E, "I'm BLAINE, LEADER"
	lang_line E, "of CINNAB--"
	lang_line E, "of the SEAFOAM" ; TODO: funny gag, but game freak wouldn't do this...
	lang_cont E, "ISLANDS!"
	lang_para E, "It's a mystery why"
	lang_line E, "I haven't had my"
	lang_cont E, "turn yet!"
	lang_para E, "When it comes to"
	lang_line E, "quizzes, it's"
	lang_cont E, "gotta be me!"
	lang_para E, "Let's do the"
	lang_line E, "blazing man's quiz!"
	lang_para E, "Hah!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang S,      "?"

	done













	news_screen PokemonQuiz, MUSIC_GAME_CORNER

	news_def_pals

	news_def_boxes
	news_box 0, 14, 20, 4, NEWSBORDER_GLOWY, 4
	
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
		.question8Text, \
		.question9Text, \
		.question10Text
	nts_end
	
	news_menu  2, 16, 4, 1, 4, 2, -1, $00, $00, $00, $00, $04
	
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
	
	news_menuitem_names   .menuItemAnswer1Text,   .menuItemAnswer2Text,   .menuItemAnswer3Text,   .menuItemQuitText
	news_menuitem_scripts .menuItemAnswer1Script, .menuItemAnswer2Script, .menuItemAnswer3Script, .menuItemQuitScript
	news_menuitem_descs   .dummyDescription,      .dummyDescription,      .dummyDescription,      .dummyDescription

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

.menuItemAnswer1Text
	lang J, "１ばん"
	lang E, "1. "
	lang D, "1. "
	lang F, "1. "
	lang I, "1. "
	lang S, "1. "
	db "@"

.menuItemAnswer2Text
	lang J, "２ばん"
	lang E, "2. "
	lang D, "2. "
	lang F, "2. "
	lang I, "2. "
	lang S, "2. "
	db "@"

.menuItemAnswer3Text
	lang J, "３ばん"
	lang E, "3. "
	lang D, "3. "
	lang F, "3. "
	lang I, "3. "
	lang S, "3. "
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
	
	quiz_answers 1,    0, 1, 0, 0, 1, 1, 0, 1, 0, 0
	quiz_answers 2,    1, 0, 0, 0, 0, 0, 1, 0, 0, 1
	quiz_answers 3,    0, 0, 1, 1, 0, 0, 0, 0, 1, 0
	

.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.dummyDescription
	db "@"
	
.question1Text
	lang J,      "ウツギはかせが　ふねのチケットを"
	lang_next J, "くれるときの　セリフの　さいごは"
	lang_next J, "「カントーに　いったら…」　なに？"
	lang_next J, ""
	lang_next J, "１　もっと　つよく　なれるね！"
	lang_next J, "２　オーキドはかせに　よろしく！"
	lang_next J, "３　ほかの　のりものも　あるかもね！"
	
	; TODO: _VERY_ ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "When PROF.ELM gave"
	lang_next E, "you the S.S.TICKET"
	lang_next E, "he told you to…"
	lang_next E, "1. Get stronger!"
	lang_next E, "2. Say hi to OAK!"
	lang_next E, "3. "
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"

	next "@"
	
.question2Text
	lang J,      "アクアごうの　なかで　まごを"
	lang_next J, "さがしている　おじさん"
	lang_next J, "どこから　でてきた？"
	lang_next J, ""
	lang_next J, "１　よこから　でてきた"
	lang_next J, "２　うえから　でてきた"
	lang_next J, "３　へやの　なかから　でてきた"

	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "Where did the old"
	lang_next E, "man on the S.S."
	lang_next E, "AQUA come from?"
	lang_next E, "1. Side 2. Above"
	lang_next E, "3. Inside a cabin"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	;Japanese
	lang J,      "ぼうそうぞくの　３にんぐみ"
	lang_next J, "「カントー　ポケモン　れんごう」の"
	lang_next J, "なわばりは　もともと　どこだった？"
	lang_next J, ""
	lang_next J, "１　ディグダの　あな"
	lang_next J, "２　サイクリングロード"
	lang_next J, "３　ちかつうろ"
	
	;English
	lang E,      "Where'd the KANTO"
	lang_next E, "#MON FEDERATION"
	lang_next E, "first hang out?"
	lang_next E, "1.DIGLETT'S CAVE"
	lang_next E, "2.CYCLING ROAD"
	lang_next E, "3.UNDERGROUND PATH"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question4Text
	;Japanese
	lang J,      "きよめのおふだを　もらえたのは"
	lang_next J, "なにが　とりついて　いたから？"
	lang_next J, ""
	lang_next J, "１　ポケモンの　ゆうれい"
	lang_next J, "２　よくない　たましい"
	lang_next J, "３　ふきつな　カゲ"
	
	;English
	lang E,      "When you got the"
	lang_next E, "CLEANSE TAG what"
	lang_next E, "hovered over you?"
	lang_next E, "1. A ghost #MON"
	lang_next E, "2. An evil spirit"
	lang_next E, "3. Sinister shadow"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question5Text
	lang J,      "ハナダシティの　そばで　たたかう"
	lang_next J, "６にんぬきとは　まったく　かんけいの"
	lang_next J, "ない　おとこは　なぜ　いどんでくる？"
	lang_next J, ""
	lang_next J, "１　つかれた　トレーナーを　たおす"
	lang_next J, "２　トレーナーの　おかねを　うばう"
	lang_next J, "３　ロケットだんの　ために"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "Why did an extra"
	lang_next E, "fight with the"
	lang_next E, "six-pack <TRAINER>s?"
	lang_next E, "1. Easy wins"
	lang_next E, "2. Stealing money"
	lang_next E, "3. For TEAM <ROCKET>"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question6Text
	lang J,      "カスミと　カスミの　ボーイフレンドは"
	lang_next J, "どのような　ならびかたで"
	lang_next J, "デート　していた？"
	lang_next J, ""
	lang_next J, "１　よこに　ならんで　いた"
	lang_next J, "２　むかいあって　いた"
	lang_next J, "３　カスミが　１ぽ　まえに　いた"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "How were MISTY and"
	lang_next E, "her boyfriend line"
	lang_next E, "up on their date?"
	lang_next E, "1. Side by side"
	lang_next E, "2. Facing apart"
	lang_next E, "3. MISTY 1 step up"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question7Text
	;Japanese
	lang J,      "はつでんしょの　しょちょうは"
	lang_next J, "はつでんきの　ぶひんの　ことを"
	lang_next J, "どう　いっていた？"
	lang_next J, ""
	lang_next J, "１　いのちより　だいじ"
	lang_next J, "２　かわいい"
	lang_next J, "３　わしの　すべて"
	
	;English
	lang E,      "What did the POWER"
	lang_next E, "PLANT MANAGER call"
	lang_next E, "the generator?"
	lang_next E, "1. Most important"
	lang_next E, "2. Cute"
	lang_next E, "3. My beloved"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question8Text
	;Japanese
	lang J,      "ポケモン　だいすき　クラブの"
	lang_next J, "かいちょうが　そだてた　ポケモンの"
	lang_next J, "かずは　なんひき　いじょう？"
	lang_next J, ""
	lang_next J, "１　１５０"
	lang_next J, "２　２５０"
	lang_next J, "３　１０００"
	
	;English
	lang E,      "How many #MON"
	lang_next E, "has the CHAIRMAN"
	lang_next E, "of the #MON FAN"
	lang_next E, "CLUB raised?"
	lang_next E, "1. 150   2. 250"
	lang_next E, "3. 1000"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question9Text
	;Japanese
	lang J,      "モノマネむすめの　ピッピにんぎょうは"
	lang_next J, "どこに　キズが　ある？"
	lang_next J, ""
	lang_next J, "１　みぎがわの　はね"
	lang_next J, "２　ひだりみみの　さき"
	lang_next J, "３　みぎあしの　つけね"
	
	;English
	lang E,      "Where was the"
	lang_next E, "tear on COPYCAT's"
	lang_next E, "CLEFAIRY DOLL?"
	lang_next E, "1. Right wing"
	lang_next E, "2. Left ear"
	lang_next E, "3. Right leg"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question10Text
	lang J,      "ポケモンリーグで　ケーシィに"
	lang_next J, "いえまで　おくりとばして　もらうには"
	lang_next J, "どうすれば　いい？"
	lang_next J, ""
	lang_next J, "１　ケーシィに　さわる"
	lang_next J, "２　じぶんの　いえを　おもいうかべる"
	lang_next J, "３　しっかりと　めを　とじる"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "How does ABRA send"
	lang_next E, "you home from the"
	lang_next E, "POKEMON LEAGUE?"
	lang_next E, "1. Touch ABRA"
	lang_next E, "2. Picturing home"
	lang_next E, "3. Close your eyes"
	
How'd you get ABRA
to send you home
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
	news_screen QuizScoreEvaluation, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box 0, 12, 20, 6, NEWSBORDER_GLOWY, 4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
	news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
	
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
	nsc_drawtrainer 6, 2, BLAINE, 7
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
	lang J, "カツラのひょうか"
	lang E, "BLAINE's RATING"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuItemScript
	nsc_textbox 1, 14, .textScoreIntro
	nsc_compare wQuizScore, .score0, .score1, .greater, 1, 1
.score0
	nsc_textbox 1, 14, .textScore0
	nsc_playsound SFX_DEX_FANFARE_LESS_THAN_20
	nsc_ret
.score1
	nsc_textbox 1, 14, .textScore1
	nsc_playsound SFX_DEX_FANFARE_20_49
	nsc_ret
	
.greater
	nsc_compare wQuizScore, .score2, .score3, .greater2, 1, 3
.score2
	nsc_textbox 1, 14, .textScore2
	nsc_playsound SFX_DEX_FANFARE_50_79
	nsc_ret
.score3
	nsc_textbox 1, 14, .textScore3
	nsc_playsound SFX_DEX_FANFARE_80_109
	nsc_ret

.greater2
	nsc_compare wQuizScore, .score4, .score5, .greater3, 1, 5
.score4
	nsc_textbox 1, 14, .textScore4
	nsc_playsound SFX_CAUGHT_MON
	nsc_ret
.score5
	nsc_textbox 1, 14, .textScore5
	nsc_playsound SFX_DEX_FANFARE_140_169
	nsc_ret

.greater3
	nsc_compare wQuizScore, .score6, .score7, .greater4, 1, 7
.score6
	nsc_textbox 1, 14, .textScore6
	nsc_playsound SFX_DEX_FANFARE_170_199
	nsc_ret
.score7
	nsc_textbox 1, 14, .textScore7
	nsc_playsound SFX_DEX_FANFARE_200_229
	nsc_ret

.greater4
	nsc_compare wQuizScore, .score8, .score9, .score10, 1, 9
.score8
	nsc_textbox 1, 14, .textScore8
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_ret
.score9
	nsc_textbox 1, 14, .textScore9
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_ret
.score10
	nsc_textbox 1, 14, .textScore10
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_waitbutton
	
	nsc_compare_newsvar sMinigameFlag, .done, .gift, .done, 1, 0
.gift
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift1
	nsc_playsound SFX_GET_TM
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift2
	nsc_giveitem TM_FIRE_BLAST, .gotGift, .noGift
.gotGift
	nsc_playsound SFX_GET_TM
	nsc_set wGSBallFlagRam, 1
	nsc_ramcopy_newsvar wGSBallFlagRam, sMinigameFlag, 1
.noGift
.done
	; TODO: no space in pack error message
	nsc_waitbutton
	
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textFarewell
	nsc_waitbutton
	
	nsc_page NewsRoot
	nsc_ret


.menuItemDescription
	lang      J, "クイズ　しゅうりょう"
	lang_line J, "ひょうか<WO>うけて　ください！"

	lang      E, "Take the QUIZ to"
	lang_line E, "receive a rating!"
	
	lang      D, "Die Bewertung"
	lang_line D, "deiner Antworten!"
	
	lang      F, "Faites le quiz et"
	lang_line F, "recevez un Avis!"
	
	lang      I, "Fai il quiz per"
	lang_line I, "una valutazione!"
	
	lang S, "?"
	
	db "@"
	
.textScoreIntro
	; Japanese
	lang_text J, "カツラ『ごくろうさん！！"
	lang_line J, "わいの　クイズは　やっぱり"
	lang_cont J, "ひとあじ　ちがう　むずかしさ！"
	
	lang_para J, "なやみまくり　だった　だろー！！"
	lang_line J, "いくつ　あたったかな？"
	
	; English
	lang_text E, "BLAINE: Good work!"
	
	lang_para E, "My quizzes are a"
	lang_line E, "cut above in terms"
	lang_cont E, "of difficulty!"
	
	lang_para E, "Must've had you"
	lang_line E, "struggling hard!"
	
	lang_para E, "So, how many did"
	lang_line E, "you get right?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	para "<……>　<……>　<……>"
	para ""
	done
.textScore0
	; Japanese
	lang_text J, "カツラ『ハッハッハ！"
	lang_line J, "わせいかいは　０こ！！"
	lang_para J, "やっぱり　わしの　クイズは"
	lang_line J, "てんか　むてきなのだー！！"
	
	; English
	lang_text E, "BLAINE: Hahaha!"
	
	lang_para E, "Zero correct"
	lang_line E, "answers!"
	
	lang_para E, "Just as I thought,"
	lang_line E, "my quiz is" 
	cont_line E, "unbeatable!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done

.textScore1
	; Japanese
	lang_text J, "カツラ『１こだけ　あたってたぞー！"
	lang_line J, "そんな　ちゅうとはんぱな"
	lang_cont J, "あたしかた　しとかんで"
	lang_cont J, "いっそ　ぜんぶ　はずれとけー！"
	
	; English
	lang_text E, "BLAINE: You only"
	lang_line E, "got one right!"
	
	lang_para E, "Don't give me that"
	lang_line E, "half-baked effort!"
	
	lang_para E, "You may as well"
	lang_line E, "have gotten them"
	lang_cont E, "all wrong!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore2
	; Japanese
	lang_text J, "カツラ『２つ　あたってるぞ！"
	
	lang_para J, "いいかえれば　８つ　まえがえたって"
	lang_line J, "ことに　なるのだー！！"
	
	lang_para J, "つまり　ダメダメって　ことだ！！！"
	
	; English
	lang_text E, "BLAINE: Two"
	lang_line E, "correct answers!"
	
	lang_para E, "That means you got"
	lang_line E, "eight wrong!"
	
	lang_para E, "In short, you're"
	lang_line E, "hopeless!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore3
	; Japanese
	lang_text J, "カツラ『３もん　せいかいだった！！"
	
	lang_para J, "たいしたこと　ないなあ！！"
	lang_line J, "たいしたこと　ないぞう！！！"
	lang_cont J, "ワッハッハッハ！！"
	
	; English
	lang_text E, "BLAINE: Three"
	lang_line E, "correct answers!"
	
	lang_line E, "Not so impressive!"

	lang_para E, "That's nothing"
	lang_line E, "special!"
	
	lang_para E, "Hahaha!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore4
	; Japanese
	lang_text J, "カツラ『せいかいは　４もんだぞー！"
	l
	ang_para J, "そんなんじゃ　まだまだ　きあいが"
	lang_line J, "たりないのだー！！！"
	
	; English
	lang_text E, "BLAINE: Four"
	lang_line E, "correct answers!"
	
	lang_para E, "Your fighting"
	lang_line E, "spirit is still"
	lang_cont E, "lacking!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore5
	; Japanese
	lang_text J, "カツラ『うおおーす！"
	lang_line J, "５もん　せいかいだったぞ！！"
	
	lang_para J, "ねらったように　ちょうど　はんぶん！"
	lang_line J, "ポケモン　しょうぶなら　ひきわけだ！"
	
	; English
	lang_text E, "BLAINE: Whoa!"
	lang_line E, "Five correct"
	lang_cont E, "answers!"
	
	lang_para E, "Right on target--"
	lang_line E, "exactly half!"
	
	lang_para E, "In a #MON"
	lang_line E, "battle, that'd"
	lang_cont E, "be a draw!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore6
	; Japanese
	lang_text J, "カツラ『せいかいは　６もんだー！！"
	
	lang_para J, "いまの　あつい　こたえっぷり"
	lang_line J, "なかなか　よかったぞーー！"
	
	; English
	lang_text E, "BLAINE: Six"
	lang_line E, "correct answers!"
	
	lang_para E, "The fiery way you"
	lang_line E, "answered just now"
	lang_cont E, "was pretty good!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore7
	; Japanese
	lang_text J, "カツラ『７つ　せいかい　なのだ！"
	
	lang_para J, "なかなか　きおくりょくが　よいぞ！"
	lang_line J, "こら！　とくいそうな　かお　するな！"
	lang_cont J, "わしから　みれば　まだまだ　なのだ！"
	
	; English
	lang_text E, "BLAINE: Seven"
	lang_line E, "correct answers!"
	
	lang_para E, "Your memory's"
	lang_line E, "pretty sharp!"
	
	lang_para E, "Hey! Don't look"
	lang_line E, "so smug!"
	
	lang_para E, "The way I see it,"
	lang_line E, "you still have a"
	lang_cont E, "long way to go!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore8
	; Japanese
	lang_text J, "カツラ『せいかい　８もん！"
	
	lang_para J, "わしの　クイズが　こんなに"
	lang_line J, "あてられる　はず　ないのだ！"
	lang_cont J, "これは　まぐれ　だったのだ！！"
	
	; English
	lang_text E, "BLAINE: Eight"
	lang_line E, "correct answers!"
	
	lang_para E, "My quiz isn't"
	lang_line E, "supposed to be"
	lang_cont E, "this easy to beat!"
	
	lang_para E, "It must be a"
	lang_line E, "fluke!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore9
	; Japanese
	lang_text J, "カツラ『あら！"
	lang_line J, "９つ　あたってるぞー！！！"
	
	lang_para J, "あ…　あと　ひとつで　まんてん"
	lang_line J, "あぶない　ところだった！"
	
	; English
	lang_text E, "BLAINE: Oh!"
	lang_line E, "You got nine"
	lang_cont E, "correct!"
	
	lang_para E, "Ah… just one more"
	lang_line E, "for a perfect"
	lang_cont E, "score!"
	
	lang_para E, "You were close!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore10
	; Japanese
	lang_text J, "カツラ『うおおー！"
	lang_line J, "ぜんもん　せいかい　だとー！？"
	
	lang_para J, "み　……　みごと！"
	lang_line J, "わしは　もえつきた……！"
	
	; English
	lang_text E, "BLAINE: Whoa!"
	lang_line E, "A perfect score?!"
	
	lang_para E, "Wow… impressive!"
	lang_line E, "I'm burned out…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textNotAllCorrect
	; Japanese
	lang_text J, "どうだ？　もう　もえつきたか？"
	lang_line J, "もういちど　やってみるかー！？"
	
	; English
	lang_text E, "BLAINE: How about"
	lang_line E, "it?"
	
	lang_para E, "Feeling burned"
	lang_line E, "out already?"
	
	lang_para E, "Wanna try again?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textTryAgain
	; Japanese
	lang_text J, "カツラ『いくぞー！"
	; English
	lang_text E, "BLAINE: Let's go!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textGiveGift1
	; Japanese
	lang_text J, "まけたものは　しかたがない"
	lang_line J, "ほうびを　やろう！"
	
	lang_para J, "わざマシン　しねしねこうせんを"
	lang_line J, "うけとって　くれい！"
	
	lang_para J, "しねしねこうせんを　もらった！"
	
	; English
	lang_text E, "I lost, no use"
	lang_line E, "fighting it!"
	
	lang_para E, "I'll give you"
	lang_line E, "a reward!"
	
	lang_para E, "Take this TM,"
	lang_line E, "it contains"
	lang_cont E, "TOMBSTONER!"
	
	lang_para E, "<PLAYER> received"
	lang_line E, "TM28."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
.textGiveGift2
	; Japanese
	lang_text J, "カツラ『<……>　<……>　<……>"
	
	lang_para J, "<……>　<……>　<……>"
	lang_line J, "<……>　<……>　<……>"
	
	lang_para J, "なんて　うそ　うそ！！"
	lang_line J, "わざマシン３８を"
	lang_cont J, "うけとってくれい！"
	
	lang_para J, "わざマシン３８を　もらった！"
	
	; English
	lang_text E, "BLAINE: <……><……><……>"
	lang_para E, "<……><……><……>"
	lang_line E, "<……><……><……>"
	
	lang_para E, "Just kidding!"
	lang_line E, "Take this."
	
	lang_para E, "<PLAYER> received"
	lang_line E, "TM38."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textFarewell
	; Japanese
	lang_text J, "カツラ『また　いつか"
	lang_line J, "パワーアップして　もどってくるぞー！"
	lang_cont J, "うおおーす！！！"
	
	; English
	lang_text E, "BLAINE: I'll be"
	lang_line E, "back someday,"
	
	lang_para E, "stronger than"
	lang_line E, "ever!"
	
	lang_para E, "Hah!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

ENDC
