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
	nsc_drawtrainer 6, 2, BLUE, 7
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
	nsc_textbox 1, 14, .greenIntroText
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

.greenIntroText
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
	
	; TODO: TEMP TRANSLATION FROM DEEPL FOR TESTING. PLEASE REWORK.
	lang_text E, "BLUE: Hey there."
	lang_line E, "So you're here to"
	lang_cont E, "take my quiz, huh?"
	lang_para E, "My quiz has tons"
	lang_line E, "of questions you"
	lang_cont E, "won't know the"
	lang_cont E, "answers to,"
	lang_para E, "no matter how much"
	lang_line E, "you've traveled"
	lang_cont E, "around this world."
	lang_para E, "After all, it's"
	lang_line E, "been three years"
	lang_cont E, "since it happened."
	lang_para E, "Anyway, let's get"
	lang_line E, "started."
	lang_para E, "There are ten"
	lang_line E, "questions, total!"
	lang_para E, "Here we go!"
	
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
	lang J,      "マサラタウンで　ポケモンの"
	lang_next J, "たいりょくを　かいふく"
	lang_next J, "する　ばしょは？"
	lang_next J, ""
	lang_next J, "１　けんきゅうじょ　２　レッドのいえ"
	lang_next J, "３　グリーンのいえ"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "Where can you"
	lang_next E, "heal your #MON"
	lang_next E, "in PALLET TOWN?"
	lang_next E, "1.OAK RESEARCH LAB"
	lang_next E, "2.RED's HOUSE"
	lang_next E, "3.BLUE's HOUSE"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"

	next "@"
	
.question2Text
	lang J,      "トキワシティで　かわれている"
	lang_next J, "オニスズメの　なまえは？"
	lang_next J, ""
	lang_next J, "１　オニチャン　２　スズチャン"
	lang_next J, "３　オニスチャン"

	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "What is the name"
	lang_next E, "of the SPEAROW"
	lang_next E, "in VIRIDIAN CITY?"
	lang_next E, "1. SPEARY"
	lang_next E, "2. ROWEY"
	lang_next E, "3. SPEAREY"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	lang J,      "ニビシティの　はくぶつかんの"
	lang_next J, "にゅうじょうりょうは　いくら？"
	lang_next J, ""
	lang_next J, "１　５０えん　２　１００えん"
	lang_next J, "３　２００えん"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "What is the"
	lang_next E, "admission fee for"
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
	lang J,      "はじめて　みさきのこやに"
	lang_next J, "いったとき　マサキに　なにが"
	lang_next J, "おきていた？"
	lang_next J, ""
	lang_next J, "１　ポケモンとくっつく　２　びょうき"
	lang_next J, "３　ポケモンをとられた"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "What was happening"
	lang_next E, "to BILL when you"
	lang_next E, "met him?"
	lang_next E, "1. #MON fusion"
	lang_next E, "2. He was sick"
	lang_next E, "3. #MON stolen"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question5Text
	lang J,      "シオン　ポケモンタワーの　ゆうれいは"
	lang_next J, "しょうたいが　わからない　とき"
	lang_next J, "せんとうで　なんと　いっていた？"
	lang_next J, ""
	lang_next J, "１　ヒキカエセ　２　チカヨルナ"
	lang_next J, "３　タチサレ"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "What did the"
	lang_next E, "unidentified GHOST"
	lang_next E, "in #MON TOWER"
	lang_next E, "say in battle?"
	lang_next E, "1.Begone 2.Go away"
	lang_next E, "3.Get out"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question6Text
	lang J,      "タマムシマンションの　おくじょうの"
	lang_next J, "こやの　いちぐちの　かんばん"
	lang_next J, "わしは　なんでも　……　なに？"
	lang_next J, ""
	lang_next J, "１　おてのもの　２　おみとおし"
	lang_next J, "３　もっている"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "CELADON MANSION's"
	lang_next E, "rooftop room reads"
	lang_next E, "“I ... EVERYTHING”"
	lang_next E, "1. DO"
	lang_next E, "2. KNOW"
	lang_next E, "3. HAVE"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question7Text
	lang J,      "ヤマブキシティの　かくとうどうじょう"
	lang_next J, "しはんが　しょうぶに　はいる　まえ"
	lang_next J, "だす　かけごえは？"
	lang_next J, ""
	lang_next J, "１　トオリャー！　２　オッス！"
	lang_next J, "３　どりゃぁぁ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "In SAFFRON CITY's"
	lang_next E, "FIGHTING DOJO,"
	lang_next E, "the KARATE MASTER's"
	lang_next E, "battle cry is..."
	lang_next E, "1.Fwaaa!  2.Grunt!"
	lang_next E, "3.Hwaaaa!"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question8Text
	lang J,      "サファリゾーンの　えんちょうの"
	lang_next J, "ひみつと　いったら？"
	lang_next J, ""
	lang_next J, "１　かつら　２　いれば"
	lang_next J, "３　ムシがこわい"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "What's the SAFARI"
	lang_next E, "ZONE WARDEN's"
	lang_next E, "secret?"
	lang_next E, "1. Wig"
	lang_next E, "2. Dentures"
	lang_next E, "3. Afraid of bugs"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question9Text
	lang J,      "ポケモンリーグで　にげだそうと"
	lang_next J, "すると　だれかの　こえが…！"
	lang_next J, "なんと　いわれる？"
	lang_next J, ""
	lang_next J, "１　にげられはせん　２　にげるのか"
	lang_next J, "３　にげてはならん"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "If you try to run"
	lang_next E, "from the LEAGUE,"
	lang_next E, "someone calls out:"
	lang_next E, "1. You can't run!"
	lang_next E, "2. Running away?"
	lang_next E, "3. Don't run away!"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	next "@"
	
.question10Text
	lang J,      "レッドは　てもちの　ポケモンが"
	lang_next J, "すべて　たたかえなく　なると"
	lang_next J, "めのまえが　どうなった？"
	lang_next J, ""
	lang_next J, "１　まっしろ　２　まっくら"
	lang_next J, "３　クラクラした"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E,      "When all of RED's"
	lang_next E, "#MON faint,"
	lang_next E, "what happens?"
	lang_next E, "1. White out"
	lang_next E, "2. Black out"
	lang_next E, "3. He gets dizzy"
	
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
	nsc_set wGSBallFlagRam, 1
	nsc_ramcopy_newsvar wGSBallFlagRam, sMinigameFlag, 1
.noGift
.done
	; TODO: no space in pack error message
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
	lang_text J, "グリーン『いくつ　わかったか"
	lang_line J, "オレが　みてやるよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "BLUE: How'd you do?"
	lang_line E, "Lemme check!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	para "<……>　<……>"
	para ""
	done
.textScore0
	lang_text J, "おいおい　ひとつも"
	lang_line J, "あたって　ないぜー！"
	lang_para J, "やっぱり　おまえには"
	lang_line J, "とても　むり　だったな"
	lang_cont J, "ごくろうさん！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Hey, hey, you"
	lang_line E, "didn't get a"
	lang_cont E, "single one right!"
	lang_para E, "I guess it was"
	lang_line E, "too difficult for"
	lang_cont E, "you, after all!"
	lang_para E, "Good job!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done

.textScore1
	lang_text J, "ひとつ　あたってるな！"
	lang_para J, "まあ　ひとつ　あたったくらいじゃ"
	lang_line J, "ぜんぜん　わかってないのと"
	lang_cont J, "おなじだぜ"
	lang_cont J, "また　でなおすんだな"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got one right!"
	lang_para E, "Well, getting just"
	lang_line E, "one right is the"
	lang_cont E, "same as knowing"
	lang_cont E, "nothing at all."
	lang_para E, "You've gotta try"
	lang_line E, "again!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore2
	lang_text J, "２もん　せいかい！"
	lang_para J, "おいおい　ほんきで　やってる？"
	lang_para J, "オレの　あいてには"
	lang_line J, "まだまだ　ふそくだな！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 2 correct!"
	lang_para E, "Hey, hey, are you"
	lang_line E, "serious?"
	lang_para E, "You're still no"
	lang_line E, "match for me!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore3
	lang_text J, "３もん　せいかい　だぜ！"
	lang_para J, "ポケモンしょうぶは　つよいのかも"
	lang_line J, "しれねえ　けど　ほかは"
	lang_cont J, "たいしたこと　ねーな！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 3 correct!"
	lang_para E, "You might be good"
	lang_line E, "at #MON battles,"
	lang_para E, "but everything"
	lang_line E, "else?"
	lang_para E, "Not so much!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textScore4
	lang_text J, "せいかいは　４つ！"
	lang_para J, "まあ　まぐれで　これだけ"
	lang_line J, "わかれば　たいした　もんだ"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 4 correct!"
	lang_para E, "Well, getting this"
	lang_line E, "many by sheer luck"
	lang_cont E, "is pretty"
	lang_cont E, "impressive!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore5
	lang_text J, "５もん　せいかい！"
	lang_para J, "なかなか　くろう　してるようだな"
	lang_line J, "まあ　オレが　かんがえたからな！"
	lang_cont J, "あと　５もんの　かべは　あついぜ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 5 correct!"
	lang_para E, "Looks like you're"
	lang_line E, "putting in some"
	lang_cont E, "effort."
	lang_para E, "Well, I did come"
	lang_line E, "up with these"
	lang_cont E, "myself!"
	lang_para E, "And the next 5"
	lang_line E, "obstacles are"
	lang_cont E, "tough!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore6
	lang_text J, "６もん　あたってたぜ！"
	lang_para J, "まあまあって　ところだな"
	lang_line J, "まあ　オレには　ぜんぜん"
	lang_cont J, "およばないけどな！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 6 correct!"
	lang_para E, "Not bad, I guess…"
	lang_para E, "But you're nowhere"
	lang_line E, "near my level!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore7
	lang_text J, "せいかいは　７もん　だぜ！"
	lang_para J, "こんなに　あたる　はず"
	lang_line J, "ねえって　おもって"
	lang_cont J, "いたんだけどな…"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 7 correct!"
	lang_para E, "I never thought"
	lang_line E, "You'd get this"
	lang_cont E, "many right…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore8
	lang_text J, "８もん　せいかい！"
	lang_para J, "なかなか　やるじゃ　ねえか"
	lang_line J, "おれの　つぎ　くらいには"
	lang_cont J, "すごい　きおくりょく　だぜ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got 8 correct!"
	lang_para E, "Not bad at all."
	lang_para E, "You're almost as"
	lang_line E, "good as me!"
	lang_para E, "That's some serious"
	lang_line E, "memory power!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore9
	lang_text J, "おっと　９もん　せいかい！"
	lang_para J, "おしいな！　あと　ひとつで"
	lang_line J, "ぜんもん　せいかい　だったのにな"
	lang_para J, "もういちど　がんばって　みろよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Whoa, 9 correct!"
	lang_para E, "So close! Just one"
	lang_line E, "more and you"
	lang_cont E, "would've got"
	lang_cont E, "them all right."
	lang_para E, "Try again!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.textScore10
	lang_text J, "ぜんもん　せいかい<……>！"
	lang_para J, "おまえ　すごいな"
	lang_line J, "３ねんも　まえの　ことを"
	lang_cont J, "これだけ　おぼえている　なんてな！"
	lang_cont J, "かんぜんに　オレの　まけだ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You got everything"
	lang_line E, "right<……>!"
	lang_para E, "You're amazing."
	lang_para E, "To remember so"
	lang_line E, "much from 3 years"
	lang_cont E, "ago!"
	lang_para E, "I'm completely"
	lang_line E, "defeated!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.textNotAllCorrect
	lang_text J, "グリーン『どうだ？　オレの"
	lang_line J, "クイズは　むずかしいだろ？"
	lang_para J, "しかたねえな　もういちど"
	lang_line J, "チャンスを　やると　するか…"
	lang_para J, "どうする？"
	lang_line J, "もういちど　やって　みるか？"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "BLUE: How'd ya do?"
	lang_para E, "My quiz's tough,"
	lang_line E, "huh?"
	lang_para E, "Well, I guess I'll"
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
	lang_text J, "またな！"
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "See ya!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textGiveGift
	; NOTE: the person recording this quiz didnt get a chance to properly record this line
	;       this is what they gave as the general gist.
	lang_text J, "おまえすごいな　じしんもっていいぜ"
	lang_para J, "わざマシン２６を　もらった！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You're amazing."
	lang_line E, "You can be proud"
	lang_cont E, "of yourself."
	lang_para E, "Received TM26!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

ENDC
