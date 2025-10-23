; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
; 
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_10.htm
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

DEF wPersonalityPage EQUS "wNewsScratch2"

MACRO minigame_start

	;nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro
	nsc_set wPersonalityPage, 0
	nsc_page MinigameStart
	
	
	
	

.gameIntroText
	; Japanese
	lang J, text "トレーナーしんだんを　はじめます！"
	lang J, para "さいしょの　１かい　だけ　しんだんが"
	lang J, line "おわると　プレゼントが　もらえます！"
	lang J, para "けっかに　よって　プレゼントが"
	lang J, line "ちがうので　きをつけてね！"
	lang J, para "それでは　スタート！"
	
	; English
	lang E, text "Starting your"
	lang E, line "<TRAINER> CHECKUP!"

	lang E, para "You'll only get"
	lang E, line "a gift after your"
	lang E, cont "first checkup!"
	
	lang E, para "The gift differs"
	lang E, line "based on your"
	lang E, cont "results, so be"
	lang E, cont "careful!"
	
	lang E, para "Alright, let's"
	lang E, line "get started!"
	
	; German
	lang D, text "Beginnen wir mit"
	lang D, line "dem <TRAINER>-"
	lang D, cont "CHECK-UP!"

	lang D, para "Du erhältst nach"
	lang D, line "nur deinem ersten"
	lang D, cont "Check-Up ein"
	lang D, cont "Geschenk!"
	
	lang D, para "Das Ergebnis be-"
	lang D, line "einflusst die Art"
	lang D, cont "deines Geschenks,"
	lang D, cont "also pass gut auf!"
	
	lang D, para "Und damit geht's"
	lang D, line "jetzt los!"

	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"

	done
	
ENDM

MACRO minigame_name
	; Japanese
	lang J, db "<TRAINER> しんだん！"
	; English
	lang E, db "<TRAINER> CHECKUP!"
	; German
	lang D, db "<TRAINER>-CHECK-UP!"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
ENDM

MACRO minigame_desc
	lang J, db   "?"
	
	lang E, db   "?"
	
	lang D, db   "?"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
ENDM

ELSE
MinigameStart::
	news_screen PersonalityTest, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wPersonalityPage, \
	.page1, \
	.page2, \
	.page3, \
	.page4, \
	.page5, \
	.page6, \
	.page7, \
	.page8, \
	.page9, \
	.page10, \
	.page11, \
	.page12, \
	.page13, \
	.page14, \
	.page15, \
	.page16
	nts_end
	
	news_menu  2, 16, 3, 1, 5, 2, -1, $00, $00, $00, 0, $04
	
	news_buttonscript .aButton     ; script pointer a button
	news_buttonscript .bButton     ; script pointer b button
	news_buttonscript              ; script pointer select button
	news_buttonscript .bButton     ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript              ; script pointer up button
	news_buttonscript              ; script pointer down button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuItemAnswer1Text,   .menuItemAnswer2Text,   .menuItemQuitText
	news_menuitem_scripts .menuItemAnswer1Script, .menuItemAnswer2Script, .menuItemQuitScript
	news_menuitem_descs   .dummyDescription,      .dummyDescription,      .dummyDescription

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
	lang J, db "はい"
	lang E, db "YES"
	lang D, db "JA"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	db "@"

.menuItemAnswer2Text
	lang J, db "いいえ"
	lang E, db "NO"
	lang D, db "NEIN"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	db "@"

.menuItemQuitText
	lang J, db "やめる"
	lang E, db "QUIT"
	lang D, db "ZUR."
	lang F, db "RET"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"
	
	
	
DEF QR EQU $80
MACRO quiz_answers
DEF _ANSWER_NUMBER = \1
.menuItemAnswer\1Script
SHIFT
DEF _QUESTION_NUMBER = 1
	nsc_add wPersonalityPage, 1
REPT _NARG
	nsc_compare wPersonalityPage, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, 1, {_QUESTION_NUMBER}

.answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}
	nsc_set wPersonalityPage, (\1 & %0111_1111)-1
IF \1 & %1000_0000 == 0
	nsc_page PersonalityTest
ELSE
	nsc_page PersonalityTestResults
ENDC
	nsc_ret

SHIFT 1
.answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}
DEF _QUESTION_NUMBER = _QUESTION_NUMBER + 1
ENDR
	nsc_ret
ENDM
	
	quiz_answers 1,    2,  3,  4, QR|1, 6, 7, QR|2,  9, QR|5, 11, 12, QR|5, QR|6, 16,   16, QR|3
	quiz_answers 2,    5, 10, 12,   13, 8, 9,   13, 16,   14, 13, 15, QR|1,   14, 15, QR|4, QR|4
	
.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.dummyDescription
	db "@"

.page1
	; Japanese
	lang J, db   "ポケモンを　つかまえたら"
	lang J, next "かならず　ニックネームを　つける"
	
	; English
	lang E, db   "Whenever I catch"
	lang E, next "a #MON,"
	lang E, next "I always give it a"
	lang E, next "nickname."	
	
	; German
	lang D, db   "Ich gebe jedem"
	lang D, next "meiner #MON"
	lang D, next "sofort einen"
	lang D, next "Spitznamen."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page2
	; Japanese
	lang J, db   "ポケモンの　なまえを　よぶときは"
	lang J, next "「ちゃん」を　つけて　よんでしまう"
	
	; English
	lang E, db   "When I call my"
	lang E, next "#MON's name,"
	lang E, next "I always end up"
	lang E, next "adding “darling”."
	
	; German
	lang D, db   "Wenn ich den"
	lang D, next "Namen meines"
	lang D, next "#MON rufe, füge"
	lang D, next "ich immer ein"
	lang D, next "“-lein” oder ein"
	lang D, next "“-chen” hinzu."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page3
	; Japanese
	lang J, db   "ポケモンに　おぼえさせる　わざは"
	lang J, next "ポケモンの　イメージに　あっていれば"
	lang J, next "つよく　なくても　きにしない"
	
	; English
	lang E, db   "As long as a move"
	lang E, next "matches my"
	lang E, next "#MON's image,"
	lang E, next "I don't care if"
	lang E, next "it's not strong."
	
	; German
	lang D, db   "Solange eine"
	lang D, next "Attacke zu meinem"
	lang D, next "#MON passt,"
	lang D, next "ist es egal, ob"
	lang D, next "sie stark ist."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page4
	; Japanese
	lang J, db   "すきな　ポケモンは　よわくても"
	lang J, next "１０ひき　いじょう　あつめてしまう"
	
	; English
	lang E, db   "I'll collect more"
	lang E, next "than ten of my"
	lang E, next "favorite #MON,"
	lang E, next "even if they're"
	lang E, next "weak."
	
	; German
	lang D, db   "Ich fange mehr als"
	lang D, next "zehn meiner Lieb-"
	lang D, next "lings-#MON,"
	lang D, next "selbst wenn sie"
	lang D, next "schwach sind."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page5
	; Japanese
	lang J, db   "こうげきが　つよければ"
	lang J, next "ぼうぎょは　あまり　きにしない"
	
	; English
	lang E, db   "If a #MON has"
	lang E, next "high attack,"
	lang E, next "I don't care"
	lang E, next "much for defense."
	
	; German
	lang D, db   "Solange ein #-"
	lang D, next "MON gute Angriffs-"
	lang D, next "werte hat, ist mir"
	lang D, next "die Verteidigung"
	lang D, next "nicht wichtig."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page6
	; Japanese
	lang J, db   "じぶんより　よわい　あいてに"
	lang J, next "かつと　きもちがいい？"
	
	; English
	lang E, db   "Winning against a"
	lang E, next "weaker opponent"
	lang E, next "feels great!"
	
	; German
	lang D, db   "Es fühlt sich gut"
	lang D, next "an, gegen schwä-"
	lang D, next "chere Gegner zu"
	lang D, next "gewinnen!"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page7
	; Japanese
	lang J, db   "だいじに　そだてた　ポケモンでも"
	lang J, next "たかい　おかねでなら　うってもいい"
	
	; English
	lang E, db   "I'd sell even the"
	lang E, next "#MON I've"
	lang E, next "raised with care"
	lang E, next "if the price was"
	lang E, next "high enough."		
	
	; German
	lang D, db   "Solange der Preis"
	lang D, next "stimmt, würde ich"
	lang D, next "auch #MON ver-"
	lang D, next "kaufen, um die"
	lang D, next "ich mich lange"
	lang D, next "gekümmert habe."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page8
	; Japanese
	lang J, db   "わざマシンの　わざの　しゅるいを"
	lang J, next "なにも　みないで"
	lang J, next "３０こ　いじょう　いえる"
	
	; English
	lang E, db   "I can name thirty"
	lang E, next "or more different"
	lang E, next "kinds of TM moves"	
	lang E, next "without looking."
	
	; German
	lang D, db   "Ich kann dreißig"
	lang D, next "oder mehr Arten"
	lang D, next "von TM-Attacken"
	lang D, next "aus dem Gedächtnis"
	lang D, next "aufzählen."
		
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page9
	; Japanese
	lang J, db   "てにいれた　わざマシンは"
	lang J, next "そのとき　もっている　ポケモンに"
	lang J, next "すぐに　つかってしまう"
	
	; English
	lang E, db   "When I get a TM,"
	lang E, next "I teach it to"
	lang E, next "my #MON right" 
	lang E, next "away!"
	
	; German
	lang D, db   "Sobald ich eine"
	lang D, next "TM erhalte, bringe"
	lang D, next "ich sie sofort"
	lang D, next "meinem #MON"
	lang D, next "bei."

	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page10
	; Japanese
	lang J, db   "いつも　くすりは　おおめに"
	lang J, next "もちあるく　ように　している"
	
	; English
	lang E, db   "I always try to"
	lang E, next "carry plenty of"
	lang E, next "medicine with me."
	
	; German
	lang D, db   "Ich habe immer"
	lang D, next "eine große Menge"
	lang D, next "Medizin bei mir."

	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page11
	; Japanese
	lang J, db   "すきな　どうぐは　やっぱり"
	lang J, next "きせきのみ　より　きあいのハチマキ！"
	
	; English
	lang E, db   "When it comes to"
	lang E, next "items, I prefer"
	lang E, next "a FOCUS BAND over"
	lang E, next "a MIRACLEBERRY!"
	
	; German
	lang D, db   "Ich bevorzuge"
	lang D, next "bei Items"
	lang D, next "ein FOKUSBAND"
	lang D, next "gegenüber einer"
	lang D, next "WUNDERBEERE!"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page12
	; Japanese
	lang J, db   "たいりょくが　あと　すこし　でも"
	lang J, next "つぎの　こうげきで　かてそうなら"
	lang J, next "かいふくは　しない"
	
	; English
	lang E, db   "Even if my #MON"
	lang E, next "has low HP,"
	lang E, next "I won't heal if"
	lang E, next "I think I can win"
	lang E, next "next turn."
	
	; German
	lang D, db   "Auch wenn mein"
	lang D, next "#MON kaum noch"
	lang D, next "KP übrig hat,"
	lang D, next "heile ich es"
	lang D, next "nicht, wenn ich"
	lang D, next "die nächste Runde"
	lang D, next "gewinnen könnte."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page13
	; Japanese
	lang J, db   "ともだちが　あまり　つかわないような"
	lang J, next "ポケモンを　つかうのが　だいすきだ"
	
	; English
	lang E, db   "I love using"
	lang E, next "#MON that my"
	lang E, next "friends don't"
	lang E, next "often use."
	
	; German
	lang D, db   "Ich mag es sehr,"
	lang D, next "#MON einzu-"
	lang D, next "setzen, die von"
	lang D, next "Freunden nicht oft"
	lang D, next "eingesetzt werden."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page14
	; Japanese
	lang J, db   "しらない　まちに　ついたら　まずは"
	lang J, next "ポケモンセンターで　かいふくする"
	
	; English
	lang E, db   "When I arrive in"
	lang E, next "a new town, the"
	lang E, next "first thing I do"
	lang E, next "is heal at a"	
	lang E, next "#MON CENTER."
	
	; German
	lang D, db   "In einer neuen"
	lang D, next "Stadt besuche ich"
	lang D, next "als allererstes"
	lang D, next "das #MON-"
	lang D, next "CENTER zum Heilen."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page15
	; Japanese
	lang J, db   "どうくつの　なかを　たんけんするより"
	lang J, next "へやで　ゆっくり　さくせんを"
	lang J, next "ねる　ほうが　すきだ"
	
	; English
	lang E, db   "I'd rather plan"
	lang E, next "strategies in my"
	lang E, next "room than go out"
	lang E, next "exploring caves."
	
	; German
	lang D, db   "Lieber plane ich"
	lang D, next "daheim in Ruhe"
	lang D, next "meine Taktik,"
	lang D, next "statt draußen Höh-"
	lang D, next "len zu erkunden."
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

.page16
	; Japanese
	lang J, db   "パソコンの　ボックスに"
	lang J, next "あずけてある　ポケモンは"
	lang J, next "きれいに　せいり　している"
	
	; English
	lang E, db   "The #MON"
	lang E, next "stored in my PC"
	lang E, next "BOXES are all"
	lang E, next "neatly organized."
	
	; German
	lang D, db   "Die #MON"
	lang D, next "in meinen PC-"
	lang D, next "BOXEN sind alle"
	lang D, next "schön geordnet."

	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"

	
	
	
	
	
	news_screen PersonalityTestResults, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;news_box 5,  1,  9,  9, NEWSBORDER_NONE,   7
	
	news_def_strings
	news_string 0, 0, "@"
;	nts_start
;	nts_switch wPersonalityPage, \
;	.result1, \
;	.result2, \
;	.result3, \
;	.result4, \
;	.result5, \
;	.result6, \
;	nts_end
	
	news_menu  2, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	
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
	news_menuitem_scripts .result1done;.menuItemScript
	news_menuitem_descs   .menuItemDesc
	
.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1, 13, 18, 4
	;nsc_select
	
	nsc_compare wPersonalityPage, .result1, .result2, .greater, 1, 1
.greater
	nsc_compare wPersonalityPage, .result3, .result4, .greater2, 1, 3
.greater2
	nsc_compare wPersonalityPage, .result5, .result6, .result6, 1, 5
	

; \1 - result ID
; \2 - male trainer
; \3 - female trainer
; \4 - gift
MACRO quizresult
.result\1
	nsc_compare wPlayerGender, .result\1male, .result\1female, .result\1female, 1, 1
.result\1male
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 2, \2, 7
	nsc_textbox 1, 14, .result\1textM
	nsc_compare_newsvar sMinigameFlag, .result\1done, .result\1gift, .result\1done, 1, 0
.result\1female
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 2, \3, 7
	nsc_textbox 1, 14, .result\1textF
	nsc_compare_newsvar sMinigameFlag, .result\1done, .result\1gift, .result\1done, 1, 0
	
.result\1gift
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .result\1text_gift
	nsc_giveitem \4, .result\1gotGift, .result\1noGift
.result\1gotGift
IF STRCMP(STRSLICE("\4", 0, 3), "TM_") == 0
	nsc_playsound SFX_GET_TM
ELSE
	nsc_playsound SFX_ITEM
ENDC
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.result\1noGift
.result\1done
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
ENDM
	
	quizresult 1, POKEFANM,      POKEFANF,      TM_RETURN
	quizresult 2, GRUNTM,        GRUNTF,        TM_FRUSTRATION
	quizresult 3, COOLTRAINERM,  COOLTRAINERF,  PP_UP
	quizresult 4, CAMPER,        PICNICKER,     SILVERPOWDER
	quizresult 5, BLACKBELT_T,   BLACKBELT_T,   TM_ENDURE
	quizresult 6, SCIENTIST,     SCIENTIST,     BRIGHTPOWDER
	
.menuItemText
	lang J, db "？"
	
	; A guess
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db "'s RESULTS"
	
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db "s ERGEBNIS"
	
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
.menuItemDesc
	db "@"
	
.result1textM
.result1textF
	; Japanese
	lang J, text "あなたの　トレーナータイプは"
	lang J, line "だいすきクラブ　ですわ！"
	
	lang J, para "ポケモンちゃんを　おかしいほど"
	lang J, line "あいする　あなたの　おきもち"
	lang J, cont "しかと　つたわって　きましたわ！"
	
	lang J, para "しょうぶに　まけても　かわいい"
	lang J, line "ポケモンちゃんを　もっている"
	lang J, cont "ほうが　かちよ！　わすれないでネ！"
	
	; English
	lang E, text "Your <TRAINER> type"
	lang E, line "is #FAN!"
	
	lang E, para "Your feelings of"
	lang E, line "adoration for your"
	lang E, cont "#MON are clear!"
	
	lang E, para "Even if you lose"
	lang E, line "in battle, having"
	lang E, cont "cute #MON is"
	lang E, cont "still a win! Don't"
	lang E, cont "forget that!"
	
	; German
	lang D, text "Dein <TRAINER>-Typ"
	lang D, line "ist #FAN!"
	
	lang D, para "Deine Zuneigung zu"
	lang D, line "#MON sind klar"
	lang D, cont "erkennbar!"
	
	lang D, para "Auch wenn du einen"
	lang D, line "Kampf verlierst,"
	lang D, cont "ist es ein Sieg,"
	lang D, cont "ein süßes #MON"
	lang D, cont "zu besitzen!"
	lang D, cont "Vergiss das nicht!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

	
.result1text_gift
	lang J, text "あなたの　ポケモンちゃんには"
	lang J, line "この　わざマシン２７　おんがえしが"
	lang J, cont "ぴったり！　つかって　くださいな！"
	lang J, para "わざマシン０４を　もらった！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang E, text "This TM27, RETURN,"
	lang E, line "will be perfect"
	lang E, cont "for your #MON!"
	lang E, cont "Please use it!"
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM27."	
	
	; German
	lang D, text "TM27, RÜCKKEHR,"
	lang D, line "passt wunderbar zu"
	lang D, cont "deinen #MON!"
	lang D, cont "Setze sie unbe-"
	lang D, cont "dingt ein!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM27."	
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result2textM
.result2textF
	; Japanese
	lang J, text "アナタは　ロケットだんに"
	lang J, line "ふさわしい　タイプ　みたいよ！"
	
	lang J, para "なんというか　アナタ　じぶんの"
	lang J, line "ことしか　かんがえて　ないのね！"
	
	lang J, para "いつも　そんな　わがままだと"
	lang J, line "しゅっせ　できないんじゃないの？"
	lang J, para "まあ　しょうらい　きがむいたら"
	lang J, line "ロケットだんに　いらっしゃい！"
	
	; English
	lang E, text "You seem like the"
	lang E, line "perfect type for"
	lang E, cont "TEAM <ROCKET>!"
	
	lang E, para "I mean, you only"
	lang E, line "ever think about"
	lang E, cont "yourself, huh?"
	
	lang E, para "If you're always"
	lang E, line "so selfish, you "
	lang E, cont "won't get far!"
	
	lang E, para "Well, if you ever"
	lang E, line "change your mind,"
	lang E, para "come join"
	lang E, line "TEAM <ROCKET>!"
	
	; German
	lang D, text "Du scheinst der"
	lang D, line "perfekte Typ für"
	lang D, cont "TEAM <ROCKET>"
	lang D, cont "zu sein!"
	
	lang D, para "Ich meine, du"
	lang D, line "denkst eigentlich"
	lang D, cont "nur an dich"
	lang D, cont "selbst, stimmt's?"
	
	lang D, para "Eine egoistische"
	lang D, line "Einstellung wird"
	lang D, cont "dich nicht weit"
	lang D, cont "bringen!"
	
	lang D, para "Tja, wenn du deine"
	lang D, line "Meinung änderst,"
	lang D, para "komm einfach zu"
	lang D, line "TEAM <ROCKET>!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.result2text_gift
	; Japanese
	lang J, text "ロケットだんとの　おちかづきの"
	lang J, line "きねんひんを　アナタにあげるわ！"
	lang J, cont "わざマシン２１　やつあたりよ！"
	lang J, para "わざマシン２１を　もらった！"
	
	; English
	lang E, text "Here's a gift to"
	lang E, line "celebrate your new"
	lang E, cont "friendship with"
	lang E, cont "TEAM <ROCKET>!"
	
	lang E, para "TM21, FRUSTRATION."
	lang E, line "Just for you!"
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM21."	
	
	; German
	lang D, text "Hier ist ein Ge-"
	lang D, line "schenk, um deine"
	lang D, cont "Freundschaft mit"
	lang D, cont "TEAM <ROCKET>"
	lang D, cont "zu feiern!"
	
	lang D, para "TM21, FRUSTRATION."
	lang D, line "Genau das Richtige"
	lang D, cont "für dich!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM21."	
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result3textM
.result3textF
	; Japanese
	lang J, text "キミは　エリートトレーナー　タイプ！"
	lang J, line "ポケモンも　だいじに　しているし"
	lang J, cont "しょうぶ　にも　つよい　みたいだし"
	
	lang J, para "なんでも　しっている　キミは"
	lang J, line "きっと　ともだちからも"
	lang J, cont "そんけい　されて　いるんだろうね！"
	
	; English
	lang E, text "You're a"
	lang E, line "COOLTRAINER!"
	
	lang E, para "You take great"
	lang E, line "care of your"
	lang E, cont "#MON, and you"
	lang E, cont "seem strong in"
	lang E, cont "battle too."
	
	lang E, para "You know so much,"
	lang E, line "your friends must"
	lang E, cont "really look up to"
	lang E, cont "you!"
	
	; German
	lang D, text "Du bist ein"
	lang D, line "ASS-TRAINER!"
	
	lang D, para "Du kümmerst dich"
	lang D, line "beispielhaft um"
	lang D, cont "deine #MON"
	lang D, cont "und scheinst auch"
	lang D, cont "gut in Kämpfen"
	lang D, cont "zu sein."
	
	lang D, para "Du weißt so viel,"
	lang D, line "dass du sicher ein"
	lang D, cont "Vorbild für deine"
	lang D, cont "Freunde bist!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result3text_gift
	; Japanese
	lang J, text "キミが　さらに　ゆうりに"
	lang J, line "しょうぶが　できる　ように"
	lang J, cont "ポイントアップを　あげるよ！"
	lang J, para "ポイントアップを　もらった！"
	
	; English
	lang E, text "To help give you"
	lang E, line "an even bigger"
	lang E, cont "edge in battle,"	
	lang E, cont "take this PP UP!"
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "PP UP."	
	
	; German
	lang D, text "Damit du noch mehr"
	lang D, line "Vorteile im Kampf"
	lang D, cont "hast, nimm dieses"
	lang D, cont "AP-PLUS!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "AP-PLUS."

	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result4textM
	; NOTE: speculative
	; Japanese
	lang J, text "キミは　キャンプボーイ　タイプ！"
	lang J, line "おんなのこ　なら　ピクニックガール！";よ
	
	lang J, para "ポケモンとの　ぼうけんを　とても"
	lang J, line "たのしめる　ひと　なのね！"
	
	lang J, para "キミと　いっしょに　たびを　している"
	lang J, line "ポケモンも　きっと　すごく"
	lang J, cont "たのしいって　おもって　いるはずよ！"
	
	; English
	lang E, text "You're a CAMPER!"
	lang E, line "If you were a"
	lang E, cont "girl, you'd be a"
	lang E, cont "PICKNICKER!"
	
	lang E, para "You really enjoy"
	lang E, line "adventuring with"
	lang E, cont "your #MON!"
	
	lang E, para "Your #MON must"
	lang E, line "have a great time"
	lang E, cont "traveling with"
	lang E, cont "you!"
	
	; German
	lang D, text "Du bist wie ein"
	lang D, line "CAMPER! Als"
	lang D, cont "Mädchen wäre das"
	lang D, cont "ein PICKNICKER!"
	
	lang D, para "Du hast wirklich"
	lang D, line "Spaß dabei, mit"
	lang D, cont "deinen #MON"
	lang D, cont "Abenteuer zu"
	lang D, cont "erleben!"
	
	lang D, para "Deine #MON sind"
	lang D, line "sicher glücklich,"
	lang D, cont "mit dir zusammen"
	lang D, cont "zu reisen!"

	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
.result4textF
	; Japanese
	lang J, text "キミは　ピクニックガール　タイプ！"
	lang J, line "おとこのこ　なら　キャンプボーイよ！"
	
	lang J, para "ポケモンとの　ぼうけんを　とても"
	lang J, line "たのしめる　ひと　なのね！"
	
	lang J, para "キミと　いっしょに　たびを　している"
	lang J, line "ポケモンも　きっと　すごく"
	lang J, cont "たのしいって　おもって　いるはずよ！"
	
	; English
	lang E, text "You're a PICNICKER!"
	lang E, line "If you were a boy,"
	lang E, cont "you'd be a CAMPER!"
	
	lang E, para "You really enjoy"
	lang E, line "adventuring with"
	lang E, cont "your #MON!"
	
	lang E, para "Your #MON must"
	lang E, line "have a great time"
	lang E, cont "traveling with"
	lang E, cont "you!"
	
	; German
	lang D, text "Du bist wie ein"
	lang D, line "PICKNICKER! Als"
	lang D, cont "Junge wäre das"
	lang D, cont "ein CAMPER!"

	lang D, para "Du hast wirklich"
	lang D, line "Spaß dabei, mit"
	lang D, cont "deinen #MON"
	lang D, cont "Abenteuer zu"
	lang D, cont "erleben!"
	
	lang D, para "Deine #MON sind"
	lang D, line "sicher glücklich,"
	lang D, cont "mit dir zusammen"
	lang D, cont "zu reisen!"

	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.result4text_gift
	; Japanese
	lang J, text "それと　プレゼントを　あげちゃうわ！"
	lang J, line "ぎんのこな　よ！"
	lang J, cont "これからも　がんばってね！"
	lang J, para "ぎんのこなを　もらった！"
	
	; English
	lang E, text "Also, here's"
	lang E, line "a gift for you!"
	
	lang E, para "It's SILVERPOWDER!"
	lang E, line "Keep up the great"
	lang E, cont "work from here on"
	lang E, cont "out!"
	
	lang E, para ""
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "SILVERPOWDER."	
	
	; German
	lang D, text "Hier ist noch ein"
	lang D, line "Geschenk für dich!"
	
	lang D, para "Es ist"
	lang D, line "SILBERSTAUB!"
	lang D, cont "Mach weiter so!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "SILBERSTAUB."	
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result5textM
.result5textF
	; Japanese
	lang J, text "ウッス！"
	lang J, line "きみは　からておう　タイプッス！"
	
	lang J, para "その　だいたんな　たたかいっぷり"
	lang J, line "すごく　かっこいいッス！"
	
	lang J, para "これからも　がんがん"
	lang J, line "あせくさい　しょうぶを　して"
	lang J, cont "つよく　なって　くださいッス！"
	
	; English
	lang E, text "Grunt!"
	lang E, line "You're the"
	lang E, cont "BLACKBELT type!"
	
	lang E, para "Your bold fighting"
	lang E, line "style is seriously"
	lang E, cont "cool!"
	
	lang E, para "Keep charging into"
	lang E, line "battle and get"
	lang E, cont "even stronger!"
	
	; German
	lang D, text "Hu-ha!"
	lang D, line "Du bist wie ein"
	lang D, cont "SCHWARZGURT!"
	
	lang D, para "Dein kühner Kampf-"
	lang D, line "stil ist wahrlich"
	lang D, cont "cool!"
	
	lang D, para "Bleib dabei, dich"
	lang D, line "schweißtreibenden"
	lang D, cont "Kämpfen auszu-"
	lang D, cont "setzen und werde"
	lang D, cont "noch stärker!"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.result5text_gift
	; Japanese
	lang J, text "わざマシン２０　あげるッス！"
	lang J, line "こらえるッス！　カンバレッス！"
	lang J, para "わざマシン２０を　もらった！"
	
	; English
	lang E, text "You can have TM20!"
	lang E, line "It teaches ENDURE!"
	lang E, cont "Hang in there!"
	
	lang E, para ""
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM20."	
	
	; German
	lang D, text "Dir wird die TM20"
	lang D, line "verliehen! Sie"
	lang D, line "lehrt AUSDAUER!"
	lang D, cont "Gib dein Bestes!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM20."	
		
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result6textM
.result6textF
	; Japanese
	lang J, text "…オマエの　トレーナータイプは…"
	lang J, line "はぐれけんきゅういん…"
	
	lang J, para "オマエ　まわりから　いつも"
	lang J, line "ヘンな　やつって　いわれてるだろ…"
	
	lang J, para "きにするな　いわせておけば　いいのさ"
	lang J, line "そして　なんと　いわれようが"
	lang J, cont "すきな　こに　ふられようが"
	lang J, cont "そのまま　じぶんを　つらぬいてくれ…"
	
	; NOTE: this text works better with the JP name
	;       of this class, "researcher gone astray"
	; English
	lang E, text "Your <TRAINER> type"
	lang E, line "is SCIENTIST…"

	lang E, para "People probably"
	lang E, line "call you weird"
	lang E, cont "sometimes."

	lang E, para "Don't let it"
	lang E, line "bother you."
	lang E, cont "Let them talk."

	lang E, para "No matter what"
	lang E, line "anyone says-"

	lang E, para "even if your"
	lang E, line "crush rejects you,"

	lang E, para "stay true to"
	lang E, line "yourself…"
	
	; German
	lang D, text "Dein <TRAINER>-Typ"
	lang D, line "lautet FORSCHERIN…"

	lang D, para "Manchmal hält man"
	lang D, line "dich vielleicht"
	lang D, cont "für sonderbar."

	lang D, para "Störe dich aber"
	lang D, line "nicht daran."
	lang D, cont "Lass sie reden."

	lang D, para "Egal, was irgend-"
	lang D, line "wer sagt…"

	lang D, para "Und selbst wenn"
	lang D, line "dein Schwarm dir"
	lang D, cont "einen Korb gibt…"

	lang D, para "Bleib einfach"
	lang D, line "du selbst…"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
.result6text_gift
	; Japanese
	lang J, text "きれいな　ひかりのこなを　やるから"
	lang J, line "これでも　みて　オマエの　こどくを"
	lang J, cont "まぎらわせたら　いいさ…"
	lang J, para "ひかりのこなを　もらった！"
	
	; English
	lang E, text "Here, take this"
	lang E, line "BRIGHTPOWDER."
	
	lang E, para "Try using it to"
	lang E, line "distract you from"
	lang E, cont "your loneliness…"
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "BRIGHTPOWDER."	
	
	; German
	lang D, text "Hier, nimm dieses"
	lang D, line "BLENDPUDER."
	
	lang D, para "Nutze es, um dich"
	lang D, line "von deiner Einsam-"
	lang D, cont "keit abzulenken…"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "BLENDPUDER."	
		
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
ENDC
