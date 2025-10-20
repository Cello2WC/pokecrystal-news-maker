IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wChain      EQUS "wNewsScratch0"
DEF wCurrentMon EQUS "wNewsScratch1"
DEF wNextMon    EQUS "wNewsScratch2"
DEF wBet        EQUS "wNewsScratch3"

MACRO def_hilo_mons
DEF loopindex = 1
DEF NUM_HILO_MONS EQU _NARG
REPT _NARG
DEF HILO_MON_{d:loopindex} EQU \1
DEF loopindex = loopindex + 1
SHIFT
ENDR
ENDM
	; smallest to largest
	def_hilo_mons NATU, DITTO, SHUCKLE, DUGTRIO, UMBREON, VILEPLUME, FURRET, SNORLAX, ARBOK, DRAGONAIR, GYARADOS, ONIX

MACRO minigame_start
	nsc_set wChain, 0
	nsc_set wCurrentMon, -1
	
	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro

;.minigame_start_retry
;	nsc_ramcopy hRandomAdd, wCurrentMon, 1
;	nsc_flagop wCurrentMon, 4, FLAG_CLEAR
;	nsc_flagop wCurrentMon, 5, FLAG_CLEAR
;	nsc_flagop wCurrentMon, 6, FLAG_CLEAR
;	nsc_flagop wCurrentMon, 7, FLAG_CLEAR
;	nsc_compare wCurrentMon, .minigame_start_continue, .minigame_start_retry, .minigame_start_retry, 1, NUM_HILO_MONS
;.minigame_start_continue
	
	nsc_page MinigameStart
	
	
.gameIntroText
	; Japanese
	lang_text J, "ゲームを　はじめると　まず"
	lang_line J, "１ぴきの　ポケモンが　でてきます"
	lang_cont J, "このあとに　また　１ぴき　ポケモンが"
	lang_cont J, "でてくるので　あとの　ポケモンの"
	lang_cont J, "せの　たかさが　まえの　ポケモンより"
	lang_cont J, "たかいか　ひくいかを　あてましょう！"

	lang_para J, "ゲームに　でてくる　ポケモンは"
	lang_line J, "ぜんぶで　１２しゅるい　だけです"
	lang_cont J, "「リスト」を　えらべば"
	lang_cont J, "いつでも　みられるので"
	lang_cont J, "こたえを　よそうすることが　できます"

	lang_para J, "ポケモンの　たかさは　ずかんに"
	lang_line J, "のっている　たかさで　かんがえます"
	lang_cont J, "７かい　つづけて　あたれば"
	lang_cont J, "ゲーム　クリアです！"
	lang_cont J, "それでは　はじめよう！"
	
	; English
	lang_text E, "When the game"
	lang_line E, "starts, a #MON"
	lang_cont E, "will be shown."
	
	lang_para E, "Then, another"
	lang_line E, "appears!"
	
	lang_para E, "Guess whether the"
	lang_line E, "next #MON will"
	lang_cont E, "be taller or"
	lang_cont E, "shorter than the"
	lang_cont E, "one before!"
	
	lang_para E, "Only twelve kinds"
	lang_line E, "of #MON can"
	lang_cont E, "appear in this"
	lang_cont E, "game."

	lang_para E, "Pick LIST to check"
	lang_line E, "them at any time."
	lang_cont E, "That may help you"
	lang_cont E, "guess the answer."
	
	lang_para E, "#DEX height is"
	lang_line E, "used when making"
	lang_cont E, "a decision."
	
	lang_para E, "Get seven right"
	lang_line E, "in a row to win!"
	
	lang_para E, "Let's get started!"
	
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
ENDM

MACRO minigame_name
	lang J, "#　たかいか　ひくいか？"
	lang E, "TALLER OR SHORTER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

; deprecating this, at least for now, 
; as it seems it might not have existed.

;MACRO minigame_desc
;ENDM

ELSE
MinigameStart::
	news_screen PokemonHiLo, MUSIC_VIRIDIAN_CITY;MUSIC_GAME_CORNER
	news_def_pals
	
	news_def_boxes
	news_box 0,  0, 20, 15, {NEWS_MAIN_BORDER}
IF DEF(_LANG_J)
	news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}
ELSE
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
ENDC
	
	news_def_strings
	news_string 0, 0, "@"
;IF DEF(_LANG_J)
;	news_string 2, 2, ""
;ELSE
;	news_string 1, 2, ""
;ENDC
;.textQuestion
;	lang      J, "この　あとに　でる　ポケモンは"
;	lang_next J, "これより　たかいか　ひくいか？"
;	; TODO: ROUGH
;	lang      E, "Next #MON'll be"
;	lang_next E, "taller or shorter?"
;	
;	lang      D, "?"
;	
;	lang      F, "?"
;	
;	lang      I, "?"
;	
;	lang      S, "?"
;	db "@"
	
IF DEF(_LANG_J)
	news_menu  2, 16, 4, 1,  4, 2, -1, 0, 0, 0, 0, $04
ELSE
	news_menu  2, 14, 2, 2, 10, 2, -1, 0, 0, 0, 0, $04
ENDC
	;news_menu  2, 14, 3, 1, 6, 2, -1, 0, 0, 0, 0, $04
	
	news_buttonscript .aButton     ; a button
	news_buttonscript .bButton     ; b button
	news_buttonscript              ; select button
	news_buttonscript .aButton     ; start button
	news_buttonscript .rightButton ; right button
	news_buttonscript .leftButton  ;  left button
IF DEF(_LANG_J)
	news_buttonscript
	news_buttonscript
ELSE
	news_buttonscript .upButton    ; up button
	news_buttonscript .downButton  ; down button
ENDC
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuHiText,   .menuLoText,   .menuListText, .menuQuitText;.pressStartText, .dummyDescription, .dummyDescription;
	news_menuitem_scripts .menuHiScript, .menuLoScript, .menuListScript, .menuQuitScript
	news_menuitem_descs   .dummyDescription, .dummyDescription, .dummyDescription, .dummyDescription

IF !DEF(_LANG_J)
.upButton
	nsc_compare wCurrentMon, .upButton_ingame, .nothing, .nothing, 1, -1
.upButton_ingame
	nsc_up
	nsc_ret
.downButton
	nsc_compare wCurrentMon, .downButton_ingame, .nothing, .nothing, 1, -1
.downButton_ingame
	nsc_down
	nsc_ret
ENDC
	
	
.rightButton
	nsc_compare wCurrentMon, .rightButton_ingame, .nothing, .nothing, 1, -1
.rightButton_ingame
	nsc_right
.nothing
	nsc_ret
.leftButton
	nsc_compare wCurrentMon, .leftButton_ingame, .nothing, .nothing, 1, -1
.leftButton_ingame
	nsc_left
	nsc_ret
.menuQuitScript
.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret
	
.aButton
	nsc_compare wCurrentMon, .abutton_ingame, .startGame, .startGame, 1, -1


.abutton_ingame
	nsc_playsound SFX_READ_TEXT
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	;nsc_clear 6, 5, 7, 7
	
	
	
	nsc_compare wNewsMenuOption, .rollNextMon, .rollNextMon, .noRoll, 1, 1
.startGame
IF DEF(_LANG_J)
	nsc_printstring 2, 2, .textQuestion
ELSE
	nsc_printstring 1, 2, .textQuestion
ENDC
.rollNextMon
	nsc_clear 6, 5, 7, 7
	nsc_ramcopy hRandomAdd, wNextMon, 1
	nsc_flagop wNextMon, 4, FLAG_CLEAR
	nsc_flagop wNextMon, 5, FLAG_CLEAR
	nsc_flagop wNextMon, 6, FLAG_CLEAR
	nsc_flagop wNextMon, 7, FLAG_CLEAR
	nsc_compareram wNextMon, 1, wCurrentMon, .rollContinue1, .rollNextMon, .rollContinue1 ; reroll if rolled same mon
.rollContinue1
	nsc_compare wNextMon, .rollContinue, .rollNextMon, .rollNextMon, 1, NUM_HILO_MONS ; reroll if rolled invalid mon

	
;.noRoll
;IF DEF(_LANG_J)
;	nsc_clear 1,  1, 18, 11
;ELSE
;	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
;ENDC
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_select
;IF DEF(_LANG_J)
;	nsc_printstring 2, 2, .textQuestion
;ELSE
;	nsc_printstring 1, 2, .textQuestion
;ENDC
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_clear 1, 13, 18, 4
	;nsc_printstring 1, 14, .textAnswers
	
	;nsc_drawbox 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	;nsc_printstring 1, 16, .textAnswers
	
	;nsc_ramcopy wCurrentMon, wNextMon, 1
	
.rollContinue
	nsc_compare wNextMon, .rolledMon1, .rolledMon2, .rolledHigher, 1, 1
.rolledHigher
	nsc_compare wNextMon, .rolledMon3, .rolledMon4, .rolledHigher2, 1, 3
.rolledHigher2
	nsc_compare wNextMon, .rolledMon5, .rolledMon6, .rolledHigher3, 1, 5
.rolledHigher3
	nsc_compare wNextMon, .rolledMon7, .rolledMon8, .rolledHigher4, 1, 7
.rolledHigher4
	nsc_compare wNextMon, .rolledMon9, .rolledMon10, .rolledHigher5, 1, 9
.rolledHigher5
	nsc_compare wNextMon, .rolledMon11, .rolledMon12, .rollNextMon, 1, 11

DEF loopindex = 1
REPT NUM_HILO_MONS
.rolledMon{d:loopindex}
	nsc_drawmon  6, 5, HILO_MON_{d:loopindex}, ANIM_MON_NORMAL, 7
	nsc_compare wNewsMenuOption, .aButtonSelect, .aButtonSelect, .aButtonDone, 1, 1
DEF loopindex = loopindex + 1
ENDR
.noRoll
IF DEF(_LANG_J)
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
ENDC
	nsc_select
	nsc_set wCurrentMon, -1 ; kinda hacky code flow...
	
.aButtonSelect
	nsc_compare wCurrentMon, .actually_do, .actually_dont, .actually_dont, 1, -1
.actually_do
IF DEF(_LANG_J)
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
ENDC
	nsc_select
.actually_dont
	nsc_ramcopy wNextMon, wCurrentMon, 1
.aButtonDone
	
	;nsc_drawbox 0,  0, 20, 15, {NEWS_MAIN_BORDER}
	;nsc_drawbox 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	



	nsc_set wNewsMenuOption, 0
	nsc_set wNewsMenuCursorX, 1
IF DEF(_LANG_J)
	nsc_printstring 0, 12, .textEraseLine
	nsc_printstring 0, 13, .textEraseLine
	nsc_drawbox 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	nsc_printstring 1, 16, .textAnswers
ELSE
	nsc_set wNewsMenuCursorY, 1
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .textAnswers
ENDC
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_clear 1, 13, 18, 4
	;nsc_printstring 1, 14, .textAnswers
	nsc_ret
	

	
	
.menuLoScript
	nsc_compareram wNextMon, 1, wCurrentMon, .correct, .correct, .incorrect ; wNextMon and wCurrentMon should never be equal here
.menuHiScript
	nsc_compareram wNextMon, 1, wCurrentMon, .incorrect, .correct, .correct ; wNextMon and wCurrentMon should never be equal here

.incorrect
	nsc_set wChain, 0
	nsc_playsound SFX_WRONG
	;nsc_drawbox 0, 12, 20, 6, {NEWS_TEXT_BORDER}
	;nsc_clear 1, 15, 18, 2
	;nsc_textbox 1, 16, .textIncorrect
IF DEF(_LANG_J)
	nsc_clear 1, 15, 18, 2
ELSE
	nsc_clear 1, 13, 18, 4
ENDC
	nsc_textbox 1, 14, .textIncorrect
	nsc_waitbutton
	nsc_ret
.correct
	nsc_add wChain, 1
	nsc_playsound SFX_LEVEL_UP
	;nsc_drawbox 0, 12, 20, 6, {NEWS_TEXT_BORDER}
	;nsc_clear 1, 15, 18, 2
	;nsc_textbox 1, 16, .textCorrect
IF DEF(_LANG_J)
	nsc_clear 1, 15, 18, 2
ELSE
	nsc_clear 1, 13, 18, 4
ENDC
	nsc_textbox 1, 14, .textCorrect
	nsc_waitbutton
	
	nsc_compare wChain, .keepGoing, .gift, .gift, 1, 7
.gift
	nsc_compare_newsvar sMinigameFlag, .noGift, .doGift, .noGift, 1, 0
.doGift
	; TODO: message for no space in pack error?
	nsc_giveitem STAR_PIECE, .giftSuccess, .giftFail
.giftSuccess
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
	;nsc_drawbox 0, 12, 20, 6, {NEWS_TEXT_BORDER}
	nsc_clear 1, 13, 18, 2
	nsc_textbox 1, 14, .textGift
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.giftFail
.noGift
	nsc_page NewsRoot
.keepGoing
	nsc_ret
	
	
	
	
	
	
.menuListScript
	;nsc_printstring 1, 2, .listText
IF !DEF(_LANG_J)
	nsc_clear 1, 13, 18, 4
ENDC
	nsc_textbox 1, 14, .listText
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	;nsc_clear 1,  1, 18, 16
	nsc_ret
	
	
	
.listText
	; Japanese
	lang_text J, "でてくる　ポケモンは"
	lang_line J, "ネイティ　カビゴン　オオタチ"
	lang_cont J, "ダグトリオ　メタモン　ギャラドス"
	lang_cont J, "アーボック　ハクリュー　ブラッキー"
	lang_cont J, "ツボツボ　ラフレシア　イワーク　です"
	
	; English	
	lang_text E, "The #MON shown:"
	lang_line E, "NATU, ARBOK, ONIX,"
	lang_cont E, "GYARADOS, FURRET," 
	lang_cont E, "DUGTRIO, SHUCKLE," 
	lang_cont E, "SNORLAX, UMBREON," 
	lang_cont E, "DITTO & DRAGONAIR"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	done
	;db "@"
	
	
	
	
.menuHiText
	lang J, "たかい"
	lang E, "TALLER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
.dummyDescription
	db "@"
	
.menuLoText
	lang J, "ひくい"
	lang E, "SHORTER"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuListText
	lang J, "リスト"
	lang E, "LIST"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuQuitText
	lang J, "やめる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
	db "@"
	
	; this is a bodge and i know it...
.textAnswers
	lang J, "▶たかい　ひくい　リスト　やめる"
	lang      E, "▶TALLER    SHORTER"
	lang_next E, " LIST      CANCEL"
	lang D, "▶?"
	lang F, "▶?"
	lang I, "▶?"
	lang S, "▶?"
	db "@"
	
	; as is this
IF DEF(_LANG_J)
.textEraseLine
	db $B3
REPT 18
	db $7F
ENDR
	db $B4
	db "@"
ENDC
	
.textQuestion
	; Japanese
	lang      J, "この　あとに　でる　ポケモンは"
	lang_next J, "これより　たかいか　ひくいか？"
	
	; English
	lang      E, "Is the next one"
	lang_next E, "taller or shorter?"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	db "@"
	
.textCorrect
	; Japanese
	lang_text J, "あたり！"
	
	; English
	lang_text E, "Correct!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
.textIncorrect
	; Japanese
	lang_text J, "はずれ！"
	
	; English
	lang_text E, "Incorrect!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textGift
	; Japanese
	lang_text J, "おめでとう！"
	lang_next J, "７かい　つづいた　ごほうびに"
	lang_cont J, "ほしのかけらを　プレゼント！"

	lang_para J, "ほしのかけらを　もらった！"
	
	; English
	lang_text E, "Congratulations!"
	
	lang_para E, "As a reward for"
	lang_line E, "getting seven in"
	lang_cont E, "a row, take this"
	lang_cont E, "STAR PIECE!"
	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "STAR PIECE."
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done
	
;.pressStartText
;	; Japanese
;	lang J, "スタートボタンを　おして！"
;	
;	; English
;	lang E, "Press START!"
;	lang D, "?"
;	lang F, "?"
;	lang I, "?"
;	lang S, "?"
;	db "@"
	
	
ENDC