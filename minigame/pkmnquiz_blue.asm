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
; French localization by ISSOtm
; Italian localization by svp
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
	lang E, text "BLUE: Yo!" ; Same salutation as in the Viridian Gym.
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

	; French
	lang F, text "BLUE: Yo!"
	lang F, line "Alors tu es ici"
	lang F, cont "pour te frotter"
	lang F, cont "à mon quiz?"

	lang F, para "Mon quiz a des"
	lang F, line "trucs que tu n'peux"
	lang F, cont "pas connaître,"
	lang F, cont "même si tu as"
	lang F, cont "tout vu tout fait."

	lang F, para "Après tout, le su-"
	lang F, line "jet c'est des trucs"
	lang F, cont "d'il y a trois ans."

	lang F, para "Bref, commençons."

	lang F, para "Il y a dix"
	lang F, line "questions en tout!"

	lang F, para "Allons-y!"

	; Italian     ------------------
	lang I, text "BLU: Eccoti!" 	; blue in viridian greets you
	lang I, line "Quindi hai deciso"; by immediately pointing out
	lang I, cont "di provare il mio"; we took forever. not even a
	lang I, cont "quiz, eh?"	; yo, ice cold...

	lang I, para "Il mio quiz ha"
	lang I, line "domande che di"
	lang I, cont "certo non saprai,"
	lang I, cont "neanche per quanto"
	lang I, cont "tu abbia viaggiato"

	lang I, para "Dopotutto, queste"
	lang I, line "sono cose di tre"
	lang I, cont "anni fa."
	
	lang I, para "Ad ogni modo, co-"
	lang I, line "minciamo."
	
	lang I, para "In tutto ci sono"
	lang I, line "dieci domande!"
	
	lang I, para "Si comincia!"

	; Spanish
	lang S, text "AZUL: ¡Hola!"
	lang S, line "Así que has"
	lang S, cont "venido a hacer"	
	lang S, cont "mi test, ¿eh?"
	
	lang S, para "Mi test tiene cosas"
	lang S, line "que no sabrás,"
	lang S, cont "no importa cuanto"
	lang S, cont "hayas viajado."

	lang S, para "Después de todo,"
	lang S, line "es sobre cosas de"
	lang S, cont "hace tres años."
	
	lang S, para "En fin, vamos a"
	lang S, line "empezar."
	
	lang S, para "¡Hay diez"
	lang S, line "preguntas en total!"
	
	lang S, para "¡Vamos allá!"

	done
ENDM
; Max 17 chars
MACRO minigame_name
	lang J, db "ポケモンクイズ！"
	lang E, db "#MON QUIZ!"
	lang D, db "#MON-QUIZ!"
	lang F, db "QUIZ #MON!"
	lang I, db "#MON QUIZ!"
	lang S, db "ACERTIJO #MON"
ENDM

MACRO minigame_desc
	lang J, db   "これまで<NO>ぼうけん<WO>どこまで"
	lang J, line "おもいだせるか　テストします！"

	lang E, db   "Test your memory"
	lang E, line "of your adventure!"

	lang D, db   "Erinnerst du dich"
	lang D, line "an dein Abenteuer?"

	; French
	lang F, db   "Testez vos souve-"
	lang F, line "nirs d'aventures!"

	; Italian
	lang I, db   "Quiz dei ricordi"
	lang I, line "sull'avventura!"

	lang S, db   "Prueba tu memoria"
	lang S, line "de tu aventura!"
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
	lang S, db "SALIR"
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

	; French
	lang F, db   "Au BOURG PALETTE,"
	lang F, next "où peut-on soigner"
	lang F, next "ses #MON?"
	lang F, next "1. LABO de CHEN"
	lang F, next "2. Chez RED"
	lang F, next "3. Chez BLUE"

	; Italian     ------------------
	lang I, db   "A BIANCAVILLA, "
	lang I, next "dove puoi curare"
	lang I, next "i tuoi #MON?"
	lang I, next "1. LABORATORIO OAK"
	lang I, next "2. CASA DI ROSSO"
	lang I, next "3. CASA DI BLU"

	; Spanish
	lang S, db   "Donde en PUEBLO"
	lang S, next "PALETA curas"
	lang S, next "a tus #MON?"
	lang S, next "1. LABORATORIO OAK"
	lang S, next "2. CASA DE ROJO"
	lang S, next "3. CASA DE AZUL"

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
	lang E, next "1. SPEARY" ; Beginning of "SPEAR(row)"
	lang E, next "2. ROWEY" ; End of "(spea)ROW"
	lang E, next "3. SPIKEY" ; Made up?

	; German
	lang D, db   "Wie heißt das"
	lang D, next "HABITAK aus"
	lang D, next "VERTANIA CITY?"
	lang D, next "1. WILLI"
	lang D, next "2. HABBI"
	lang D, next "3. TAKKI"

	; French
	lang F, db   "Quel est le surnom"
	lang F, next "du PIAFABEC de"
	lang F, next "JADIELLE?"
	lang F, next "1. PIAFFY"
	lang F, next "2. BECCY"
	lang F, next "3. CONDOR"

	; Italian
	lang I, db   "Come si chiama"
	lang I, next "lo SPEAROW da"
	lang I, next "SMERALDOPOLI?"
	lang I, next "1. SPEARY"
	lang I, next "2. ROWEY"
	lang I, next "3. ROSTO" ;if spikey is made up im taking some artistic licensing here

	; Spanish
	lang S, db   "Cómo se llama"
	lang S, next "el SPEAROW de"
	lang S, next "CIUDAD VERDE?"
	lang S, next "1. SPEARY"
	lang S, next "2. ROWEY"
	lang S, next "3. SPIKEY"

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

	; French
	lang F, db   "Combien coûte un"
	lang F, next "ticket enfant au"
	lang F, next "MUSEE DES SCIENCES"
	lang F, next "d'ARGENTA?"
	lang F, next "1. 50¥   2. 100¥"
	lang F, next "3. 200¥"

	; Italian     ------------------
	lang I, db   "Quanto costa l'"
	lang I, next "ingresso al MUSEO"
	lang I, next "della SCIENZA di"
	lang I, next "PLUMBEOPOLI?"
	lang I, next "1. ¥50   2. ¥100"
	lang I, next "3. ¥200"
	

	; Spanish
	lang S, db   "¿Cuánto cuesta la"
	lang S, next "entrada al MUSEO"
	lang S, next "DE LA CIENCIA"
	lang S, next "CIUDAD PLATEADA?"
	lang S, next "1. ¥50   2. ¥100"
	lang S, next "3. ¥200"

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

	; French
	lang F, db   "Quel problème"
	lang F, next "avait LEO quand tu"
	lang F, next "l'as rencontré?"
	lang F, next "1. Fusion #MON"
	lang F, next "2. Maladie"
	lang F, next "3. #MON volé"

	; Italian     ------------------
	lang I, db   "Quale era il pro-"
	lang I, next "blema che BILL"
	lang I, next "aveva quando lo"
	lang I, next "incontrasti a"
	lang I, next "MIRAMARE?"	; i cant believe they named the real life place after the pokemon location...
	lang I, next "1. Fuso a #MON"
	lang I, next "2. Era malato"
	lang I, next "3. #MON rubato"

	; Spanish
	lang S, db   "Conociste a BILL"
	lang S, next "en la CASA DEL MAR"
	lang S, next "¿qué pasó?"
	lang S, next "1. Fusión #MON"
	lang S, next "2. Estaba enfermo"
	lang S, next "3. #MON robado"
	
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

	; French
	lang F, db   "Que dit un SPECTRE"
	lang F, next "non indentifié"
	lang F, next "lors d'un combat à"
	lang F, next "la TOUR POKéMON?"
	lang F, next "1. Houu  2. Pars" ; Le texte pré-combat dit "Fuis... Impudent...".
	lang F, next "3. Dehors" ; Le texte en combat dit "Va-t-en... dehors...".

	; Italian     ------------------
	lang I, db   "Nella TORRE"
	lang I, next "#MON, lo SPETTRO"
	lang I, next "non identificato"
	lang I, next "cosa diceva in"
	lang I, next "lotta?"
	lang I, next "1. Uuuh 2. Via…"
	lang I, next "3. Fuori…"

	; Spanish
	lang S, db   "En TORRE #MON"
	lang S, next "Qué dijo"
	lang S, next "GHOST en"
	lang S, next "el combate?"
	lang S, next "1. Fuera  2. Vete"
	lang S, next "3. Lárgate"
	
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

	; French
	lang F, db   "Sur le toit du"
	lang F, next "MANOIR CELADON, le"
	lang F, next "panneau dit"
	lang F, next "“JE … TOUT!”"
	lang F, next "1. FAIS 2. SAIS"
	lang F, next "3. VEUX"	

	; Italian     ------------------
	lang I, db   "Il cartello sul"
	lang I, next "tetto del CENTRO"
	lang I, next "COMMERCIALE di"
	lang I, next "AZZURROPOLI diceva"
	lang I, next "IO … TUTTO!"
	lang I, next "1. DO 2. SO"
	lang I, next "3. HO"
	
	; Spanish
	lang S, db   "El letrero en el"
	lang S, next "tejado del MANSIÓN"
	lang S, next "AZULONA dice"
	lang S, next "“¡LO … TODO!”"
	lang S, next "1. HAGO 2. SÉ"
	lang S, next "3. TENGO"	
	
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

	; French
	lang F, db   "Quel est le cri de"
	lang F, next "combat du MAITRE"
	lang F, next "de KARATE au DOJO"
	lang F, next "de SAFRANIA?"
	lang F, next "1. Ayaaaaa! 2. Hm!"
	lang F, next "3. Seiiyahh!"

	; Italian     ------------------
	lang I, db   "Nel DOJO KARATE"
	lang I, next "a ZAFFERANOPOLI,"
	lang I, next "quale è il grido"
	lang I, next "di lotta del RE"
	lang I, next "del KARATE?"
	lang I, next "1. Fuaaa! 2. Hiah!"
	lang I, next "3. Ho-ha!"
	

	; Spanish
	lang S, db   "En el DOJO-KARATE"
	lang S, next "CIUDAD AZAFRÁN el"
	lang S, next "grito batalla del"
	lang S, next "MAESTRO KARATEKA"
	lang S, next "1. ¡Fuaaa! 2. Ja."
	lang S, next "3. ¡Jia!"
	
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

	; French
	lang F, db   "Quel est le secret"
	lang F, next "du GARDIEN du"
	lang F, next "PARC SAFARI?"
	lang F, next "Il a …?"
	lang F, next "1. Une perruque"
	lang F, next "2. Un dentier"
	lang F, next "3. Un doudou"

	; Italian     ------------------
	lang I, db   "Quale è il segreto"
	lang I, next "del GUARDIANO del-"
	lang I, next "la ZONA SAFARI?"
	lang I, next "1. Parrucca"
	lang I, next "2. Dentiera"
	lang I, next "3. Insettofobia"

	; Spanish
	lang S, db   "¿Cuál es secreto"
	lang S, next "del GUARDA de"
	lang S, next "la ZONA SAFARI?"
	lang S, next "1. Una peluca"
	lang S, next "2. Dentadura"
	lang S, next "3. Miedo insectos"
	
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

	; French
	lang F, db   "Que dit la voix"
	lang F, next "quand on fait demi"
	lang F, next "tour à la LIGUE?"
	lang F, next "1. Tu ne peux pas!"
	lang F, next "2. Tu nous quitte?"
	lang F, next "3. Ne fuis pas!"

	; Italian
	lang I, db   "Cosa viene detto"
	lang I, next "quando cerchi di"
	lang I, next "darti alla FUGA"
	lang I, next "alla LEGA #MON?"
	lang I, next "1. Non si scappa!"
	lang I, next "2. Scappi via?"
	lang I, next "3. Non scappare!"
	

	; Spanish
	lang S, db   "¿Qué se dice si"
	lang S, next "intentas HUIR de"
	lang S, next "la LIGA #MON?"
	lang S, next "1.¡No puedes huir!"
	lang S, next "2. ¿Huyes?"
	lang S, next "3. ¡No huyas!"
	
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

	; French
	lang F, db   "Qu'arrive-t-il à"
	lang F, next "RED quand tous ses"
	lang F, next "#MON sont K.O.?"
	lang F, next "1. Temps mort"
	lang F, next "2. Hors-jeu"
	lang F, next "3. Mal de crâne"

	; Italian     ------------------
	lang I, db   "Cosa succede a"
	lang I, next "ROSSO quando i"
	lang I, next "suoi #MON sono"
	lang I, next "tutti esausti?"
	lang I, next "1. Non ci vede più"
	lang I, next "2. Crolla"
	lang I, next "3. È alle strette"

	; Spanish
	lang S, db   "Qué le pasa a"
	lang S, next "ROJO cuando sus"
	lang S, next "#MON se debilitan?"
	lang S, next "1. Se desmayó"
	lang S, next "2. Perdió conoc."
	lang S, next "3. Se ha mareado"
	
	next "@"



	news_screen QuizScoreEvaluation, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes
IF DEF(_LANG_J)
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01 ; RATING text location
ELIF DEF(_LANG_E)
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01 ; RATING text location
ELIF DEF(_LANG_D)
	news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01 ; RATING text location
ELSE	
	news_menu  2, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
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
	nsc_drawtrainer 6, 2, BLUE, 7
	nsc_select
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textNotAllCorrect
IF DEF(_LANG_D)
	nsc_yesno 12, 7, .restartQuiz, .giveUp
ELSE
	nsc_yesno 13, 7, .restartQuiz, .giveUp
ENDC
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
	lang F, db "EVALUATION de BLUE"
	lang I, db "VALUTAZIONE di BLU"
	lang S, db "EVALUACIÓN DE AZUL"
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

	; French
	lang F, db   "Fin du quiz!"
	lang F, line "Voici le résultat!"

	; Italian
	lang I, db   "Quiz completato!"
	lang I, line "Ecco i risultati!"

	; Spanish
	lang S, db   "¡Listo!"
	lang S, line "¡Tu puntuación!"
	
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

	; French
	lang F, text "BLUE: Tu t'en es"
	lang F, line "sorti comment?"
	lang F, cont "Voyons ça!"

	lang F, para "..."

	; Italian
	lang I, text "BLU: Com'è andata?"
	lang I, line "Fammi vedere!"

	lang I, para "…"

	; Spanish
	lang S, text "BLUE: ¿Cómo fue?"
	lang S, line "¡Déjame ver!"

	lang S, para "…"

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

	; French
	lang F, text "Pfff, même pas une"
	lang F, line "de juste?"

	lang F, para "Je l'savais, t'as"
	lang F, line "pas le niveau."
	lang F, cont "Bien essayé!"

	; Italian
	lang I, text "Ehi, neanche una"
	lang I, line "risposta giusta?"

	lang I, para "Lo sapevo, non"
	lang I, line "ce l'hai fatta."
	lang I, cont "Bel tentativo!"

	; Spanish
	lang S, text "Oye, ni siquiera"
	lang S, line "una ¿verdad?"

	lang S, para "Lo sabía,"
	lang S, line "no podías hacerlo."
	lang S, cont "¡Buena esa!"

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

	; French
	lang F, text "Une de juste!"

	lang F, para "Mais seulement une"
	lang F, line "c'est comme si tu"
	lang F, cont "n'en avais trouvé"
	lang F, cont "aucune."

	lang F, para "Retente."

	; Italian
	lang I, text "Una giusta!"
	lang I, para "Ma solo una ris-"
	lang I, line "posta giusta è"
	lang I, cont "come non saperne"
	lang I, cont "nessuna."
	lang I, para "Riprova."

	; Spanish
	lang S, text "¡Una correcta!"

	lang S, para "Pero acertar solo"
	lang S, line "una es lo mismo" 
	lang S, cont "que no"
	lang S, cont "saber nada."

	lang S, para "Inténtalo nuevo."

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

	; French
	lang F, text "Deux de juste!"

	lang F, para "Ne me dis pas que"
	lang F, line "tu essayais"
	lang F, cont "sérieusement?"

	lang F, para "Tu ne m'arrives"
	lang F, line "même pas à la"
	lang F, cont "cheville!"

	; Italian
	lang I, text "Due giuste!"
	lang I, line "Ehi, ma fai sul"
	lang I, cont "serio?"

	lang I, para "Hai ancora molta"
	lang I, line "strada prima di"
	lang I, cont "raggiungermi!"

	; Spanish
	lang S, text "¡Dos correctas!"

	lang S, para "Oye, ¿estás"
	lang S, line "esforzándote?"

	lang S, para "¡Sigues sin"
	lang S, line "estar a mi altura!"

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

	; French
	lang F, text "Trois de juste!"

	lang F, para "Peut-être que tu"
	lang F, line "te débrouilles en"
	lang F, cont "combat #MON,"

	lang F, para "mais à part ça?"
	lang F, line "Pas grand-chose!"

	; Italian
	lang I, text "Tre giuste!"

	lang I, para "Magari te la cavi"
	lang I, line "bene con le lotte"
	lang I, cont "#MON…"

	lang I, para "Ma per il resto?"
	lang I, line "Non ne sono tanto"
	lang I, cont "sicuro!"

	; Spanish
	lang S, text "¡Tres correctas!"

	lang S, para "Quizás seas bueno"
	lang S, line "en combates #MON,"

	lang S, para "¿pero aparte de"
	lang S, line "eso?"
	lang S, cont "¡No tanto!"

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

	; French
	lang F, text "Quatre de juste!"

	lang F, para "En trouver autant"
	lang F, line "par hasard est"
	lang F, cont "impressionnant!"

	; Italian
	lang I, text "Quattro giuste!"

	lang I, para "Avere fortuna per"
	lang I, line "tutte queste volte"
	lang I, cont "è degno di nota!"



	lang S, text "¡Cuatro correctas!"

	lang S, para "¡Tantas respuestas"
	lang S, line "con suerte"
	lang S, cont "es impresionante!"

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

	; French
	lang F, text "Cinq de juste!"

	lang F, para "Tu m'as l'air d'y"
	lang F, line "mettre du tien."

	lang F, para "Ceci dit, c'est"
	lang F, line "moi qui ai choisi"
	lang F, cont "ces questions!"

	lang F, para "Alors accroche-toi"
	lang F, line "bien pour les"
	lang F, cont "cinq prochaines!"

	; Italian
	lang I, text "Cinque giuste!"

	lang I, para "Sembra che tu ci"
	lang I, line "stia provando sul"
	lang I, cont "serio."

	lang I, para "Beh, dopotutto ho"
	lang I, line "ideato io queste"
	lang I, cont "domande!"

	lang I, para "Le altre cinque"
	lang I, line "ti daranno molto"
	lang I, cont "filo da torcere!"

	; Spanish
	lang S, text "¡Cinco correctas!"

	lang S, para "Parece que si"
	lang S, line "estás intentando."

	lang S, para "Se me"
	lang S, line "ocurrieron estas"
	lang S, cont "preguntas solo!"

	lang S, para "¡Las próximas"
	lang S, line "serán mas dif.!"

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

	; French
	lang F, text "Six de juste!"

	lang F, para "Pas mal, j'dirais."

	lang F, para "Mais ton niveau"
	lang F, line "est loin du mien!"

	; Italian
	lang I, text "Sei giuste!"
	
	lang I, para "Hm. Non male."

	lang I, para "Ma ne hai di"
	lang I, line "strada da fare"
	lang I, cont "per raggiungermi!"

	; Spanish
	lang S, text "¡Seis correctas!"

	lang S, para "No está mal,"

	lang S, para "Pero estás lejos"
	lang S, line "de mi nivel!"

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

	; French
	lang F, text "Sept de juste!"

	lang F, para "Je ne pensais pas"
	lang F, line "que tu en trou-"
	lang F, cont "verais autant..."

	; Italian
	lang I, text "Sette giuste!"
	lang I, para "Non pensavo che"
	lang I, line "ne azzeccassi"
	lang I, cont "così tante…"

	; Spanish
	lang S, text "¡Siete correctas!"

	lang S, para "No pensé"
	lang S, line "que conseguirías"
	lang S, cont "bastantes…"

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

	; French
	lang F, text "Huit de juste!"

	lang F, para "Pas mal du tout."

	lang F, para "Ta mémoire est"
	lang F, line "presque aussi bon-"
	lang F, cont "ne que la mienne!"

	; Italian
	lang I, text "Otto giuste!"

	lang I, para "Niente male!"

	lang I, para "La tua memoria è"
	lang I, line "buona quasi quanto"
	lang I, cont "la mia!"

	; Spanish
	lang S, text "¡Ocho correctas!"

	lang S, para "No está nada mal."

	lang S, para "¡Tu memoria es"
	lang S, line "casi tan buena"
	lang S, cont "como la mía!"

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

	; French
	lang F, text "Waouh, neuf de"
	lang F, line "juste!"

	lang F, para "Si près! Une seule"
	lang F, line "de plus et tu les"
	lang F, cont "avais toutes!"

	lang F, para "Retente!"

	; Italian
	lang I, text "Wow, nove giuste!"

	lang I, para "C'eri quasi! Solo"
	lang I, line "un'altra e le"
	lang I, cont "avresti azzeccate"
	lang I, cont "tutte!"
	
	lang I, para "Prova ancora!"

	; Spanish
	lang S, text "¡Vaya, nueve"
	lang S, line "correctas!"

	lang S, para "¡Una más"
	lang S, line "y habrías acertado"
	lang S, cont "todas!"

	lang S, para "¡Inténtalo nuevo!"

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

	; French
	lang F, text "Tout juste..!"

	lang F, para "Tu forces le"
	lang F, line "respect."

	lang F, para "Se souvenir de"
	lang F, line "tout ça trois ans"
	lang F, cont "plus tard!"

	lang F, para "Je m'avoue vaincu!"

	; Italian
	lang I, text "Tutte giuste!"

	lang I, para "Fantastico!"

	lang I, para "Ti ricordi tutto"
	lang I, line "questo da tre"
	lang I, cont "anni fa!"

	lang I, para "Mi arrendo!"

	; Spanish
	lang S, text "Todo correcto…!"

	lang S, para "Eres increíble."

	lang S, para "Recordar todo"
	lang S, line "eso de hace tres"
	lang S, cont "años!"

	lang S, para "Estoy totalmente"
	lang S, line "hecho polvo!"

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
	lang D, line ""
	lang D, line "war ein schweres"
	lang D, cont "Quiz, nicht wahr?"

	lang D, para "Ich schätze, ich"
	lang D, line "gebe dir noch eine"
	lang D, cont "Chance…"

	lang D, para "Was sagst du?"
	lang D, line "Noch ein Versuch?"

	; French
	lang F, text "BLUE: Alors? Mon"
	lang F, line "quiz donne du fil"
	lang F, cont "à retordre, hein?"

	lang F, para "J'imagine que tu"
	lang F, line "mérites une autre"
	lang F, cont "chance..."

	lang F, para "T'en dis quoi? Tu"
	lang F, line "remets une couche?"

	; Italian
	lang I, text "BLU: Beh? Il mio"
	lang I, line "quiz è proprio"
	lang I, cont "tosto, nevvero?"

	lang I, para "Vorrà dire che ti"
	lang I, line "potrei concedere"
	lang I, cont "un altro tenta-"
	lang I, cont "tivo…"

	lang I, para "Che ne dici?"
	lang I, line "Vuoi riprovare?"

	; Spanish
	lang S, text "AZUL: ¿Y bien? Mi"
	lang S, line "test es difícil,"
	lang S, cont "¿no es así?"

	lang S, para "Supongo que te"
	lang S, line "daré otra"
	lang S, cont "oportunidad…"

	lang S, para "¿Qué me dices?"
	lang S, line "¿Reintentar?"

	done

.textGiveUp
	; Japanese
	lang J, text "またな！"

	; English
	lang E, text "See ya!"
	lang D, text "Ciao!"
	lang F, text "Bye-bye!"
	lang I, text "Ci vediamo!"
	lang S, text "¡Nos vemos!"
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

	; French
	lang F, text "Bien joué!"

	lang F, para "Tu peux être"
	lang F, line "fier de toi!"

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT26."

	; Italian
	lang I, text "Ben fatto!"

	lang I, para "Dovresti essere" 
	lang I, line "fiero di te!"	; todo: find a way to make this gender neutral

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   " riceve"
	lang I, line "MT26."

	; Spanish
	lang S, text "¡Bien hecho!"

	lang S, para "Deberías estar"
	lang S, line "orgulloso de ti ."

	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT26."

	done

ENDC
