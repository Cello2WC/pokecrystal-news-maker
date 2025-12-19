; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_11.htm
; Thanks to nohm for providing their first-hand account of this minigame!
;
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization TODO
; Spanish localization TODO

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"

MACRO minigame_abuttonhook
	;nsc_drawbox 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_clear 1, 4, 18, 8
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, BLAINE, 7
ENDM

MACRO minigame_start
	; fake page transition
	nsc_playmusic MUSIC_GYM
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0

	nsc_textbox 1, 14, .blaineIntroText
	nsc_waitbutton
	nsc_page PokemonQuiz

.blaineIntroText
	; Japanese
	lang J, text "カツラ『うおおーす！"
	lang J, line "わしは　ねっけつ　クイズ　おやじ！"

	lang J, para "グレン…　いや　ふたごじまの"
	lang J, line "リーダー　カツラなのだー！"

	lang J, para "いままで　なんで　わしの　でばんが"
	lang J, line "なかったのか　ふしぎな　くらい！"

	lang J, para "やっぱり　クイズと　いえば　わし！"
	lang J, line "もえる　おとこの　クイズ"
	lang J, cont "いくぞー！　うおおーす！！"

	; English
	lang E, text "BLAINE: Hah!"

	lang E, para "I'm the hotheaded"
	lang E, line "quiz master!"

	lang E, para "From CINNABAR…"
	lang E, line "no, from the"
	lang E, cont "SEAFOAM ISLANDS!"

	lang E, para "I am BLAINE, the"
	lang E, line "GYM LEADER!"

	lang E, para "It's a mystery why"
	lang E, line "I haven't had my"
	lang E, cont "turn until now!"

	lang E, para "When it comes to"
	lang E, line "quizzes, it's"
	lang E, cont "gotta be me!"

	lang E, para "This is a blazing"
	lang E, line "man's quiz!"

	lang E, para "Hah!"

	; German
	lang D, text "PYRO: Wuah!"

	lang D, para "Ich bin der hit-"
	lang D, line "zige Quizmaster!"

	lang D, para "Ich bin PYRO, der"
	lang D, line "ARENALEITER der"
	lang D, cont "ZINNOBER…"

	lang D, para "Nein, von den"
	lang D, line "SEESCHAUMINSELN!"

	lang D, para "Es ist rätselhaft,"
	lang D, line "dass ich bisher"
	lang D, cont "nicht dabei war!"

	lang D, para "Wenn es um Quiz"
	lang D, line "geht, denkt man"
	lang D, cont "zuerst an mich!"

	lang D, para "Und für dieses"
	lang D, line "Quiz brenne ich!"

	lang D, para "Wuah!"

	; French
	lang F, text "AUGUSTE: Waaah!"

	lang F, para "Je suis le maître" ; Suivi les traductions dans les autres jeux.
	lang F, line "du quiz!"

	lang F, text "Depuis CRAMOIS..."
	lang F, line "Non, depuis les"
	lang F, cont "ILES ECUME!"

	lang F, para "Je suis AUGUSTE,"
	lang F, line "le CHAMPION!"

	lang F, para "Incompréhensible"
	lang F, line "que je n'ai pas été"
	lang F, cont "appelé plus tôt!"

	lang F, para "Quand il s'agit de"
	lang F, line "faire un quiz, qui"
	lang F, cont "de mieux que moi?"

	lang F, para "Voici un quiz"
	lang F, line "chaud bouillant!"

	lang F, para "Waaah!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Ja!"
	
	lang S, para "Soy el acalorado"
	lang S, line "¡maestro del quiz!"
	
	lang S, para "De CANELA…"
	lang S, line "no, ¡de las"
	lang S, cont "ISLAS ESPUMA!"	
	
	lang S, para "Soy BLAINE, ¡el"
	lang S, line "LÍDER de GIMNASIO!"
	
	lang S, para "¡Es misterio que"
	lang S, line "no he tenido mi"
	lang S, cont "momento aún!"
	
	lang S, para "Cuando se trata de"
	lang S, line "acertijos, ¡es"
	lang S, cont "asunto mio!"
	
	lang S, para "¡Este es el quiz"
	lang S, line "del hombre fogoso!"
	
	lang S, para "¡Ja!"

	done

ENDM

MACRO minigame_name
; Max 17 chars
	lang J, db "ポケモンクイズ！"
	lang E, db "#MON QUIZ!"
	lang D, db "#MON-QUIZ!"
	lang F, db "QUIZ #MON!"
	lang I, db "?"
	lang S, db "Acertijo #MON"
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
	;Japanese
	lang J, db   "ウツギはかせが　ふねのチケットを"
	lang J, next "くれるときの　セリフの　さいごは"
	lang J, next "「カントーに　いったら…」　なに？"
	lang J, next ""
	lang J, next "１　もっと　つよく　なれるね！"
	lang J, next "２　オーキドはかせに　よろしく！"
	lang J, next "３　ほかの　のりものも　あるかもね！"

	;English
	lang E, db   "When ELM gave you"
	lang E, next "the S.S.TICKET he"
	lang E, next "said “… in KANTO!”"
	lang E, next "1. Get stronger"
	lang E, next "2. Say hi to OAK"
	lang E, next "3. Try other rides"

	;German
	lang D, db   "Worum bat LIND,"
	lang D, next "als er dir das"
	lang D, next "BOOTSTICKET gab?"
	lang D, next "1. Stärker werden"
	lang D, next "2. EICH grüßen"
	lang D, next "3. Weiter reisen"

	;French
	lang F, db   "Après t'avoir donné"
	lang F, next "le PASSE BATEAU,"
	lang F, next "ORME a dit “... à"
	lang F, next "KANTO!”:"
	lang F, next "1. Entraîne-toi"
	lang F, next "2. Amitiés à CHEN"
	lang F, next "3. Essaye le train"

	;Italian
	lang I, db   "?"
	
	lang S, db   "Cuando ELM te dio"
	lang S, next "el TICKET BARCO te"
	lang S, next "dijo “… en KANTO!”"
	lang S, next "1. Hazte más"
	lang S, next "2. Saluda a OAK"
	lang S, next "3. Otros recorr."

	next "@"

.question2Text
	;Japanese
	lang J, db   "アクアごうの　なかで　まごを"
	lang J, next "さがしている　おじさん"
	lang J, next "どこから　でてきた？"
	lang J, next ""
	lang J, next "１　よこから　でてきた"
	lang J, next "２　うえから　でてきた"
	lang J, next "３　へやの　なかから　でてきた"

	;English
	lang E, db   "Where did the lost"
	lang E, next "girl's grandfather"
	lang E, next "appear from on"
	lang E, next "the S.S.AQUA?"
	lang E, next "1. The side"
	lang E, next "2. Above 3. A room"

	;German
	lang D, db   "Von wo tauchte der"
	lang D, next "Großvater des ver-"
	lang D, next "lor. Mädchens auf"
	lang D, next "der M.S. AQUA auf?"
	lang D, next "1. Seite"
	lang D, next "2. Oben  3. Kabine"

	;French
	lang F, db   "D'où est apparu"
	lang F, next "le grand-père de"
	lang F, next "la fille perdue"
	lang F, next "sur l'AQUARIA?"
	lang F, next "1. Le côté"
	lang F, next "2. En haut"
	lang F, next "3. Une cabine"

	;Italian
	lang I, db   "?"
	
	lang S, db   "¿De donde apareció"
	lang S, next "el abuelo perdido"
	lang S, next "de aquella niña"
	lang S, next "en el S.S.AQUA?"
	lang S, next "1. Lado 2. Arriba"
	lang S, next "3. Una habitación"
	
	next "@"

.question3Text
	;Japanese
	lang J, db   "ぼうそうぞくの　３にんぐみ"
	lang J, next "「カントー　ポケモン　れんごう」の"
	lang J, next "なわばりは　もともと　どこだった？"
	lang J, next ""
	lang J, next "１　ディグダの　あな"
	lang J, next "２　サイクリングロード"
	lang J, next "３　ちかつうろ"

	;English
	lang E, db   "Where'd the KANTO"
	lang E, next "#MON FEDERATION"
	lang E, next "first hang out?"
	lang E, next "1.DIGLETT'S CAVE"
	lang E, next "2.CYCLING ROAD"
	lang E, next "3.UNDERGROUND PATH"

	;German
	lang D, db   "Wo befindet sich"
	lang D, next "die TRAINERGILDE"
	lang D, next "aus KANTO?"
	lang D, next "1. DIGDA-HÖHLE"
	lang D, next "2. RADWEG"
	lang D, next "3. UNTERFÜHRUNG"

	; French
	lang F, db   "Où traînait la"
	lang F, next "FEDERATION des"
	lang F, next "dresseurs de KANTO"
	lang F, next "à ses débuts?"
	lang F, next "1. CAVE TAUPIQUEUR"
	lang F, next "2. PISTE CYCLABLE"
	lang F, next "3. SOUTERRAIN"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿Dónde se reunía"
	lang S, next "la FEDERACIÓN"
	lang S, next "#MON de KANTO?"
	lang S, next "1.La CUEVA DIGLETT"
	lang S, next "2.El CAMINO BICIS"
	lang S, next "3.La VÍA"
	
	next "@"

.question4Text
	;Japanese
	lang J, db   "きよめのおふだを　もらえたのは"
	lang J, next "なにが　とりついて　いたから？"
	lang J, next ""
	lang J, next "１　ポケモンの　ゆうれい"
	lang J, next "２　よくない　たましい"
	lang J, next "３　ふきつな　カゲ"

	;English
	lang E, db   "When you got the"
	lang E, next "CLEANSE TAG what"
	lang E, next "hovered over you?"
	lang E, next "1. A ghost #MON"
	lang E, next "2. An evil spirit"
	lang E, next "3. Sinister shadow"

	;German
	lang D, db   "Was schwebte über"
	lang D, next "dir bei Erhalt des"
	lang D, next "SCHUTZBANDs?"
	lang D, next "1. Ein Gespenst"
	lang D, next "2. Ein böser Geist"
	lang D, next "3. Ein Schatten"

	; French
	lang F, db   "A cause de quoi"
	lang F, next "as-tu reçu la"
	lang F, next "RUNE PURIF.?"
	lang F, next "1. #MON fantôme"
	lang F, next "2. Présence maléf."
	lang F, next "3. Ombre sinistre"

	; Italian
	lang I, db   "?"
	
	lang S, db   "Cuando encontraste"
	lang S, next "el AMULETO ¿qué"
	lang S, next "vino sobre ti?"
	lang S, next "1. Un #MON"
	lang S, next "2. Un espíritu"
	lang S, next "3. Una sombra"
	
	next "@"

.question5Text
	;Japanese
	lang J, db   "ハナダシティの　そばで　たたかう"
	lang J, next "６にんぬきとは　まったく　かんけいの"
	lang J, next "ない　おとこは　なぜ　いどんでくる？"
	lang J, next ""
	lang J, next "１　つかれた　トレーナーを　たおす"
	lang J, next "２　トレーナーの　おかねを　うばう"
	lang J, next "３　ロケットだんの　ために"

	;English
	lang E, db   "After the six-pack"
	lang E, next "trainers, why did"
	lang E, next "the man fight you?"
	lang E, next "1. Easy wins"
	lang E, next "2. Stealing money"
	lang E, next "3. For TEAM ROCKET"

	;German
	lang D, db   "Welche Motivation"
	lang D, next "hatte der letzte"
	lang D, next "der NUGGET-BRÜCKE?"
	lang D, next "1. Leichtes Siegen"
	lang D, next "2. Geld stehlen"
	lang D, next "3. TEAM ROCKET"

	; French
	lang F, db   "Pourquoi l'homme"
	lang F, next "après les six"
	lang F, next "dresseurs vous a-"
	lang F, next "t-il combattu?"
	lang F, next "1. Victoire facile"
	lang F, next "2. Voler l'argent"
	lang F, next "3. La TEAM <ROCKET>"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿Qué motivación"
	lang S, next "tenía el último"
	lang S, next "del PUENTE PEPITA?"
	lang S, next "1. Victorias"
	lang S, next "2. Robar dinero"
	lang S, next "3. El TEAM ROCKET"
	
	next "@"

.question6Text
	;Japanese
	lang J, db   "カスミと　カスミの　ボーイフレンドは"
	lang J, next "どのような　ならびかたで"
	lang J, next "デート　していた？"
	lang J, next ""
	lang J, next "１　よこに　ならんで　いた"
	lang J, next "２　むかいあって　いた"
	lang J, next "３　カスミが　１ぽ　まえに　いた"

	;English
	lang E, db   "How did MISTY and"
	lang E, next "her boyfriend sit"
	lang E, next "on their date?"
	lang E, next "1. Side by side"
	lang E, next "2. Face to face"
	lang E, next "3. MISTY in front"

	;German
	lang D, db   "Wie standen MISTY"
	lang D, next "und ihr Freund bei"
	lang D, next "ihrer Verabredung?"
	lang D, next "1. Nebeneinander"
	lang D, next "2. Gegenüber"
	lang D, next "3. MISTY vorn"

	; French
	lang F, db   "Comment était"
	lang F, next "placée ONDINE"
	lang F, next "par rapport à"
	lang F, next "son rencart?"
	lang F, next "1. Côte à côte"
	lang F, next "2. Face à face"
	lang F, next "3. Devant lui"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿Cómo se sentaron"
	lang S, next "MISTY y su novio"
	lang S, next "en su cita?"
	lang S, next "1. Uno lado otro"
	lang S, next "2. Cara a cara"
	lang S, next "3. MISTY delante"
	
	next "@"

.question7Text
	;Japanese
	lang J, db   "はつでんしょの　しょちょうは"
	lang J, next "はつでんきの　ぶひんの　ことを"
	lang J, next "どう　いっていた？"
	lang J, next ""
	lang J, next "１　いのちより　だいじ"
	lang J, next "２　かわいい"
	lang J, next "３　わしの　すべて"

	;English
	lang E, db   "What did the POWER"
	lang E, next "PLANT MANAGER call"
	lang E, next "the generator?"
	lang E, next "1. Most important"
	lang E, next "2. My beloved"
	lang E, next "3. Cute"

	;German
	lang D, db   "Wie nannte der"
	lang D, next "KRAFTWERKSDIREKTOR"
	lang D, next "den Generator?"
	lang D, next "1. ultra wichtig"
	lang D, next "2. geliebt"
	lang D, next "3. ein und alles"

	; French
	lang F, db   "Comment le PATRON"
	lang F, next "de la CENTRALE a-"
	lang F, next "t-il parlé du"
	lang F, next "générateur?"
	lang F, next "1. Ultra important"
	lang F, next "2. Tant aimé"
	lang F, next "3. Si beau"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿DIRECTOR dijo"
	lang S, next "CENTRAL ENERGÍA"
	lang S, next "al generador?"
	lang S, next "1. Más importante"
	lang S, next "2. Mi querido"
	lang S, next "3. Bonito"
	
	next "@"

.question8Text
	;Japanese
	lang J, db   "ポケモン　だいすき　クラブの"
	lang J, next "かいちょうが　そだてた　ポケモンの"
	lang J, next "かずは　なんひき　いじょう？"
	lang J, next ""
	lang J, next "１　１５０"
	lang J, next "２　２５０"
	lang J, next "３　１０００"

	;English
	lang E, db   "How many #MON"
	lang E, next "has the CHAIRMAN"
	lang E, next "of the #MON FAN"
	lang E, next "CLUB raised?"
	lang E, next "1. 150   2. 250"
	lang E, next "3. 1000"

	;German
	lang D, db   "Der VORSITZENDE"
	lang D, next "des #MON-FAN-"
	lang D, next "CLUBS zog wie"
	lang D, next "viele #MON auf?"
	lang D, next "1. 150   2. 250"
	lang D, next "3. 1000"

	; French
	lang F, db   "Combien de #MON"
	lang F, next "le PRESIDENT du"
	lang F, next "FAN CLUB #MON"
	lang F, next "a-t-il élevé?"
	lang D, next "1. 150   2. 250"
	lang F, next "3. 1000"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿Cuántos #MON"
	lang S, next "tiene PRESIDENTE"
	lang S, next "del CLUB de"
	lang S, next "FANS de #MON?"
	lang S, next "1. 150   2. 250"
	lang S, next "3. 1000"
	
	next "@"

.question9Text
	;Japanese
	lang J, db   "モノマネむすめの　ピッピにんぎょうは"
	lang J, next "どこに　キズが　ある？"
	lang J, next ""
	lang J, next "１　みぎがわの　はね"
	lang J, next "２　ひだりみみの　さき"
	lang J, next "３　みぎあしの　つけね"

	;English
	lang E, db   "Where was the"
	lang E, next "tear on COPYCAT's"
	lang E, next "CLEFAIRY DOLL?"
	lang E, next "1. Right wing"
	lang E, next "2. Left ear"
	lang E, next "3. Right leg"

	;German
	lang D, db   "Wo war die Naht"
	lang D, next "an der PIEPI-PUPPE"
	lang D, next "der NACHAHMERIN?"
	lang D, next "1. Rechter Flügel"
	lang D, next "2. Linkes Ohr"
	lang D, next "3. Rechtes Bein"

	; French
	lang F, db   "Où la peluche de"
	lang F, next "la COPIEUSE était-"
	lang F, next "elle abîmée?"
	lang F, next "1. Aile droite"
	lang F, next "2. Oreille gauche"
	lang F, next "3. Jambe droite"

	; Italian
	lang I, db   "?"
	
	lang S, db   "¿Dónde estaba el"
	lang S, next "descosido MUÑECO"
	lang S, next "CLEFAIRY COPIONA?"
	lang S, next "1. Ala derecha"
	lang S, next "2. Oreja izquierda"
	lang S, next "3. Pata derecha"

	
	next "@"

.question10Text
	; Japanese
	lang J, db   "ポケモンリーグで　ケーシィに"
	lang J, next "いえまで　おくりとばして　もらうには"
	lang J, next "どうすれば　いい？"
	lang J, next ""
	lang J, next "１　ケーシィに　さわる"
	lang J, next "２　じぶんの　いえを　おもいうかべる"
	lang J, next "３　しっかりと　めを　とじる"

	; English
	lang E, db   "The #MON LEAGUE"
	lang E, next "ABRA will send"
	lang E, next "you home if you…?"
	lang E, next "1. Touch ABRA"
	lang E, next "2. Picture home"
	lang E, next "3. Close your eyes"

	; German
	lang D, db   "Das ABRA der PKMN-"
	lang D, next "LIGA schickt dich"
	lang D, next "wann nach Hause?"
	lang D, next "1. ABRA berühren"
	lang D, next "2. Bildlich denken"
	lang D, next "3. Augen schließen"

	; French
	lang F, db   "L'ABRA de la LIGUE"
	lang F, next "#MON te ramène"
	lang F, next "chez toi si tu..."
	lang F, next "1. Le touches"
	lang F, next "2. Penses à ta"
	lang F, next "   maison" ; FIXME: bleh.
	lang F, next "3. Ferme les yeux"

	; Italian
	lang I, db   "?"
	
	lang S, db   "El Abra de la"
	lang S, next "LIGA #MON te"
	lang S, next "emviará casa si…?"
	lang S, next "1. Tocas al ABRA"
	lang S, next "2. Visualizas casa"
	lang S, next "3. Cierras ojos"
	
	next "@"

	news_screen QuizScoreEvaluation, MUSIC_GYM

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes

	news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

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
	lang J, db "カツラのひょうか"
	lang E, db "BLAINE's RATING"
	lang D, db "PYROs BEWERTUNG"
	lang F, db "EVAL. d'AUGUSTE"
	lang I, db "?"
	lang S, db "EVALUACIÓN BLAINE"
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
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
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
; Rework in other languages

	lang D, db   "Die Bewertung"
	lang D, line "deiner Antworten!"

	; French
	lang F, db   "Fin du quiz!"
	lang F, line "Voici le résultat!"

	; Italian
	lang I, db   "Fai il quiz per"
	lang I, line "una valutazione!"
	
	lang S, db   "¡Listo!"
	lang S, line "¡Tu evaluación!"
	
	db "@"

.textScoreIntro
	; Japanese
	lang J, text "カツラ『ごくろうさん！！"
	lang J, line "わいの　クイズは　やっぱり"
	lang J, cont "ひとあじ　ちがう　むずかしさ！"

	lang J, para "なやみまくり　だった　だろー！！"
	lang J, line "いくつ　あたったかな？"

	; English
	lang E, text "BLAINE: Good work!"

	lang E, para "My quizzes are a"
	lang E, line "cut above in terms"
	lang E, cont "of difficulty!"

	lang E, para "Must've had you"
	lang E, line "struggling hard!"

	lang E, para "So, how many did"
	lang E, line "you get right?"

	; German
	lang D, text "PYRO: Gut gemacht!"

	lang D, para "Mein Quiz ist"
	lang D, line "gar nicht mal so"
	lang D, cont "einfach, stimmt's?"

	lang D, para "Das hat dich be-"
	lang D, line "stimmt gefordert!"

	lang D, para "Wie oft lagst du"
	lang D, line "wohl richtig?"

	; French
	lang F, text "AUGUSTE: Bien!"

	lang F, para "Mes quiz sont d'un"
	lang F, line "autre niveau de"
	lang F, cont "difficulté!"

	lang F, para "Tu as dû avoir"
	lang F, line "du mal!"

	lang F, para "Alors, combien de"
	lang F, line "réponses justes?"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Bien!"
	
	lang S, para "Mis acertijos son"
	lang S, line "superiores en"
	lang S, cont "dificultad!"
	
	lang S, para "«¡Debes haber"
	lang S, line "tenido problemas!"
	
	lang S, para "Entonces, ¿cuántos"
	lang S, line "has acertado?"

	para "<……>　<……>　<……>"
	para ""
	done
.textScore0
	; Japanese
	lang J, text "カツラ『ハッハッハ！"
	lang J, line "わせいかいは　０こ！！"
	lang J, para "やっぱり　わしの　クイズは"
	lang J, line "てんか　むてきなのだー！！"

	; English
	lang E, text "BLAINE: Hahaha!"

	lang E, para "Zero correct"
	lang E, line "answers!"

	lang E, para "Just as I thought,"
	lang E, line "my quiz is"
	lang E, cont "unbeatable!"

	; German
	lang D, text "PYRO: Hahaha!"

	lang D, para "Nicht ein"
	lang D, line "Treffer!"

	lang D, para "Wie erwartet, ist"
	lang D, line "meine Herausforde-"
	lang D, cont "rung unschlagbar!"

	; French
	lang F, text "AUGUSTE: Hahaha!"

	lang F, para "Zéro pointé!"

	lang F, para "Je savais bien que"
	lang F, line "mon quiz est"
	lang F, cont "insurmontable!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Jajaja!"
	
	lang S, para "¡Cero respuestas"
	lang S, line "correctas!"
	
	lang S, para "Tal como pensaba,"
	lang S, line "¡mis acertijos" 
	lang S, cont "son imbatibles!"

	done

.textScore1
	; Japanese
	lang J, text "カツラ『１こだけ　あたってたぞー！"
	lang J, line "そんな　ちゅうとはんぱな"
	lang J, cont "あたしかた　しとかんで"
	lang J, cont "いっそ　ぜんぶ　はずれとけー！"

	; English
	lang E, text "BLAINE: You only"
	lang E, line "got one right!"

	lang E, para "Don't give me that"
	lang E, line "half-baked effort!"

	lang E, para "You may as well"
	lang E, line "have gotten them"
	lang E, cont "all wrong!"

	; German
	lang D, text "PYRO: Du hast nur"
	lang D, line "einen Treffer"
	lang D, cont "gelandet!"

	lang D, para "Sei nicht so"
	lang D, line "halbherzig dabei!"

	lang D, para "So hättest du auch"
	lang D, line "ruhig alles falsch"
	lang D, cont "haben können!"

	; French
	lang F, text "AUGUSTE: Une seule"
	lang F, line "bonne réponse?"

	lang F, para "Mets-y un peu"
	lang F, line "du tien!"

	lang F, para "C'est tout comme"
	lang F, line "si tu avais eu"
	lang F, cont "tout faux!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Solo has"
	lang S, line "acertado una sola!"
	
	lang S, para "¡No vengas con ese"
	lang S, line "esfuerzo a medias!"
	
	lang S, para "Habría sido mejor"
	lang S, line "que hubieras"
	lang S, cont "fallado todas!"
	
	done

.textScore2
	; Japanese
	lang J, text "カツラ『２つ　あたってるぞ！"

	lang J, para "いいかえれば　８つ　まえがえたって"
	lang J, line "ことに　なるのだー！！"

	lang J, para "つまり　ダメダメって　ことだ！！！"

	; English
	lang E, text "BLAINE: Two"
	lang E, line "correct answers!"

	lang E, para "That means you got"
	lang E, line "eight wrong!"

	lang E, para "In short, you're"
	lang E, line "hopeless!"

	; German
	lang D, text "PYRO: Zwei rich-"
	lang D, line "tige Antworten!"

	lang D, para "Also lagst du bei"
	lang D, line "acht daneben!"

	lang D, para "Kurz gesagt, ein"
	lang D, line "hoffnungsloser"
	lang D, cont "Fall!"

	; French
	lang F, text "AUGUSTE: Deux"
	lang F, next "bonnes réponses!"

	lang F, para "Ca veut dire que"
	lang F, line "tu as répondu faux"
	lang F, cont "huit fois!"

	lang F, para "Faisons court: tu"
	lang F, line "es sans espoir!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Dos"
	lang S, line "correctas!"
	
	lang S, para "Eso significa que"
	lang S, line "has fallado ocho!"
	
	lang S, para "¡En resumen, eres"
	lang S, line "un desastre!"
	
	done

.textScore3
	; Japanese
	lang J, text "カツラ『３もん　せいかいだった！！"

	lang J, para "たいしたこと　ないなあ！！"
	lang J, line "たいしたこと　ないぞう！！！"
	lang J, cont "ワッハッハッハ！！"

	; English
	lang E, text "BLAINE: Three"
	lang E, line "correct answers!"

	lang E, para "Not so impressive!"

	lang E, para "That's nothing"
	lang E, line "special!"

	lang E, para "Hahaha!"

	; German
	lang D, text "PYRO: Drei rich-"
	lang D, line "tige Antworten!"

	lang D, para "Nicht sehr"
	lang D, line "beeindruckend!"

	lang D, para "Das ist nichts"
	lang D, line "Besonderes!"

	lang D, para "Hahaha!"

	; French
	lang F, text "AUGUSTE: Trois"
	lang F, line "bonnes réponses!"

	lang F, para "Tout juste"
	lang F, line "passable!"

	lang F, para "Ca n'a rien de"
	lang F, line "spécial!"

	lang F, para "Hahaha!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Tres"
	lang S, line "aciertos!"
	
	lang S, line "¡No impresionas!"

	lang S, para "¡Eso no es nada"
	lang S, line "especial!"
	
	lang S, para "¡Jajaja!"
	
	done

.textScore4
	; Japanese
	lang J, text "カツラ『せいかいは　４もんだぞー！"
	lang J, para "そんなんじゃ　まだまだ　きあいが"
	lang J, line "たりないのだー！！！"

	; English
	lang E, text "BLAINE: Four"
	lang E, line "correct answers!"

	lang E, para "Your fighting"
	lang E, line "spirit is still"
	lang E, cont "lacking!"

	; German
	lang D, text "PYRO: Vier rich-"
	lang D, line "tige Antworten!"

	lang D, para "Dein Kampfgeist"
	lang D, line "lässt noch zu"
	lang D, cont "wünschen übrig!"

	; French
	lang F, text "AUGUSTE: Quatre"
	lang F, line "bonnes réponses!"

	lang F, para "Ton esprit comba-"
	lang F, line "tif laisse à"
	lang F, cont "diésirer!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: Cuatro"
	lang S, line "¡aciertos!"
	
	lang S, para "¡Tu espíritu de"
	lang S, line "lucha sigue siendo"
	lang S, cont "insuficiente!"
	
	done

.textScore5
	; Japanese
	lang J, text "カツラ『うおおーす！"
	lang J, line "５もん　せいかいだったぞ！！"

	lang J, para "ねらったように　ちょうど　はんぶん！"
	lang J, line "ポケモン　しょうぶなら　ひきわけだ！"

	; English
	lang E, text "BLAINE: Whoa!"
	lang E, line "Five correct"
	lang E, cont "answers!"

	lang E, para "Right on target--"
	lang E, line "exactly half!"

	lang E, para "In a #MON"
	lang E, line "battle, that'd"
	lang E, cont "be a draw!"

	; German
	lang D, text "PYRO: Oha!"
	lang D, line "Fünf richtige"
	lang D, cont "Antworten!"

	lang D, para "Genau die Hälfte"
	lang D, line "erwischt!"

	lang D, para "In einem #MON-"
	lang D, line "Kampf wäre dies"
	lang D, cont "ein Remis!"

	; French
	lang F, text "AUGUSTE: Waouh!"
	lang F, line "Cinq bonnes"
	lang F, cont "réponses!"

	lang F, para "Dans le mille--"
	lang F, line "pile la moitié!"

	lang F, para "Dans un combat"
	lang F, line "#MON, ce serait"
	lang F, cont "une égalité!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Guau!"
	lang S, line "¡Cinco respuestas"
	lang S, cont "correctas!"
	
	lang S, para "«Justo en"
	lang S, line "la mitad!"
	
	lang S, para "¡En un combate"
	lang S, line "#MON, eso sería"
	lang S, cont "un empate!"
	
	done

.textScore6
	; Japanese
	lang J, text "カツラ『せいかいは　６もんだー！！"

	lang J, para "いまの　あつい　こたえっぷり"
	lang J, line "なかなか　よかったぞーー！"

	; English
	lang E, text "BLAINE: Six"
	lang E, line "correct answers!"

	lang E, para "The fiery way you"
	lang E, line "answered just now"
	lang E, cont "was pretty good!"

	; German
	lang D, text "PYRO: Sechs rich-"
	lang D, line "tige Antworten!"

	lang D, para "Eine wahrlich"
	lang D, line "feurige Leistung!"

	; French
	lang F, text "AUGUSTE: Six"
	lang F, line "bonnes réponses!"

	lang F, para "Tu as répondu à"
	lang F, line "brûle-pourpoint,"
	lang F, cont "continue comme ça!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: Seis"
	lang S, line "aciertos!"
	
	lang S, para "Respondes de"
	lang S, line "forma apasioanada"
	lang S, cont "¡Muy bien!"
	
	done

.textScore7
	; Japanese
	lang J, text "カツラ『７つ　せいかい　なのだ！"

	lang J, para "なかなか　きおくりょくが　よいぞ！"
	lang J, line "こら！　とくいそうな　かお　するな！"
	lang J, cont "わしから　みれば　まだまだ　なのだ！"

	; English
	lang E, text "BLAINE: Seven"
	lang E, line "correct answers!"

	lang E, para "Your memory's"
	lang E, line "pretty sharp!"

	lang E, para "Hey! Don't look"
	lang E, line "so smug!"

	lang E, para "The way I see it,"
	lang E, line "you still have a"
	lang E, cont "long way to go!"

	; German
	lang D, text "PYRO: Sieben rich-"
	lang D, line "tige Antworten!"

	lang D, para "Du hast ein schar-"
	lang D, line "fes Gedächtnis!"

	lang D, para "Hey! Mach kein so"
	lang D, line "selbstgefälliges"
	lang D, cont "Gesicht!"

	lang D, para "Meiner Meinung"
	lang D, line "nach hast du noch"
	lang D, cont "einen weiten Weg"
	lang D, cont "vor dir!"

	; French
	lang F, text "AUGUSTE: Sept"
	lang F, line "bonnes réponses!"

	lang F, para "Tu as une plutôt"
	lang F, line "bonne mémoire!"

	lang F, para "Hé, ne prends pas"
	lang F, line "la grosse téte!"

	lang F, para "Tu as encore beau-"
	lang F, line "coup de chemin à"
	lang F, cont "faire, à mon avis!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Siete"
	lang S, line "aciertos!"
	
	lang S, para "¡Tu memoria es"
	lang S, line "muy buena!"
	
	lang S, para "¡Eh! No pongas"
	lang S, line "esa cara!"
	
	lang S, para "Tal y como yo veo,"
	lang S, line "aún te queda un"
	lang S, cont "largo camino"
	
	done

.textScore8
	; Japanese
	lang J, text "カツラ『せいかい　８もん！"

	lang J, para "わしの　クイズが　こんなに"
	lang J, line "あてられる　はず　ないのだ！"
	lang J, cont "これは　まぐれ　だったのだ！！"

	; English
	lang E, text "BLAINE: Eight"
	lang E, line "correct answers!"

	lang E, para "My quiz isn't"
	lang E, line "supposed to be"
	lang E, cont "this easy to beat!"

	lang E, para "It must be a"
	lang E, line "fluke!"

	; German
	lang D, text "PYRO: Acht rich-"
	lang D, line "tige Antworten!"

	lang D, para "So einfach sollte"
	lang D, line "mein Quiz eigent-"
	lang D, cont "lich nicht zu"
	lang D, cont "lösen sein!"

	lang D, para "Du hattest sicher"
	lang D, line "einfach nur Glück!"

	; French
	lang F, text "AUGUSTE: Huit"
	lang F, line "bonnes réponses!"

	lang F, para "Mon quiz n'est"
	lang F, line "pas censé être"
	lang F, cont "aussi facile!"

	lang F, para "Ca doit être un"
	lang F, line "accident!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Ocho"
	lang S, line "aciertos!"
	
	lang S, para "Mi cuestionario no"
	lang S, line "se supone que deba"
	lang S, cont "ser fácil!"
	
	lang S, para "¡Debe ser una"
	lang S, line "casualidad!"
	
	done

.textScore9
	; Japanese
	lang J, text "カツラ『あら！"
	lang J, line "９つ　あたってるぞー！！！"

	lang J, para "あ…　あと　ひとつで　まんてん"
	lang J, line "あぶない　ところだった！"

	; English
	lang E, text "BLAINE: Oh!"
	lang E, line "You got nine"
	lang E, cont "correct!"

	lang E, para "Ah… just one more"
	lang E, line "for a perfect"
	lang E, cont "score!"

	lang E, para "You were close!"

	; German
	lang D, text "PYRO: Oh!"
	lang D, line "Du hast neun rich-"
	lang D, cont "tig beantwortet!"

	lang D, para "Ah… Dir fehlte nur"
	lang D, line "noch ein Treffer"
	lang D, cont "für die perfekte"
	lang D, cont "Punktzahl!"

	lang D, para "Du warst nah dran!"

	; French
	lang F, text "AUGUSTE: Oh!"
	lang F, line "Tu as visé juste"
	lang F, cont "neuf fois!"

	lang F, para "Ah... juste une"
	lang F, line "de plus pour un"
	lang F, cont "score parfait!"

	lang F, para "Tu y es presque!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡Oh!"
	lang S, line "¡Tienes nueve"
	lang S, cont "correctas!"
	
	lang S, para "Ah… ¡solo una más"
	lang S, line "para una nota"
	lang S, cont "perfecta!"
	
	lang S, para "¡Estuviste cerca!"
	
	done

.textScore10
	; Japanese
	lang J, text "カツラ『うおおー！"
	lang J, line "ぜんもん　せいかい　だとー！？"

	lang J, para "み　……　みごと！"
	lang J, line "わしは　もえつきた……！"

	; English
	lang E, text "BLAINE: Whoa!"
	lang E, line "A perfect score?!"

	lang E, para "Wow… impressive!"
	lang E, line "I'm burned out…"

	; German
	lang D, text "PYRO: Wow!"
	lang D, line "Perfekt gelöst?!"

	lang D, para "G… Glückwunsch!"
	lang D, line "Ich bin"
	lang D, cont "ausgebrannt…"

	; French
	lang F, text "AUGUSTE: Wouah!"
	lang F, line "Un score parfait!?"

	lang F, para "Eh bien... c'est"
	lang F, line "impressionnant!"
	; "Tu m'as fumé !" ou "Tu m'as éteint !" serait parfait, mais ton trop familier :D
	lang F, cont "Je me sens"
	lang F, cont "refroidi..."

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¡¿Una "
	lang S, line "nota perfecta?!"
	
	lang S, para "Vaya… increible"
	lang S, line "Me consumí…"
	
	done

.textNotAllCorrect
	; Japanese
	lang J, text "どうだ？　もう　もえつきたか？"
	lang J, line "もういちど　やってみるかー！？"

	; English
	lang E, text "BLAINE: How about"
	lang E, line "it?"

	lang E, para "Feeling burned"
	lang E, line "out already?"

	lang E, para "Wanna try again?"

	; German
	lang D, text "PYRO: Na, fühlst"
	lang D, line "du dich schon"
	lang D, cont "ausgebrannt?"

	lang D, para "Oder versuchst du"
	lang D, line "es noch einmal?!"

	; French
	lang F, text "AUGUSTE: Alors?"

	lang F, para "Tu te sens"
	lang F, line "refroidi?"

	lang F, para "Es-tu assez chaud"
	lang F, line "pour réessayer?"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: ¿Que te"
	lang S, line "ha parecido?"
	
	lang S, para "¿Has acabado"
	lang S, line "consumido ya?"
	
	lang S, para "¿Reintentar?"
	
	done

.textTryAgain
	; Japanese
	lang J, text "カツラ『いくぞー！"
	; English
	lang E, text "BLAINE: Let's go!"
	; German
	lang D, text "PYRO: Los geht's!"
	; French
	lang F, text "AUGUSTE: Allons-y!"
	; Italian
	lang I, text "?"
	lang S, text "¡Vamos!"
	done

.textGiveGift1
	; Japanese
	lang J, text "まけたものは　しかたがない"
	lang J, line "ほうびを　やろう！"

	lang J, para "わざマシン　しねしねこうせんを"
	lang J, line "うけとって　くれい！"

	lang J, para "しねしねこうせんを　もらった！"

	; English
	lang E, text "I lost, no use"
	lang E, line "fighting it!"

	lang E, para "I'll give you"
	lang E, line "a reward!"

	lang E, para "Take this TM,"
	lang E, line "it contains"
	lang E, cont "TOMBSTONER!" ; C.f. the Cinnabar Cym quiz in R/B/Y.

	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM28."

	; German
	lang D, text "Ich habe verloren."
	lang D, line "Daran gibt es"
	lang D, cont "nichts zu rütteln!"

	lang D, para "Ich überreiche dir"
	lang D, line "eine Belohnung!"

	lang D, para "Nimm diese TM,"
	lang D, line "sie enthält die"
	lang D, cont "FROSCH-ATTACKE!"

	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM28."

	; French
	lang F, text "AUGUSTE: J'ai"
	lang F, line "perdu, c'est"
	lang F, cont "indéniable!"

	lang F, para "Tu mérites une"
	lang F, line "récompense!"

	lang F, para "Prends cette CT,"
	lang F, line "elle contient"
	lang F, cont "FOSSE!"

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT28."

	; Italian
	lang I, text "?"

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   "?"
	lang I, line "TM28."
	
	lang S, text "He perdido, ¡es"
	lang S, line "inútil resistirse!"
	
	lang S, para "¡Te daré"
	lang S, line "una recompensa!"
	
	lang S, para "Toma esta MT,"
	lang S, line "contiene"
	lang S, cont "TUMBAPIETRA!"
	
	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT28."
	
	done
.textGiveGift2
	; Japanese
	lang J, text "カツラ『<……>　<……>　<……>"

	lang J, para "<……>　<……>　<……>"
	lang J, line "<……>　<……>　<……>"

	lang J, para "なんて　うそ　うそ！！"
	lang J, line "わざマシン３８を"
	lang J, cont "うけとってくれい！"

	lang J, para "わざマシン３８を　もらった！"

	; English
	lang E, text "BLAINE: <……><……><……>"
	lang E, para "<……><……><……>"
	lang E, line "<……><……><……>"

	lang E, para "Just kidding!"
	lang E, line "Take this."

	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM38."

	; German
	lang D, text "PYRO: <……><……><……>"
	lang D, para "<……><……><……>"
	lang D, line "<……><……><……>"

	lang D, para "Ich mache nur"
	lang D, line "Spaß! Nimm dies."

	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM38."

	; French
	lang F, text "AUGUSTE: <……><……><……>"
	lang F, para "<……><……><……>"
	lang F, line "<……><……><……>"

	lang F, para "C'était pour rire!"
	lang F, line "Tiens, voilà."

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT38."

	; Italian
	lang I, text "BLAINE: <……><……><……>"
	lang I, para "<……><……><……>"
	lang I, line "<……><……><……>"

	lang I, para "?"

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   "?"
	lang I, line "TM38."
	
	lang S, text "BLAINE: <……><……><……>"
	lang S, para "<……><……><……>"
	lang S, line "<……><……><……>"
	
	lang S, para "¡Es broma!"
	lang S, line "Toma esto."
	
	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT38."
	
	done

.textFarewell
	; Japanese
	lang J, text "カツラ『また　いつか"
	lang J, line "パワーアップして　もどってくるぞー！"
	lang J, cont "うおおーす！！！"

	; English
	lang E, text "BLAINE: I'll be"
	lang E, line "back someday,"

	lang E, para "stronger than"
	lang E, line "ever!"

	lang E, para "Hah!" ; Use the same as in the opening text.

	; German
	lang D, text "PYRO: Irgendwann"
	lang D, line "kehre ich zurück,"

	lang D, para "noch stärker als"
	lang D, line "je zuvor!"

	lang D, para "Wuah!"

	; French
	lang F, text "AUGUSTE: Je serai"
	lang F, line "de retour un jour,"

	lang F, para "plus fort"
	lang F, line "que jamais!"

	lang F, para "Waaah!"

	; Italian
	lang I, text "?"
	
	lang S, text "BLAINE: Estaré de"
	lang S, line "vuelta algún día,"
	
	lang S, para "¡más fuerte que"
	lang S, line "nunca!"
	
	lang S, para "¡Ja!"
	
	done

ENDC
