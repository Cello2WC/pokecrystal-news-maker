; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
; 
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_07.htm
; Thanks to nohm for providing their first-hand account of this minigame!
; 
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization TODO
; Italian localization TODO
; Spanish localization TODO

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"

MACRO minigame_abuttonhook
	nsc_clear 1, 4, 18, 8
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, BLUE, 7
ENDM

MACRO minigame_start
	; fake page transition
	nsc_playmusic MUSIC_GYM
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0

	nsc_textbox 1, 14, .greenIntroText
	nsc_waitbutton
	nsc_page PokemonQuiz
	
.greenIntroText
; Japanese
	lang J, text "グリーン『よお"
	lang J, line "さっそく　オレの　クイズに"
	lang J, cont "ちょうせん　しにきた　ってわけだな"
	
	lang J, para "オレの　クイズは　おまえが"
	lang J, line "いくら　このせかいを　まわってみても"
	lang J, cont "わからないことが　いっぱいだぜ"
	
	lang J, para "なにせ　３ねんまえの　はなしだからな"
	lang J, line "まあ　とにかく　はじめようぜ"
	lang J, para "クイズは　ぜんぶで　１０もん！"
	
	lang J, para "いくぜ！"
	
; English
	lang E, text "BLUE: Yo!"
	lang E, line "So you came to"
	lang E, cont "take my quiz, huh?"
	
	lang E, para "My quiz has things"
	lang E, line "you won't know,"
	lang E, cont "no matter how much"
	lang E, cont "you've traveled."

	lang E, para "After all, this is"
	lang E, line "about stuff from"
	lang E, cont "three years ago."
	
	lang E, para "Anyway, let's get"
	lang E, line "started."
	
	lang E, para "There are ten"
	lang E, line "questions total!"
	
	lang E, para "Let's go!"
	
; German
	lang D, text "BLAU: Yo!"
	lang D, line "Du bist hier, um"
	lang D, cont "mein Quiz heraus-"
	lang D, cont "zufordern, hm?"
	
	lang D, para "Mein Quiz bietet"
	lang D, line "Fragen, die du nie"
	lang D, cont "beantworten wirst,"
	lang D, cont "egal, wie weit du"
	lang D, cont "gereist bist."

	lang D, para "Es handelt sich"
	lang D, line "schließlich um"
	lang D, cont "Fakten von vor"
	lang D, cont "drei Jahren."
	
	lang D, para "Wie dem auch sei,"
	lang D, line "lass uns beginnen."
	
	lang D, para "Insgesamt gibt es"
	lang D, line "zehn Fragen!"
	
	lang D, para "Also, los geht's!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, db   "?"

	done
ENDM

MACRO minigame_name
	lang J, db "ポケモンクイズ！"
	lang E, db "#MON QUIZ!"
	lang D, db "#MON-QUIZ!"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
ENDM

MACRO minigame_desc
	lang J, db   "これまで<NO>ぼうけん<WO>どこまで"
	lang J, line "おもいだせるか　テストします！"
	
	lang E, db   "Test your memory"
	lang E, line "of your adventure!"
	
	lang D, db   "Erinnerst du dich"
	lang D, line "an dein Abenteuer?"
	
	lang F, db   "Testez vos souve-"
	lang F, line "nirs d'aventures!"
	
	lang I, db   "Quiz dei ricordi"
	lang I, line "sull'avventura!"
	
	lang S, db "?"
ENDM

ELSE
MinigameStart::
	
	news_screen PokemonQuiz, MUSIC_GAME_CORNER

	news_def_pals

	news_def_boxes
	news_box 0, 14, 20, 4, {NEWS_TEXT_BORDER}
	
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
	lang J, db "１ばん"
	lang E, db "1. "
	lang D, db "1. "
	lang F, db "1. "
	lang I, db "1. "
	lang S, db "1. "
	db "@"

.menuItemAnswer2Text
	lang J, db "２ばん"
	lang E, db "2. "
	lang D, db "2. "
	lang F, db "2. "
	lang I, db "2. "
	lang S, db "2. "
	db "@"

.menuItemAnswer3Text
	lang J, db "３ばん"
	lang E, db "3. "
	lang D, db "3. "
	lang F, db "3. "
	lang I, db "3. "
	lang S, db "3. "
	db "@"

.menuItemQuitText
	lang J, db "やめる"
	lang E, db "QUIT"
	lang D, db "ZUR."
	lang F, db "RET"
	lang I, db "ESCI"
	lang S, db "?"
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
	lang J, db   "マサラタウンで　ポケモンの"
	lang J, next "たいりょくを　かいふく"
	lang J, next "する　ばしょは？"
	lang J, next ""
	lang J, next "１　けんきゅうじょ　２　レッドのいえ"
	lang J, next "３　グリーンのいえ"
	
	; English
	lang E, db   "Where in PALLET"
	lang E, next "TOWN can you heal"
	lang E, next "your #MON?"
	lang E, next "1. OAK'S LAB"
	lang E, next "2. RED'S HOUSE"
	lang E, next "3. BLUE'S HOUSE"
	
	; German
	lang D, db   "Wo in ALABASTIA"
	lang D, next "kannst du deine"
	lang D, next "#MON heilen?"
	lang D, next "1. EICHs LABOR"
	lang D, next "2. Haus von ROT"
	lang D, next "3. Haus von BLAU"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"

	next "@"
	
.question2Text
	; Japanese
	lang J, db   "トキワシティで　かわれている"
	lang J, next "オニスズメの　なまえは？"
	lang J, next ""
	lang J, next "１　オニチャン　２　スズチャン"
	lang J, next "３　オニスチャン"

	; English
	lang E, db   "What's the name of"
	lang E, next "the SPEAROW from"
	lang E, next "VIRIDIAN CITY?"
	lang E, next "1. SPEARY"
	lang E, next "2. ROWEY"
	lang E, next "3. SPIKEY"
	
	; German
	lang D, db   "Wie heißt das"
	lang D, next "HABITAK aus"
	lang D, next "VERTANIA CITY?"
	lang D, next "1. WILLI"
	lang D, next "2. HABBI"
	lang D, next "3. TAKKI"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question3Text
	; Japanese
	lang J, db   "ニビシティの　はくぶつかんの"
	lang J, next "にゅうじょうりょうは　いくら？"
	lang J, next ""
	lang J, next "１　５０えん　２　１００えん"
	lang J, next "３　２００えん"
	
	; English
	lang E, db   "How much is the"
	lang E, next "entrance fee for"
	lang E, next "the PEWTER MUSEUM"
	lang E, next "OF SCIENCE?"
	lang E, next "1. ¥50   2. ¥100"
	lang E, next "3. ¥200"
	
	; German
	lang D, db   "Was kostet in MAR-"
	lang D, next "MORIA der Eintritt"
	lang D, next "für das WISSEN-"
	lang D, next "SCHAFTSMUSEUM?"
	lang D, next "1. ¥50   2. ¥100"
	lang D, next "3. ¥200"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question4Text
	; Japanese
	lang J, db   "はじめて　みさきのこやに"
	lang J, next "いったとき　マサキに　なにが"
	lang J, next "おきていた？"
	lang J, next ""
	lang J, next "１　ポケモンとくっつく　２　びょうき"
	lang J, next "３　ポケモンをとられた"
	
	; English
    lang E, db   "When you met BILL"
    lang E, next "at the SEA COTTAGE"
    lang E, next "what happened?"
    lang E, next "1. #MON fusion"
    lang E, next "2. He was sick"
    lang E, next "3. #MON stolen"
	
	; German
    lang D, db   "Was ist im KÜSTEN-"
    lang D, next "HAUS von BILL"
    lang D, next "passiert?"
    lang D, next "1. #MON-Fusion"
    lang D, next "2. Krankheit"
    lang D, next "3. Diebstahl"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"

.question5Text
	; Japanese
	lang J, db   "シオン　ポケモンタワーの　ゆうれいは"
	lang J, next "しょうたいが　わからない　とき"
	lang J, next "せんとうで　なんと　いっていた？"
	lang J, next ""
	lang J, next "１　ヒキカエセ　２　チカヨルナ"
	lang J, next "３　タチサレ"
	
	; English
	lang E, db   "In #MON TOWER"
	lang E, next "what did the"
	lang E, next "unidentified GHOST"
	lang E, next "say in battle?"
	lang E, next "1. Shoo 2. Go away"
	lang E, next "3. Get out"
	
	; German
	lang D, db   "Was sagte der"
	lang D, next "GEIST im #MON-"
	lang D, next "TURM im Kampf?"
	lang D, next ""
	lang D, next "1. Buuh 2. Geh weg"
	lang D, next "3. Verschwinde"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question6Text
	; Japanese
	lang J, db   "タマムシマンションの　おくじょうの"
	lang J, next "こやの　いちぐちの　かんばん"
	lang J, next "わしは　なんでも　……　なに？"
	lang J, next ""
	lang J, next "１　おてのもの　２　おみとおし"
	lang J, next "３　もっている"
	
	; English
	lang E, db   "The sign on the"
	lang E, next "rooftop of CELADON"
	lang E, next "MANSION says"
	lang E, next "“I … EVERYTHING!”"
	lang E, next "1. DO 2. KNOW"
	lang E, next "3. HAVE"	
	
	; German
	lang D, db   "Das Schild oben"
	lang D, next "auf der PRISMANIA-"
	lang D, next "VILLA besagt: “ICH"
	lang D, next "… ALLES!”"
	lang D, next "1. TUE 2. WEISS"
	lang D, next "3. HABE"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question7Text
	; Japanese
	lang J, db   "ヤマブキシティの　かくとうどうじょう"
	lang J, next "しはんが　しょうぶに　はいる　まえ"
	lang J, next "だす　かけごえは？"
	lang J, next ""
	lang J, next "１　トオリャー！　２　オッス！"
	lang J, next "３　どりゃぁぁ！"
	
	; English
	lang E, db   "In SAFFRON CITY's"
	lang E, next "FIGHTING DOJO, the"
	lang E, next "battle cry of the"
	lang E, next "KARATE MASTER is?"
	lang E, next "1. Fwaaa!  2. Haa!"
	lang E, next "3. Hiyah!"
	
	; German
	lang D, db   "Der Kampfschrei d."
	lang D, next "KARATE-MEISTERS in"
	lang D, next "SAFFRONIA CITY"
	lang D, next "klingt wie?"
	lang D, next "1. Hai!  2. Haa!"
	lang D, next "3. Hu-ha!"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question8Text
	; Japanese
	lang J, db   "サファリゾーンの　えんちょうの"
	lang J, next "ひみつと　いったら？"
	lang J, next ""
	lang J, next "１　かつら　２　いれば"
	lang J, next "３　ムシがこわい"
	
	; English
	lang E, db   "What is the SAFARI"
	lang E, next "ZONE WARDEN's"
	lang E, next "secret?"
	lang E, next "1. A wig"
	lang E, next "2. False teeth"
	lang E, next "3. Fear of bugs"
	
	; German
	lang D, db   "Welches Geheimnis"
	lang D, next "hat der WÄRTER der"
	lang D, next "SAFARI ZONE?"
	lang D, next "1. Perücke"
	lang D, next "2. Zahnlosigkeit"
	lang D, next "3. Insektenphobie"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question9Text
	; Japanese
	lang J, db   "ポケモンリーグで　にげだそうと"
	lang J, next "すると　だれかの　こえが…！"
	lang J, next "なんと　いわれる？"
	lang J, next ""
	lang J, next "１　にげられはせん　２　にげるのか"
	lang J, next "３　にげてはならん"
	
	; English
	lang E, db   "What's said if you"
	lang E, next "try to RUN at the"
	lang E, next "#MON LEAGUE?"
	lang E, next "1. You can't run!"
	lang E, next "2. Running away?"
	lang E, next "3. Don't run away!"
	
	; German
	lang D, db   "Was sagt EINE"
	lang D, next "STIMME in der"
	lang D, next "#MON-LIGA?"
	lang D, next "1.Kein Entkommen!"
	lang D, next "2.Du verlässt uns?"
	lang D, next "3.Lauf nicht davon"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"
	
.question10Text
	; Japanese
	lang J, db   "レッドは　てもちの　ポケモンが"
	lang J, next "すべて　たたかえなく　なると"
	lang J, next "めのまえが　どうなった？"
	lang J, next ""
	lang J, next "１　まっしろ　２　まっくら"
	lang J, next "３　クラクラした"
	
	; English
	lang E, db   "What happens to"
	lang E, next "RED when all of"
	lang E, next "his #MON faint?"
	lang E, next "1. Whites out"
	lang E, next "2. Blacks out"
	lang E, next "3. Gets dizzy"
	
	; German
	lang D, db   "Was passiert, wenn"
	lang D, next "ROTs #MON alle"
	lang D, next "kampfunfähig sind?"
	lang D, next "1. Schlechte Sicht"
	lang D, next "2. Ohnmacht"
	lang D, next "3. Schwindel"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	next "@"

	
	
	news_screen QuizScoreEvaluation, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	
	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes
	
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
	lang J, db "グリーンのひょうか"
	lang E, db "BLUE's RATING"
	lang D, db "BLAUs BEWERTUNG"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
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
	lang J, db   "クイズ　しゅうりょう"
	lang J, line "ひょうか<WO>うけて　ください！"

; i believe this to be a mistranslation due to the string's placement...
;	lang E, db   "Take the QUIZ to"
;	lang E, line "receive a rating!"
; i think the japanese text reads more like...
;	lang E, db   "Quiz complete!"
;	lang E, line "Please be rated!"
; but that's clunky, so we'll go with
	lang E, db   "Quiz complete!"
	lang E, line "Here's the rating!"
; TODO: potentially revise, and match in other languages

	lang D, db   "Die Bewertung"
	lang D, line "deiner Antworten!"
	
	lang F, db   "Faites le quiz et"
	lang F, line "recevez un Avis!"
	
	lang I, db   "Fai il quiz per"
	lang I, line "una valutazione!"
	
	lang S, db "?"
	
	db "@"
	
.textScoreIntro
	; Japanese
	lang J, text "グリーン『いくつ　わかったか"
	lang J, line "オレが　みてやるよ！"
	
	lang J, para "<……>　<……>"
	
	
	; English
	lang E, text "BLUE: How'd you do?"
	lang E, line "Lemme check!"
	
	lang E, para "…"
	
	; German
	lang D, text "BLAU: Wie hast du"
	lang D, line "abgeschnitten?"
	lang D, cont "Mal sehen!"
	
	lang D, para "…"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	para ""
	done
.textScore0
	; Japanese
	lang J, text "おいおい　ひとつも"
	lang J, line "あたって　ないぜー！"
	
	lang J, para "やっぱり　おまえには"
	lang J, line "とても　むり　だったな"
	lang J, cont "ごくろうさん！"
	
	; English
	lang E, text "Hey, not even one"
	lang E, line "right?"
	
	lang E, para "I knew it, you"
	lang E, line "couldn't do it."
	lang E, cont "Nice try!"
	
	; German
	lang D, text "Hey, nicht eine"
	lang D, line "richtige Antwort?"
	
	lang D, para "Ich wusste es!"
	
	lang D, para "Du bist dem nicht"
	lang D, line "gewachsen."
	lang D, cont "Netter Versuch!"

	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"

	done

.textScore1
	; Japanese
	lang J, text "ひとつ　あたってるな！"
	
	lang J, para "まあ　ひとつ　あたったくらいじゃ"
	lang J, line "ぜんぜん　わかってないのと"
	lang J, cont "おなじだぜ"
	lang J, cont "また　でなおすんだな"
	
	; English
	lang E, text "One correct!"
	
	lang E, para "But getting just"
	lang E, line "one right is the" 
	lang E, cont "same as not"
	lang E, cont "knowing anything."
	
	lang E, para "Try again."
	
	; German
	lang D, text "Ein Treffer!"
	
	lang D, para "Nur eine richtige"
	lang D, line "Antwort ist das"
	lang D, cont "gleiche wie gar"
	lang D, cont "nichts zu wissen."
	
	lang D, para "Versuche es"
	lang D, line "noch einmal."
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.textScore2
	; Japanese
	lang J, text "２もん　せいかい！"
	
	lang J, para "おいおい　ほんきで　やってる？"
	lang J, para "オレの　あいてには"
	lang J, line "まだまだ　ふそくだな！"
	
	; English
	lang E, text "Two correct!"
	
	lang E, para "Hey, are you"
	lang E, line "really trying?"
	
	lang E, para "You're still no"
	lang E, line "match for me!"
	
	; German
	lang D, text "Zwei Treffer!"
	
	lang D, para "Hey, versuchst du"
	lang D, line "es überhaupt?"
	
	lang D, para "Du hast keine"
	lang D, line "Chance gegen mich!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.textScore3
	; Japanese
	lang J, text "３もん　せいかい　だぜ！"
	
	lang J, para "ポケモンしょうぶは　つよいのかも"
	lang J, line "しれねえ　けど　ほかは"
	lang J, cont "たいしたこと　ねーな！"
	
	; English
	lang E, text "Three correct!"
	
	lang E, para "Maybe you're good"
	lang E, line "at #MON battles,"
	
	lang E, para "but other than"
	lang E, line "that?"
	lang E, cont "Not so much!"
	
	; German
	lang D, text "Drei Treffer!"
	
	lang D, para "Du bist möglicher-"
	lang D, line "weise gut in"
	lang D, cont "#MON-Kämpfen."
	
	lang D, para "Aber darüber"
	lang D, line "hinaus?"
	lang D, cont "Nicht wirklich!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.textScore4
	; Japanese
	lang J, text "せいかいは　４つ！"
	
	lang J, para "まあ　まぐれで　これだけ"
	lang J, line "わかれば　たいした　もんだ"
	
	; English
	lang E, text "Four correct!"
	
	lang E, para "Getting this many"
	lang E, line "lucky guesses is"
	lang E, cont "pretty impressive!"
	
	; German
	lang D, text "Vier Treffer!"
	
	lang D, para "So viele Zufalls-"
	lang D, line "treffer zu landen"
	lang D, cont "ist beeindruckend!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore5
	; Japanese
	lang J, text "５もん　せいかい！"
	
	lang J, para "なかなか　くろう　してるようだな"
	lang J, line "まあ　オレが　かんがえたからな！"
	lang J, cont "あと　５もんの　かべは　あついぜ！"
	
	; English
	lang E, text "Five correct!"
	
	lang E, para "Looks like you're"
	lang E, line "actually trying."
	
	lang E, para "Well, I did come"
	lang E, line "up with these"
	lang E, cont "myself!"
	
	lang E, para "The next five will"
	lang E, line "be tough though!"
	
	; German
	lang D, text "Fünf Treffer!"
	
	lang D, para "Du scheinst dich"
	lang D, line "wenigstens"
	lang D, cont "anzustrengen."
	
	lang D, para "Na ja, dafür habe"
	lang D, line "ich mir das alles"
	lang D, para "ganz alleine"
	lang D, line "ausgedacht!"
	
	lang D, para "Die restlichen"
	lang D, line "fünf Fragen waren"
	lang D, cont "aber wohl zu heiß!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore6
	; Japanese
	lang J, text "６もん　あたってたぜ！"
	
	lang J, para "まあまあって　ところだな"
	lang J, line "まあ　オレには　ぜんぜん"
	lang J, cont "およばないけどな！"
	
	; English
	lang E, text "Six correct!"
	
	lang E, para "Not bad, I guess."
	
	lang E, para "But you're nowhere"
	lang E, line "near my level!"
	
	; German
	lang D, text "Sechs Treffer!"
	
	lang D, para "Nicht schlecht,"
	lang D, line "schätze ich."
	
	lang D, para "Aber an meine"
	lang D, line "Fähigkeiten kommst"
	lang D, cont "du nicht heran!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore7
	; Japanese
	lang J, text "せいかいは　７もん　だぜ！"
	
	lang J, para "こんなに　あたる　はず"
	lang J, line "ねえって　おもって"
	lang J, cont "いたんだけどな…"
	
	; English
	lang E, text "Seven correct!"
	
	lang E, para "I didn't think"
	lang E, line "you'd get this"
	lang E, cont "many right…"
	
	; German
	lang D, text "Sieben Treffer!"
	
	lang D, para "Ich hätte nicht"
	lang D, line "erwartet, dass du"
	lang D, para "so viele Antworten"
	lang D, line "weißt…"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore8
	; Japanese
	lang J, text "８もん　せいかい！"
	
	lang J, para "なかなか　やるじゃ　ねえか"
	lang J, line "おれの　つぎ　くらいには"
	lang J, cont "すごい　きおくりょく　だぜ！"
	
	; English
	lang E, text "Eight correct!"
	
	lang E, para "Not bad at all."
	
	lang E, para "Your memory is"
	lang E, line "almost as good"
	lang E, cont "as mine!"
	
	; German
	lang D, text "Acht Treffer!"
	
	lang D, para "Gar nicht übel."
	
	lang D, para "Du kannst dir fast"
	lang D, line "so viel merken"
	lang D, cont "wie ich!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore9
	; Japanese
	lang J, text "おっと　９もん　せいかい！"
	
	lang J, para "おしいな！　あと　ひとつで"
	lang J, line "ぜんもん　せいかい　だったのにな"
	
	lang J, para "もういちど　がんばって　みろよ！"
	
	; English
	lang E, text "Whoa, nine"
	lang E, line "correct!"
	
	lang E, para "So close! One more"
	lang E, line "and you'd have got"
	lang E, cont "them all!"
	
	lang E, para "Try again!"
	
	; German
	lang D, text "Wow, neun"
	lang D, line "Treffer!"
	
	lang D, para "Nah dran! Nur ein"
	lang D, line "weiterer Treffer"
	lang D, cont "und du hättest"
	
	lang D, para "alles richtig"
	lang D, line "beantwortet."
	
	lang D, para "Versuche es"
	lang D, line "noch einmal!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.textScore10
	; Japanese
	lang J, text "ぜんもん　せいかい<……>！"
	
	lang J, para "おまえ　すごいな"
	lang J, line "３ねんも　まえの　ことを"
	lang J, cont "これだけ　おぼえている　なんてな！"  
	lang J, cont "かんぜんに　オレの　まけだ！"
	
	; English
	lang E, text "All correct…!"
	
	lang E, para "You're amazing."
	
	lang E, para "To remember all"
	lang E, line "that from three"
	lang E, cont "years ago!"

	lang E, para "I'm totally"
	lang E, line "beat!"
	
	; German
	lang D, text "Alles richtig…!"
	
	lang D, para "Du bist stark."
	
	lang D, para "Das alles drei"
	lang D, line "Jahre später noch"
	lang D, cont "zu wissen!"

	lang D, para "Du hast mich"
	lang D, line "komplett besiegt!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.textNotAllCorrect
	; Japanese
	lang J, text "グリーン『どうだ？　オレの"
	lang J, line "クイズは　むずかしいだろ？"
	lang J, para "しかたねえな　もういちど"
	lang J, line "チャンスを　やると　するか…"
	lang J, para "どうする？"
	lang J, line "もういちど　やって　みるか？"
	
	; English
	lang E, text "BLUE: Well? My"
	lang E, line "quiz is hard,"
	lang E, cont "isn't it?"
	
	lang E, para "I guess I'll"
	lang E, line "give you another"
	lang E, cont "chance…"

	lang E, para "What do you say?"
	lang E, line "Wanna try again?"
	
	; German
	lang D, text "BLAU: Und? Das"
	lang D, line "war ein schweres"
	lang D, cont "Quiz, nicht wahr?"
	
	lang D, para "Ich schätze, ich"
	lang D, line "gebe dir noch eine"
	lang D, cont "Chance…"

	lang D, para "Was sagst du?"
	lang D, line "Noch ein Versuch?"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.textGiveUp
	; Japanese
	lang J, text "またな！"
	
	; English
	lang E, text "See ya!"
	lang D, text "Ciao!"
	lang F, text "?"
	lang I, text "?"
	lang S, text "?"
	done

.textGiveGift
	; NOTE: the person recording this quiz didnt get a chance to properly record this line
	;       this is what they gave as the general gist.
	; Japanese
	lang J, text "おまえすごいな　じしんもっていいぜ"
	lang J, para "わざマシン２６を　もらった！"
	
	; English
	lang E, text "Well done!"
	
	lang E, para "You should be"
	lang E, line "proud of yourself."
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM26."
	
	; German
	lang D, text "Gut gemacht!"
	
	lang D, para "Du kannst stolz"
	lang D, line "auf dich sein."
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM26."	
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

ENDC