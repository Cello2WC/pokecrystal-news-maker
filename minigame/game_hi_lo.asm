; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
; 
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_12.htm
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
	nsc_page MinigameStart
	
	
.gameIntroText
	; Japanese
	lang J, text "ゲームを　はじめると　まず"
	lang J, line "１ぴきの　ポケモンが　でてきます"
	lang J, cont "このあとに　また　１ぴき　ポケモンが"
	lang J, cont "でてくるので　あとの　ポケモンの"
	lang J, cont "せの　たかさが　まえの　ポケモンより"
	lang J, cont "たかいか　ひくいかを　あてましょう！"

	lang J, para "ゲームに　でてくる　ポケモンは"
	lang J, line "ぜんぶで　１２しゅるい　だけです"
	lang J, cont "「リスト」を　えらべば"
	lang J, cont "いつでも　みられるので"
	lang J, cont "こたえを　よそうすることが　できます"

	lang J, para "ポケモンの　たかさは　ずかんに"
	lang J, line "のっている　たかさで　かんがえます"
	lang J, cont "７かい　つづけて　あたれば"
	lang J, cont "ゲーム　クリアです！"
	lang J, cont "それでは　はじめよう！"
	
	; English
	lang E, text "When the game"
	lang E, line "starts, a #MON"
	lang E, cont "will be shown."
	
	lang E, para "Then, another"
	lang E, line "appears!"
	
	lang E, para "Guess whether the"
	lang E, line "next #MON will"
	lang E, cont "be taller or"
	lang E, cont "shorter than the"
	lang E, cont "one before!"
	
	lang E, para "Only twelve kinds"
	lang E, line "of #MON can"
	lang E, cont "appear in this"
	lang E, cont "game."

	lang E, para "Pick LIST to check"
	lang E, line "them at any time."
	lang E, cont "That may help you"
	lang E, cont "guess the answer."
	
	lang E, para "#DEX height is"
	lang E, line "used when making"
	lang E, cont "a decision."
	
	lang E, para "Get seven right"
	lang E, line "in a row to win!"
	
	lang E, para "Let's get started!"
	
	; German
	lang D, text "Bei Spielbeginn"
	lang D, line "wird dir ein"
	lang D, cont "#MON gezeigt."
	
	lang D, para "Danach erscheint"
	lang D, line "ein weiteres!"
	
	lang D, para "Errate, ob das"
	lang D, line "nächste #MON"
	lang D, cont "größer oder"
	lang D, cont "kleiner ist als"
	lang D, cont "das vorherige!"
	
	lang D, para "Nur zwölf ver-"
	lang D, line "schiedene #MON"
	lang D, cont "tauchen in"
	lang D, cont "diesem Spiel auf."

	lang D, para "Als Hinweis zeigt"
	lang D, line "dir die LISTE alle"
	lang D, cont "möglichen #MON-"
	lang D, cont "Arten an."
	
	lang D, para "Es zählt die im"
	lang D, line "#DEX verzeich-"
	lang D, cont "nete Größe."
	
	lang D, para "Um zu gewinnen,"
	lang D, line "musst du sieben"
	lang D, cont "Mal hintereinander"
	lang D, cont "richtig liegen."

	lang D, para "Und los geht's!"


	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
ENDM

MACRO minigame_name
	lang J, db "#　たかいか　ひくいか？"
	lang E, db "TALLER OR SHORTER"
	lang D, db "GRÖSSER? KLEINER?"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
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
	lang    J, news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	notlang J, news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 0, 0, "@"

	lang    J, news_menu  2, 16, 4, 1,  4, 2, -1, 0, 0, 0, 0, $04
	notlang J, news_menu  2, 14, 2, 2, 10, 2, -1, 0, 0, 0, 0, $04
	
	news_buttonscript .aButton     ; a button
	news_buttonscript .bButton     ; b button
	news_buttonscript              ; select button
	news_buttonscript .aButton     ; start button
	news_buttonscript .rightButton ; right button
	news_buttonscript .leftButton  ;  left button
	lang    J, news_buttonscript
	notlang J, news_buttonscript .upButton    ; up button
	lang    J, news_buttonscript
	notlang J, news_buttonscript .downButton  ; down button
	
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
	lang    J, nsc_printstring 2, 2, .textQuestion
	notlang J, nsc_printstring 1, 2, .textQuestion
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
	lang J, nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_select
	nsc_set wCurrentMon, -1 ; kinda hacky code flow...
	
.aButtonSelect
	nsc_compare wCurrentMon, .actually_do, .actually_dont, .actually_dont, 1, -1
.actually_do
	lang J, nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_select
.actually_dont
	nsc_ramcopy wNextMon, wCurrentMon, 1
.aButtonDone
	
	;nsc_drawbox 0,  0, 20, 15, {NEWS_MAIN_BORDER}
	;nsc_drawbox 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	



	nsc_set wNewsMenuOption, 0
	nsc_set wNewsMenuCursorX, 1
	
	lang J, nsc_printstring 0, 12, .textEraseLine
	lang J, nsc_printstring 0, 13, .textEraseLine
	lang J, nsc_drawbox 0, 14, 20,  4, {NEWS_TEXT_BORDER}
	lang J, nsc_printstring 1, 16, .textAnswers

	notlang J, nsc_set wNewsMenuCursorY, 1
	notlang J, nsc_clear 1, 13, 18, 4
	notlang J, nsc_printstring 1, 14, .textAnswers

	nsc_ret
	

	
	
.menuLoScript
	nsc_compareram wNextMon, 1, wCurrentMon, .correct, .correct, .incorrect ; wNextMon and wCurrentMon should never be equal here
.menuHiScript
	nsc_compareram wNextMon, 1, wCurrentMon, .incorrect, .correct, .correct ; wNextMon and wCurrentMon should never be equal here

.incorrect
	nsc_set wChain, 0
	nsc_playsound SFX_WRONG
	lang    J, nsc_clear 1, 15, 18, 2
	notlang J, nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_textbox 1, 14, .textIncorrect
	nsc_waitbutton
	nsc_ret
.correct
	nsc_add wChain, 1
	nsc_playsound SFX_LEVEL_UP
	lang    J, nsc_clear 1, 15, 18, 2
	notlang J, nsc_clear 1, 13, 18, 4
	nsc_delay 1
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
	nsc_clear 1, 13, 18, 2
	nsc_delay 1
	nsc_textbox 1, 14, .textGift
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.giftFail
.noGift
	nsc_page NewsRoot
.keepGoing
	nsc_ret
	
.menuListScript
	notlang J, nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_textbox 1, 14, .listText
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_ret
	
.listText
	; Japanese
	lang J, text "でてくる　ポケモンは"
	lang J, line "ネイティ　カビゴン　オオタチ"
	lang J, cont "ダグトリオ　メタモン　ギャラドス"
	lang J, cont "アーボック　ハクリュー　ブラッキー"
	lang J, cont "ツボツボ　ラフレシア　イワーク　です"
	
	; English	
	lang E, text "The #MON shown:"
	lang E, line "NATU, ARBOK, ONIX,"
	lang E, cont "GYARADOS, FURRET," 
	lang E, cont "DUGTRIO, SHUCKLE," 
	lang E, cont "SNORLAX, UMBREON," 
	lang E, cont "DITTO & DRAGONAIR."
	
	; German
	lang D, text "Erscheinen werden:"
	lang D, line "NATU RELAXO DIGDRI"
	lang D, cont "WIESENIOR DITTO"
	lang D, cont "GARADOS ARBOK ONIX"
	lang D, cont "DRAGONIR NACHTARA"
	lang D, cont "POTTROTT GIFLOR"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	done
	
.menuHiText
	lang J, db "たかい"
	lang E, db "TALLER"
	lang D, db "GRÖSSER"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
.dummyDescription
	db "@"
	
.menuLoText
	lang J, db "ひくい"
	lang E, db "SHORTER"
	lang D, db "KLEINER"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	db "@"

.menuListText
	lang J, db "リスト"
	lang E, db "LIST"
	lang D, db "LISTE"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	db "@"
	
.menuQuitText
	lang J, db "やめる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"
	
	; this is a bodge and i know it...
.textAnswers
	lang J, db "▶たかい　ひくい　リスト　やめる"
	lang E, db   "▶TALLER    SHORTER"
	lang E, next " LIST      CANCEL"
	lang D, db   "▶GRÖSSER   KLEINER"
	lang D, next " LISTE     ZURÜCK"
	lang F, db "▶?"
	lang I, db "▶?"
	lang S, db "▶?"
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
	lang J, db   "この　あとに　でる　ポケモンは"
	lang J, next "これより　たかいか　ひくいか？"
	
	; English
	lang E, db   "Is the next one"
	lang E, next "taller or shorter?"
	
	; German
	lang D, db   "Wie groß ist wohl"
	lang D, next "das nächste PKMN?"
	
	lang F, db   "?"
	
	lang I, db   "?"
	
	lang S, db   "?"
	
	db "@"
	
.textCorrect
	; Japanese
	lang J, text "あたり！"
	
	; English
	lang E, text "Correct!"
	
	; German
	lang D, text "Richtig!"
	
	lang F, text "?"
	lang I, text "?"
	lang S, text "?"
	done
.textIncorrect
	; Japanese
	lang J, text "はずれ！"
	
	; English
	lang E, text "Incorrect!"
	
	; German
	lang D, text "Leider falsch!"
	
	lang F, text "?"
	lang I, text "?"
	lang S, text "?"
	done

.textGift
	; Japanese
	lang J, text "おめでとう！"
	lang J, next "７かい　つづいた　ごほうびに"
	lang J, cont "ほしのかけらを　プレゼント！"

	lang J, para "ほしのかけらを　もらった！"
	
	; English
	lang E, text "Congratulations!"
	
	lang E, para "As a reward for"
	lang E, line "getting seven in"
	lang E, cont "a row, take this"
	lang E, cont "STAR PIECE!"
	
	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "STAR PIECE."
	
	; German
	lang D, text "Glückwunsch!"

	lang D, para "Für 7 Richtige in"
	lang D, line "in Folge gewinnst"
	lang D, cont "du dieses"
	lang D, cont "STERNENSTÜCK!"
	
	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "STERNENSTÜCK."

	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done
	
ENDC