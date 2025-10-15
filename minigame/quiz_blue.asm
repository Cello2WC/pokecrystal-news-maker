IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"

MACRO minigame_abuttonhook
	;nsc_drawbox 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	;nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	nsc_clear 1, 4, 18, 8
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, BLUE, 7
ENDM

MACRO minigame_start
	; fake page transition
	
;	nsc_set wcd4b, LOW(.drawGreenPtr - currentScreen + $D000)
;	nsc_set wcd4c, HIGH(.drawGreenPtr - currentScreen + $D000)
;	nsc_set wcd2e, 0
	
	
;	nsc_drawbox 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
;	nsc_drawtrainer 6, 4, BLUE, 7
;	nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	nsc_playmusic MUSIC_GYM
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	
;	nsc_select
	
	;nsc_drawbox 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	;nsc_drawtrainer 6, 4, BLUE, 7
	;nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	;nsc_playmusic MUSIC_GYM
	;nsc_set wQuizQuestionNo, 0
	;nsc_set wQuizScore, 0
	
	;nsc_12
	;nsc_black
	
;	nsc_set wSpriteUpdatesEnabled, 1
	
;	nsc_set hBGMapMode, 2
;	nsc_set hBGMapMode, 2
	
;	nsc_set hBGMapMode, 2
	;nsc_drawbox 6,  4, 7, 7, NEWSBORDER_NONE, 7
;	nsc_clear 1, 13, 18, 4
	
;	nsc_delay 1
;	nsc_set wSpriteUpdatesEnabled, 0

;	nsc_set hBGMapMode, 2
	;nsc_clear 1, 13, 18, 4
	;nsc_delay 1

	;nsc_select
	nsc_textbox 1, 14, .greenIntroText
	nsc_waitbutton
	nsc_page PokemonQuiz
	
;.drawGreenPtr
;	relativepointer .drawGreen
;.drawGreen
;	nsc_ret
	
.greenIntroText
; Japanese
	lang_text J, "グリーン『よお"
	lang_line J, "さっそく　オレの　クイズに"
	lang_cont J, "ちょうせん　しにきた　ってわけだな"
	
	lang_para J, "オレの　クイズは　おまえが"
	lang_line J, "いくら　このせかいを　まわってみても"
	lang_cont J, "わからないことが　いっぱいだぜ"
	
	lang_para J, "なにせ　３ねんまえの　はなしだからな"
	lang_line J, "まあ　とにかく　はじめようぜ"
	lang_para J, "クイズは　ぜんぶで　１０もん！"
	
	lang_para J, "いくぜ！"
	
; English
	lang_text E, "BLUE: Yo!"
	lang_line E, "So you came to"
	lang_cont E, "take my quiz, huh?"
	
	lang_para E, "My quiz has things"
	lang_line E, "you won't know,"
	lang_cont E, "no matter how much"
	lang_cont E, "you've traveled."

	lang_para E, "After all, this is"
	lang_line E, "about stuff from"
	lang_cont E, "three years ago."
	
	lang_para E, "Anyway, let's get"
	lang_line E, "started."
	
	lang_para E, "There are ten"
	lang_line E, "questions total!"
	
	lang_para E, "Let's go!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang S,      "?"

	done
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
	
	news_menu  2, 16, 4, 1, 4, 2, -1, $00, $00, $00, 0, $04
	
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
	
	news_menuitem_names   .menuItemAnswer1Text,   .menuItemAnswer2Text,   .menuItemAnswer3Text,   .menuItemQuitText
	news_menuitem_scripts .menuItemAnswer1Script, .menuItemAnswer2Script, .menuItemAnswer3Script, .menuItemQuitScript
	news_menuitem_descs   .dummyDescription,      .dummyDescription,      .dummyDescription,      .dummyDescription

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
	
	quiz_answers 1,    0, 1, 1, 1, 0, 0, 1, 0, 0, 0
	quiz_answers 2,    1, 0, 0, 0, 0, 1, 0, 1, 0, 1
	quiz_answers 3,    0, 0, 0, 0, 1, 0, 0, 0, 1, 0
	

.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.dummyDescription
	db "@"
	
.question1Text
	; Japanese
	lang J,      "マサラタウンで　ポケモンの"
	lang_next J, "たいりょくを　かいふく"
	lang_next J, "する　ばしょは？"
	lang_next J, ""
	lang_next J, "１　けんきゅうじょ　２　レッドのいえ"
	lang_next J, "３　グリーンのいえ"
	
	; English
	lang E,      "Where in PALLET"
	lang_next E, "TOWN can you heal"
	lang_next E, "your #MON?"
	lang_next E, "1. OAK's LAB"
	lang_next E, "2. RED's HOUSE"
	lang_next E, "3. BLUE's HOUSE"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"

	next "@"
	
.question2Text
	; Japanese
	lang J,      "トキワシティで　かわれている"
	lang_next J, "オニスズメの　なまえは？"
	lang_next J, ""
	lang_next J, "１　オニチャン　２　スズチャン"
	lang_next J, "３　オニスチャン"

	; English
	lang E,      "What's the name of"
	lang_next E, "the SPEAROW from"
	lang_next E, "VIRIDIAN CITY?"
	lang_next E, "1. SPEARY"
	lang_next E, "2. ROWEY"
	lang_next E, "3. SPIKEY"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	; Japanese
	lang J,      "ニビシティの　はくぶつかんの"
	lang_next J, "にゅうじょうりょうは　いくら？"
	lang_next J, ""
	lang_next J, "１　５０えん　２　１００えん"
	lang_next J, "３　２００えん"
	
	; English
	lang E,      "How much is the"
	lang_next E, "entrance fee for"
	lang_next E, "the PEWTER MUSEUM"
	lang_next E, "OF SCIENCE?"
	lang_next E, "1. ¥50   2. ¥100"
	lang_next E, "3. ¥200"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question4Text
	; Japanese
	lang J,      "はじめて　みさきのこやに"
	lang_next J, "いったとき　マサキに　なにが"
	lang_next J, "おきていた？"
	lang_next J, ""
	lang_next J, "１　ポケモンとくっつく　２　びょうき"
	lang_next J, "３　ポケモンをとられた"
	
	; English
	lang E,      "What happened"
	lang_next E, "to BILL at the"
	lang_next E, "SEA COTTAGE?"
	lang_next E, "1. #MON fusion"
	lang_next E, "2. He was sick"
	lang_next E, "3. #MON stolen"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"

.question5Text
	; Japanese
	lang J,      "シオン　ポケモンタワーの　ゆうれいは"
	lang_next J, "しょうたいが　わからない　とき"
	lang_next J, "せんとうで　なんと　いっていた？"
	lang_next J, ""
	lang_next J, "１　ヒキカエセ　２　チカヨルナ"
	lang_next J, "３　タチサレ"
	
	; English
	lang E,      "In #MON TOWER"
	lang_next E, "what did the"
	lang_next E, "unidentified GHOST"
	lang_next E, "say in battle?"
	lang_next E, "1. Shoo 2. Go away"
	lang_next E, "3. Get out"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question6Text
	; Japanese
	lang J,      "タマムシマンションの　おくじょうの"
	lang_next J, "こやの　いちぐちの　かんばん"
	lang_next J, "わしは　なんでも　……　なに？"
	lang_next J, ""
	lang_next J, "１　おてのもの　２　おみとおし"
	lang_next J, "３　もっている"
	
	; English
	lang E,      "The sign on the"
	lang_next E, "rooftop of CELADON"
	lang_next E, "MANSION says"
	lang_next E, "“I … EVERYTHING!”"
	lang_next E, "1. DO 2. KNOW"
	lang_next E, "3. HAVE"	
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question7Text
	; Japanese
	lang J,      "ヤマブキシティの　かくとうどうじょう"
	lang_next J, "しはんが　しょうぶに　はいる　まえ"
	lang_next J, "だす　かけごえは？"
	lang_next J, ""
	lang_next J, "１　トオリャー！　２　オッス！"
	lang_next J, "３　どりゃぁぁ！"
	
	; English
	lang E,      "In SAFFRON CITY's"
	lang_next E, "FIGHTING DOJO, the"
	lang_next E, "battle cry of the"
	lang_next E, "KARATE MASTER is?"
	lang_next E, "1. Fwaaa!  2. Haa!"
	lang_next E, "3. Hiyah!"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question8Text
	; Japanese
	lang J,      "サファリゾーンの　えんちょうの"
	lang_next J, "ひみつと　いったら？"
	lang_next J, ""
	lang_next J, "１　かつら　２　いれば"
	lang_next J, "３　ムシがこわい"
	
	; English
	lang E,      "What is the SAFARI"
	lang_next E, "ZONE WARDEN's"
	lang_next E, "secret?"
	lang_next E, "1. A wig"
	lang_next E, "2. False teeth"
	lang_next E, "3. Fear of bugs"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question9Text
	; Japanese
	lang J,      "ポケモンリーグで　にげだそうと"
	lang_next J, "すると　だれかの　こえが…！"
	lang_next J, "なんと　いわれる？"
	lang_next J, ""
	lang_next J, "１　にげられはせん　２　にげるのか"
	lang_next J, "３　にげてはならん"
	
	; English
	lang E,      "What's said if you"
	lang_next E, "try to RUN at the"
	lang_next E, "#MON LEAGUE?"
	lang_next E, "1. You can't run!"
	lang_next E, "2. Running away?"
	lang_next E, "3. Don't run away!"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question10Text
	; Japanese
	lang J,      "レッドは　てもちの　ポケモンが"
	lang_next J, "すべて　たたかえなく　なると"
	lang_next J, "めのまえが　どうなった？"
	lang_next J, ""
	lang_next J, "１　まっしろ　２　まっくら"
	lang_next J, "３　クラクラした"
	
	; English
	lang E,      "What happens to"
	lang_next E, "RED when all of"
	lang_next E, "his #MON faint?"
	lang_next E, "1. Whites out"
	lang_next E, "2. Blacks out"
	lang_next E, "3. Gets dizzy"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"

	
	
	news_screen QuizScoreEvaluation, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	
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
	nsc_drawtrainer 6, 2, BLUE, 7
	nsc_select
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textNotAllCorrect
	nsc_yesno 13, 7, .restartQuiz, .giveUp
;	nsc_page NewsRoot
;	nsc_ret

.restartQuiz
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page PokemonQuiz

.giveUp
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveUp
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
	
.menuItemText
	lang J, "グリーンのひょうか"
	lang E, "BLUE's RATING"
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
	nsc_textbox 1, 14, .textGiveGift
	nsc_giveitem TM_EARTHQUAKE, .gotGift, .noGift
.gotGift
	nsc_playsound SFX_GET_TM
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.noGift
.done
	; TODO: no space in pack error message
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret


.menuItemDescription
	lang      J, "クイズ　しゅうりょう"
	lang_line J, "ひょうか<WO>うけて　ください！"

; i believe this to be a mistranslation due to the string's placement...
;	lang      E, "Take the QUIZ to"
;	lang_line E, "receive a rating!"
; i think the japanese text reads more like...
;	lang      E, "Quiz complete!"
;	lang_line E, "Please be rated!"
; but that's clunky, so we'll go with
	lang      E, "Quiz complete!"
	lang_line E, "How did you do?"
; TODO: potentially revise, and match in other languages

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
	lang_text J, "グリーン『いくつ　わかったか"
	lang_line J, "オレが　みてやるよ！"
	
	lang_para J, "<……>　<……>"
	
	
	; English
	lang_text E, "BLUE: How'd you do?"
	lang_line E, "Lemme check!"
	
	lang_para E, "…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	para ""
	done
.textScore0
	; Japanese
	lang_text J, "おいおい　ひとつも"
	lang_line J, "あたって　ないぜー！"
	
	lang_para J, "やっぱり　おまえには"
	lang_line J, "とても　むり　だったな"
	lang_cont J, "ごくろうさん！"
	
	; English
	lang_text E, "Hey, not even one"
	lang_line E, "right?"
	
	lang_para E, "I knew it, you"
	lang_line E, "couldn't do it."
	lang_cont E, "Nice try!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done

.textScore1
	; Japanese
	lang_text J, "ひとつ　あたってるな！"
	
	lang_para J, "まあ　ひとつ　あたったくらいじゃ"
	lang_line J, "ぜんぜん　わかってないのと"
	lang_cont J, "おなじだぜ"
	lang_cont J, "また　でなおすんだな"
	
	; English
	lang_text E, "One correct!"
	
	lang_para E, "But getting just"
	lang_line E, "one right is the" 
	lang_cont E, "same as not"
	lang_cont E, "knowing anything."
	
	lang_para E, "Try again."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore2
	; Japanese
	lang_text J, "２もん　せいかい！"
	
	lang_para J, "おいおい　ほんきで　やってる？"
	lang_para J, "オレの　あいてには"
	lang_line J, "まだまだ　ふそくだな！"
	
	; English
	lang_text E, "Two correct!"
	
	lang_para E, "Hey, are you"
	lang_line E, "really trying?"
	
	lang_para E, "You're still no"
	lang_line E, "match for me!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore3
	; Japanese
	lang_text J, "３もん　せいかい　だぜ！"
	
	lang_para J, "ポケモンしょうぶは　つよいのかも"
	lang_line J, "しれねえ　けど　ほかは"
	lang_cont J, "たいしたこと　ねーな！"
	
	; English
	lang_text E, "Three correct!"
	
	lang_para E, "Maybe you're good"
	lang_line E, "at #MON battles,"
	
	lang_para E, "but other than"
	lang_line E, "that?"
	lang_cont E, "Not so much!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore4
	; Japanese
	lang_text J, "せいかいは　４つ！"
	
	lang_para J, "まあ　まぐれで　これだけ"
	lang_line J, "わかれば　たいした　もんだ"
	
	; English
	lang_text E, "Four correct!"
	
	lang_para E, "Getting this many"
	lang_line E, "lucky guesses is"
	lang_cont E, "pretty impressive!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore5
	; Japanese
	lang_text J, "５もん　せいかい！"
	
	lang_para J, "なかなか　くろう　してるようだな"
	lang_line J, "まあ　オレが　かんがえたからな！"
	lang_cont J, "あと　５もんの　かべは　あついぜ！"
	
	; English
	lang_text E, "Five correct!"
	
	lang_para E, "Looks like you're"
	lang_line E, "actually trying."
	
	lang_para E, "Well, I did come"
	lang_line E, "up with these"
	lang_cont E, "myself!"
	
	lang_para E, "The next five will"
	lang_line E, "be tough though!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore6
	; Japanese
	lang_text J, "６もん　あたってたぜ！"
	
	lang_para J, "まあまあって　ところだな"
	lang_line J, "まあ　オレには　ぜんぜん"
	lang_cont J, "およばないけどな！"
	
	; English
	lang_text E, "Six correct!"
	
	lang_para E, "Not bad, I guess."
	
	lang_para E, "But you're nowhere"
	lang_line E, "near my level!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore7
	; Japanese
	lang_text J, "せいかいは　７もん　だぜ！"
	
	lang_para J, "こんなに　あたる　はず"
	lang_line J, "ねえって　おもって"
	lang_cont J, "いたんだけどな…"
	
	; English
	lang_text E, "Seven correct!"
	
	lang_para E, "I didn't think"
	lang_line E, "you'd get this"
	lang_cont E, "many right…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore8
	; Japanese
	lang_text J, "８もん　せいかい！"
	
	lang_para J, "なかなか　やるじゃ　ねえか"
	lang_line J, "おれの　つぎ　くらいには"
	lang_cont J, "すごい　きおくりょく　だぜ！"
	
	; English
	lang_text E, "Eight correct!"
	
	lang_para E, "Not bad at all."
	
	lang_para E, "Your memory is"
	lang_line E, "almost as good"
	lang_cont E, "as mine!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore9
	; Japanese
	lang_text J, "おっと　９もん　せいかい！"
	
	lang_para J, "おしいな！　あと　ひとつで"
	lang_line J, "ぜんもん　せいかい　だったのにな"
	
	lang_para J, "もういちど　がんばって　みろよ！"
	
	; English
	lang_text E, "Whoa, nine"
	lang_line E, "correct!"
	
	lang_para E, "So close! One more"
	lang_line E, "and you'd have got"
	lang_cont E, "them all!"
	
	lang_para E, "Try again!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore10
	; Japanese
	lang_text J, "ぜんもん　せいかい<……>！"
	
	lang_para J, "おまえ　すごいな"
	lang_line J, "３ねんも　まえの　ことを"
	lang_cont J, "これだけ　おぼえている　なんてな！"  
	lang_cont J, "かんぜんに　オレの　まけだ！"
	
	; English
	lang_text E, "All correct…!"
	
	lang_para E, "You're amazing."
	
	lang_para E, "To remember all"
	lang_line E, "that from three"
	lang_cont E, "years ago!"

	lang_para E, "I'm totally"
	lang_line E, "beat!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textNotAllCorrect
	; Japanese
	lang_text J, "グリーン『どうだ？　オレの"
	lang_line J, "クイズは　むずかしいだろ？"
	lang_para J, "しかたねえな　もういちど"
	lang_line J, "チャンスを　やると　するか…"
	lang_para J, "どうする？"
	lang_line J, "もういちど　やって　みるか？"
	
	; English
	lang_text E, "BLUE: Well? My"
	lang_line E, "quiz is hard,"
	lang_cont E, "isn't it?"
	
	lang_para E, "I guess I'll"
	lang_line E, "give you another"
	lang_cont E, "chance…"

	lang_para E, "What do you say?"
	lang_line E, "Wanna try again?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textGiveUp
	; Japanese
	lang_text J, "またな！"
	
	; English
	lang_text E, "See ya!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textGiveGift
	; NOTE: the person recording this quiz didnt get a chance to properly record this line
	;       this is what they gave as the general gist.
	; Japanese
	lang_text J, "おまえすごいな　じしんもっていいぜ"
	lang_para J, "わざマシン２６を　もらった！"
	
	; English
	lang_text E, "Well done!"
	
	lang_para E, "You should be"
	lang_line E, "proud of yourself."
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM26."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

ENDC