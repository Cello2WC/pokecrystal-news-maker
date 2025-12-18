; this file matches the version seen in the "first issue"
; stored in the english ROM.
;
; there are discrepancies between this version of the quiz,
; and the one seen in magazine scans featuring the first issue.
; for a version attempting to match the magazine scans, see minigame/pkmnquiz_oak.asm



IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 0

DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"

MACRO minigame_start
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page MinigameStart
ENDM

MACRO minigame_name
	lang J, db "ポケモンカルト"
	lang E, db "#MANIA QUIZ"
	lang D, db "#MANIAC-QUIZ"
	lang F, db "QUIZ #MANIA"
	lang I, db "QUIZ #FANATICO"
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

	news_menu  2, 16, 4, 1, 4, 2, -1, $00, $00, $00, $00, $04

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

	quiz_answers 1,    1, 0, 3, 1, 0, 0, 0, 3, 0, 0
	quiz_answers 2,    0, 0, 0, 0, 0, 1, 2, 0, 2, 2
	quiz_answers 3,    0, 2, 0, 0, 3, 0, 0, 0, 0, 0


.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.dummyDescription
	db "@"

.question1Text
	lang J, db   "ウツギはかせ<GA>はじめに"
	lang J, next "えらばせてくれた　#"
	lang J, next "まんなか<NI>いたのは？"
	lang J, next ""
	lang J, next "１．ワニノコ　　２．チコりータ"
	lang J, next "３．ヒノアラシ"

	lang E, db   "Who was in the"
	lang E, next "middle #BALL at"
	lang E, next "PROF.ELM's LAB?"
	lang E, next "1. TOTODILE"
	lang E, next "2. CYNDAQUIL"
	lang E, next "3. CHIKORITA"

	lang D, db   "Wer befand sich im"
	lang D, next "mittleren #BALL"
	lang D, next "in LINDs LABOR?"
	lang D, next "1. KARNIMANI"
	lang D, next "2. FEURIGEL"
	lang D, next "3. ENDIVIE"

	lang F, db   "Qui était le #-"
	lang F, next "MON du milieu au"
	lang F, next "LABO du PROF.ORME?"
	lang F, next "1. KAIMINUS"
	lang F, next "2. HERICENDRE"
	lang F, next "3. GERMIGNON"

	lang I, db   "Chi c'era nella"
	lang I, next "# BALL centrale"
	lang I, next "del PROF.ELM?"
	lang I, next "1. TOTODILE"
	lang I, next "2. CYNDAQUIL"
	lang I, next "3. CHIKORITA"

	lang S, db   "?"

	next "@"

.question2Text
	lang J, db   "ウツギはかせ<NO>よこに"
	lang J, next "ある　ごみばこに"
	lang J, next "はい<TTE>　いるのは？"
	lang J, next ""
	lang J, next "１．たべのこし　２．ジュースのびん"
	lang J, next "３．おかしのふくろ"


	lang E, db   "What is inside"
	lang E, next "the trash can"
	lang E, next "next to PROF.ELM?"
	lang E, next "1. LEFTOVERS"
	lang E, next "2. JUICE BOTTLE"
	lang E, next "3. SNACK WRAPPER"

	lang D, db   "Was befindet sich"
	lang D, next "im Mülleimer neben"
	lang D, next "PROF. LIND?"
	lang D, next "1. ÜBERRESTE"
	lang D, next "2. SAFTFLASCHE"
	lang D, next "3. SNACK-FOLIE"

	lang F, db   "Qu'est-ce qui était"
	lang F, next "dans la poubelle à"
	lang F, next "coté du PROF.ORME?"
	lang F, next "1. RESTES"
	lang F, next "2. BOUTEILLE VIDE"
	lang F, next "3. EMBALLAGE"

	lang I, db   "Cosa c'è nel"
	lang I, next "cestino vicino"
	lang I, next "al PROF. ELM?"
	lang I, next "1. AVANZI"
	lang I, next "2. BOTTIGLIA VUOTA"
	lang I, next "3. CARTA SNACK"

	lang S, db   "?"

	next "@"

.question3Text
	lang J, db   "#<NO>つかまえかたを"
	lang J, next "おしえて　くれる"
	lang J, next "おにいさん<NO>りュックに"
	lang J, next "きずくすり<WA>いくつ？"
	lang J, next "１．１こ　　　２．２こ"
	lang J, next "３．３こ"

	lang E, db   "How many POTIONs"
	lang E, next "did the DUDE who"
	lang E, next "taught you to"
	lang E, next "catch #MON have"
	lang E, next "in his pack?"
	lang E, next "1. 1  2. 2  3. 3"

	lang D, db   "Wie viele TRÄNKE"
	lang D, next "besaß der KUMPEL,"
	lang D, next "der dir das Fan-"
	lang D, next "gen von #MON"
	lang D, next "beigebracht hat?"
	lang D, next "1. 1  2. 2  3. 3"

	lang F, db   "Combien de POTIONs"
	lang F, next "le COPAIN qui t'a"
	lang F, next "appris à attraper"
	lang F, next "des #MON avait-"
	lang F, next "il dans son sac?"
	lang F, next "1. 1  2. 2  3. 3"

	lang I, db   "Quante POZIONI"
	lang I, next "aveva nello ZAINO"
	lang I, next "l'AMICO che ti ha"
	lang I, next "ha insegnato a"
	lang I, next "catturare #MON?"
	lang I, next "1. 1  2. 2  3. 3"

	lang S, db   "?"

	next "@"

.question4Text
	lang J, db   "おかあさんの"
	lang J, next "とくい　りょうりは"
	lang J, next "「グレンふう　かざん　？？？」"
	lang J, next "「？？？」<WA>なに？"
	lang J, next "１．ハンバーグ　　２．カレー"
	lang J, next "３．やきそば"

	lang E, db   "MOM's specialty"
	lang E, next "dish is the"
	lang E, next "CINNABAR VOLCANO ?"
	lang E, next "1. BURGER"
	lang E, next "2. CURRY"
	lang E, next "3. NOODLES"

	lang D, db   "Mamas Spezialität"
	lang D, next "heißt wie genau?"
	lang D, next "ZINNOBER-VULKAN-…"
	lang D, next "1. BURGER"
	lang D, next "2. CURRY"
	lang D, next "3. NUDELN"

	lang F, db   "Le plat style"
	lang F, next "CRAMOIS'ILE"
	lang F, next "de MAMAN est..."
	lang F, next "1. un BURGER"
	lang F, next "2. un CURRY"
	lang F, next "3. des NOUILLES"

	lang I, db   "La specialità di"
	lang I, next "MAMMA è … DELL'"
	lang I, next "ISOLA CANNELLA?"
	lang I, next "1. MINESTRONE"
	lang I, next "2. CURRY"
	lang I, next "3. NOODLE"

	next "@"

.question5Text
	lang J, db   "ジョバンニせんせいは"
	lang J, next "はなしかけてから"
	lang J, next "じゅく<NI>はいるまで"
	lang J, next "なんかい　まわる？"
	lang J, next "１．５かい　　　２．６かい"
	lang J, next "３．７かい"

	lang E, db   "How many times"
	lang E, next "does EARL spin"
	lang E, next "from talking to"
	lang E, next "him until he goes"
	lang E, next "into the ACADEMY?"
	lang E, next "1. 5  2. 6  3. 7"

	lang D, db   "Wie oft hatte"
	lang D, next "sich EARL gedreht,"
	lang D, next "bevor er in die"
	lang D, next "#MON-AKADEMIE"
	lang D, next "ging?"
	lang D, next "1. 5  2. 6  3. 7"

	lang F, db   "Combien de fois"
	lang F, next "THEOPHILE tourne-"
	lang F, next "t-il sur lui même"
	lang F, next "avant d'entrer"
	lang F, next "dans l'ACADEMIE?"
	lang F, next "1. 5  2. 6  3. 7"

	lang I, db   "Quante volte gira"
	lang I, next "PRIMO da quando"
	lang I, next "gli parli a quando"
	lang I, next "va nell'ACCADEMIA?"
	lang I, next "1. 5  2. 6  3. 7"

	lang S, db   "?"

	next "@"

.question6Text
	lang J, db   "つながりのどうくつに"
	lang J, next "おちていない　どうぐは？"
	lang J, next ""
	lang J, next "１．プラスパワー　２．まひなおし"
	lang J, next "３．きずぐすり"

	lang E, db   "Which of these"
	lang E, next "items is not found"
	lang E, next "in UNION CAVE?"
	lang E, next "1. X ATTACK"
	lang E, next "2. PARLYZ HEAL"
	lang E, next "3. POTION"

	lang D, db   "Welches Item"
	lang D, next "gibt es nicht im"
	lang D, next "EINHEITSTUNNEL?"
	lang D, next "1. X-ANGRIFF"
	lang D, next "2. PARAHEILER"
	lang D, next "3. TRANK"

	lang F, db   "Lequel ne trouve-"
	lang F, next "t-on pas dans les"
	lang F, next "CAVES JUMELLES?"
	lang F, next "1. ATTAQUE +"
	lang F, next "2. ANTI-PARA"
	lang F, next "3. POTION"

	lang I, db   "Quale oggetto non"
	lang I, next "è presente nella"
	lang I, next "GROTTA DI MEZZO?"
	lang I, next "1. X ATTACCO"
	lang I, next "2. ANTIPARALISI"
	lang I, next "3. POZIONE"

	lang S, db   "?"

	next "@"

.question7Text
	lang J, db   "カモネギ<WO>つかまえるとき"
	lang J, next "いちばん　すくない　てかずは"
	lang J, next "なんかい　カモネギに"
	lang J, next "はなしかければ　いい？"
	lang J, next "１．３かい　　２．４かい"
	lang J, next "３．５かい"

	lang E, db   "What is the least"
	lang E, next "amount of times"
	lang E, next "you need to talk"
	lang E, next "to FARFETCH'd to"
	lang E, next "capture it?"
	lang E, next "1. 3  2. 4  3. 5"

	lang D, db   "Wie oft muss man"
	lang D, next "PORENTA mindestens"
	lang D, next "ansprechen, bevor"
	lang D, next "man es fangen"
	lang D, next "kann?"
	lang D, next "1. 3  2. 4  3. 5"

	lang F, db   "Combien de fois"
	lang F, next "au minimum faut-il"
	lang F, next "parler au CANAR-"
	lang F, next "TICHO pour pouvoir"
	lang F, next "le capturer?"
	lang F, next  "1. 3  2. 4  3. 5"

	lang I, db   "Qual è il numero"
	lang I, next "minimo di volte in"
	lang I, next "cui devi parlare"
	lang I, next "a FARFETCH'D per"
	lang I, next "acchiapparlo?"
	lang I, next "1. 3  2. 4  3. 5"

	lang S, db   "?"

	next "@"

.question8Text
	lang J, db   "ヤドンのいどに"
	lang J, next "ヤドン<WO>たすけ<NI>いったとき"
	lang J, next "いど<NO>なか<NI>いるヤドンは"
	lang J, next "なんひき　だった？"
	lang J, next "１．２ひき　　２．３ひき"
	lang J, next "３．４ひき"

	lang E, db   "How many SLOWPOKE"
	lang E, next "were in the cave"
	lang E, next "when you rescued"
	lang E, next "them at SLOWPOKE"
	lang E, next "WELL?"
	lang E, next "1. 2  2. 3  3. 4"

	lang D, db   "Wie viele FLEGMON"
	lang D, next "befanden sich im"
	lang D, next "FLEGMON-BRUNNEN"
	lang D, next "als du sie ge-"
	lang D, next "rettet hast?"
	lang D, next "1. 2  2. 3  3. 4"

	lang F, db   "Combien de RAMO-"
	lang F, next "LOSS y avait-il"
	lang F, next "dans le PUITS"
	lang F, next "RAMOLOSS quand tu"
	lang F, next "les as secourus?"
	lang F, next "1. 2  2. 3  3. 4"

	lang I, db   "Quanti SLOWPOKE"
	lang I, next "c'erano nella"
	lang I, next "grotta al POZZO"
	lang I, next "SLOWPOKE quando"
	lang I, next "li hai salvati?"
	lang I, next "1. 2  2. 3  3. 4"

	lang S, db   "?"

	next "@"

.question9Text
	lang J, db   "ヨシノシティ<NI>いる"
	lang J, next "あんないじいさんは"
	lang J, next "うみ　<WO>なんばんめに"
	lang J, next "あんない　してくれる？"
	lang J, next "１．３ばんめ　　２．４ばんめ"
	lang J, next "３．５ばんめ"

	lang E, db   "Which stop is the"
	lang E, next "sea on the GUIDE"
	lang E, next "GENT's tour around"
	lang E, next "CHERRYGROVE CITY?"
	lang E, next "1. 3rd  2. 4th "
	lang E, next "3. 5th"

	lang D, db   "Das Meer war der"
	lang D, next "wievielte Halt des"
	lang D, next "FREMDENFÜHRERS von"
	lang D, next "ROSALIA CITY?"
	lang D, next ""
	lang D, next "1. 3. 2. 4. 3. 5."

	lang F, db   "Au bout de combien"
	lang F, next "d'arrêts le GUIDE"
	lang F, next "de VILLE GRIOTTE"
	lang F, next "montre-t'il la mer?" ; Il faudrait un tiret, mais ça fait UN caractère de trop......
	lang F, next "1. 3ème  2. 4ème"
	lang F, next "3. 5ème"

	lang I, db   "A che fermata è il"
	lang I, next "mare durante il"
	lang I, next "tour della GUIDA"
	lang I, next "di FIORPESCOPOLI?"
	lang I, next "1. 3º  2. 4º "
	lang I, next "3. 5º"

	lang S, db   "?"

	next "@"

.question10Text
	lang J, db   "#じいさん<NO>いえに"
	lang J, next "がいこく<NO>ものが"
	lang J, next "あるけど　このなかで"
	lang J, next "ない　ものは？"
	lang J, next "１．コイン　　２．き<TTE>"
	lang J, next "３．ざっし"

	lang E, db   "Which of these"
	lang E, next "foreign items is"
	lang E, next "not found in MR."
	lang E, next "#MON's HOUSE?"
	lang E, next "1. COIN  2. STAMP"
	lang E, next "3. MAGAZINE"

	lang D, db   "Was findet man"
	lang D, next "nicht im HAUS von"
	lang D, next "MR. #MON?"
	lang D, next "1. MÜNZE"
	lang D, next "2. BRIEFMARKE"
	lang D, next "3. HEFT"

	lang F, db   "Lequel de ces"
	lang F, next "objets étrangers"
	lang F, next "ne se trouve pas"
	lang F, next "chez M.#MON?"
	lang F, next "1. PIECE 2. TAMPON"
	lang F, next "3. MAGAZINE"

	lang I, db   "Quale oggetto"
	lang I, next "non è nella CASA"
	lang I, next "di MR. #MON?"
	lang I, next "1. MONETE"
	lang I, next "2. FRANCOBOLLO"
	lang I, next "3. RIVISTA"

	lang S, db   "?"

	next "@"



	news_screen QuizScoreEvaluation, MUSIC_POKEMON_TALK

	news_def_pals

	news_def_boxes
	news_box 0, 12, 20, 6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes

	lang J, news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01
	notlang J, news_menu  2, 10, 1, 1, 0, 0, -1, $00, $00, $00, $02, $01

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
	nsc_drawtrainer 6, 2, POKEMON_PROF, 7
	nsc_select
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret

.menuItemText
	lang J, db "オーキドはかせの　ひょうか"
	lang E, db "PROF.OAK's RATING"
	; TODO: Rework in other languages (check out what's used for the Dex rating)
	lang D, db "EICHs BEWERTUNG"
	lang F, db "EVALUATION de CHEN"
	lang I, db "RAPPORTO DI OAK"
	lang S, db "?"
	db "@"

.menuItemScript
	nsc_compare wQuizScore, .scorelow, .scorelow, .greater, 1, 5

.scorelow
	nsc_textbox 1, 14, .textScoreLow
	nsc_playsound SFX_DEX_FANFARE_LESS_THAN_20
	nsc_ret

.greater
	nsc_compare wQuizScore, .scoreaverage, .scoreaverage, .greater2, 1, 10

.scoreaverage
	nsc_textbox 1, 14, .textScoreAverage
	nsc_playsound SFX_DEX_FANFARE_140_169
	nsc_ret

.greater2
	nsc_compare wQuizScore, .scoregood, .scoregood, .greater3, 1, 15

.scoregood
	nsc_textbox 1, 14, .textScoreGood
	nsc_playsound SFX_DEX_FANFARE_170_199
	nsc_ret

.greater3
	nsc_compare wQuizScore, .scoregreat, .scoregreat, .greater4, 1, 19

.scoregreat
	nsc_textbox 1, 14, .textScoreGreat
	nsc_playsound SFX_DEX_FANFARE_200_229
	nsc_ret

.greater4
	nsc_compare wQuizScore, .scorebest, .scorebest, .scoreoutofbounds, 1, 20

.scorebest
	nsc_textbox 1, 14, .textScoreBest
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_ret

.scoreoutofbounds
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

	lang D, db   "Zur Bewertung"
	lang D, line "deiner Antworten!"

	lang F, db   "Fin du quiz!"
	lang F, line "Voici le résultat!"

	lang I, db   "Fai il quiz per"
	lang I, line "una valutazione!"

	lang S, db "?"

	db "@"

.textScoreLow
	lang J, text "ぜんぜん　まだまだ　じゃな"
	lang J, line "これ<WA>おぼえてなくても　いいだろう"
	lang J, cont "というような　ことまで　おぼえるのが"
	lang J, cont "#マニアと　いうものじゃ"

	lang E, text "It's not enough to"
	lang E, cont "memorize things."

	lang E, para "A true #MANIAC"
	lang E, line "can memorize"
	lang E, cont "things they don't"
	lang E, cont "even need to"
	lang E, cont "remember!"

	lang D, text "Es genügt nicht,"
	lang D, line "Dinge bloß aus-"
	lang D, cont "wendig zu lernen."

	lang D, para "#MANIACs können"
	lang D, line "sich Dinge merken,"
	lang D, cont "ohne dafür lernen"
	lang D, cont "zu müssen!"

	lang F, text "Ce n'est pas assez"
	lang F, line "de mémoriser des"
	lang F, cont "choses."

	lang F, para "Un vrai #MANIAC"
	lang F, line "peut mémoriser des"
	lang F, cont "choses dont il n'a"
	lang F, cont "même pas besoin de"
	lang F, cont "se rappeler!"

	lang I, text "Imparare a memoria"
	lang I, line "non basta."

	lang I, para "I #FANATICI"
	lang I, line "memorizzano cose"
	lang I, cont "che non hanno"
	lang I, cont "nemmeno bisogno"
	lang I, cont "di ricordare!"

	lang S, db   "?"

	done

.textScoreAverage
	lang J, text "#マニア<NI>して<WA>まだ"
	lang J, line "ボりューム<GA>たりん！"
	lang J, para "いろいろな　ものを"
	lang J, line "むだでも　くまなく　みるのじゃ！"

	lang E, text "You still have"
	lang E, line "lots to do."
	lang E, cont "#MANIACs have a"
	lang E, cont "lot more passion!"

	lang E, para "Be sure to look in"
	lang E, line "every nook and"
	lang E, cont "cranny!"

	lang D, text "Du hast noch eine"
	lang D, line "Menge Arbeit vor"
	lang D, cont "dir."

	lang D, para "Echte #MANIACs"
	lang D, line "sind da noch mehr"
	lang D, cont "bei der Sache!"

	lang D, para "Sieh dich genau"
	lang D, line "in allen Ecken"
	lang D, cont "und Winkeln um!"

	lang F, text "Il te reste beau-"
	lang F, line "coup à faire."
	lang F, cont "Les #MANIAC ont"
	lang F, cont "plus de passion!"

	lang F, para "Sois sûr de bien"
	lang F, line "vérifier tous les"
	lang F, cont "coins et recoins!"

	lang I, text "Hai ancora"
	lang I, line "molto da fare."

	lang I, para "I #FANATICI"
	lang I, line "hanno molta più"
	lang I, cont "passione!"

	lang I, para "Assicurati di"
	lang I, line "guardare in ogni"
	lang I, cont "angolo!"

	lang S, db   "?"

	done

.textScoreGood
	lang J, text "ふむ　がんば<TTE>おるな"
	lang J, line "それなり<NI>#マニア"
	lang J, cont "らしく　な<TTE>きておるよ！"

	lang J, para "ともだちと　そうだん　しているかな？"
	lang J, line "ひとりで<WA>たいへん　だからな"

	lang E, text "You're trying--I"
	lang E, line "can see that."

	lang E, para "You're really"
	lang E, line "starting to earn"
	lang E, cont "the title of"
	lang E, cont "#MANIAC!"

	lang E, para "Are you talking"
	lang E, line "with your friends?"
	lang E, para "It's tough to"
	lang E, line "do this alone!"

	lang D, text "Du gibst dir Mühe."
	lang D, line ""

	lang D, para "Du bist fast"
	lang D, line "schon sowas wie"
	lang D, cont "ein #MANIAC!"

	lang D, para "Tauschst du dich"
	lang D, line "auch mit deinen"
	lang D, cont "Freunden aus?"

	lang D, para "Zusammen ist man"
	lang D, line "immer stärker!"

	lang F, text "Tu te donnes du"
	lang F, line "mal, ça se voit."

	lang F, para "Tu commences à"
	lang F, line "vraiment mériter"
	lang F, cont "le titre de"
	lang F, cont "#MANIAC!"

	lang F, para "Est-ce que tu par-"
	lang F, line "les avec tes amis?"
	lang F, para "Seul, c'est bien"
	lang F, line "plus difficile!"

	lang I, text "Ti impegni, si"
	lang I, line "vede."

	lang I, para "Stai tentando"
	lang I, line "di diventare un"
	lang I, cont "#FANATICO."

	lang I, para "Stai parlando"
	lang I, line "coi tuoi amici?"

	lang I, para "È dura farcela"
	lang I, line "da soli!"

	lang S, db   "?"

	done

.textScoreGreat
	lang J, text "エクセレントじゃ！"
	lang J, line "きみ<WA>じゅうばこ<NO>すみを"
	lang J, cont "つつくの<GA>すき　なんじゃろ？"

	lang E, text "Excellent! You"
	lang E, line "really like to"

	lang E, para "poke around in"
	lang E, line "those nooks and"
	lang E, cont "crannies, don't"
	lang E, cont "you?"

	lang D, text "Exzellent! Du"
	lang D, line "beobachtest wirk-"

	lang D, para "lich alles ganz"
	lang D, line "genau, nicht wahr?"

	lang F, text "Super! Tu aimes"
	lang F, line "vraiment fouiller"

	lang F, para "dans tous les"
	lang F, line "coins et recoins,"
	lang F, cont "n'est-ce pas?"

	lang I, text "Eccellente! Ti"
	lang I, line "piace proprio"

	lang I, para "ficcare il naso"
	lang I, line "dappertutto!"

	lang S, db   "?"

	done

.textScoreBest
	lang J, text "おおっ　ゆめにまで　みた"
	lang J, line "パーフェクトな　#マニアの"
	lang J, cont "かんせいじゃ！　<……>　おめでとう！"

	lang E, text "Whoa! A perfect"
	lang E, line "#MANIAC! I've"

	lang E, para "dreamt about this!"
	lang E, line "Congratulations!"

	lang D, text "Wow! Du bist ein"
	lang D, line "wahrer #MANIAC,"

	lang D, para "von dem man sonst"
	lang D, line "nur träumen kann!"

	lang D, para "Perfekt! Herzli-"
	lang D, line "chen Glückwunsch!"

	lang F, text "Whaou! Un #MA-"
	lang F, line "NIAC parfait!"

	lang F, para "Mon rêve"
	lang F, line "devient réalité!"
	lang F, cont "Bravo! Bravo!"

	lang I, text "Ma questo è un"
	lang I, line "#FANATICO"
	lang I, cont "perfetto!"

	lang I, para "È sempre stato il"
	lang I, line "mio sogno."
	lang I, cont "Complimenti!"

	lang S, db   "?"

	done
ENDC
