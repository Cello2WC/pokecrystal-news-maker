; this file does NOT match the version seen in the "first issue"
; stored in the english ROM!
; it has been tweaked to more closely
; match magazine scans featuring the first issue.
; for a version matching the ROM, see minigame/oak_quiz_debug.asm



IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 0

DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"


MACRO minigame_abuttonhook
	nsc_clear 1, 4, 18, 8
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, POKEMON_PROF, 7
ENDM

MACRO minigame_start
	; fake page transition
	nsc_playmusic MUSIC_POKEMON_TALK
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	
	nsc_textbox 1, 14, .oakIntroText
	nsc_waitbutton
	nsc_page PokemonQuiz

.oakIntroText
	; NOTE: record only exists for one box of this text.......
	; Japanese
	lang_text J, "オーキド『こ<NO>コーナーは"
	lang_line J, "わし<GA>あんない　しよう！"
	; this dialogue has not been recovered past this point.
	; following is filler.
	lang_para J, "<……> <……>"
	lang_line J, "<……> <……>"
	lang_para J, "２エラー"
	
	; English
	lang_text E, "OAK: I'll guide you"
	lang_line E, "through this part!"
	; this dialogue has not been recovered past this point.
	; following is filler.
	lang_para E, "<……> <……>"
	lang_line E, "<……> <……>"
	lang_para E, "２エラー"
	
	; German
	lang_text D, "EICH: Ich führe"
	lang_line D, "dich durch diesen"
	lang_cont D, "Bereich!"
	; this dialogue has not been recovered past this point.
	; following is filler.
	lang_para D, "<……> <……>"
	lang_line D, "<……> <……>"
	lang_para D, "Fehler 2"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang S,      "?"

	done

ENDM

MACRO minigame_name
	lang J, "ポケモンクイズ！"
	lang E, "#MON QUIZ!"
	lang D, "#MON-QUIZ!"
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
	lang J,      "ウツギはかせ<GA>はじめに"
	lang_next J, "えらばせてくれた　#"
	lang_next J, "まんなか<NI>いたのは？"
	lang_next J, ""
	lang_next J, "１．ワニノコ　　２．チコりータ"
	lang_next J, "３．ヒノアラシ"
	
	lang E,      "Who was in the"
	lang_next E, "middle #BALL at"
	lang_next E, "PROF.ELM's LAB?"
	lang_next E, "1. TOTODILE"
	lang_next E, "2. CYNDAQUIL"
	lang_next E, "3. CHIKORITA"
	
	lang D,      "Wer befand sich im"
    lang_next D, "mittleren #BALL"
    lang_next D, "in LINDs LABOR?"
    lang_next D, "1. KARNIMANI"
    lang_next D, "2. FEURIGEL"
    lang_next D, "3. ENDIVIE"
	
	lang F,      "Qui était le #-"
	lang_next F, "MON du milieu au"
	lang_next F, "LABO du PROF.ORME?" 
	lang_next F, "1. KAIMINUS"
	lang_next F, "2. HERICENDRE"
	lang_next F, "3. GERMIGNON"
	
	lang I,      "Chi c'era nella"
    lang_next I, "# BALL centrale"
    lang_next I, "del PROF.ELM?"
    lang_next I, "1. TOTODILE"
    lang_next I, "2. CYNDAQUIL"
    lang_next I, "3. CHIKORITA"
	
	lang S,      "?"

	next "@"
	
.question2Text
	lang J,      "ウツギはかせ<NO>よこに"
	lang_next J, "ある　ごみばこに"
	lang_next J, "はい<TTE>　いるのは？"
	lang_next J, ""
	lang_next J, "１．たべのこし　２．ジュースのびん"
	lang_next J, "３．おかしのふくろ"
	

	lang E,      "What is inside"
	lang_next E, "the trash can"
	lang_next E, "next to PROF.ELM?"
	lang_next E, "1. LEFTOVERS"
	lang_next E, "2. JUICE BOTTLE"
	lang_next E, "3. SNACK WRAPPER"
	
	lang D,      "Was befindet sich"
    lang_next D, "im Mülleimer neben"
    lang_next D, "PROF. LIND?"
    lang_next D, "1. ÜBERRESTE"
    lang_next D, "2. SAFTFLASCHE"
    lang_next D, "3. SNACK-FOLIE"
	
	lang F,      "Qu'est-ce qui était"
	lang_next F, "dans la poubelle à"
	lang_next F, "coté du PROF.ORME?"
	lang_next F, "1. RESTES"
	lang_next F, "2. BOUTEILLE VIDE"
	lang_next F, "3. EMBALLAGE"
	
	lang I,      "Cosa c'è nel"
    lang_next I, "cestino vicino" 
    lang_next I, "al PROF. ELM?"
    lang_next I, "1. AVANZI"
    lang_next I, "2. BOTTIGLIA VUOTA"
    lang_next I, "3. CARTA SNACK"
	
	lang S,      "?"
	
	next "@"
	
.question3Text
	lang J,      "#<NO>つかまえかたを"
	lang_next J, "おしえて　くれる"
	lang_next J, "おにいさん<NO>りュックに"
	lang_next J, "きずくすり<WA>いくつ？"
	lang_next J, "１．１こ　　　２．２こ"
	lang_next J, "３．３こ"
	
	lang E,      "How many POTIONs"
	lang_next E, "did the DUDE who"
	lang_next E, "taught you to"
	lang_next E, "catch #MON have"
	lang_next E, "in his pack?"
	lang_next E, "1. 1  2. 2  3. 3"
	
	lang D,      "Wie viele TRÄNKE"
    lang_next D, "besaß der KUMPEL,"
    lang_next D, "der dir das Fan-"
    lang_next D, "gen von #MON"
    lang_next D, "beigebracht hat?"
    lang_next D, "1. 1  2. 2  3. 3"
	
	lang F,      "Combien de POTIONs"
	lang_next F, "le MEC qui t'as"
	lang_next F, "appris à attraper"
	lang_next F, "des #MON avait-"
	lang_next F, "il dans son sac?"
	lang_next F, "1. 1  2. 2  3. 3"
	
	lang I,      "Quante POZIONI"
    lang_next I, "aveva nello ZAINO"
    lang_next I, "l'AMICO che ti ha"
    lang_next I, "ha insegnato a"
    lang_next I, "catturare #MON?"
    lang_next I, "1. 1  2. 2  3. 3"
	
	lang S,      "?"
	
	next "@"
	
.question4Text
	lang J,      "おかあさんの"
	lang_next J, "とくい　りょうりは"
	lang_next J, "「グレンふう　かざん　？？？」"
	lang_next J, "「？？？」<WA>なに？"
	lang_next J, "１．ハンバーグ　　２．カレー"
	lang_next J, "３．やきそば"
	
	lang E,      "MOM's specialty"
	lang_next E, "dish is the"
	lang_next E, "CINNABAR VOLCANO ?"
	lang_next E, "1. BURGER"
	lang_next E, "2. CURRY"
	lang_next E, "3. NOODLES"
	
	lang D,      "Mamas Spezialität"
    lang_next D, "heißt wie genau?"
    lang_next D, "ZINNOBER-VULKAN-…"
    lang_next D, "1. BURGER"
    lang_next D, "2. CURRY"
    lang_next D, "3. NUDELN"
	
	lang F,      "Le plat Spécial"
	lang_next F, "CRAMOIS'ILE" 
	lang_next F, "de MAMAN est?"
	lang_next F, "1. un BURGER"
	lang_next F, "2. un CURRY"
	lang_next F, "3. des NOUILLES"
	
	lang I,      "La specialità di"
    lang_next I, "MAMMA è … DELL'"
    lang_next I, "ISOLA CANNELLA?"
    lang_next I, "1. MINESTRONE"
    lang_next I, "2. CURRY"
    lang_next I, "3. NOODLE"
	
	next "@"
	
.question5Text
	lang J,      "ジョバンニせんせいは"
	lang_next J, "はなしかけてから"
	lang_next J, "じゅく<NI>はいるまで"
	lang_next J, "なんかい　まわる？"
	lang_next J, "１．５かい　　　２．６かい"
	lang_next J, "３．７かい"

	lang E,      "How many times"
	lang_next E, "does EARL spin"
	lang_next E, "from talking to"
	lang_next E, "him until he goes"
	lang_next E, "into the ACADEMY?"
	lang_next E, "1. 5  2. 6  3. 7"
	
	lang D,      "Wie oft hatte"
    lang_next D, "sich EARL gedreht,"
    lang_next D, "bevor er in die"
    lang_next D, "#MON-AKADEMIE"
    lang_next D, "ging?"
    lang_next D, "1. 5  2. 6  3. 7"
	
	lang F,      "Combien de fois"
	lang_next F, "THEOPHILE tourne-"
	lang_next F, "t-il sur lui même"
	lang_next F, "avant d'entrer"
	lang_next F, "dans l'ACADEMIE?"
	lang_next F, "1. 5  2. 6  3. 7"
	
	lang I,      "Quante volte gira"
    lang_next I, "PRIMO da quando"
    lang_next I, "gli parli a quando"
    lang_next I, "va nell'ACCADEMIA?"
    lang_next I, "1. 5  2. 6  3. 7"
	
	lang S,      "?"
	
	next "@"
	
.question6Text
	lang J,      "つながりのどうくつに"
	lang_next J, "おちていない　どうぐは？"
	lang_next J, ""
	lang_next J, "１．プラスパワー　２．まひなおし"
	lang_next J, "３．きずぐすり"

	lang E,      "Which of these"
	lang_next E, "items is not found"
	lang_next E, "in UNION CAVE?"
	lang_next E, "1. X ATTACK"
	lang_next E, "2. PARLYZ HEAL"
	lang_next E, "3. POTION"
	
	lang D,      "Welches Item"
    lang_next D, "gibt es nicht im"
    lang_next D, "EINHEITSTUNNEL?"
    lang_next D, "1. X-ANGRIFF"
    lang_next D, "2. PARAHEILER"
    lang_next D, "3. TRANK"
	
	lang F,      "Quel objet n'existe"
	lang_next F, "pas dans les"
	lang_next F, "CAVES JUMELLES?"
	lang_next F, "1. ATTAQUE +"
	lang_next F, "2. ANTI-PARA"
	lang_next F, "3. POTION"
	
	lang I,      "Quale oggetto non"
    lang_next I, "è presente nella"
    lang_next I, "GROTTA DI MEZZO?"
    lang_next I, "1. X ATTACCO"
    lang_next I, "2. ANTIPARALISI"
    lang_next I, "3. POZIONE"
	
	lang S,      "?"
	
	next "@"
	
.question7Text
	lang J,      "カモネギ<WO>つかまえるとき"
	lang_next J, "いちばん　すくない　てかずは"
	lang_next J, "なんかい　カモネギに"
	lang_next J, "はなしかければ　いい？"
	lang_next J, "１．３かい　　２．４かい"
	lang_next J, "３．５かい"
	
	lang E,      "What is the least"
	lang_next E, "amount of times"
	lang_next E, "you need to talk"
	lang_next E, "to FARFETCH'd to"
	lang_next E, "capture it?"
	lang_next E, "1. 3  2. 4  3. 5"
	
	lang D,      "Wie oft muss man"
	lang_next D, "PORENTA mindestens"
	lang_next D, "ansprechen, bevor"
	lang_next D, "man es fangen"
	lang_next D, "kann?"
	lang_next D, "1. 3  2. 4  3. 5"
	
	lang F,      "Quel est le nombre"
	lang_next F, "minimal de fois"
	lang_next F, "qu'il faille parler"
	lang_next F, "à CANARTICHO"
	lang_next F, "pour le capturer?"
	lang_next F,  "1. 3  2. 4  3. 5"
	
	lang I,      "Qual è il numero"
	lang_next I, "minimo di volte in"
	lang_next I, "cui devi parlare"
	lang_next I, "a FARFETCH'D per"
	lang_next I, "acchiapparlo?"
	lang_next I, "1. 3  2. 4  3. 5"
	
	lang S,      "?"
	
	next "@"
	
.question8Text
	lang J,   "ヤドンのいどに"
	lang_next J, "ヤドン<WO>たすけ<NI>いったとき"
	lang_next J, "いど<NO>なか<NI>いるヤドンは"
	lang_next J, "なんひき　だった？"
	lang_next J, "１．２ひき　　２．３ひき"
	lang_next J, "３．４ひき"

	lang E,      "How many SLOWPOKE"
	lang_next E, "were in the cave"
	lang_next E, "when you rescued"
	lang_next E, "them at SLOWPOKE"
	lang_next E, "WELL?"
	lang_next E, "1. 2  2. 3  3. 4"
	
	lang D,      "Wie viele FLEGMON"
	lang_next D, "befanden sich im"
	lang_next D, "FLEGMON-BRUNNEN"
	lang_next D, "als du sie ge-"
	lang_next D, "rettet hast?"
	lang_next D, "1. 2  2. 3  3. 4"
	
	lang F,      "Combien de" 
	lang_next F, "RAMOLOSS devaient"
	lang_next F, "être secourus dans"
	lang_next F, "la grotte du PUITS"
	lang_next F, "RAMOLOSS?"
	lang_next F, "1. 2  2. 3  3. 4"
	
	lang I,      "Quanti SLOWPOKE"
	lang_next I, "c'erano nella"
	lang_next I, "grotta al POZZO"
	lang_next I, "SLOWPOKE quando"
	lang_next I, "li hai salvati?"
	lang_next I, "1. 2  2. 3  3. 4"
	
	lang S,      "?"
	
	next "@"
	
.question9Text
	lang J,      "ヨシノシティ<NI>いる"
	lang_next J, "あんないじいさんは"
	lang_next J, "うみ　<WO>なんばんめに"
	lang_next J, "あんない　してくれる？"
	lang_next J, "１．３ばんめ　　２．４ばんめ"
	lang_next J, "３．５ばんめ"
	
	lang E,      "Which stop is the"
	lang_next E, "sea on the GUIDE"
	lang_next E, "GENT's tour around"
	lang_next E, "CHERRYGROVE CITY?"
	lang_next E, "1. 3rd  2. 4th "
	lang_next E, "3. 5th"
	
	lang D,      "Das Meer war der"
	lang_next D, "wievielte Halt des"
	lang_next D, "FREMDENFÜHRERS von"
	lang_next D, "ROSALIA CITY?"
	lang_next D, ""
	lang_next D, "1. 3. 2. 4. 3. 5."
	
	lang F,      "Quel est l'arrêt"
	lang_next F, "de la mer lors du"
	lang_next F, "tour du GUIDE de"
	lang_next F, "VILLE GRIOTTE?"
	lang_next F, "1. 3ème  2. 4ème "
	lang_next F, "3. 5ème"
	
	lang I,      "A che fermata è il"
	lang_next I, "mare durante il"
	lang_next I, "tour della GUIDA"
	lang_next I, "di FIORPESCOPOLI?"
	lang_next I, "1. 3º  2. 4º "
	lang_next I, "3. 5º"
	
	lang S,      "?"
	
	next "@"
	
.question10Text
	lang J,      "#じいさん<NO>いえに"
	lang_next J, "がいこく<NO>ものが"
	lang_next J, "あるけど　このなかで"
	lang_next J, "ない　ものは？"
	lang_next J, "１．コイン　　２．き<TTE>"
	lang_next J, "３．ざっし"
	
	lang E,      "Which of these"
	lang_next E, "foreign items is"
	lang_next E, "not found in MR."
	lang_next E, "#MON's HOUSE?"
	lang_next E, "1. COIN  2. STAMP"
	lang_next E, "3. MAGAZINE"
	
	lang D,      "Was findet man"
	lang_next D, "nicht im HAUS von"
	lang_next D, "MR. #MON?"
	lang_next D, "1. MÜNZE"
	lang_next D, "2. BRIEFMARKE"
	lang_next D, "3. HEFT"
	
	lang F,      "Lequel de ces"
	lang_next F, "objets étrangers"
	lang_next F, "ne se trouve pas"
	lang_next F, "chez M.#MON?"
	lang_next F, "1. PIECE 2. TAMPON"
	lang_next F, "3. MAGAZINE"
	
	lang I,      "Quale oggetto"
	lang_next I, "non è nella CASA"
	lang_next I, "di MR. #MON?"
	lang_next I, "1. MONETE"
	lang_next I, "2. FRANCOBOLLO"
	lang_next I, "3. RIVISTA"
	
	lang S,      "?"
	
	next "@"

	
	
	news_screen QuizScoreEvaluation, MUSIC_POKEMON_TALK

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20, 6, {NEWS_TEXT_BORDER}
	
	
	news_def_strings
	news_string 0, 0, "@" ; ......why?
	
IF DEF(_LANG_J)
	news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
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
	nsc_drawtrainer 6, 2, POKEMON_PROF, 7
	nsc_select
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
	
.menuItemText
	lang J, "オーキドはかせの　ひょうか"
	lang E, "PROF.OAK's RATING"
	; Rework in other languages
	lang D, "EICHs BEWERTUNG"
	lang F, "RAPPORT DE CHEN"
	lang I, "RAPPORTO DI OAK"
	lang S, "?"
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
	lang_line E, "Here's the rating!"
; TODO: Rework in other languages
	
	lang      D, "Zur Bewertung"
	lang_line D, "deiner Antworten!"
	
	lang      F, "Faites le quiz et"
	lang_line F, "recevez un Avis!"
	
	lang      I, "Fai il quiz per"
	lang_line I, "una valutazione!"
	
	lang S, "?"
	
	db "@"

.textScoreLow
	lang_text J, "ぜんぜん　まだまだ　じゃな"
	lang_line J, "これ<WA>おぼえてなくても　いいだろう"
	lang_cont J, "というような　ことまで　おぼえるのが"
	lang_cont J, "#マニアと　いうものじゃ"
	
	lang_text E, "It's not enough to"
	lang_cont E, "memorize things."
	
	lang_para E, "A true #MANIAC"
	lang_line E, "can memorize"
	lang_cont E, "things they don't"
	lang_cont E, "even need to"
	lang_cont E, "remember!"
	
	lang_text D, "Es genügt nicht,"
	lang_line D, "Dinge bloß aus-"
	lang_cont D, "wendig zu lernen."
	
	lang_para D, "#MANIACs können"
	lang_line D, "sich Dinge merken,"
	lang_cont D, "ohne dafür lernen"
	lang_cont D, "zu müssen!"
	
	lang_text F, "Ce n'est pas assez"
	lang_line F, "de mémoriser des"
	lang_cont F, "trucs."
	
	lang_para F, "Les #MANIACs"
	lang_line F, "peuvent mémoriser"
	
	lang_para F, "des choses dont"
	lang_line F, "ils n'ont même pas"
	lang_cont F, "besoin de se"
	lang_cont F, "rappeler!"
	
	lang_text I, "Imparare a memoria"
	lang_line I, "non basta."
	
	lang_para I, "I #FANATICI"
	lang_line I, "memorizzano cose"
	
	lang_para I, "che non hanno"
	lang_line I, "nemmeno bisogno"
	lang_cont I, "di ricordare!"
	
	lang S,      "?"

	done

.textScoreAverage
	lang_text J, "#マニア<NI>して<WA>まだ"
	lang_line J, "ボりューム<GA>たりん！"
	lang_para J, "いろいろな　ものを"
	lang_line J, "むだでも　くまなく　みるのじゃ！"
	
	lang_text E, "You still have"
	lang_line E, "lots to do."
	lang_cont E, "#MANIACs have a"
	lang_cont E, "lot more passion!"
	
	lang_para E, "Be sure to look in"
	lang_line E, "every nook and"
	lang_cont E, "cranny!"
	
	lang_text D, "Du hast noch eine"
	lang_line D, "Menge Arbeit vor"
	lang_cont D, "dir."
	
	lang_para D, "Echte #MANIACs"
	lang_line D, "sind da noch mehr"
	lang_cont D, "bei der Sache!"
	
	lang_para D, "Sieh dich genau"
	lang_line D, "in allen Ecken"
	lang_cont D, "und Winkeln um!"
	
	lang_text F, "Il te reste beau-"
	lang_line F, "coup à faire."
	lang_cont F, "Les #MANIAC ont"
	lang_cont F, "plus de passion!"
	
	lang_para F, "Sois sûr de bien"
	lang_line F, "vérifier tous les"
	lang_cont F, "coins et recoins!"
	
	lang_text I, "Hai ancora"
	lang_line I, "molto da fare."
	
	lang_para I, "I #FANATICI"
	lang_line I, "hanno molta più"
	lang_cont I, "passione!"
	
	lang_para I, "Assicurati di"
	lang_line I, "guardare in ogni"
	lang_cont I, "angolo!"
	
	lang S,      "?"
	
	done

.textScoreGood
	lang_text J, "ふむ　がんば<TTE>おるな"
	lang_line J, "それなり<NI>#マニア"
	lang_cont J, "らしく　な<TTE>きておるよ！"
	
	lang_para J, "ともだちと　そうだん　しているかな？"
	lang_line J, "ひとりで<WA>たいへん　だからな"
	
	lang_text E, "You're trying--I"
	lang_line E, "can see that."
	
	lang_para E, "You're really"
	lang_line E, "starting to earn"	
	lang_cont E, "the title of" 
	lang_cont E, "#MANIAC!"
	
	lang_para E, "Are you talking"
	lang_line E, "with your friends?"
	lang_para E, "It's tough to" 
	lang_line E, "do this alone!"
	
	lang_text D, "Du gibst dir Mühe."
	lang_line D, ""
	
	lang_para D, "Du bist fast"
	lang_line D, "schon sowas wie"
	lang_cont D, "ein #MANIAC!"
	
	lang_para D, "Tauschst du dich"
	lang_line D, "auch mit deinen"
	lang_cont D, "Freunden aus?"
	
	lang_para D, "Zusammen ist man"
	lang_line D, "immer stärker!"
	
	lang_text F, "Tu te donnes du"
	lang_line F, "mal, ça se voit."
	
	lang_para F, "Tu commences à"
	lang_line F, "vraiment mériter"
	lang_cont F, "le titre de"
	lang_cont F, "#MANIAC!"
	
	lang_para F, "Est-ce que tu"
	lang_line F, "vois des gens?"
	lang_para F, "Il faut se faire"
	lang_line F, "des amis!"
	
	lang_text I, "Ti impegni, si"
	lang_line I, "vede."
	
	lang_para I, "Stai tentando"
	lang_line I, "di diventare un"
	lang_cont I, "#FANATICO."
	
	lang_para I, "Stai parlando"
	lang_line I, "coi tuoi amici?"
	
	lang_para I, "È dura farcela"
	lang_line I, "da soli!"
	
	lang S,      "?"
	
	done

.textScoreGreat
	lang_text J, "エクセレントじゃ！"
	lang_line J, "きみ<WA>じゅうばこ<NO>すみを"
	lang_cont J, "つつくの<GA>すき　なんじゃろ？"
	
	lang_text E, "Excellent! You"
	lang_line E, "really like to"
	
	lang_para E, "poke around in"
	lang_line E, "those nooks and"
	lang_cont E, "crannies, don't"
	lang_cont E, "you?"
	
	lang_text D, "Exzellent! Du"
	lang_line D, "beobachtest wirk-"
	
	lang_para D, "lich alles ganz"
	lang_line D, "genau, nicht wahr?"
	
	lang_text F, "Super! Tu aimes"
	lang_line F, "vraiment fouiller"
	
	lang_para F, "dans tous les"
	lang_line F, "coins et recoins,"
	lang_cont F, "hein?"
	
	lang_text I, "Eccellente! Ti"
	lang_line I, "piace proprio"
	
	lang_para I, "ficcare il naso"
	lang_line I, "dappertutto!"
	
	lang S,      "?"
	
	done

.textScoreBest
	lang_text J, "おおっ　ゆめにまで　みた"
	lang_line J, "パーフェクトな　#マニアの"
	lang_cont J, "かんせいじゃ！　<……>　おめでとう！"
	
	lang_text E, "Whoa! A perfect"
	lang_line E, "#MANIAC! I've"
	
	lang_para E, "dreamt about this!"
	lang_line E, "Congratulations!"
	
	lang_text D, "Wow! Du bist ein"
	lang_line D, "wahrer #MANIAC,"
	
	lang_para D, "von dem man sonst"
	lang_line D, "nur träumen kann!"
	
	lang_para D, "Perfekt! Herzli-"
	lang_line D, "chen Glückwunsch!"
	
	lang_text F, "Whoa! Un parfait"
	lang_line F, "#MANIAC!"
	
	lang_para F, "Mon rêve"
	lang_line F, "devient réalité!"
	lang_cont F, "Bravo! Bravo!"
	
	lang_text I, "Ma questo è un"
	lang_line I, "#FANATICO"
	lang_cont I, "perfetto!"
	
	lang_para I, "È sempre stato il"
	lang_line I, "mio sogno."
	lang_cont I, "Complimenti!"
	
	lang S,      "?"
	
	done
ENDC