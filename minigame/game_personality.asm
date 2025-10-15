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
	lang_text J, "トレーナーしんだんを　はじめます！"
	lang_para J, "さいしょの　１かい　だけ　しんだんが"
	lang_line J, "おわると　プレゼントが　もらえます！"
	lang_para J, "けっかに　よって　プレゼントが"
	lang_line J, "ちがうので　きをつけてね！"
	lang_para J, "それでは　スタート！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Starting the"
	lang_line E, "<TRAINER> CHECK!"
	lang_para E, "Only your very"
	lang_line E, "first check"
	lang_cont E, "will earn you"
	lang_cont E, "a gift!"
	lang_para E, "You'll get a diff-"
	lang_line E, "erent gift based"
	lang_cont E, "on your answers,"
	lang_cont E, "so be careful!"
	lang_para E, "So, let's start!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"

	done
	
ENDM

MACRO minigame_name
	lang J, "トレーナー　しんだん！"
	lang E, "<TRAINER> CHECK!"
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
	lang      J, "ポケモンを　つかまえたら"
	lang_next J, "かならず　ニックネームを　つける"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You always nick-"
	lang_next E, "name your #MON."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page2
	lang      J, "ポケモンの　なまえを　よぶときは"
	lang_next J, "「ちゃん」を　つけて　よんでしまう"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "When calling your"
	lang_next E, "#MON's name, you"
	lang_next E, "always end up"
	lang_next E, "adding “-chan”."
	lang_next E, "(plz localize…)"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page3
	lang      J, "ポケモンに　おぼえさせる　わざは"
	lang_next J, "ポケモンの　イメージに　あっていれば"
	lang_next J, "つよく　なくても　きにしない"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "It's OK if your"
	lang_next E, "#MON's moves"
	lang_next E, "aren't strong, as"
	lang_next E, "long as they fit"
	lang_next E, "your #MON's"
	lang_next E, "image."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page4
	lang      J, "すきな　ポケモンは　よわくても"
	lang_next J, "１０ひき　いじょう　あつめてしまう"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "Even if they're"
	lang_next E, "weak, you'd catch"
	lang_next E, "over 10 of your"
	lang_next E, "favorite #MON."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page5
	lang      J, "こうげきが　つよければ"
	lang_next J, "ぼうぎょは　あまり　きにしない"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "If an attack is"
	lang_next E, "strong, you don't"
	lang_next E, "care too much"
	lang_next E, "about DEFENSE."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page6
	lang      J, "じぶんより　よわい　あいてに"
	lang_next J, "かつと　きもちがいい？"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You enjoy beating"
	lang_next E, "<TRAINER>S weaker"
	lang_next E, "than yourself."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page7
	lang      J, "だいじに　そだてた　ポケモンでも"
	lang_next J, "たかい　おかねでなら　うってもいい"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You'd sell any of"
	lang_next E, "your #MON, for"
	lang_next E, "the right price."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page8
	lang      J, "わざマシンの　わざの　しゅるいを"
	lang_next J, "なにも　みないで"
	lang_next J, "３０こ　いじょう　いえる"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You could name the"
	lang_next E, "MOVES on at least"
	lang_next E, "30 TMs, without"
	lang_next E, "looking."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page9
	lang      J, "てにいれた　わざマシンは"
	lang_next J, "そのとき　もっている　ポケモンに"
	lang_next J, "すぐに　つかってしまう"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "When you get a TM,"
	lang_next E, "you teach it"
	lang_next E, "to a #MON"
	lang_next E, "immediately."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page10
	lang      J, "いつも　くすりは　おおめに"
	lang_next J, "もちあるく　ように　している"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You always carry"
	lang_next E, "plenty of healing"
	lang_next E, "items."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page11
	lang      J, "すきな　どうぐは　やっぱり"
	lang_next J, "きせきのみ　より　きあいのハチマキ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You prefer the"
	lang_next E, "FOCUS BAND over"
	lang_next E, "the MIRACLEBERRY"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page12
	lang      J, "たいりょくが　あと　すこし　でも"
	lang_next J, "つぎの　こうげきで　かてそうなら"
	lang_next J, "かいふくは　しない"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "If you have just"
	lang_next E, "enough HP to win"
	lang_next E, "with your next"
	lang_next E, "attack, you won't"
	lang_next E, "heal."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page13
	lang      J, "ともだちが　あまり　つかわないような"
	lang_next J, "ポケモンを　つかうのが　だいすきだ"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You prefer using"
	lang_next E, "#MON that your"
	lang_next E, "friends don't use."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page14
	lang      J, "しらない　まちに　ついたら　まずは"
	lang_next J, "ポケモンセンターで　かいふくする"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "When first reach-"
	lang_next E, "ing a new town,"
	lang_next E, "you immediately"
	lang_next E, "heal at the"
	lang_next E, "#MON CENTER."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page15
	lang      J, "どうくつの　なかを　たんけんするより"
	lang_next J, "へやで　ゆっくり　さくせんを"
	lang_next J, "ねる　ほうが　すきだ"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "You'd rather strat-"
	lang_next E, "egize in your room"
	lang_next E, "than explore"
	lang_next E, "a cave."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"

.page16
	lang      J, "パソコンの　ボックスに"
	lang_next J, "あずけてある　ポケモンは"
	lang_next J, "きれいに　せいり　している"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang      E, "Your PC BOXES are"
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
	
	news_menu  6, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	
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
	lang E, "RESULTS"
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
	lang_text J, "あなたの　トレーナータイプは"
	lang_line J, "だいすきクラブ　ですわ！"
	lang_para J, "ポケモンちゃんを　おかしいほど"
	lang_line J, "あいする　あなたの　おきもち"
	lang_cont J, "しかと　つたわって　きましたわ！"
	lang_para J, "しょうぶに　まけても　かわいい"
	lang_line J, "ポケモンちゃんを　もっている"
	lang_cont J, "ほうが　かちよ！　わすれないでネ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Your <TRAINER> CLASS"
	lang_line E, "is #FAN!"
	lang_para E, "Your feelings for"
	lang_line E, "you #MON, which"
	lang_cont E, "you love to an"
	lang_cont E, "absurd degree,"
	lang_para E, "have come through"
	lang_line E, "loud and clear!"
	lang_para E, "Even if you lose"
	lang_line E, "in battle, it's"
	lang_cont E, "having a cute"
	lang_cont E, "#MON that's the"
	lang_cont E, "real victory!"
	lang_cont E, "Don't forget that!"
	
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
	lang_text E, "This TM27, RETURN"
	lang_line E, "will be perfect"
	lang_cont E, "for your #MON!"
	lang_cont E, "Please use it!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result2textM
.result2textF
	lang_text J, "アナタは　ロケットだんに"
	lang_line J, "ふさわしい　タイプ　みたいよ！"
	lang_para J, "なんというか　アナタ　じぶんの"
	lang_line J, "ことしか　かんがえて　ないのね！"
	lang_para J, "いつも　そんな　わがままだと"
	lang_line J, "しゅっせ　できないんじゃないの？"
	lang_para J, "まあ　しょうらい　きがむいたら"
	lang_line J, "ロケットだんに　いらっしゃい！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You seem like the"
	lang_line E, "perfect type for"
	lang_cont E, "TEAM <ROCKET>!"
	lang_para E, "How do I put this…"
	lang_para E, "You only really"
	lang_line E, "care about"
	lang_cont E, "yourself!"
	lang_para E, "But if you're"
	lang_line E, "always so selfish,"
	lang_cont E, "will you ever"
	lang_cont E, "really succeed…?"
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
	lang_text J, "ロケットだんとの　おちかづきの"
	lang_line J, "きねんひんを　アナタにあげるわ！"
	lang_cont J, "わざマシン２１　やつあたりよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "For your closeness"
	lang_line E, "to TEAM <ROCKET>,"
	lang_cont E, "Here's a gift!"
	lang_para E, "It's TM21,"
	lang_line E, "FRUSTRATION!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result3textM
.result3textF
	lang_text J, "キミは　エリートトレーナー　タイプ！"
	lang_line J, "ポケモンも　だいじに　しているし"
	lang_cont J, "しょうぶ　にも　つよい　みたいだし"
	lang_para J, "なんでも　しっている　キミは"
	lang_line J, "きっと　ともだちからも"
	lang_cont J, "そんけい　されて　いるんだろうね！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You're a"
	lang_line E, "COOLTRAINER!"
	lang_para E, "You treat your"
	lang_line E, "#MON well, and"
	lang_cont E, "you're strong in"
	lang_cont E, "battle, too!"
	lang_para E, "Knowing everything"
	lang_line E, "like you do…"
	lang_para E, "Your friends must"
	lang_line E, "respect you a lot!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result3text_gift
	lang_text J, "キミが　さらに　ゆうりに"
	lang_line J, "しょうぶが　できる　ように"
	lang_cont J, "ポイントアップを　あげるよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "To help you fight"
	lang_line E, "even better,"
	lang_cont E, "here's a PP UP!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result4textM
	; NOTE: speculative
	lang_text J, "キミは　キャンプボーイ　タイプ！"
	lang_line J, "おんなのこ　なら　ピクニックガール！";よ
	lang_para J, "ポケモンとの　ぼうけんを　とても"
	lang_line J, "たのしめる　ひと　なのね！"
	lang_para J, "キミと　いっしょに　たびを　している"
	lang_line J, "ポケモンも　きっと　すごく"
	lang_cont J, "たのしいって　おもって　いるはずよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "You're a CAMPER!"
	lang_line E, "If you were a girl,"
	lang_cont E, "You'd be a"
	lang_cont E, "PICNICKER!"
	lang_para E, "You're the sort who"
	lang_line E, "really likes to go"
	lang_cont E, "on adventures with"
	lang_cont E, "your #MON!"
	lang_para E, "Your #MON com-"
	lang_line E, "panions must be"
	lang_cont E, "having a blast,"
	lang_cont E, "too!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
.result4textF
	lang_text J, "キミは　ピクニックガール　タイプ！"
	lang_line J, "おとこのこ　なら　キャンプボーイよ！"
	lang_para J, "ポケモンとの　ぼうけんを　とても"
	lang_line J, "たのしめる　ひと　なのね！"
	lang_para J, "キミと　いっしょに　たびを　している"
	lang_line J, "ポケモンも　きっと　すごく"
	lang_cont J, "たのしいって　おもって　いるはずよ！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	
	lang_text E, "You're a PICNICKER!"
	lang_line E, "If you were a boy,"
	lang_cont E, "You'd be a CAMPER!"
	lang_para E, "You're the sort who"
	lang_line E, "really likes to go"
	lang_cont E, "on adventures with"
	lang_cont E, "your #MON!"
	lang_para E, "Your #MON com-"
	lang_line E, "panions must be"
	lang_cont E, "having a blast,"
	lang_cont E, "too!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.result4text_gift
	lang_text J, "それと　プレゼントを　あげちゃうわ！"
	lang_line J, "ぎんのこな　よ！"
	lang_cont J, "これからも　がんばってね！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Also, here's"
	lang_line E, "a gift!"
	lang_para E, "It's SILVERPOWDER!"
	lang_para E, "Keep up the"
	lang_line E, "great work!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result5textM
.result5textF
	lang_text J, "ウッス！"
	lang_line J, "きみは　からておう　タイプッス！"
	lang_para J, "その　だいたんな　たたかいっぷり"
	lang_line J, "すごく　かっこいいッス！"
	lang_para J, "これからも　がんがん"
	lang_line J, "あせくさい　しょうぶを　して"
	lang_cont J, "つよく　なって　くださいッス！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Grunt!"
	lang_line E, "You're a BLACKBELT!"
	lang_para E, "Your fighting spir-"
	lang_line E, "it is super cool!"
	lang_para E, "Keep going strong,"
	lang_line E, "fighting hard,"
	lang_cont E, "and toughing up!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

.result5text_gift
	lang_text J, "わざマシン２０　あげるッス！"
	lang_line J, "こらえるッス！　カンバレッス！"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Take this TM20!"
	lang_line E, "Hang in there!"
	lang_cont E, "Do your best!"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result6textM
.result6textF
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
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Your <TRAINER> CLASS"
	lang_line E, "is… the SCIENTIST…"
	lang_para E, "People always say"
	lang_line E, "you're a weirdo,"
	lang_cont E, "right…?"
	lang_para E, "Don't worry about"
	lang_line E, "it. Let them talk."
	lang_para E, "And no matter what"
	lang_line E, "they say,"
	lang_para E, "No matter if your"
	lang_line E, "crush rejects you,"
	lang_para E, "just stay true"
	lang_line E, "to yourself…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
.result6text_gift
	lang_text J, "きれいな　ひかりのこなを　やるから"
	lang_line J, "これでも　みて　オマエの　こどくを"
	lang_cont J, "まぎらわせたら　いいさ…"
	
	; TODO: ROUGH TRANSLATION. PLEASE REWORK
	lang_text E, "Here, take this"
	lang_line E, "BRIGHTPOWDER."
	lang_para E, "Use it to distract"
	lang_line E, "yourself from"
	lang_cont E, "your loneliness…"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
ENDC
