INCLUDE "ranking_types.asm"

IF !DEF(RANKING_1)
DEF RANKING_1 EQUS "BATTLE_TOWER_WINS"
ENDC

IF !DEF(RANKING_{RANKING_1}_FULLNAME)
DEF RANKING_{RANKING_1}_FULLNAME EQUS "{RANKING_{RANKING_1}_NAME}"
ENDC
IF !DEF(RANKING_{RANKING_2}_FULLNAME)
DEF RANKING_{RANKING_2}_FULLNAME EQUS "{RANKING_{RANKING_2}_NAME}"
ENDC
IF !DEF(RANKING_{RANKING_3}_FULLNAME)
DEF RANKING_{RANKING_3}_FULLNAME EQUS "{RANKING_{RANKING_3}_NAME}"
ENDC

IF !DEF(RANKING_{RANKING_1}_FMT_PLAYER)
DEF RANKING_{RANKING_1}_FMT_PLAYER EQUS "{RANKING_{RANKING_1}_FMT}"
ENDC
IF !DEF(RANKING_{RANKING_2}_FMT_PLAYER)
DEF RANKING_{RANKING_2}_FMT_PLAYER EQUS "{RANKING_{RANKING_2}_FMT}"
ENDC
IF !DEF(RANKING_{RANKING_3}_FMT_PLAYER)
DEF RANKING_{RANKING_3}_FMT_PLAYER EQUS "{RANKING_{RANKING_3}_FMT}"
ENDC








	news_screen TrainerRankings, MUSIC_PROF_ELM
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string	1, 2, ""
	lang J, db "トレーナーランキング"
	lang E, db "<TRAINER> RANKINGS"
	lang D, db "BESTENLISTE"
	lang F, db "CLASSEMENT"
	lang I, db "CLASSIFICA ALLEN."
	lang S, db "?"
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuViewRankingsText,   .menuUpdateRankingsText,   .menuRankingsDescriptionText,   .menuReturnText
	news_menuitem_scripts .menuViewRankingsScript, .menuUpdateRankingsScript, .menuRankingsDescriptionScript, .menuReturnScript
	news_menuitem_descs   .menuViewRankingsDesc,   .menuUpdateRankingsDesc,   .menuRankingsDescriptionDesc,   .menuReturnDesc
	

.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret

.b_button
	nsc_playsound SFX_MENU
	nsc_page openingScreen
	nsc_ret

.up_button
	nsc_up
	nsc_ret

.down_button
	nsc_down
	nsc_ret

.menuViewRankingsText
	lang J, db "ランキング　<WO>みる"
	lang E, db "VIEW RANKINGS"
	lang D, db "BETRACHTEN"
	lang F, db "VOIR CLASSEMENT"
	lang I, db "VEDI CLASSIFICHE"
	lang S, db "?"
	db "@"

.menuUpdateRankingsText
	lang J, db "ランキング　<NO>こうしん"
	lang E, db "UPDATE RANKINGS"
	lang D, db "ÜBERTRAGEN"
	lang F, db "MàJ CLASSEMENT"
	lang I, db "AGG. CLASSIFICHE"
	lang S, db "?"
	db "@"

.menuRankingsDescriptionText
	lang J, db "ランキング　<NO>せつめい"
	lang E, db "RANKING INFO"
	lang D, db "BESTENL.-INFO"
	lang F, db "INFO CLASSEMENT"
	lang I, db "INFO CLASSIFICA"
	lang S, db "?"
	db "@"
	
.menuReturnText
	lang J, db "やめる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"

.menuViewRankingsScript
	nsc_compareram sNewsId, 12, sNewsIdBackup, .noRankingsData, .continueToCategoriesScreen, .noRankingsData

.continueToCategoriesScreen
	nsc_page RankingsCategories
	nsc_ret

.noRankingsData
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .noRankingsDataText
	nsc_ret

.menuUpdateRankingsScript
	nsc_update_rankings
	nsc_compare wRankingsUpdateResult, .rankingsUpdated, .rankingsUpdateCancelled, .rankingsUpdateFailed, 1, 1

.rankingsUpdated
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdatedText
	nsc_waitbutton
	nsc_ret

.rankingsUpdateCancelled
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdateCancelledText
	nsc_waitbutton
	nsc_ret

.rankingsUpdateFailed
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdateFailedText
	nsc_waitbutton
	nsc_ret

.rankingsUpdatedText
	lang J, text "ランキング<NO>こうしんを"
	lang J, line "しました！"
	
	lang E, text "Rankings update"
	lang E, line "was successful!"
	
	lang D, text "Bestenlisten wur-"
	lang D, line "den übertragen!"
	
	lang F, text "Mise à jour du"
	lang F, line "classement"
	lang F, cont "réussie!"
	
	lang I, text "Classifiche"
	lang I, line "aggiornate!"
	
	lang S, text "?"
	lang S, line "?"
	
	done

.rankingsUpdateCancelledText
	lang J, text "ランキング<NO>こうしんを"
	lang J, line "やめました"

	lang E, text "Rankings update"
	lang E, line "was stopped."
	
	lang D, text "Die Übertragung"
	lang D, line "wurde abgebrochen."
	
	lang F, text "Mise à jour du"
	lang F, line "classement"
	lang F, cont "arrêtée!"
	
	lang I, text "Aggiornam. classi-"
	lang I, line "fiche interrotto."
	
	lang S, text "?"
	lang S, line "?"
	
	done

.rankingsUpdateFailedText
	lang J, text "ランキング<NO>こうしんに"
	lang J, line "しっぱい⋯"
	lang J, para "あたらしい　ニュースを"
	lang J, line "よみこんで　ください"

	lang E, text "Rankings update"
	lang E, line "has failed…"
	lang E, para "Please download"
	lang E, line "the latest NEWS."
	
	lang D, text "Die Übertragung"
	lang D, line "schlug fehl…"
	lang D, para "Die NACHRICHTEN"
	lang D, line "bitte neu laden."
	
	lang F, text "Mise à jour du"
	lang F, line "classement"
	lang F, cont "échouée..."
	lang F, para "Télécharger les"
	lang F, line "dernières INFOS"
	lang F, cont "s.v.p."
	
	lang I, text "Aggiornamento"
	lang I, line "classifiche…"
	lang I, cont "fallito…"
	lang I, para "Riscarica le"
	lang I, line "NOTIZIE."
	
	lang S, text "?"
	lang S, line "?"
	lang S, para "?"
	lang S, line "?"
	
	
	done

.menuRankingsDescriptionScript
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsDescriptionText
	nsc_waitbutton
	nsc_ret

.menuReturnScript
	nsc_page NewsRoot
	nsc_ret

.rankingsDescriptionText
	text "{RANKING_{RANKING_1}_FULLNAME}"
	lang J, db "は"
	describe_ranking_{RANKING_1}
	; matching weirdness in JP issue 1
	para "{RANKING_{RANKING_3}_FULLNAME}"
	lang J, db "は"
	describe_ranking_{RANKING_3}

	para "{RANKING_{RANKING_2}_FULLNAME}"
	lang J, db "は"
	describe_ranking_{RANKING_2}

	;para "{RANKING_{RANKING_3}_FULLNAME}"
	;lang J, db "は"
	;describe_ranking_{RANKING_3}
	done

.noRankingsDataText
	lang J, text "ランキングデータ<GA>ありません"
	lang J, line "ランキング<NO>こうしん<WO>すれば"
	lang J, cont "みること<GA>できます"
	
	lang E, text "There is no"
	lang E, line "ranking data."
	lang E, para "Link to obtain" 
	lang E, line "ranking data."
	
	lang D, text "Keine Daten zur"
	lang D, line "Bestenliste vor-"
	lang D, cont "handen."
	lang D, para "Aktualisiere die"
	lang D, line "die Daten, um die"
	lang D, para "Bestenliste zu"
	lang D, line "betrachten."
	
	lang F, text "Il n'y a aucune"
	lang F, line "données"
	lang F, cont "de classement."
	lang F, para "Connectez-vous"
	lang F, line "pour obtenir"
	lang F, cont "les données"
	lang F, cont "de classement."
	
	lang I, text "Dati classifiche"
	lang I, line "assenti."
	lang I, para "Collegati per" 
	lang I, line "ottenere i dati."
	
	lang S, text "?"
	lang S, line "?"
	lang S, cont "?"
	
	para
	done

.menuViewRankingsDesc
	lang J, db   "いろいろな　ランキングが"
	lang J, line "みれます"
	
	lang E, db   "View the various"
	lang E, line "rankings."
	
	lang D, db   "Betrachte versch."
	lang D, line "Bestenlisten."
	
	lang F, db   "Voir les diffé-"
	lang F, line "rents classements."
	
	lang I, db   "Guarda le varie"
	lang I, line "classifiche."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"

.menuUpdateRankingsDesc
	lang J, db   "ランキング<WO>よみこみなおします"
	lang J, line  "あなた<NO>せいせきも　かわります"
	
	lang E, db   "Reload rankings to"
	lang E, line "update your score."
	
	lang D, db   "Übertrage und em-"
	lang D, line "pfange Daten."
	
	lang F, db   "MàJ du classement"
	lang F, line "et de vos scores."
	
	lang I, db   "Ricarica classi-"
	lang I, line "fiche e punteggi."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"

.menuRankingsDescriptionDesc
	lang J, db   "こんかい<NO>ランキングの"
	lang J, line  "テーマ<NI>ついて　せつめいします"
	
	lang E, db   "An explanation of"
	lang E, line "ranking themes."
	
	lang D, db   "Eine Erklärung zu"
	lang D, line "einzelnen Listen."
	
	lang F, db   "Infos sur les thé-"
	lang F, line "mes de classement."
	
	lang I, db   "Spiegazione temi"
	lang I, line "classifiche."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"

.menuReturnDesc
	lang J, db   "さいしょ<NO>ぺージ<NI>もどります"
	
	lang E, db   "Return to the"
	lang E, line "first page."
	
	lang D, db   "Zurück zur ersten"
	lang D, line "Seite."
	
	lang F, db   "Retourner à la"
	lang F, line "première page."
	
	lang I, db   "Torna alla"
	lang I, line "prima pagina."
	
	lang S, db   "?"
	
	db "@"


	news_screen RankingsCategories, MUSIC_PROF_ELM
	news_def_pals

	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string	1, 2, ""
	lang J, db "トレーナーランキング"
	lang E, db "<TRAINER> RANKINGS"
	lang D, db "BESTENLISTE"
	lang F, db "CLASSEMENT"
	lang I, db "CLASSIFICA ALLEN."
	lang S, db "?"
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
	
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
	
	news_menuitem_names   .menuitem1_name,   .menuitem2_name,   .menuitem3_name,   .menuitem4_name
	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script
	news_menuitem_descs   .menuitem1_desc,   .menuitem2_desc,   .menuitem3_desc,   .menuitem4_desc
	
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
	; fall through
.menuitem4_script
	nsc_page TrainerRankings
	nsc_ret
	
.menuitem1_name
	db "{RANKING_{RANKING_1}_NAME}@"
.menuitem2_name
	db "{RANKING_{RANKING_2}_NAME}@"
.menuitem3_name
	db "{RANKING_{RANKING_3}_NAME}@"
.menuitem4_name
	lang J, db "もどる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"
	
.menuitem1_script
	nsc_set wRankingsTable, 0
	nsc_set wRankingsCategory, 0
	nsc_page RankingsAreaChoice
	nsc_ret
.menuitem2_script
	nsc_set wRankingsTable, 3
	nsc_set wRankingsCategory, 1
	nsc_page RankingsAreaChoice
	nsc_ret
.menuitem3_script
	nsc_set wRankingsTable, 6
	nsc_set wRankingsCategory, 2
	nsc_page RankingsAreaChoice
	nsc_ret
	
.menuitem1_desc
.menuitem2_desc
.menuitem3_desc
.menuitem4_desc
	lang J, db   "みたい　ランキングを"
	lang J, line "えらんで　ください"
	
	lang E, db   "Please choose a"
	lang E, line "RANKING to view."
	
	lang D, db   "Bitte wähle eine"
	lang D, line "Bestenliste."
	
	lang F, db   "Choisir le classe-"
	lang F, line "ment à voir s.v.p."
	
	lang I, db   "Scegli quale"
	lang I, line "classifica vedere."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"
	
	news_screen RankingsAreaChoice, MUSIC_PROF_ELM
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wRankingsCategory, .ranking1_label, .ranking2_label, .ranking3_label
	nts_end
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
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
	
	news_menuitem_names   .menuitem1_name,   .menuitem2_name,   .menuitem3_name,   .menuitem4_name
	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script
	news_menuitem_descs   .menuitem1_desc,   .menuitem2_desc,   .menuitem3_desc,   .menuitem4_desc
	
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
.start_button
	nsc_playsound SFX_MENU
	nsc_page TrainerRankings
	nsc_ret

.menuitem1_name
	lang J, db "ぜんこく　<NO>ランキング"
	lang E, db "NATIONAL RANKINGS"
	lang D, db "LANDESLISTE"
	lang F, db "CLASSEMENT NATIO."
	lang I, db "CLASSIFICA NAZ."
	lang S, db "?"
	db "@"
.menuitem2_name
	nts_start
	nts_player_region_backup
	nts_end
	lang J, db "　<NO>ランキング"
	lang E, db " RANKINGS"
	lang D, db "-LISTE"
	lang F, db "CLASSEMENT" ; TODO; should there be a space here?
	lang I, db " CLASSIFICA"
	lang S, db "?"
	db "@"
.menuitem3_name
	lang J, db "■" ; post code symbol
	nts_start
	nts_player_zip_backup 3
	nts_end
	lang J, db "　<NO>ランキング"
	lang E, db "×× RANKINGS"
	lang D, db "-LISTE"
	lang F, db "CLASSEMENT" ; TODO; should there be a space here?
	lang I, db " CLASSIFICA"
	lang S, db "?"
	db "@"
	
.menuitem4_name
	lang J, db "もどる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"
	
.menuitem1_script
	nsc_set wRankingsType, 0
	nsc_page Rankings
	nsc_ret
.menuitem2_script
	nsc_add wRankingsTable, 1
	nsc_set wRankingsType, 1
	nsc_page Rankings
	nsc_ret
.menuitem3_script
	nsc_add wRankingsTable, 2
	nsc_set wRankingsType, 2
	nsc_page Rankings
	nsc_ret
.b_button
	nsc_playsound SFX_MENU
	; fall through
.menuitem4_script
	nsc_page RankingsCategories
	nsc_ret
	
.menuitem1_desc
.menuitem2_desc
.menuitem3_desc
.menuitem4_desc
	lang J, db   "みたい　ちいき　を"
	lang J, line "えらんで　ください"
	
	lang E, db   "Choose an area to"
	lang E, line "view the RANKINGS."
	
	lang D, db   "Für welche Region"
	lang D, line "anzeigen?"
	
	lang F, db   "Choisir la zone de"
	lang F, line "classement à voir."
	
	lang I, db   "Scegli dove ved-"
	lang I, line "ere la classifica."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"
.ranking1_label
	db "{RANKING_{RANKING_1}_NAME}@"
.ranking2_label
	db "{RANKING_{RANKING_2}_NAME}@"
.ranking3_label
	db "{RANKING_{RANKING_3}_NAME}@"
	
	news_screen Rankings, MUSIC_PROF_ELM
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wRankingsCategory, .ranking1_title, .ranking2_title, .ranking3_title
	nts_end
	
	lang J, news_string 2, 5, ""
	notlang J, news_string 2, 4, ""
	
	nts_start
	nts_switch wRankingsType, .national_top_10_string, .prefectural_top_10_string, .local_top_10_string
	nts_end


	lang    J, news_menu 2, 7, 1, 3, 0, 2, 16, 4, 7, 3, SHOW_DESCRIPTIONS, $03
	notlang J, news_menu 2, 6, 1, 3, 0, 2, 16, 4, 7, 3, SHOW_DESCRIPTIONS, $03
	
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
	news_loadrankingstable
	
REPT 10
	news_menuitem_names .menuitems_name
ENDR
	news_menuitem_names .lastmenuitem_name
REPT 10
	news_menuitem_scripts .menuitems_script
ENDR
	news_menuitem_scripts .lastmenuitem_script
REPT 11
	news_menuitem_descs .menuitems_desc
ENDR
	
.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret
.b_button
	nsc_playsound SFX_MENU
	nsc_subram wRankingsTable, wRankingsType
	nsc_page RankingsAreaChoice
	nsc_ret
.up_button
	nsc_up
	nsc_ret
.down_button
	nsc_down
	nsc_ret
.start_button
	nsc_playsound SFX_MENU
	nsc_page TrainerRankings
	nsc_ret
.menuitems_name
	nts_start
	nts_switch wRankingsCategory, .menuitems_ranking1, .menuitems_ranking2, .menuitems_ranking3
	db "@"
	
.menuitems_ranking1
	nts_start
	nts_placement 2, 3
	
IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_1}_SPACING};6
	nts_ranking_number $0018, {RANKING_{RANKING_1}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_1}_SPACING}
	nts_ranking_number $0014, {RANKING_{RANKING_1}_FMT} ; compensating for smaller EZChat messages
ENDC
	
	nts_end
	db "{RANKING_{RANKING_1}_UNIT}@"
	
.menuitems_ranking2
	nts_start
	nts_placement 2, 3
	
IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_2}_SPACING}
	nts_ranking_number $0018, {RANKING_{RANKING_2}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_2}_SPACING};20
	nts_ranking_number $0014, {RANKING_{RANKING_2}_FMT} ; compensating for smaller EZChat messages
ENDC
	
	nts_end
	db "{RANKING_{RANKING_2}_UNIT}@"
	
.menuitems_ranking3
	nts_start
	nts_placement 2, 3

IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_3}_SPACING}
	nts_ranking_number $0018, {RANKING_{RANKING_3}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_3}_SPACING}
	nts_ranking_number $0014, {RANKING_{RANKING_3}_FMT} ; compensating for smaller EZChat messages
ENDC
	
	nts_end
	db "{RANKING_{RANKING_3}_UNIT}@"
.lastmenuitem_name
	lang F, db "RANG de "
	lang I, db "GRADO di "
	nts_start
	nts_player_name 0
	nts_end
	lang J, db "　<NO>じゅんい"
	lang E, db "'s RANK"
	lang D, db "s RANG"
	lang F, db ":"
	lang I, db ":"
	lang S, db "?"
	db "@"
.menuitems_script
	nsc_compareram wNewsMenuOption, 1, wNumListedPlayers, .less, .notless, .notless
.less
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .ranked_player_info
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .ranked_player_ezchat
	nsc_ret
.notless
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .no_one_is_ranked_here_text
	nsc_ret

.no_one_is_ranked_here_text
	lang J, db   "ここに<WA>だれも"
	lang J, next "ランクイン　してません"
	
	lang E, db   "No one is"
	lang E, next "ranked here."
	
	lang D, db   "Hier gibt es"
	lang D, next "keinen Eintrag."
	
	lang F, db   "Il n'y a personne"
	lang F, next "de classé ici."
	
	lang I, db   "Nessun classi-"
	lang I, next "ficato qui."
	
	lang S, db   "?"
	lang S, next "?"
	
	para   "@"
	
.lastmenuitem_script
	nsc_compareram wOwnRank, 4, wNumRankedPlayers, .lastmenuitem_lessorequal, .lastmenuitem_lessorequal, .lastmenuitem_greater
	
.lastmenuitem_lessorequal
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .players_ranking_placed
	nsc_compare wOwnRank, .playerplaced_ret, .playerplaced_first, .playerplaced_ret, 4,   $00,$00,$00,$01
.playerplaced_first
	nsc_compare sGSBallFlag, .playerplaced_ret, .not_received_gs_ball, .playerplaced_ret, 1,    0
.not_received_gs_ball
	nsc_set wNewsScratch5, 1
	nsc_ramcopy wNewsScratch5, sGSBallFlag, $0001
	nsc_clear 1, 13, 18, 4 
	nsc_textbox 1, 14, .gs_ball_present_text
	nsc_waitbutton
.playerplaced_ret
	nsc_ret
.lastmenuitem_greater
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .players_ranking
	nsc_ret
	
.gs_ball_present_text
	lang J, text "ランキングで　トップ<WO>とった"
	lang J, next "あなたに⋯"
	lang J, cont "すてきな　プレゼント<GA>あります"
	lang J, cont "おたのしみに！"
	
	lang E, text "For receiving such"
	lang E, next "a high rank,"
	lang E, para "we have a nice"
	lang E, line "gift for you."
	lang E, cont "Enjoy!"
	
	lang D, text "Wer so einen hohen"
	lang D, next "Rang erreicht,"
	lang D, para "verdient ein"
	lang D, line "tolles Geschenk."
	lang D, cont "Bitte schön!"
	
	lang F, text "Pour avoir atteint"
	lang F, next "un rang si haut,"
	lang F, para "voici un beau"
	lang F, line "cadeau pour vous."
	lang F, cont "Profitez-en bien!"
	
	lang I, text "Per aver ricevuto"
	lang I, next "un grado così"
	lang I, cont "alto,"
	lang I, para "ecco un regalo"
	lang I, line "per te."
	lang I, cont "Buon divertimento!"
	
	lang S, text "?"
	
	done
.ranked_player_info
;IF DEF(_LANG_J)
	nts_start 
	nts_ranking_gender $000B, 4
	nts_ranking_number $000A, 1, 3, 4  ; prints one additional space after this number
	nts_end
	lang J, db "さい　"
	lang E, db "yrs. "
	lang D, db "Jahre"
	lang F, db "?"
	lang I, db "?"
	lang S, db "?"
	nts_start
	nts_ranking_region $0007, $7, 
	nts_end
;ELSE
;	nts_start 
;	nts_ranking_number $000A, 1, 3, 3
;	nts_end
;	lang E, db "-year-old "
;	lang D, db "-jährig "
;	lang F, db ""
;	lang I, db ""
;	lang S, db ""
;	nts_start
;	nts_ranking_gender $000B, 4, 
;	nts_end
;	lang E, line "from "
;	lang D, line "aus "
;	lang F, line ""
;	lang I, line ""
;	lang S, line ""
;	nts_start
;	nts_ranking_region $0007, $7, 
;	nts_end
;ENDC
	para "@"
.ranked_player_ezchat
	nts_start
	nts_ranking_ezchat $000C
	nts_end
	para "@"
.players_ranking_placed
	; print score in this category, first
	nts_start
	nts_switch wRankingsCategory, .players_ranking1, .players_ranking2, .players_ranking3
	
	; then, show player their rank!
	lang J, nts_start
	lang J, nts_player_name, 0
	lang J, nts_end
	lang J, db "　<NO>じゅんいは⋯"
	lang J, para
	lang J, nts_start
	lang J, nts_number wOwnRank, 4, 4
	lang J, nts_end
	lang J, db   "　ばん　<NI>ランクイン！"
	lang J, line "おめでとう！"
	
	lang E, nts_start
	lang E, nts_player_name, 0
	lang E, nts_end
	lang E, db "'s RANK is…"
	lang E, para
	lang E, db "RANK "
	lang E, nts_start
	lang E, nts_number wOwnRank, 4, 4
	lang E, nts_end
	lang E, db   "!"
	lang E, line "Congratulations!"
	
	lang D, nts_start
	lang D, nts_player_name, 0
	lang D, nts_end
	lang D, db "s RANG ist…"
	lang D, para
	lang D, nts_start
	lang D, nts_number wOwnRank, 4, 4
	lang D, nts_end
	lang D, db   "!"
	lang D, line "Glückwunsch!"
	
	lang F, db "Le RANG de "
	lang F, nts_start
	lang F, nts_player_name, 0
	lang F, nts_end
	lang F, next "est…"
	lang F, para
	lang F, nts_start
	lang F, nts_number wOwnRank, 4, 4
	lang F, nts_end
	lang F, db   "!"
	lang F, line "Félicitations!"
	
	lang I, db "GRADO di "
	lang I, nts_start
	lang I, nts_player_name, 0
	lang I, nts_end
	lang I, db "è…"
	lang I, para
	lang I, nts_start
	lang I, nts_number wOwnRank, 4, 4
	lang I, nts_end
	lang I, db   "!"
	lang I, line "Complimenti!"
	
	lang S, nts_start
	lang S, nts_player_name, 0
	lang S, nts_end
	lang S, db "?"
	lang S, para
	lang S, nts_start
	lang S, nts_number wOwnRank, 4, 4
	lang S, nts_end
	lang S, db   "?"
	lang S, line "?"
	
	para "@"
.players_ranking
	; print score in this category, first
	nts_start
	nts_switch wRankingsCategory, .players_ranking1, .players_ranking2, .players_ranking3 
	
	; then, tell them the news...
	lang J, nts_start
	lang J, nts_player_name, 0
	lang J, nts_end
	lang J, db   "　<NO>じゅんいは⋯"
	lang J, para  "ランクイン　しなかった⋯"
	lang J, line "ざんねん⋯"
	
	lang E, nts_start
	lang E, nts_player_name, 0
	lang E, nts_end
	lang E, db   "'s RANK is…"
	lang E, para "Not currently in"
	lang E, line "the RANKINGS."
	
	lang D, nts_start
	lang D, nts_player_name, 0
	lang D, nts_end
	lang D, db   "s RANG ist…"
	lang D, para "leider außerhalb"
	lang D, line "der Bestenliste."
	
	lang F, db "Le RANG de "
	lang F, nts_start
	lang F, nts_player_name, 0
	lang F, nts_end
	lang F, next "est…"
	lang F, para "Absent du"
	lang F, line "classement."
	
	lang I, db "GRADO di "
	lang I, nts_start
	lang I, nts_player_name, 0
	lang I, nts_end
	lang I, db   "è…"
	lang I, para "Attualmente non"
	lang I, line "in classifica."
	
	lang S, nts_start
	lang S, nts_player_name, 0
	lang S, nts_end
	lang S, db   "?"
	lang S, para "?"
	lang S, line "?"
	para "@"
	
.players_ranking1
	lang J, nts_start
	lang J, nts_player_name 0 
	lang J, nts_end
	lang J, db "　<NO>せいせきは"
	
	lang E, nts_start
	lang E, nts_player_name 0 
	lang E, nts_end
	lang E, db "'s SCORE:"
	
	lang D, nts_start
	lang D, nts_player_name 0 
	lang D, nts_end
	lang D, db "s PUNKTZAHL:"
	
	lang F, db "SCORE de "
	lang F, nts_start
	lang F, nts_player_name 0 
	lang F, nts_end
	lang F, db ":"
	
	lang I, db "PUNTEG. di "
	lang I, nts_start
	lang I, nts_player_name 0 
	lang I, nts_end
	lang I, db ":"
	
	lang S, nts_start
	lang S, nts_player_name 0 
	lang S, nts_end
	lang S, db "?"
	
	line
	nts_start
	nts_number {RANKING_{RANKING_1}_ADDR}, {RANKING_{RANKING_1}_FMT_PLAYER}
	nts_end
	db "{RANKING_{RANKING_1}_UNIT}"
	para "@" 
	
.players_ranking2
	lang J, nts_start
	lang J, nts_player_name 0 
	lang J, nts_end
	lang J, db "　<NO>せいせきは"
	
	lang E, nts_start
	lang E, nts_player_name 0 
	lang E, nts_end
	lang E, db "'s SCORE:"
	
	lang D, nts_start
	lang D, nts_player_name 0 
	lang D, nts_end
	lang D, db "s PUNKTZAHL:"
	
	lang F, db "SCORE de "
	lang F, nts_start
	lang F, nts_player_name 0 
	lang F, nts_end
	lang F, db ":"
	
	lang I, db "PUNTEG. di "
	lang I, nts_start
	lang I, nts_player_name 0 
	lang I, nts_end
	lang I, db ":"
	
	lang S, nts_start
	lang S, nts_player_name 0 
	lang S, nts_end
	lang S, db "?"
	
	line
	nts_start
	nts_number {RANKING_{RANKING_2}_ADDR}, {RANKING_{RANKING_2}_FMT_PLAYER}
	nts_end
	db "{RANKING_{RANKING_2}_UNIT}"
	para "@"
	
.players_ranking3
	lang J, nts_start
	lang J, nts_player_name 0 
	lang J, nts_end
	lang J, db "　<NO>せいせきは"
	
	lang E, nts_start
	lang E, nts_player_name 0 
	lang E, nts_end
	lang E, db "'s SCORE:"
	
	lang D, nts_start
	lang D, nts_player_name 0 
	lang D, nts_end
	lang D, db "s PUNKTZAHL:" ; TODO; check about PUNKTZAHL vs REKORD
	
	lang F, db "SCORE de "
	lang F, nts_start
	lang F, nts_player_name 0 
	lang F, nts_end
	lang F, db ":"
	
	lang I, db "PUNTEG. di "
	lang I, nts_start
	lang I, nts_player_name 0 
	lang I, nts_end
	lang I, db ":"
	
	lang S, nts_start
	lang S, nts_player_name 0 
	lang S, nts_end
	lang S, db "?"
	
	line
	nts_start
	nts_number {RANKING_{RANKING_3}_ADDR}, {RANKING_{RANKING_3}_FMT_PLAYER}
	nts_end 
	db "{RANKING_{RANKING_3}_UNIT}"
	para "@"
.menuitems_desc
	; cry quiz debug issue text
;	lang J, db   "えらんだ　ひと<NO>データを"
;	lang J, line "みること<GA>できます"
	; first issue text
	lang J, db   "えらんだ　ひと<NO>プロフィールを"
	lang J, line "みること<GA>できます"
	
	lang E, db   "View the profile"
	lang E, line "of this <TRAINER>."
	
	lang D, db   "Profil des"
	lang D, line "<TRAINER>s anzeigen."
	
	lang F, db   "Voir le profil"
	lang F, line "de ce DRESSEUR."
	
	lang I, db   "Guarda il profilo"
	lang I, line "di questo ALLEN."
	
	lang S, db   "?"
	lang S, line "?"
	
	db "@"
.ranking1_title
	db "{RANKING_{RANKING_1}_NAME}@"
.ranking2_title
	db "{RANKING_{RANKING_2}_NAME}@"
.ranking3_title
	db "{RANKING_{RANKING_3}_NAME}@"
.national_top_10_string
	lang J, db "ぜんこく　<NO>トップ１０！"
	lang E, db "NATIONAL TOP 10!"
	lang D, db "LANDES-TOP-10!"
	lang F, db "TOP 10 NATIONAL!"
	lang I, db "TOP 10 NAZIONALE"
	lang S, db "?"
	db "@" 
.prefectural_top_10_string
	nts_start
	nts_player_region_backup
	nts_end
	lang J, db "　<NO>トップ１０！"
	lang E, db " TOP 10!"
	lang D, db " TOP-10!"
	lang F, db " TOP 10!"
	lang I, db " TOP 10!"
	lang S, db "?"
	db "@"
.local_top_10_string
	lang J, db "■" ; post code symbol
	nts_start
	nts_player_zip_backup 3
	nts_end
	lang J, db "　<NO>トップ１０！"
	lang E, db "×× TOP 10!"
	lang D, db " TOP-10!"
	lang F, db " TOP 10!"
	lang I, db " TOP 10!"
	lang S, db "?"
	db "@"
