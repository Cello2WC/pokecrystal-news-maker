; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_08.htm
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

DEF wCurrentCrySet EQUS "wNewsScratch0"
DEF wCurrentStreak EQUS "wNewsScratch1"
DEF wCurrentIndex  EQUS "wNewsScratch2"
DEF wCrySequence1  EQUS "wNewsScratch3"
DEF wCrySequence2  EQUS "wNewsScratch4"
DEF wCrySequence3  EQUS "wRankingsCategory"
DEF wCrySequence4  EQUS "wRankingsType"
DEF wCrySequence5  EQUS "wRankingsTable"
DEF wCurDirection  EQUS "wNumListedPlayers"
DEF wMathScratch   EQUS "wOwnRank"
DEF wMathScratch2  EQUS "wNumRankedPlayers"

DEF GIFTINDEX_BERRY        EQU 0
DEF GIFTINDEX_POKE_DOLL    EQU 1
DEF GIFTINDEX_PEARL        EQU 2
DEF GIFTINDEX_BIG_PEARL    EQU 3
DEF GIFTINDEX_STARDUST     EQU 4
DEF GIFTINDEX_TM_REST      EQU 5
DEF GIFTINDEX_PNK_APRICORN EQU 6
DEF GIFTINDEX_GRN_APRICORN EQU 7
DEF GIFTINDEX_YLW_APRICORN EQU 8
DEF wGiftIndex     EQUS "wNewsScratch2"


MACRO minigame_start
	nsc_page CrySetSelect
ENDM

MACRO minigame_name
; Max 17 chars
	; Japanese
	lang J, db "ポケモン　つづくかな？"

	; English
	lang E, db "#RAP IT UP!"
	lang D, db "#MON-PLAUDEREI!"
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
	news_screen CrySetSelect, MUSIC_SHOW_ME_AROUND
	news_def_pals

	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, ""
	minigame_name
	db "@"

	news_menu 2, 5, 1, 4, 0, 2, 16, 4, 7, 4, SHOW_DESCRIPTIONS | SHOW_ARROWS, 4

	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4

	news_norankingstable

	news_menuitem_names   .menuGameInstructionName,   .menuCrySet1Name,   .menuCrySet2Name,   .menuCrySet3Name,   .menuCancelName
	news_menuitem_scripts .menuGameInstructionScript, .menuCrySet1Script, .menuCrySet2Script, .menuCrySet3Script, .menuCancelScript
	news_menuitem_descs   .menuGameInstructionDesc,   .menuCrySet1Desc,   .menuCrySet2Desc,   .menuCrySet3Desc,   .menuCancelDesc

.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret
.up_button
	nsc_up
	nsc_ret
.down_button
	nsc_down
	nsc_ret
.b_button
.start_button
	nsc_playsound SFX_MENU
.menuCancelScript
	nsc_page NewsRoot
	nsc_ret
; Max 17 chars
.menuCrySet1Name
	lang J, db "なきごえセット　１"
	lang E, db "CRY SET 1"
	lang D, db "RUF-SET 1"
	lang F, db "GROUPE DE CRIS 1"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuCrySet2Name
	lang J, db "なきごえセット　２"
	lang E, db "CRY SET 2"
	lang D, db "RUF-SET 2"
	lang F, db "GROUPE DE CRIS 2"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuCrySet3Name
	lang J, db "なきごえセット　３"
	lang E, db "CRY SET 3"
	lang D, db "RUF-SET 3"
	lang F, db "GROUPE DE CRIS 3"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuGameInstructionName
	lang J, db "ゲームの　せつめい"
	lang E, db "GAME EXPLANATION"
	lang D, db "SPIELREGELN"
	lang F, db "REGLES DU JEU"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuCancelName
	lang J, db "もどる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "?"
	lang S, db "?"
	db "@"

MACRO def_cryset
DEF CRYSET\1_UP_MON      EQU \2
DEF CRYSET\1_DOWN_MON    EQU \3
DEF CRYSET\1_LEFT_MON    EQU \4
DEF CRYSET\1_RIGHT_MON   EQU \5
DEF CRYSET\1_BIG_PRIZE   EQU \6
DEF CRYSET\1_BIG_PRIZE_2 EQU \7
ENDM

	def_cryset 1, IGGLYBUFF, TOGEPI,   CLEFFA,     PICHU,     BIG_PEARL, PNK_APRICORN
	def_cryset 2, BULBASAUR, PIKACHU,  CHARMANDER, SQUIRTLE,  STARDUST,  GRN_APRICORN
	def_cryset 3, POLIWAG,   POLITOED, POLIWRATH,  POLIWHIRL, TM_REST,   YLW_APRICORN

.menuCrySet1Script
	nsc_set wCurrentCrySet, 1
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret

.menuCrySet2Script
	nsc_set wCurrentCrySet, 2
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret
.menuCrySet3Script
	nsc_set wCurrentCrySet, 3
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret


.menuGameInstructionScript
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_textbox 1, 14, .gameInstructionText
	nsc_ret

.gameInstructionText
	; Japanese
	lang J, text "まず　ゲームに　つかうための"
	lang J, line "すきな　なきごえの　セットを"
	lang J, cont "えらんで　ください"

	lang J, para "えらぶと　ゲームが　はじまります"
	lang J, line "がめんの　まんなかから　みて"
	lang J, cont "うえ・した・ひだり・みぎの　どこかに"
	lang J, cont "ポケモンが　あらわれて　なきます"

	lang J, para "そのあと　ポケモンが　がめんの"
	lang J, line "どこに　あらわれたか"
	lang J, cont "じゅうじボタンで　まちがわず"
	lang J, cont "おすことが　できたら　せいかいです"

	lang J, para "ポケモンの　あらわれる　かずは"
	lang J, line "だんだん　おおく　なって　いくので"
	lang J, cont "じゅんばんを　おぼえて"
	lang J, cont "じゅうじボタンで"
	lang J, cont "くりかえして　いきましょう"

	lang J, para "ぜんぶで　２０かい　じゅんばんを"
	lang J, line "ただしく　くりかえせば　クリア！"
	lang J, cont "それでは　はじめよう！"

	; English
	lang E, text "First, choose a"
	lang E, line "cry set to use."

	lang E, para "Pick the one"
	lang E, line "you like best."

	lang E, para "Once chosen, the"
	lang E, line "game will begin!"

	lang E, para "Watch the center"
	lang E, line "of the screen."

	lang E, para "A #MON will let"
	lang E, line "out a loud cry!"

	lang E, para "It will come from"
	lang E, line "up, down, left or"
	lang E, cont "right--so listen"
	lang E, cont "up!"

	lang E, para "Press the matching"
	lang E, line "direction on the"
	lang E, cont "Control Pad."

	lang E, para "Get it right and"
	lang E, line "you'll move ahead!"

	lang E, para "More #MON will"
	lang E, line "show up each round"
	lang E, cont "so try to remember"
	lang E, cont "how they appear!"

	lang E, para "Wrap up twenty"
	lang E, line "rounds in a row"
	lang E, cont "to win the game!"

	lang E, para "Let's get started!"

	; German
	lang D, text "Wähle zunächst"
	lang D, line "ein Ruf-Set aus."

	lang D, para "Wähle dein"
	lang D, line "Favoriten-Set."

	lang D, para "Danach beginnt"
	lang D, line "das Spiel!"

	lang D, para "Konzentriere dich"
	lang D, line "auf die Bild-"
	lang D, cont "schirmmitte."

	lang D, para "Ein #MON stößt"
	lang D, line "seinen Ruf aus!"

	lang D, para "Es kann von oben,"
	lang D, line "unten, links oder"
	lang D, cont "rechts kommen."
	lang D, cont "Also hör gut zu!"

	lang D, para "Drücke die"
	lang D, line "passende Richtung"
	lang D, cont "auf dem"
	lang D, cont "Steuerkreuz."

	lang D, para "Liegst du richtig,"
	lang D, line "geht es in die"
	lang D, cont "nächste Runde!"

	lang D, para "Mit jeder Runde"
	lang D, line "erscheinen mehr"
	lang D, cont "#MON. Versuche,"
	lang D, cont "dir die Reihen-"
	lang D, cont "folge einzuprägen."

	lang D, para "Schaffst du es,"
	lang D, line "20 Runden durch-"
	lang D, cont "zuhalten, gewinnst"
	lang D, cont "du das Spiel!"

	lang D, para "Und los geht's!"

	; French
	lang F, text "D'abord, choisis"
	lang F, line "un groupe de cris."

	lang F, para "Prends celui"
	lang F, line "que préfères."

	lang F, para "Une fois choisi,"
	lang F, line "le jeu commencera!"

	lang F, para "Regarde bien le"
	lang F, line "centre de l'écran."

	lang F, para "Un #MON va"
	lang F, line "pousser son cri!"

	lang F, para "Il viendra de la"
	lang F, line "gauche, d'en haut,"
	lang F, cont "de la droite, ou"
	lang F, cont "d'en bas--sois" ; Le double tiret est utilisé deux fois dans le jeu de base.
	lang F, cont "attentif!"

	lang F, para "Appuie sur la"
	lang F, line "bonne direction"
	lang F, cont "avec la manette." ; "manette" est utilisé dans le jeu de base (pour les instructions de réglage du RTC, je crois).

	lang F, para "Réussis et tu"
	lang F, line "passeras au niveau"
	lang F, cont "suivant!"

	; TODO: check actual behaviour for whether that description is suitable
	lang F, para "Plus de #MON"
	lang F, line "apparaissent plus"
	lang F, cont "le niveau est"
	lang F, cont "élevé, donc essaye"
	lang F, cont "de mémoriser leurs"
	lang F, cont "apparitions!"

	lang F, para "Remporte vingt"
	lang F, line "niveaux d'affilée"
	lang F, cont "pour gagner"
	lang F, cont "la partie!"

	lang F, para "C'est parti!"

	; Italian
	lang I, text "?"

	; Spanish
	lang S, db   "?"

	para ""
	done

; TODO: did this text even exist?
.menuCrySet1Desc
.menuCrySet2Desc
.menuCrySet3Desc
.menuGameInstructionDesc
.menuCancelDesc
	db "?@"





	news_screen CryGame, MUSIC_SHOW_ME_AROUND;MUSIC_VIRIDIAN_CITY
	news_def_pals

	news_def_boxes
	news_box  0,  0, 20, 18, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 0, 0, "@"

	;news_menu 4, 9, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0
	news_menu 2, 14, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0

	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .start_button
	news_buttonscript .right_button
	news_buttonscript .left_button
	news_buttonscript .up_button
	news_buttonscript .down_button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4

	news_norankingstable

	news_menuitem_names   .pressStartText,  .menuDummyName,   .menuDummyName,   .menuDummyName, .menuDummyName
	news_menuitem_scripts .cry_up,          .cry_down,        .cry_left,        .cry_right,     .checkNextDir, .drawTextBox
	news_menuitem_descs   .menuDummyName,   .menuDummyName,   .menuDummyName,   .menuDummyName, .menuDummyName

	; no record of this text actually existing.
	; maybe the whole game worked differently??
.pressStartText
;	lang J, db "スタートボタンを　おして！"
;	lang E, db "PRESS START!"
;	lang D, db "Drücke START!"
;	lang F, db "Appuyer sur START!"
;	lang I, db "?"
;	lang S, db "?"

	lang J, db "なきごえセット"
	lang E, db "CRY SET"
	lang D, db "RUF-SET"
	lang F, db "GROUPE DE CRIS"
	lang I, db "?"
	lang S, db "?"

	nts_start
	nts_number wCurrentCrySet, 1, 2
	nts_end
.menuDummyName
	db "@"

.b_button
	nsc_playsound SFX_MENU
	nsc_page CrySetSelect
.nothing
	nsc_ret

.drawTextBox
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_delay 1
	;nsc_compare wCurrentIndex, .nothing, .nothing, .nothing, 1, 0
	nsc_ret

DEF UP_BITS    EQU %00_00_00_00
DEF DOWN_BITS  EQU %01_01_01_01
DEF LEFT_BITS  EQU %10_10_10_10
DEF RIGHT_BITS EQU %11_11_11_11

.up_button
	nsc_compare wCurrentIndex, .up_button_continue, .nothing, .nothing, 1, -2
.up_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_set wCurDirection, UP_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret

.cry_up
	nsc_compare wCurrentCrySet, .cryset1_up, .cryset2_up, .cryset3_up, 1, 2
.cryset1_up
	nsc_drawmon  6, 1, CRYSET1_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret
.cryset2_up
	nsc_drawmon  6, 1, CRYSET2_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret
.cryset3_up
	nsc_drawmon  6, 1, CRYSET3_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret

.down_button
	nsc_compare wCurrentIndex, .down_button_continue, .nothing, .nothing, 1, -2
.down_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_set wCurDirection, DOWN_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret

.cry_down
	nsc_compare wCurrentCrySet, .cryset1_down, .cryset2_down, .cryset3_down, 1, 2
.cryset1_down
	nsc_drawmon  6, 9, CRYSET1_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret
.cryset2_down
	nsc_drawmon  6, 9, CRYSET2_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret
.cryset3_down
	nsc_drawmon  6, 9, CRYSET3_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret

.left_button
	nsc_compare wCurrentIndex, .left_button_continue, .nothing, .nothing, 1, -2
.left_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_set wCurDirection, LEFT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret

.cry_left
	nsc_compare wCurrentCrySet, .cryset1_left, .cryset2_left, .cryset3_left, 1, 2
.cryset1_left
	nsc_drawmon  1, 5, CRYSET1_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret
.cryset2_left
	nsc_drawmon  1, 5, CRYSET2_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret
.cryset3_left
	nsc_drawmon  1, 5, CRYSET3_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret

.right_button
	nsc_compare wCurrentIndex, .right_button_continue, .nothing, .nothing, 1, -2
.right_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 3
	nsc_select
	nsc_set wCurDirection, RIGHT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret

.cry_right
	nsc_compare wCurrentCrySet, .cryset1_right, .cryset2_right, .cryset3_right, 1, 2
.cryset1_right
	nsc_drawmon  11, 5, CRYSET1_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret
.cryset2_right
	nsc_drawmon  11, 5, CRYSET2_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret
.cryset3_right
	nsc_drawmon  11, 5, CRYSET3_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret

.preview
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_set wNewsMenuOption, 3
	nsc_select

	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_set wNewsMenuOption, 5
	;nsc_select

	nsc_delay 1
	nsc_textbox 1, 14, .thisSetText
	nsc_yesno 13, 7, .useThisSet, .notThisSet
.notThisSet
	nsc_page CrySetSelect

.useThisSet
	nsc_set wCurrentStreak, 0
	nsc_set wCurrentIndex, -1

	; generate cry sequence
	; (thankfully the powers of two are kind to us)
	nsc_ramcopy hRandomAdd, wCrySequence1, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence3, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence5, 1

	nsc_playmusic MUSIC_VIRIDIAN_CITY

	; fall thru
.a_button
.start_button
	nsc_compare wCurrentIndex, .nothing, .preview, .start_button_continue, 1, -2
.start_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}

DEF cryindex = 0
REPT 20
DEF crysequencebyte = (cryindex/4)+1
DEF nextcryindex = cryindex + 1
.cry{d:cryindex}
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8), .cry{d:cryindex}_odd, .cry{d:cryindex}_even   ; 0
.cry{d:cryindex}_odd
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8) + 1, .cry{d:cryindex}_RIGHT, .cry{d:cryindex}_DOWN ; 1
.cry{d:cryindex}_even
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8) + 1, .cry{d:cryindex}_LEFT, .cry{d:cryindex}_UP    ; 1
.cry{d:cryindex}_UP
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_DOWN
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_LEFT
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_RIGHT
	nsc_set wNewsMenuOption, 3
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
DEF cryindex = cryindex + 1
ENDR
.cry20
.yourTurn

;	lang    J, nsc_printstring 3, 8, .textYourTurn
;	notlang J, nsc_printstring 2, 8, .textYourTurn

	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_set wNewsMenuOption, 5
	;nsc_select

	nsc_printstring 1, 14, .textYourTurn

	nsc_playsound SFX_TWINKLE;SFX_HIT_END_OF_EXP_BAR;SFX_TWO_PC_BEEPS
	nsc_set wCurrentIndex, 0
	nsc_ret



.checkNextDir
	nsc_ramcopy wCurrentIndex, wMathScratch, 1
	nsc_flagop wMathScratch, FLAG_CLEAR, 0
	nsc_flagop wMathScratch, FLAG_CLEAR, 1

	nsc_compare wMathScratch, .sequence00to03, .sequence04to07, .higher, 1, 1 << 2
.higher
	nsc_compare wMathScratch, .sequence08to11, .sequence12to15, .sequence16to19, 1, 3 << 2
.sequence00to03
	nsc_ramcopy wCrySequence1, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence04to07
	nsc_ramcopy wCrySequence2, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence08to11
	nsc_ramcopy wCrySequence3, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence12to15
	nsc_ramcopy wCrySequence4, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence16to19
	nsc_ramcopy wCrySequence5, wMathScratch2, 1
.sequenceCheckRejoin
	nsc_ramcopy wCurrentIndex, wMathScratch, 1
	nsc_flagop wMathScratch, FLAG_CLEAR, 2
	nsc_flagop wMathScratch, FLAG_CLEAR, 3
	nsc_flagop wMathScratch, FLAG_CLEAR, 4
	nsc_flagop wMathScratch, FLAG_CLEAR, 5
	nsc_flagop wMathScratch, FLAG_CLEAR, 6
	nsc_flagop wMathScratch, FLAG_CLEAR, 7

	nsc_bit wMathScratch, 0, .sequence_odd, .sequence_even
.sequence_odd
	nsc_bit wMathScratch, 1, .sequence03, .sequence01
.sequence_even
	nsc_bit wMathScratch, 1, .sequence02, .sequence00
.sequence00
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence01
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence02
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence03
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
.sequenceCheckRejoin2
	; the big moment!!!!
	nsc_compareram wCurDirection, 1, wMathScratch2, .sequenceWrong, .sequenceRight, .sequenceWrong

.sequenceWrong
	; TODO: fix "wawawawawawawa" (return and do prize text on a-script?)
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}

	;nsc_delay 1
	nsc_printstring 1, 14, .textWrong
	nsc_playsound SFX_WRONG
	;nsc_waitbutton

	; intermediate rewards

	nsc_set wNumListedPlayers, 16
	;nsc_set wNewsMenuOption, 5
	;nsc_select
	nsc_set wNewsMenuOption, 0

	nsc_compare wCurrentStreak, .prizeDone, .prize5, .prizeGreater1, 1, 5
.prizeGreater1
	nsc_compare wCurrentStreak, .prize5, .prize10, .prizeGreater2, 1, 10
.prizeGreater2
	nsc_compare wCurrentStreak, .prize10, .prize15, .prize15, 1, 15
.prize5
	nsc_giveitem BERRY, .doPrize5, .prizeDone
.doPrize5
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_BERRY
	nsc_textbox 1, 14, .textPresent1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize10
	nsc_giveitem POKE_DOLL, .doPrize10, .prizeDone
.doPrize10
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_POKE_DOLL
	nsc_textbox 1, 14, .textPresent2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize15
	nsc_giveitem PEARL, .doPrize15, .prizeDone
.doPrize15
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_PEARL
	nsc_textbox 1, 14, .textPresent3
	nsc_playsound SFX_ITEM
	;nsc_waitbutton
.prizeDone
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect

.sequenceRight

	nsc_compareram wCurrentIndex, 1, wCurrentStreak, .keepGoing, .sequenceComplete, .sequenceComplete
.sequenceComplete


	nsc_add wCurrentStreak, 1

	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;nsc_set wNewsMenuOption, 5
	;nsc_select

	;nsc_delay 1
	nsc_printstring 1, 14, .textRight
	nsc_playsound SFX_LEVEL_UP
	;nsc_waitbutton
	nsc_compare wCurrentStreak, .nextSequence, .allClear, .allClear, 1, 20
.nextSequence
	nsc_set wCurrentIndex, -1
	nsc_ret
.keepGoing
	nsc_add wCurrentIndex, 1
	nsc_ret
.allClear
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_textbox 1, 14, .textAllClear
	nsc_set wNumListedPlayers, 16
	nsc_set wNewsMenuOption, 0
	nsc_waitbutton
	nsc_compare wCurrentCrySet, .allClearCrySet1, .allClearCrySet2, .allClearCrySet3, 1, 2
.allClearCrySet1
	nsc_bit_newsvar sMinigameFlag, 0, .prize20_1_2, .prize20_1_1
.prize20_1_1
	nsc_giveitem CRYSET1_BIG_PRIZE, .doPrize20_1_1, .prizeDone
.doPrize20_1_1
	nsc_flagop_newsvar sMinigameFlag, 0, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_BIG_PEARL
	nsc_textbox 1, 14, .textPresent4A1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_1_2
	nsc_giveitem CRYSET1_BIG_PRIZE_2, 5, .doPrize20_1_2, .prizeDone
.doPrize20_1_2
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_PNK_APRICORN
	nsc_textbox 1, 14, .textPresent4A2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.allClearCrySet2
	nsc_bit_newsvar sMinigameFlag, 1, .prize20_2_2, .prize20_2_1
.prize20_2_1
	nsc_giveitem CRYSET2_BIG_PRIZE, .doPrize20_2_1, .prizeDone
.doPrize20_2_1
	nsc_flagop_newsvar sMinigameFlag, 1, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_STARDUST
	nsc_textbox 1, 14, .textPresent4B1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_2_2
	nsc_giveitem CRYSET2_BIG_PRIZE_2, 5, .doPrize20_2_2, .prizeDone
.doPrize20_2_2
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_GRN_APRICORN
	nsc_textbox 1, 14, .textPresent4B2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.allClearCrySet3
	nsc_bit_newsvar sMinigameFlag, 2, .prize20_3_2, .prize20_3_1
.prize20_3_1
	nsc_giveitem CRYSET3_BIG_PRIZE, .doPrize20_3_1, .prizeDone
.doPrize20_3_1
	nsc_flagop_newsvar sMinigameFlag, 2, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_TM_REST
	nsc_textbox 1, 14, .textPresent4C1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_3_2
	nsc_giveitem CRYSET3_BIG_PRIZE_2, 5, .doPrize20_3_2, .prizeDone
.doPrize20_3_2
	nsc_clear 1, 13, 18, 4
	nsc_delay 1
	nsc_set wGiftIndex, GIFTINDEX_YLW_APRICORN
	nsc_textbox 1, 14, .textPresent4C2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect


.thisSetText
	; Japanese
	lang J, text "このなきごえセットを　つかいますか？"

	; English
	lang E, text "Do you want to use"
	lang E, line "this cry set?"

	; German
	lang D, text "Wählst du dieses"
	lang D, line "Ruf-Set?"

	; French
	lang F, text "Utiliser ce groupe"
	lang F, line "de cris?"

	; Italian
	lang I, text "?"

	; Spanish
	lang S, text "?"
	done

; center-aligned version
;.textYourTurn
;	lang J, db   "　　あなたの　ばんです！"
;	lang J, next "じゅうじボタンを　おしてね！"
;
;	lang E, db   " Your turn! Use"
;	lang E, next "the Control Pad!"
;
;	lang D, db   "  Du bist dran!"
;   lang D, next "   Drücke das"
;   lang D, next "  Steuerkreuz!"
;
;	lang F, db   "   A ton tour!"
;	lang F, next "     Utilise"
;	lang F, next "   la manette!"
;
;	lang I, db   "?"
;
;	lang S, db   "?"
;
;	db "@"

; left-aligned version
.textYourTurn
	; Japanese
	lang J, db   "あなたの　ばんです！"
	lang J, next "じゅうじボタンを　おしてね！"

	; English
	lang E, db   "Your turn! Use"
	lang E, next "the Control Pad!"

	; German
	lang D, db   "Du bist dran!"
	lang D, next "Drücke das"
	lang D, next "Steuerkreuz!"

	lang F, db   "A ton tour!"
	lang F, next "Utilise"
	lang F, next "la manette!"

	lang I, db   "?"

	lang S, db   "?"

	db "@"

.textRight
	; Japanese
	lang J, db   "せいかい！！"

	; English
	lang E, db   "Correct!"

	; German
	lang D, db   "Richtig!"

	; French
	lang F, db   "Bravo!"

	; Italian
	lang I, db   "?"

	; Spanish
	lang S, db   "?"

	db "@"

.textWrong
	; Japanese
	lang J, db   "ざんねん…まちがえちゃった！"

	; English
	lang E, db   "Oops…"
	lang E, next "You messed up!"

	; German
	lang D, db   "Schade… Das war"
	lang D, next "nicht richtig!"

	; French
	lang F, db   "Dommage..."
	lang F, next "C'est raté!"

	; Italian
	lang I, db   "?"

	; Spanish
	lang S, db   "?"

	db "@"

.textAllClear
	; Japanese
	lang J, text "２０もんクリア！　おめでとう！"

	; English
	lang E, text "You wrapped up all"
	lang E, line "twenty! Well done!"

	; German
	lang D, text "20 Runden ge-"
	lang D, line "schafft! Klasse!"

	; French
	lang F, text "Tu as réussi tous"
	lang F, line "les vingt!"
	lang F, cont "Félicitations!"

	; Italian
	lang I, text "?"

	; Spanish
	lang S, text "?"

	done


	; NOTE: the japanese text uses the same verb in this text
	;       as in the minigame title. literally it would be smth like
	;       "since you continued × times", if the minigame's name is "will it continue?"
.textPresent1
.textPresent2
.textPresent3
.textPresent4A1
.textPresent4A2
.textPresent4B1
.textPresent4B2
.textPresent4C1
.textPresent4C2
.textPresent
	; Japanese
	lang J, text
	lang J, nts_start
	lang J, nts_number wCurrentStreak, 1, 2, 2
	lang J, nts_end
	lang J, text "かい　いじょう　つづいたので"
	lang J, line
	lang J, nts_start
	lang J, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	lang J, db   "を　プレゼント！"

	lang J, para
	lang J, nts_start
	lang J, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	lang J, db "を　もらった！"

	; English
	lang E, text "You wrapped up"
	lang E, line
	lang E, nts_start
	lang E, nts_number wCurrentStreak, 1, 2, 3
	lang E, nts_end
	lang E, db   "rounds!"

	lang E, para "Here! Take"
	lang E, line "this "
	lang E, nts_start
	lang E, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang E, nts_end
	lang E, cont   "as a gift!"

	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line
	lang E, nts_start
	lang E, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang E, nts_end
	lang E, db   "."

	; German
	lang D, text "Du hast "
	lang D, nts_start
	lang D, nts_number wCurrentStreak, 1, 2, 3
	lang D, nts_end
	lang D, db   " Run-"
	lang D, line "den durchgehalten!"

	lang D, para "Hier! Nimm bitte"
	lang D, line
	lang D, nts_start
	lang D, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang D, nts_end
	lang D, db   " als"
	lang D, cont "Geschenk!"

	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line
	lang D, nts_start
	lang D, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang D, nts_end
	lang D, db   "."

	; French
	lang F, text "Tu as réussi"
	lang F, nts_start
	lang F, nts_number wCurrentStreak, 1, 2, 3
	lang F, nts_end
	lang F, db   "niveaux!"

	lang F, para "Tiens! Voici"
	lang F, line
	lang F, nts_start
	lang F, nts_switch wGiftIndex, .itemName_BERRY_pronoun, .itemName_POKE_DOLL_pronoun, .itemName_PEARL_pronoun, \
	                               .itemName_BIG_PEARL_pronoun, .itemName_STARDUST_pronoun, .itemName_TM_REST_pronoun, \
	                               .itemName_PNK_APRICORN_pronoun, .itemName_GRN_APRICORN_pronoun, .itemName_YLW_APRICORN_pronoun
	;lang F, nts_end
	lang F, cont "en cadeau!"

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   "reçoit"
	lang F, line
	lang F, nts_start
	; Les messages d'obtention n'utilisent pas d'article en général ;
	; ici, on pourrait, mais préférons rester cohérents avec le jeu de base.
	lang F, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang F, nts_end
	lang F, db   "."

	; Italian
	lang I, text "?"
	lang I, nts_start
	lang I, nts_number wCurrentStreak, 1, 2, 3
	lang I, nts_end
	lang I, db   "?"

	lang I, para "?"
	lang I, nts_start
	lang I, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang I, nts_end
	lang I, db   "?"

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   "?"
	lang I, line
	lang I, nts_start
	lang I, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang I, nts_end
	lang I, db   "?"

	; Spanish
	lang S, text "?"
	lang S, nts_start
	lang S, nts_number wCurrentStreak, 1, 2, 3
	lang S, nts_end
	lang S, db   "?"

	lang S, para "?"
	lang S, nts_start
	lang S, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang S, nts_end
	lang S, db   "?"

	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   "?"
	lang S, line
	lang S, nts_start
	lang S, nts_switch wGiftIndex, .itemName_BERRY, .itemName_POKE_DOLL, .itemName_PEARL, \
	                               .itemName_BIG_PEARL, .itemName_STARDUST, .itemName_TM_REST, \
	                               .itemName_PNK_APRICORN, .itemName_GRN_APRICORN, .itemName_YLW_APRICORN
	;lang S, nts_end
	lang S, db   "?"

	done


.itemName_BERRY_pronoun
	lang F, db "une "
.itemName_BERRY
	lang J, db "きのみ"
	lang E, db "BERRY"
	lang D, db "BEERE"
	lang F, db "BAIE"
	lang I, db "BACCA"
	lang S, db "BAYA"
	db "@"

.itemName_POKE_DOLL_pronoun
	lang F, db "une "
.itemName_POKE_DOLL
	lang J, db "ピッピにんぎょう"
	lang E, db "# DOLL"
	lang D, db "#PUPPE"
	lang F, db "# POUPEE"
	lang I, db "# BAMBOLA"
	lang S, db "# MUÑECO"
	db "@"

.itemName_PEARL_pronoun
	lang F, db "une "
.itemName_PEARL
	lang J, db "しんじゅ"
	lang E, db "PEARL"
	lang D, db "PERLE"
	lang F, db "PERLE"
	lang I, db "PERLA"
	lang S, db "PERLA"
	db "@"

.itemName_BIG_PEARL_pronoun
	lang F, db "une "
.itemName_BIG_PEARL
	lang J, db "おおきなしんじゅ"
	lang E, db "BIG PEARL"
	lang D, db "RIESENPERLE"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	db "@"

.itemName_STARDUST_pronoun
	lang F, db "une "
.itemName_STARDUST
	lang J, db "ほしのすな"
	lang E, db "STARDUST"
	lang D, db "STERNENSTAUB"
	lang F, db "GRANDE PERLE"
	lang I, db "GRANDE PERLA"
	lang S, db "PERLA GRANDE"
	db "@"

.itemName_TM_REST_pronoun
	lang F, db "la "
.itemName_TM_REST
	lang J, db "わざマシン４４"
	lang E, db "TM44"
	lang D, db "TM44"
	lang F, db "CT44"
	lang I, db "MT44"
	lang S, db "MT44"
	db "@"

.itemName_PNK_APRICORN_pronoun
	lang F, db "un "
.itemName_PNK_APRICORN
	lang J, db "ももぼんぐり"
	lang E, db "PNK APRICORN"
	lang D, db "APRIKOKO PNK"
	lang F, db "NOIGRUME ROS" ; Le nom est utilisé tronqué sur la Route 35.
	lang I, db "GHICOC.ROSA"
	lang S, db "BONGURI ROS"
	db "@"

.itemName_GRN_APRICORN_pronoun
	lang F, db "un "
.itemName_GRN_APRICORN
	lang J, db "みどぼんぐり"
	lang E, db "GRN APRICORN"
	lang D, db "APRIKOKO GRN"
	lang F, db "NOIGRUME VER"
	lang I, db "GHICOC.VERDE"
	lang S, db "BONGURI VER"
	db "@"

.itemName_YLW_APRICORN_pronoun
	lang F, db "un "
.itemName_YLW_APRICORN
	lang J, db "きぼんぐり"
	lang E, db "YLW APRICORN"
	lang D, db "APRIKOKO GLB"
	lang F, db "NOIGRUME JNE"
	lang I, db "GHICOC.GIAL."
	lang S, db "BONGURI AMA"
	db "@"

ENDC
