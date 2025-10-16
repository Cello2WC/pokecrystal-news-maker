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
	lang_text J, "トレーナーしんだんを　はじめます！"
	lang_para J, "さいしょの　１かい　だけ　しんだんが"
	lang_line J, "おわると　プレゼントが　もらえます！"
	lang_para J, "けっかに　よって　プレゼントが"
	lang_line J, "ちがうので　きをつけてね！"
	lang_para J, "それでは　スタート！"
	
	; English
	lang_text E, "Starting your"
	lang_line E, "<TRAINER> CHECKUP!"

	lang_para E, "You'll only get"
	lang_line E, "a gift after your"
	lang_cont E, "first checkup!"
	
	lang_para E, "The gift differs"
	lang_line E, "based on your"
	lang_cont E, "results, so be"
	lang_cont E, "careful!"
	
	lang_para E, "Alright, let's"
	lang_line E, "get started!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done
	
ENDM

MACRO minigame_name
	; Japanese
	lang J, "<TRAINER> しんだん！"
	; English
	lang E, "<TRAINER> CHECKUP!"
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
	news_screen PersonalityTest, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box 0, 14, 20,  4, NEWSBORDER_GLOWY,  4
	
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
	lang J, "はい"
	lang E, "YES"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuItemAnswer2Text
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
	lang      J, "ポケモンを　つかまえたら"
	lang_next J, "かならず　ニックネームを　つける"
	
	; English
	lang      E, "Whenever I catch"
	lang_next E, "a #MON,"
	lang_next E, "I always give it a"
	lang_next E, "nickname."	
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page2
	; Japanese
	lang      J, "ポケモンの　なまえを　よぶときは"
	lang_next J, "「ちゃん」を　つけて　よんでしまう"
	
	; English
	lang      E, "When I call my"
	lang_next E, "#MON's name,"
	lang_next E, "I always end up"
	lang_next E, "adding “darling”."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page3
	; Japanese
	lang      J, "ポケモンに　おぼえさせる　わざは"
	lang_next J, "ポケモンの　イメージに　あっていれば"
	lang_next J, "つよく　なくても　きにしない"
	
	; English
	lang      E, "As long as a move"
	lang_next E, "matches my"
	lang_next E, "#MON's image,"
	lang_next E, "I don't care if"
	lang_next E, "it's not strong."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page4
	; Japanese
	lang      J, "すきな　ポケモンは　よわくても"
	lang_next J, "１０ひき　いじょう　あつめてしまう"
	
	; English
	lang      E, "I'll collect more"
	lang_next E, "than ten of my"
	lang_next E, "favorite #MON,"
	lang_next E, "even if they're"
	lang_next E, "weak."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page5
	; Japanese
	lang      J, "こうげきが　つよければ"
	lang_next J, "ぼうぎょは　あまり　きにしない"
	
	; English
	lang      E, "If a #MON has"
	lang_next E, "high attack,"
	lang_next E, "I don't care"
	lang_next E, "much for defense."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page6
	; Japanese
	lang      J, "じぶんより　よわい　あいてに"
	lang_next J, "かつと　きもちがいい？"
	
	; English
	lang      E, "Does it feel good"
	lang_next E, "to win against an"
	lang_next E, "opponent weaker"
	lang_next E, "than me?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page7
	; Japanese
	lang      J, "だいじに　そだてた　ポケモンでも"
	lang_next J, "たかい　おかねでなら　うってもいい"
	
	; English
	lang      E, "I'd sell even the"
	lang_next E, "#MON I've"
	lang_next E, "raised with care"
	lang_next E, "if the price was"
	lang_next E, "high enough."		
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page8
	; Japanese
	lang      J, "わざマシンの　わざの　しゅるいを"
	lang_next J, "なにも　みないで"
	lang_next J, "３０こ　いじょう　いえる"
	
	; English
	lang      E, "I can name thirty"
	lang_next E, "or more different"
	lang_next E, "kinds of TM moves"	
	lang_next E, "without looking."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page9
	; Japanese
	lang      J, "てにいれた　わざマシンは"
	lang_next J, "そのとき　もっている　ポケモンに"
	lang_next J, "すぐに　つかってしまう"
	
	; English
	lang      E, "When I get a TM,"
	lang_next E, "I teach it to"
	lang_next E, "my #MON right" 
	lang_next E, "away!"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page10
	; Japanese
	lang      J, "いつも　くすりは　おおめに"
	lang_next J, "もちあるく　ように　している"
	
	; English
	lang      E, "I always try to"
	lang_next E, "carry plenty of"
	lang_next E, "medicine with me."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page11
	; Japanese
	lang      J, "すきな　どうぐは　やっぱり"
	lang_next J, "きせきのみ　より　きあいのハチマキ！"
	
	; English
	lang      E, "When it comes to"
	lang_next E, "items, I prefer"
	lang_next E, "a FOCUS BAND over"
	lang_next E, "a MIRACLEBERRY!"	
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page12
	; Japanese
	lang      J, "たいりょくが　あと　すこし　でも"
	lang_next J, "つぎの　こうげきで　かてそうなら"
	lang_next J, "かいふくは　しない"
	
	; English
	lang      E, "Even if my #MON"
	lang_next E, "has low HP,"
	lang_next E, "I won't heal if"
	lang_next E, "I think I can win"
	lang_next E, "next turn."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page13
	; Japanese
	lang      J, "ともだちが　あまり　つかわないような"
	lang_next J, "ポケモンを　つかうのが　だいすきだ"
	
	; English
	lang      E, "I love using"
	lang_next E, "#MON that my"
	lang_next E, "friends don't"
	lang_next E, "often use."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page14
	; Japanese
	lang      J, "しらない　まちに　ついたら　まずは"
	lang_next J, "ポケモンセンターで　かいふくする"
	
	; English
	lang      E, "When I arrive in"
	lang_next E, "a new town, the"
	lang_next E, "first thing I do"
	lang_next E, "is heal at a"	
	lang_next E, "#MON CENTER."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page15
	; Japanese
	lang      J, "どうくつの　なかを　たんけんするより"
	lang_next J, "へやで　ゆっくり　さくせんを"
	lang_next J, "ねる　ほうが　すきだ"
	
	; English
	lang      E, "I'd rather plan"
	lang_next E, "strategies in my"
	lang_next E, "room than go out"
	lang_next E, "exploring caves."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page16
	; Japanese
	lang      J, "パソコンの　ボックスに"
	lang_next J, "あずけてある　ポケモンは"
	lang_next J, "きれいに　せいり　している"
	
	; English
	lang      E, "The #MON"
	lang_next E, "stored in my PC"
	lang_next E, "BOXES are all"
	lang_next E, "neatly organized."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

	
	
	
	
	
	news_screen PersonalityTestResults, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, NEWSBORDER_GLOWY,    4
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
	nsc_giveitem \3, .result\1gotGift, .result\1noGift
.result\1gotGift
IF STRCMP(STRSLICE("{\3}", 0, 3), "TM_") == 0
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
	
	
	
	
	
	
	
	
;	nsc_waitbutton
;	nsc_page NewsRoot
;	nsc_ret
	
.menuItemText
	lang J, "？"
	; Guess
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang E, "'s RESULTS"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
.menuItemDesc
	db "@"
	
;.menuItemScript
;	nsc_compare wPersonalityPage, .result1, .result2, .greater, 1, 1
;.greater
;	nsc_compare wPersonalityPage, .result3, .result4, .greater2, 1, 3
;.greater2
;	nsc_compare wPersonalityPage, .result5, .result6, .result6, 1, 5
	

	
	
.result1textM
.result1textF
	; Japanese
	lang_text J, "あなたの　トレーナータイプは"
	lang_line J, "だいすきクラブ　ですわ！"
	
	lang_para J, "ポケモンちゃんを　おかしいほど"
	lang_line J, "あいする　あなたの　おきもち"
	lang_cont J, "しかと　つたわって　きましたわ！"
	
	lang_para J, "しょうぶに　まけても　かわいい"
	lang_line J, "ポケモンちゃんを　もっている"
	lang_cont J, "ほうが　かちよ！　わすれないでネ！"
	
	; English
	lang_text E, "Your <TRAINER> type"
	lang_line E, "is #FAN!"
	
	lang_para E, "Your feelings of"
	lang_line E, "adoration for your"
	lang_cont E, "#MON are clear!"
	
	lang_para E, "Even if you lose"
	lang_line E, "in battle, having"
	lang_cont E, "cute #MON is"
	lang_cont E, "still a win! Don't"
	lang_cont E, "forget that!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

	
.result1text_gift
	lang_text J, "あなたの　ポケモンちゃんには"
	lang_line J, "この　わざマシン２７　おんがえしが"
	lang_cont J, "ぴったり！　つかって　くださいな！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "This TM27, RETURN,"
	lang_line E, "will be perfect"
	lang_cont E, "for your #MON!"
	lang_cont E, "Please use it!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM27."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result2textM
.result2textF
	; Japanese
	lang_text J, "アナタは　ロケットだんに"
	lang_line J, "ふさわしい　タイプ　みたいよ！"
	
	lang_para J, "なんというか　アナタ　じぶんの"
	lang_line J, "ことしか　かんがえて　ないのね！"
	
	lang_para J, "いつも　そんな　わがままだと"
	lang_line J, "しゅっせ　できないんじゃないの？"
	lang_para J, "まあ　しょうらい　きがむいたら"
	lang_line J, "ロケットだんに　いらっしゃい！"
	
	; English
	lang_text E, "You seem like the"
	lang_line E, "perfect type for"
	lang_cont E, "TEAM <ROCKET>!"
	
	lang_para E, "I mean, you only"
	lang_line E, "ever think about"
	lang_cont E, "yourself, huh?"
	
	lang_para E, "If you're always"
	lang_line E, "so selfish, you "
	lang_cont E, "won't get far!"
	
	lang_para E, "Well, if you ever"
	lang_line E, "change your mind,"
	lang_para E, "come join"
	lang_line E, "TEAM <ROCKET>!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.result2text_gift
	; Japanese
	lang_text J, "ロケットだんとの　おちかづきの"
	lang_line J, "きねんひんを　アナタにあげるわ！"
	lang_cont J, "わざマシン２１　やつあたりよ！"
	
	; English
	lang_text E, "Here's a gift to"
	lang_line E, "celebrate your new"
	lang_cont E, "friendship with"
	lang_cont E, "TEAM <ROCKET>!"
	
	lang_para E, "TM21, FRUSTRATION."
	lang_line E, "Just for you!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM21."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result3textM
.result3textF
	; Japanese
	lang_text J, "キミは　エリートトレーナー　タイプ！"
	lang_line J, "ポケモンも　だいじに　しているし"
	lang_cont J, "しょうぶ　にも　つよい　みたいだし"
	
	lang_para J, "なんでも　しっている　キミは"
	lang_line J, "きっと　ともだちからも"
	lang_cont J, "そんけい　されて　いるんだろうね！"
	
	; English
	lang_text E, "You're a"
	lang_line E, "COOLTRAINER!"
	
	lang_para E, "You take great"
	lang_line E, "care of your"
	lang_cont E, "#MON, and you"
	lang_cont E, "seem strong in"
	lang_cont E, "battle too."
	
	lang_para E, "You know so much,"
	lang_line E, "your friends must"
	lang_cont E, "really look up to"
	lang_cont E, "you!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result3text_gift
	; Japanese
	lang_text J, "キミが　さらに　ゆうりに"
	lang_line J, "しょうぶが　できる　ように"
	lang_cont J, "ポイントアップを　あげるよ！"
	
	; English
	lang_text E, "To help give you"
	lang_line E, "an even bigger"
	lang_cont E, "edge in battle,"	
	lang_cont E, "take this PP UP!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "PP UP."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result4textM
	; NOTE: speculative
	; Japanese
	lang_text J, "キミは　キャンプボーイ　タイプ！"
	lang_line J, "おんなのこ　なら　ピクニックガール！";よ
	
	lang_para J, "ポケモンとの　ぼうけんを　とても"
	lang_line J, "たのしめる　ひと　なのね！"
	
	lang_para J, "キミと　いっしょに　たびを　している"
	lang_line J, "ポケモンも　きっと　すごく"
	lang_cont J, "たのしいって　おもって　いるはずよ！"
	
	; English
	lang_text E, "You're a CAMPER!"
	lang_line E, "If you were a"
	lang_cont E, "girl, you'd be a"
	lang_cont E, "PICKNICKER!"
	
	lang_para E, "You really enjoy"
	lang_line E, "adventuring with"
	lang_cont E, "your #MON!"
	
	lang_para E, "Your #MON must"
	lang_line E, "have a great time"
	lang_cont E, "traveling with"
	lang_cont E, "you!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
.result4textF
	; Japanese
	lang_text J, "キミは　ピクニックガール　タイプ！"
	lang_line J, "おとこのこ　なら　キャンプボーイよ！"
	
	lang_para J, "ポケモンとの　ぼうけんを　とても"
	lang_line J, "たのしめる　ひと　なのね！"
	
	lang_para J, "キミと　いっしょに　たびを　している"
	lang_line J, "ポケモンも　きっと　すごく"
	lang_cont J, "たのしいって　おもって　いるはずよ！"
	
	; English
	lang_text E, "You're a PICNICKER!"
	lang_line E, "If you were a boy,"
	lang_cont E, "you'd be a CAMPER!"
	
	lang_para E, "You really enjoy"
	lang_line E, "adventuring with"
	lang_cont E, "your #MON!"
	
	lang_para E, "Your #MON must"
	lang_line E, "have a great time"
	lang_cont E, "traveling with"
	lang_cont E, "you!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.result4text_gift
	; Japanese
	lang_text J, "それと　プレゼントを　あげちゃうわ！"
	lang_line J, "ぎんのこな　よ！"
	lang_cont J, "これからも　がんばってね！"
	
	; English
	lang_text E, "Also, here's"
	lang_line E, "a gift for you!"
	
	lang_para E, "It's SILVERPOWDER!"
	lang_line E, "Keep up the great"
	lang_cont E, "work from here on"
	lang_cont E, "out!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "SILVERPOWDER."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result5textM
.result5textF
	; Japanese
	lang_text J, "ウッス！"
	lang_line J, "きみは　からておう　タイプッス！"
	
	lang_para J, "その　だいたんな　たたかいっぷり"
	lang_line J, "すごく　かっこいいッス！"
	
	lang_para J, "これからも　がんがん"
	lang_line J, "あせくさい　しょうぶを　して"
	lang_cont J, "つよく　なって　くださいッス！"
	
	; English
	lang_text E, "Grunt!"
	lang_line E, "You're the"
	lang_cont E, "BLACKBELT type!"
	
	lang_para E, "Your bold fighting"
	lang_line E, "style is seriously"
	lang_cont E, "cool!"
	
	lang_para E, "Keep charging into"
	lang_line E, "battle and get"
	lang_cont E, "even stronger!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.result5text_gift
	; Japanese
	lang_text J, "わざマシン２０　あげるッス！"
	lang_line J, "こらえるッス！　カンバレッス！"
	
	; English
	lang_text E, "You can have TM20!"
	lang_line E, "It teaches ENDURE!"
	lang_cont E, "Hang in there!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM20."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result6textM
.result6textF
	; Japanese
	lang_text J, "…オマエの　トレーナータイプは…"
	lang_line J, "はぐれけんきゅういん…"
	
	lang_para J, "オマエ　まわりから　いつも"
	lang_line J, "ヘンな　やつって　いわれてるだろ…"
	
	lang_para J, "きにするな　いわせておけば　いいのさ"
	lang_line J, "そして　なんと　いわれようが"
	lang_cont J, "すきな　こに　ふられようが"
	lang_cont J, "そのまま　じぶんを　つらぬいてくれ…"
	
	; NOTE: this text works better with the JP name
	;       of this class, "researcher gone astray"
	; English
	lang_text E, "Your <TRAINER> type"
	lang_line E, "is SCIENTIST…"

	lang_para E, "People probably"
	lang_line E, "call you weird"
	lang_cont E, "sometimes."

	lang_para E, "Don't let it"
	lang_line E, "bother you."
	lang_cont E, "Let them talk."

	lang_para E, "No matter what"
	lang_line E, "anyone says-"

	lang_para E, "even if your"
	lang_line E, "crush rejects you,"

	lang_para E, "stay true to"
	lang_line E, "yourself…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result6text_gift
	; Japanese
	lang_text J, "きれいな　ひかりのこなを　やるから"
	lang_line J, "これでも　みて　オマエの　こどくを"
	lang_cont J, "まぎらわせたら　いいさ…"
	
	; English
	lang_text E, "Here, take this"
	lang_line E, "BRIGHTPOWDER."
	
	lang_para E, "Try using it to"
	lang_line E, "distract you from"
	lang_cont E, "your loneliness…"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BRIGHTPOWDER."	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
ENDC
