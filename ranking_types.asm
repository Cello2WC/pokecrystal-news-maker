; --------------------------------
; Ranking 1: Play time when last entered the Hall of Fame
DEF RANKING_GAME_TIME_HOF_ADDR EQUS "sTrainerRankingGameTimeHOFHours"
DEF RANKING_GAME_TIME_HOF_ADDR_MIN EQUS "sTrainerRankingGameTimeHOFMinutes"
DEF RANKING_GAME_TIME_HOF_ADDR_SEC EQUS "sTrainerRankingGameTimeHOFSeconds"
DEF RANKING_GAME_TIME_HOF_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 3\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $0016, PRINTNUM_LEADINGZEROS | 1, 2\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $0017, PRINTNUM_LEADINGZEROS | 1, 2"

; variant excluding seconds
;DEF RANKING_GAME_TIME_HOF_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 3\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $0016, PRINTNUM_LEADINGZEROS | 1, 2"
DEF RANKING_GAME_TIME_HOF_FMT_PLAYER EQUS "PRINTNUM_LEADINGZEROS | 2, 3\nnts_end\ndb $6D\nnts_start\nnts_number {RANKING_GAME_TIME_HOF_ADDR_MIN}, PRINTNUM_LEADINGZEROS | 1, 2\nnts_end\ndb $6D\nnts_start\nnts_number {RANKING_GAME_TIME_HOF_ADDR_SEC}, PRINTNUM_LEADINGZEROS | 1, 2"
DEF RANKING_GAME_TIME_HOF_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "?"
REDEF RANKING_GAME_TIME_HOF_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 3\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $001A, PRINTNUM_LEADINGZEROS | 1, 2\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $001A, PRINTNUM_LEADINGZEROS | 1, 2"
; variant excluding seconds
;REDEF RANKING_GAME_TIME_HOF_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 3\nnts_end\ndb $6D\nnts_start\nnts_ranking_number $001A, PRINTNUM_LEADINGZEROS | 1, 2"
MACRO describe_ranking_GAME_TIME_HOF
	db   "?"
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""

; English
ELIF DEF(_LANG_E)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "LAST HOF RECORD" ; Max 17 chars
; Custom Description
MACRO describe_ranking_GAME_TIME_HOF
	para "The amount of time"
	line "played before the"
	cont "last entry into"
	cont "the HALL OF FAME."
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""

; German
ELIF DEF(_LANG_D)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "SPIELZEIT BEI RH." ; Max 17 chars
MACRO describe_ranking_GAME_TIME_HOF
	para "Spielzeit vor dem"
	line "letzten Eintritt"
	cont "in die RUHMES-"
	cont "HALLE."
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""

; French
ELIF DEF(_LANG_F)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "TEMPS PANTHEON" ; Max 17 chars
MACRO describe_ranking_GAME_TIME_HOF
	para "Temps de jeu à la"
	line "dernière entrée"
	cont "au PANTHEON."
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "TEMPO ULTIMA SDO" ; Max 17 chars
MACRO describe_ranking_GAME_TIME_HOF
	para "Il tempo di gioco"
	line "al momento dell'"
	cont "ultimo ingresso"
	cont "in SALA D'ONORE."  	; this should be nella instead of in, for prettyness' sake, but this works too...
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_GAME_TIME_HOF_NAME EQUS "RÉCORD ÚLTIMO" ; Max 17 chars
MACRO describe_ranking_GAME_TIME_HOF
	para "Cantidad de tiempo"
	line "jugado antes"
	cont "del último"
	cont "HALL de la FAMA."
ENDM
DEF RANKING_GAME_TIME_HOF_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 2: Step count when last entered the Hall of Fame
DEF RANKING_STEP_COUNT_HOF_ADDR EQUS "sTrainerRankingStepCountHOF"
DEF RANKING_STEP_COUNT_HOF_FMT  EQUS "4, 9"
DEF RANKING_STEP_COUNT_HOF_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "?"
MACRO describe_ranking_STEP_COUNT_HOF
	db   "?"
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS ""

; English
ELIF DEF(_LANG_E)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "LAST HOF STEPS" ; Max 17 chars
; Custom Description
MACRO describe_ranking_STEP_COUNT_HOF
	para "The amount of"
	line "steps walked"
	cont "before the last"
	cont "entry into the"
	cont "HALL OF FAME."
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS " steps"
REDEF RANKING_STEP_COUNT_HOF_SPACING EQU -1

; German
ELIF DEF(_LANG_D)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "SCHRITTE BEI RH." ; Max 17 chars
MACRO describe_ranking_STEP_COUNT_HOF
	para "Anzahl der ge-"
	line "laufenen Schritte"
	cont "vor dem letzten"
	cont "Eintritt in die"
	cont "RUHMESHALLE."
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS "?"

; French
ELIF DEF(_LANG_F)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "MARATHON PANTHEON" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT_HOF
	para "Nombre de pas"
	line "faits avant la"
	cont "dernière entrée"
	cont "au PANTHEON."
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS " pas"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "PASSI ULTIMA SDO" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT_HOF
	para "Il numero di"
	line "passi camminati"
	cont "prima dell'ultimo"
	cont "ingresso nella"
	cont "SALA D'ONORE."
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_STEP_COUNT_HOF_NAME EQUS "PASOS ÚLTIMO HALL"
MACRO describe_ranking_STEP_COUNT_HOF
	para "Cantidad de"
	line "pasos caminados"
	cont "antes del último"
	cont "registro del"
	cont "HALL de la FAMA."
ENDM
DEF RANKING_STEP_COUNT_HOF_UNIT EQUS " pasos"
ENDC


; --------------------------------
; Ranking 3: Number of times the party was healed when last entered the Hall of Fame
DEF RANKING_HEALINGS_HOF_ADDR EQUS "sTrainerRankingHealingsHOF"
DEF RANKING_HEALINGS_HOF_FMT  EQUS "4, 9"
DEF RANKING_HEALINGS_HOF_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_HEALINGS_HOF_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_HEALINGS_HOF
	db   "?"
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS ""

; English
ELIF DEF(_LANG_E)
DEF RANKING_HEALINGS_HOF_NAME EQUS "LAST HOF HEALED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_HEALINGS_HOF
	para "The amount of"
	line "times the party"
	cont "has been fully"
	cont "healed before the"
	cont "last entry into"
	cont "the HALL OF FAME."
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS " heals"
REDEF RANKING_HEALINGS_HOF_SPACING EQU 1

; German
ELIF DEF(_LANG_D)
DEF RANKING_HEALINGS_HOF_NAME EQUS "HEILUNGEN BEI RH." ; Max 17 chars
MACRO describe_ranking_HEALINGS_HOF
	para "Anzahl der Team-"
	line "Heilungen vor dem"
	cont "letzten Eintritt"
	cont "in die RUHMES-"
	cont "HALLE."
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS " Heilungen" ; May be too long is 'heilt' valid?
REDEF RANKING_HEALINGS_HOF_SPACING EQU -3

; French
ELIF DEF(_LANG_F)
DEF RANKING_HEALINGS_HOF_NAME EQUS "SOINS PANTHEON" ; Max 17 chars
MACRO describe_ranking_HEALINGS_HOF
	para "Nombre de fois où"
	line "l'équipe a été"
	cont "entièrement"
	cont "soignée avant la"
	cont "dernière entrée"
	cont "au PANTHEON."
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS " soins"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_HEALINGS_HOF_NAME EQUS "CURE ULTIMA SDO" ; Max 17 chars
MACRO describe_ranking_HEALINGS_HOF
	para "Il numero di vol-"
	line "te la tua squadra"
	cont "è stata completa-"
	cont "mente curata"
	cont "prima dell'ultima"
	cont "SALA D'ONORE."
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS " cure" ;

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_HEALINGS_HOF_NAME EQUS "CURAS ÚLTIMO HALL" ; Max 17 chars
MACRO describe_ranking_HEALINGS_HOF
	para "Cantidad de veces"
	line "que el equipo"
	cont "fue totalmente"
	cont "curado antes"
	cont "del último"
	cont "HALL de la FAMA."
ENDM
DEF RANKING_HEALINGS_HOF_UNIT EQUS " curas"
ENDC


; --------------------------------
; Ranking 4: Number of battles when last entered the Hall of Fame
; Copies from Ranking 8 during hall of fame sequence
; INCLUDES:
; - wild battles
; - trainer battles
; - bug contest battles
; - link battles
; - other battle types im forgetting
; EXCLUDES:
; - catching tutorial
DEF RANKING_BATTLES_HOF_ADDR EQUS "sTrainerRankingBattlesHOF"
DEF RANKING_BATTLES_HOF_FMT  EQUS "3, 7"
DEF RANKING_BATTLES_HOF_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_BATTLES_HOF_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_BATTLES_HOF
	db   "?"
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_BATTLES_HOF_NAME EQUS "LAST HOF BATTLES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_BATTLES_HOF
	para "The amount of"
	line "#MON battles"
	cont "before the last"
	cont "entry into the"
	cont "HALL OF FAME."
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS "?"

; German
ELIF DEF(_LANG_D)
DEF RANKING_BATTLES_HOF_NAME EQUS "KÄMPFE BEI RH." ; Max 17 chars
MACRO describe_ranking_BATTLES_HOF
	para "Anzahl der #MON-"
	line "Kämpfe vor dem"
	cont "letzten Eintritt"
	cont "in die RUHMES-"
	cont "HALLE."
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS "?"

; French
ELIF DEF(_LANG_F)
DEF RANKING_BATTLES_HOF_NAME EQUS "COMBATS PANTHEON" ; Max 17 chars
MACRO describe_ranking_BATTLES_HOF
	para "Nombre de combats"
	line "#MON avant la"
	cont "dernière entrée"
	cont "au PANTHEON."
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS "?"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_BATTLES_HOF_NAME EQUS "LOTTE ULTIMA SDO" ; Max 17 chars
MACRO describe_ranking_BATTLES_HOF
	para "Il numero di lot-"
	line "te #MON prima"
	cont "dell'ultima SALA"
	cont "D'ONORE."
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS " lotte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_BATTLES_HOF_NAME EQUS "COMBATES ÚLTIMO" ; Max 17 chars
MACRO describe_ranking_BATTLES_HOF
	para "Cantidad de"
	line "combates #MON"
	cont "antes del"
	cont "último registro"
	cont "del HALL DE FAMA."
ENDM
DEF RANKING_BATTLES_HOF_UNIT EQUS " combates"
ENDC


; --------------------------------
; Ranking 5: Step count
DEF RANKING_STEP_COUNT_ADDR EQUS "sTrainerRankingStepCount"
DEF RANKING_STEP_COUNT_FMT  EQUS "4, 9"
DEF RANKING_STEP_COUNT_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_STEP_COUNT_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT
	db   "?"
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS ""

; English
ELIF DEF(_LANG_E)
DEF RANKING_STEP_COUNT_NAME EQUS "STEPS WALKED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_STEP_COUNT
	para "The total amount"
	line "of steps walked"
	cont "since you first"
	cont "started your"
	cont "adventure."
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS " steps"
REDEF RANKING_STEP_COUNT_SPACING EQU -1

; German
ELIF DEF(_LANG_D)
DEF RANKING_STEP_COUNT_NAME EQUS "SCHRITTE GELAUFEN" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT
	para "Anzahl der ge-"
	line "laufenen Schritte"
	cont "seit dem Beginn"
	cont "deines Abenteuers."
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS " Schritte"

; French
ELIF DEF(_LANG_F)
DEF RANKING_STEP_COUNT_NAME EQUS "NOMBRE DE PAS" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT
	para "Total du nombre de"
	line "pas effectués au"
	cont "cours de votre"
	cont "aventure."
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS " pas"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_STEP_COUNT_NAME EQUS "PASSI CAMMINATI" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT
	para "Il numero di passi"
	line "camminati dall'"
	cont "inizio della tua"
	cont "avventura."
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS " passi"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_STEP_COUNT_NAME EQUS "PASOS CAMINADOS" ; Max 17 chars
MACRO describe_ranking_STEP_COUNT
	para "Cantidad total"
	line "total de pasos"
	cont "que has dado"
	cont "desde el inicio"
	cont "de tu aventura."
ENDM
DEF RANKING_STEP_COUNT_UNIT EQUS " pasos"
ENDC


; --------------------------------
; Ranking 6: Number of Battle Tower Wins
DEF RANKING_BATTLE_TOWER_WINS_ADDR EQUS "sTrainerRankingBattleTowerWins"
; 2, 5, SPACING=1 matches. 4, (6 or 7) works
;DEF RANKING_BATTLE_TOWER_WINS_FMT  EQUS "2, 5"
DEF RANKING_BATTLE_TOWER_WINS_FMT  EQUS "4, 7"
DEF RANKING_BATTLE_TOWER_WINS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "バトルタワーで　かった　かいすう" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	db   "４０ばんどうろ<NO>バトルタワーで"
	cont "あなた<GA>これまで<NI>なんにんの"
	cont "<TRAINER>と<NO>しょうぶ<NI>かったか"
	cont "にんずうで　きそいます"
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "BATTLE TOWER WINS" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	para "The number of"
	line "#MON battles"
	cont "won against other"
	cont "<TRAINER>S at the"
	cont "BATTLE TOWER on"
	cont "ROUTE 40."
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS " wins"
REDEF RANKING_BATTLE_TOWER_WINS_SPACING EQU 2
; Rework in other languages (?)

; German
ELIF DEF(_LANG_D)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "DUELLTURM-SIEGE" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	para "Anzahl der"
	line "gewonnenen"
	cont "#MON-Kämpfe"
	cont "gegen andere"
	cont "<TRAINER> beim"
	cont "DUELLTURM auf"
	cont "ROUTE 40."
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS " Punkte"
REDEF RANKING_BATTLE_TOWER_WINS_SPACING EQU 0

; French
ELIF DEF(_LANG_F)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "TOUR DE COMBAT" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	para "Nombre de"
	line "combats #MON"
	cont "gagnés contre les"
	cont "<TRAINER>S dans"
	cont "la TOUR de COMBAT"
	cont "sur la ROUTE 40."
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS " points"
REDEF RANKING_BATTLE_TOWER_WINS_SPACING EQU 0

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "TORRE LOTTA" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	para "Il numero di lotte"
	line "#MON vinte"
	cont "contro gli"
	cont "ALLENATORI alla"
	cont "TORRE LOTTA sul"
	cont "PERCORSO 40."
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS " punti"
REDEF RANKING_BATTLE_TOWER_WINS_SPACING EQU 1

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_BATTLE_TOWER_WINS_NAME EQUS "TORRE BATALLA" ; Max 17 chars
MACRO describe_ranking_BATTLE_TOWER_WINS
	para "Número de"
	line "combates #MON"
	cont "ganados ante otros"
	cont "<TRAINER>S en la"
	cont "TORRE BATALLA de"
	cont "la RUTA 40."
ENDM
DEF RANKING_BATTLE_TOWER_WINS_UNIT EQUS " victorias"
ENDC


; --------------------------------
; Ranking 7: Number of times TMs and HMs have been taught
DEF RANKING_TMS_HMS_TAUGHT_ADDR EQUS "sTrainerRankingTMsHMsTaught"
DEF RANKING_TMS_HMS_TAUGHT_FMT  EQUS "3, 7"
DEF RANKING_TMS_HMS_TAUGHT_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "?"
MACRO describe_ranking_TMS_HMS_TAUGHT
	db   "?"
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "TMs/HMs TAUGHT" ; Max 17 chars
; Custom Description
MACRO describe_ranking_TMS_HMS_TAUGHT
	para "The total amount"
	line "of TMs and HMs"
	cont "taught to #MON."
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS " taught"

; German
ELIF DEF(_LANG_D)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "TMs/VMs-EINSATZ" ; Max 17 chars
MACRO describe_ranking_TMS_HMS_TAUGHT
	para "Gesamtzahl der"
	line "TMs oder VMs, die"
	cont "#MON beige-"
	cont "bracht wurden."
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS " eingesetzt"

; French
ELIF DEF(_LANG_F)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "CT/CS UTILISEES" ; Max 17 chars
MACRO describe_ranking_TMS_HMS_TAUGHT
	para "Nombre total de"
	line "CT et CS apprises"
	cont "à des #MON."
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS " apprises"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "MT/MN INSEGNATE" ; Max 17 chars
MACRO describe_ranking_TMS_HMS_TAUGHT
	para "Il numero di MT e"
	line "MN insegnate ai"
	cont "tuoi #MON."
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS " insegnate"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_TMS_HMS_TAUGHT_NAME EQUS "MT/MO ENSEÑADAS" ; Max 17 chars
MACRO describe_ranking_TMS_HMS_TAUGHT
	para "Cantidad total"
	line "de MT y MOs"
	cont "usadas en #MON."
ENDM
DEF RANKING_TMS_HMS_TAUGHT_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 8: Number of battles
; incremented during `BattleIntro`
; INCLUDES:
; - wild battles
; - trainer battles
; - bug contest battles
; - link battles
; - other battle types im forgetting
; SPECIFICALLY EXCLUDES:
; - catching tutorial
DEF RANKING_BATTLES_ADDR EQUS "sTrainerRankingBattles"
DEF RANKING_BATTLES_FMT  EQUS "3, 7"
DEF RANKING_BATTLES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_BATTLES_NAME EQUS "ポケモンと　たたかった　かいすう"
MACRO describe_ranking_BATTLES
	db   "?"
ENDM
DEF RANKING_BATTLES_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_BATTLES_NAME EQUS "#MON BATTLES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_BATTLES
	para "The total amount"
	line "of #MON battles"
	cont "participated in."
ENDM
DEF RANKING_BATTLES_UNIT EQUS " battles"

; German
ELIF DEF(_LANG_D)
DEF RANKING_BATTLES_NAME EQUS "#MON-KÄMPFE" ; Max 17 chars
MACRO describe_ranking_BATTLES
	para "Gesamtzahl der"
	line "durchgeführten"
	cont "#MON-Kämpfe."
ENDM
DEF RANKING_BATTLES_UNIT EQUS " Kämpfe"

; French
ELIF DEF(_LANG_F)
DEF RANKING_BATTLES_NAME EQUS "COMBATS #MON" ; Max 17 chars
MACRO describe_ranking_BATTLES
	para "Nombre total de"
	line "combats #MON"
	cont "livrés."
ENDM
DEF RANKING_BATTLES_UNIT EQUS " combats"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_BATTLES_NAME EQUS "LOTTE #MON" ; Max 17 chars
MACRO describe_ranking_BATTLES
	para "Il totale delle"
	line "lotte #MON a"
	cont "cui hai parteci-"
	cont "pato."
ENDM
DEF RANKING_BATTLES_UNIT EQUS " lotte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_BATTLES_NAME EQUS "#MON COMBATES" ; Max 17 chars
MACRO describe_ranking_BATTLES
	para "Cantidad total"
	line "de luchas #MON"
	cont "en que luchaste."
ENDM
DEF RANKING_BATTLES_UNIT EQUS " combates"
ENDC


; --------------------------------
; Ranking 9: Number of wild Pokémon battles
; incremented during `InitEnemyWildmon`
; INCLUDES
; - wild battles
; - bug contest battles
; EXCLUDES:
; - catching tutorial
; - trainer battles
; - link battles
DEF RANKING_WILD_BATTLES_ADDR EQUS "sTrainerRankingWildBattles"
DEF RANKING_WILD_BATTLES_FMT  EQUS "3, 7"
DEF RANKING_WILD_BATTLES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_WILD_BATTLES_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
	db   "?"
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_WILD_BATTLES_NAME EQUS "#MON ENCOUNTER" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
; Custom Description
	para "The total amount"
	line "of encounters"
	cont "with wild #MON."
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_WILD_BATTLES_NAME EQUS "#MON BEGEGNET" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
	para "Gesamtzahl der"
	line "wilden #MON,"
	cont "die dir begegnet"
	cont "sind."
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
; "RENCONTRES POKéMON" fait malheureusement 18 caractères u_u
DEF RANKING_WILD_BATTLES_NAME EQUS "#MON SAUVAGES" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
	para "Total du nombre de"
	line "#MON sauvages"
	cont "rencontrés."
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS " rencontres" ; Sinon, "combats"?

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_WILD_BATTLES_NAME EQUS "#MON SELVATICI" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
	para "Il totale di"
	line "#MON selvatici"
	cont "incontrati."
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_WILD_BATTLES_NAME EQUS "ENCUENTROS" ; Max 17 chars
MACRO describe_ranking_WILD_BATTLES
	para "Cantidad total"
	line "de encuentros"
	cont "con #MON salv."
ENDM
DEF RANKING_WILD_BATTLES_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 10: Number of Trainer battles
; incremented during `InitEnemyTrainer`
; INCLUDES
; - trainer battles
; - link battles
; EXCLUDES:
; - catching tutorial
; - wild battles
; - bug contest battles
DEF RANKING_TRAINER_BATTLES_ADDR EQUS "sTrainerRankingTrainerBattles"
DEF RANKING_TRAINER_BATTLES_FMT  EQUS "3, 7"
DEF RANKING_TRAINER_BATTLES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "?"
MACRO describe_ranking_TRAINER_BATTLES
	db   "?"
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "<TRAINER> BATTLES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_TRAINER_BATTLES
	para "The total amount"
	line "of #MON battles"
	cont "had with other"
	cont "trainers."
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS " battles"

; German
ELIF DEF(_LANG_D)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "<TRAINER>-KÄMPFE" ; Max 17 chars
MACRO describe_ranking_TRAINER_BATTLES
	para "Gesamtzahl der"
	line "#MON-Kämpfe,"
	cont "die du mit anderen"
	cont "Trainern durch-"
	cont "geführt hast."
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS " Kämpfe"

; French
ELIF DEF(_LANG_F)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "COMBATS <TRAINER>" ; Max 17 chars
MACRO describe_ranking_TRAINER_BATTLES
	para "Total du nombre de"
	line "combats #MON"
	cont "livrés contre"
	cont "d'autres dresseurs." ; "d'" = 1 caractère !
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS " combats"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "LOTTE ALLENATORI" ; Max 17 chars
MACRO describe_ranking_TRAINER_BATTLES
	para "Il totale delle"
	line "lotte contro"
	cont "altri allenatori."
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS " lotte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_TRAINER_BATTLES_NAME EQUS "COMB. ENTRENADOR" ; Max 17 chars
MACRO describe_ranking_TRAINER_BATTLES
	para "Cantidad total"
	line "de combates #MON"
	cont "que has tenido"
	cont "con entrenadores."
ENDM
DEF RANKING_TRAINER_BATTLES_UNIT EQUS " combates"
ENDC


; --------------------------------
; Ranking 11: Unused 1
DEF RANKING_UNUSED_1_ADDR EQUS "sTrainerRankingUnused1"
DEF RANKING_UNUSED_1_FMT  EQUS "3, 8"
DEF RANKING_UNUSED_1_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_UNUSED_1_NAME EQUS "?"
MACRO describe_ranking_UNUSED_1
	db   "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_UNUSED_1_NAME EQUS "?"
MACRO describe_ranking_UNUSED_1
	para "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS "?"

; German
ELIF DEF(_LANG_D)
DEF RANKING_UNUSED_1_NAME EQUS "?"
MACRO describe_ranking_UNUSED_1
	para "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS "?"

; French
ELIF DEF(_LANG_F)
DEF RANKING_UNUSED_1_NAME EQUS "?"
MACRO describe_ranking_UNUSED_1
	para "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS "?"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_UNUSED_1_NAME EQUS "?"
MACRO describe_ranking_UNUSED_1
	para "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_UNUSED_1_NAME EQUS "NO USADO 1"
MACRO describe_ranking_UNUSED_1
	para "?"
ENDM
DEF RANKING_UNUSED_1_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 12: Number of Hall of Fame inductions
DEF RANKING_HOF_ENTRIES_ADDR EQUS "sTrainerRankingHOFEntries"
DEF RANKING_HOF_ENTRIES_FMT  EQUS "3, 7"
DEF RANKING_HOF_ENTRIES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_HOF_ENTRIES_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_HOF_ENTRIES
	db   "?"
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_HOF_ENTRIES_NAME EQUS "HOF ENTRIES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_HOF_ENTRIES
	para "The total amount"
	line "of inductions"
	cont "into the HALL OF"
	cont "FAME."
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS " entries"

; German
ELIF DEF(_LANG_D)
DEF RANKING_HOF_ENTRIES_NAME EQUS "RH-EINTRÄGE" ; Max 17 chars
MACRO describe_ranking_HOF_ENTRIES
	para "Gesamtzahl der"
	line "Einträge in der"
	cont "RUHMESHALLE."
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS " Einträge"

; French
ELIF DEF(_LANG_F)
DEF RANKING_HOF_ENTRIES_NAME EQUS "CELEBRITES" ; Max 17 chars
MACRO describe_ranking_HOF_ENTRIES
	para "Nombre de fois où"
	line "votre nom a été"
	cont "inscrit au"
	cont "PANTHEON."
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_HOF_ENTRIES_NAME EQUS "VOLTE IN SDO" ; Max 17 chars
MACRO describe_ranking_HOF_ENTRIES
	para "Quante volte hai"
	line "raggiunto la"
	cont "SALA D'ONORE"
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_HOF_ENTRIES_NAME EQUS "ENTRADAS HALL" ; Max 17 chars
MACRO describe_ranking_HOF_ENTRIES
	para "Cantidad total"
	line "de veces que has"
	cont "entrado en el"
	cont "HALL de la FAMA."	
ENDM
DEF RANKING_HOF_ENTRIES_UNIT EQUS " entradas"
ENDC


; --------------------------------
; Ranking 13: Number of wild Pokémon caught
DEF RANKING_WILD_MONS_CAUGHT_ADDR EQUS "sTrainerRankingWildMonsCaught"
DEF RANKING_WILD_MONS_CAUGHT_FMT  EQUS "3, 7"
DEF RANKING_WILD_MONS_CAUGHT_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "つかまえた　ポケモンの　かず" ; Max 17 chars
MACRO describe_ranking_WILD_MONS_CAUGHT
	db   "?"
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS "ひき"

; English
ELIF DEF(_LANG_E)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "#MON CAUGHT" ; Max 17 chars
; Custom Description
MACRO describe_ranking_WILD_MONS_CAUGHT
	para "The total amount"
	line "of wild #MON"
	cont "caught."
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS " caught"

; German
ELIF DEF(_LANG_D)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "#MON GEFANGEN" ; Max 17 chars
MACRO describe_ranking_WILD_MONS_CAUGHT
	para "Gesamtzahl der"
	line "gefangenen wilden"
	cont "#MON."
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS " gefangen"

; French
ELIF DEF(_LANG_F)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "#MON CAPTURES" ; Max 17 chars
MACRO describe_ranking_WILD_MONS_CAUGHT
	para "Total du nombre de"
	line "#MON sauvages"
	cont "capturés."
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS " capturés"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "#MON CATTURATI" ; Max 17 chars
MACRO describe_ranking_WILD_MONS_CAUGHT
	para "Il totale dei"
	line "#MON selvatici"
	cont "catturati."
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS " catturati"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_WILD_MONS_CAUGHT_NAME EQUS "CAPTURADOS" ; Max 17 chars
MACRO describe_ranking_WILD_MONS_CAUGHT
	para "Cantidad total de"
	line "#MON salvajes"
	cont "capturados."	
ENDM
DEF RANKING_WILD_MONS_CAUGHT_UNIT EQUS " #MON"
ENDC


; --------------------------------
; Ranking 14: Number of hooked Pokémon encounters
DEF RANKING_HOOKED_ENCOUNTERS_ADDR EQUS "sTrainerRankingHookedEncounters"
DEF RANKING_HOOKED_ENCOUNTERS_FMT  EQUS "3, 7"
DEF RANKING_HOOKED_ENCOUNTERS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "ポケモンを　つった　かいすう" ; Max 17 chars
MACRO describe_ranking_HOOKED_ENCOUNTERS
	db   "?"
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "#MON HOOKED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_HOOKED_ENCOUNTERS
	para "The total amount"
	line "of #MON"
	cont "encountered while"
	cont "fishing."
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS " hooked"

; German
ELIF DEF(_LANG_D)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "#MON GEANGELT" ; Max 17 chars
MACRO describe_ranking_HOOKED_ENCOUNTERS
	para "Gesamtzahl der"
	line "geangelten wilden"
	cont "#MON."
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS " geangelt"

; French
ELIF DEF(_LANG_F)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "#MON FERRES" ; Max 17 chars
MACRO describe_ranking_HOOKED_ENCOUNTERS
	para "Total du nombre de"
	line "#MON ferrés"
	cont "par CANNE."
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS " ferrés"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "#MON PESCATI" ; Max 17 chars
MACRO describe_ranking_HOOKED_ENCOUNTERS
	para "Il totale dei"
	line "#MON pescati."
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS " pescati"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_HOOKED_ENCOUNTERS_NAME EQUS "#MON PICADOS" ; Max 17 chars
MACRO describe_ranking_HOOKED_ENCOUNTERS
	para "Cantidad total"
	line "de #MON"
	cont "hallados mientras"
	cont "estabas pescando."	
ENDM
DEF RANKING_HOOKED_ENCOUNTERS_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 15: Number of Eggs hatched
DEF RANKING_EGGS_HATCHED_ADDR EQUS "sTrainerRankingEggsHatched"
DEF RANKING_EGGS_HATCHED_FMT  EQUS "3, 7"
DEF RANKING_EGGS_HATCHED_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_EGGS_HATCHED_NAME EQUS "タマゴを　かえした　かいすう" ; Max 17 chars
MACRO describe_ranking_EGGS_HATCHED
	db   "?"
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_EGGS_HATCHED_NAME EQUS "EGGS HATCHED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_EGGS_HATCHED
	para "The total amount"
	line "of #MON that"
	cont "have been hatched"
	cont "from an EGG."
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS " EGGS"

; German
ELIF DEF(_LANG_D)
DEF RANKING_EGGS_HATCHED_NAME EQUS "EIER GESCHLÜPFT" ; Max 17 chars
MACRO describe_ranking_EGGS_HATCHED
	para "Gesamtzahl der"
	line "ausgebrüteten"
	cont "#MON-EIER."
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS " EIER"

; French
ELIF DEF(_LANG_F)
DEF RANKING_EGGS_HATCHED_NAME EQUS "OEUFS ECLOS" ; Max 17 chars
MACRO describe_ranking_EGGS_HATCHED
	para "Total du nombre de"
	line "#MON sortis"
	cont "d'un OEUF."
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS " OEUFS"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_EGGS_HATCHED_NAME EQUS "UOVA SCHIUSE" ; Max 17 chars
MACRO describe_ranking_EGGS_HATCHED
	para "Il totale delle"
	line "uova #MON"
	cont "schiuse."
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS " uova"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_EGGS_HATCHED_NAME EQUS "HUEVOS NACIDOS" ; Max 17 chars
MACRO describe_ranking_EGGS_HATCHED
	para "Cantidad total"
	line "de #MON que"
	cont "han eclosionado"	
	cont "de un HUEVO."
ENDM
DEF RANKING_EGGS_HATCHED_UNIT EQUS " huevos"
ENDC


; --------------------------------
; Ranking 16: Number of Pokémon evolved
DEF RANKING_MONS_EVOLVED_ADDR EQUS "sTrainerRankingMonsEvolved"
DEF RANKING_MONS_EVOLVED_FMT  EQUS "3, 7"
DEF RANKING_MONS_EVOLVED_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_MONS_EVOLVED_NAME EQUS "ポケモンが　しんかした　かいすう" ; Max 17 chars
MACRO describe_ranking_MONS_EVOLVED
	db   "?"
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_MONS_EVOLVED_NAME EQUS "#MON EVOLVED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_MONS_EVOLVED
	para "The total amount"
	line "of times #MON"
	cont "have evolved."
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS " evolved"

; German
ELIF DEF(_LANG_D)
DEF RANKING_MONS_EVOLVED_NAME EQUS "#MON ENTWICKELT" ; Max 17 chars
MACRO describe_ranking_MONS_EVOLVED
	para "Gesamtzahl der"
	line "#MON, die sich"
	cont "weiterentwickelt"
	cont "haben."
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS " entwickelt"

; French
ELIF DEF(_LANG_F)
DEF RANKING_MONS_EVOLVED_NAME EQUS "EVOLUTIONS #MON" ; Max 17 chars
MACRO describe_ranking_MONS_EVOLVED
	para "Total du nombre de"
	line "#MON qui ont"
	cont "évolué."
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS " évolutions"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_MONS_EVOLVED_NAME EQUS "#MON EVOLUTI" ; Max 17 chars
MACRO describe_ranking_MONS_EVOLVED
	para "Il totale delle"
	line "evoluzioni dei"
	cont "tuoi #MON."
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS " evoluti"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_MONS_EVOLVED_NAME EQUS "EVOLUCIONADOS" ; Max 17 chars
MACRO describe_ranking_MONS_EVOLVED
	para "Cantidad total"
	line "de #MON que has"
	cont "evolucionado."
ENDM
DEF RANKING_MONS_EVOLVED_UNIT EQUS " #MON"
ENDC


; --------------------------------
; Ranking 17: Number of Berries and Apricorns picked
; includes any item obtained from a "fruit tree" object
DEF RANKING_FRUIT_PICKED_ADDR EQUS "sTrainerRankingFruitPicked"
DEF RANKING_FRUIT_PICKED_FMT  EQUS "3, 7"
DEF RANKING_FRUIT_PICKED_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_FRUIT_PICKED_NAME EQUS "とった　きのみの　かず" ; Max 17 chars
MACRO describe_ranking_FRUIT_PICKED
	db   "?"
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS "こ"

; English
ELIF DEF(_LANG_E)
; name "FRUIT" was chosen because of the first line
; when interacting with the berry/apricorn tree object:
; "It's a fruit-bearing tree."
DEF RANKING_FRUIT_PICKED_NAME EQUS "FRUIT PICKED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_FRUIT_PICKED
	para "The total amount"
	line "of BERRIES and"
	cont "APRICORNS picked"
	cont "from trees."
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS " fruit"
REDEF RANKING_FRUIT_PICKED_SPACING EQU 1

; German
ELIF DEF(_LANG_D)
DEF RANKING_FRUIT_PICKED_NAME EQUS "OBST GEPFLÜCKT" ; Max 17 chars
MACRO describe_ranking_FRUIT_PICKED
	para "Gesamtzahl der"
	line "BEEREN und"
	cont "APRIKOKOS, die von"
	cont "Obstbäumen ge-"
	cont "pflückt wurden."
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS " Stück"
REDEF RANKING_FRUIT_PICKED_SPACING EQU 1

; French
ELIF DEF(_LANG_F)
DEF RANKING_FRUIT_PICKED_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_FRUIT_PICKED
	para "Total du nombre de"
	line "BAIES et NOIGRUMES"
	cont "ramassées sur des"
	cont "arbres."
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS " fruits"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_FRUIT_PICKED_NAME EQUS "FRUTTI RACCOLTI" ; Max 17 chars
MACRO describe_ranking_FRUIT_PICKED
	para "Il totale di BAC-"
	line "CHE e GHICOCCHE"
	cont "raccolte dalle"
	cont "piante da frutta."
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS " frutti"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_FRUIT_PICKED_NAME EQUS "FRUTA RECOGIDA" ; Max 17 chars
MACRO describe_ranking_FRUIT_PICKED
	para "Cantidad total"
	line "de BAYAS y"
	cont "BONGURIS recogidos"
	cont "de los árboles."	
ENDM
DEF RANKING_FRUIT_PICKED_UNIT EQUS " frutas"
ENDC


; --------------------------------
; Ranking 18: Number of times the party is healed
; INCLUDES
; - the healing machine in elm's lab
; - sleeping in your cabin in the fast ship
; - being healed before a mobile battle
; - the scene with mr. pokémon and oak at the start of the game
; - the healer on rt. 26
; - lance healing the party in rocket base b2f
; - pokémon center nurse
; - pokécom center nurse
DEF RANKING_HEALINGS_ADDR EQUS "sTrainerRankingHealings"
DEF RANKING_HEALINGS_FMT  EQUS "3, 7"
DEF RANKING_HEALINGS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_HEALINGS_NAME EQUS "?"
MACRO describe_ranking_HEALINGS
	db   "?"
ENDM
DEF RANKING_HEALINGS_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_HEALINGS_NAME EQUS "PARTY HEALED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_HEALINGS
	para "The total amount"
	line "of times the party"
	cont "has been fully"
	cont "healed."
ENDM
DEF RANKING_HEALINGS_UNIT EQUS " heals"
REDEF RANKING_HEALINGS_SPACING EQU 1

; German
ELIF DEF(_LANG_D)
DEF RANKING_HEALINGS_NAME EQUS "TEAM GEHEILT" ; Max 17 chars
MACRO describe_ranking_HEALINGS
	para "Gesamtzahl der"
	line "Team-Heilungen."
ENDM
DEF RANKING_HEALINGS_UNIT EQUS " Heilungen"
REDEF RANKING_HEALINGS_SPACING EQU -3

; French
ELIF DEF(_LANG_F)
DEF RANKING_HEALINGS_NAME EQUS "SOINS D'EQUIPE" ; Max 17 chars
MACRO describe_ranking_HEALINGS
	para "Total du nombre de"
	line "fois où l'équipe a"
	cont "été entièrement"
	cont "soignée."
ENDM
DEF RANKING_HEALINGS_UNIT EQUS " soins"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_HEALINGS_NAME EQUS "CURE SQUADRA" ; Max 17 chars
MACRO describe_ranking_HEALINGS
	para "Il numero di vol-"
	line "te la tua squadra"
	cont "è stata completa-"
	cont "mente curata."
ENDM
DEF RANKING_HEALINGS_UNIT EQUS " cure"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_HEALINGS_NAME EQUS "CURAS TOTALES" ; Max 17 chars
MACRO describe_ranking_HEALINGS
	para "Cantidad total"
	line "de veces que el"
	cont "equipo ha sido"
	cont "totalmente curado."
ENDM
DEF RANKING_HEALINGS_UNIT EQUS " curas"
ENDC


; --------------------------------
; Ranking 19: Number of times Mystery Gift is used
DEF RANKING_MYSTERY_GIFT_ADDR EQUS "sTrainerRankingMysteryGift"
DEF RANKING_MYSTERY_GIFT_FMT  EQUS "3, 7"
DEF RANKING_MYSTERY_GIFT_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "ふしぎな　おくりものの　かいすう" ; Max 17 chars
MACRO describe_ranking_MYSTERY_GIFT
	db   "?"
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "MYSTERY GIFT USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_MYSTERY_GIFT
	para "The total amount"
	line "of times MYSTERY"
	cont "GIFT has been"
	cont "used."
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS " gifts"
REDEF RANKING_MYSTERY_GIFT_SPACING EQU 1

; German
ELIF DEF(_LANG_D)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "GEHEIMGABE GENUTZT" ; Max 17 chars
MACRO describe_ranking_MYSTERY_GIFT
	para "Gesamtzahl der"
	line "erfolgreichen"
	cont "GEHEIMGABE-"
	cont "Vorgänge."
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS " Mal"
REDEF RANKING_MYSTERY_GIFT_SPACING EQU 3

; French
ELIF DEF(_LANG_F)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "CADEAUX MYSTERE" ; Max 17 chars
MACRO describe_ranking_MYSTERY_GIFT
	para "Total du nombre"
	line "d'utilisations du"
	cont "CADEAU MYSTERE."
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "DONI SEGRETI DATI" ; Max 17 chars
MACRO describe_ranking_MYSTERY_GIFT
	para "Il numero di volte"
	line "il DONO SEGRETO è"
	cont "stato usato."
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS " doni"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_MYSTERY_GIFT_NAME EQUS "REGALO MISTERIOSO" ; Max 17 chars
MACRO describe_ranking_MYSTERY_GIFT
	para "Cantidad total"
	line "de veces que"
	cont "has usado"
	cont "REGALO MISTERIOSO."
ENDM
DEF RANKING_MYSTERY_GIFT_UNIT EQUS " regalos"
ENDC


; --------------------------------
; Ranking 20: Number of trades
DEF RANKING_TRADES_ADDR EQUS "sTrainerRankingTrades"
DEF RANKING_TRADES_FMT  EQUS "3, 7"
DEF RANKING_TRADES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_TRADES_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_TRADES
	db   "?"
ENDM
DEF RANKING_TRADES_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_TRADES_NAME EQUS "TRADES COMPLETED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_TRADES
	para "The total amount"
	line "of successful"
	cont "#MON trades."
ENDM
DEF RANKING_TRADES_UNIT EQUS " trades"

; German
ELIF DEF(_LANG_D)
DEF RANKING_TRADES_NAME EQUS "TAUSCHVORGÄNGE" ; Max 17 chars
MACRO describe_ranking_TRADES
	para "Gesamtzahl der"
	line "erfolgreichen"
	cont "#MON-Tausch-"
	cont "vorgänge."
ENDM
DEF RANKING_TRADES_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_TRADES_NAME EQUS "ECHANGES TERMINES" ; Max 17 chars
MACRO describe_ranking_TRADES
	para "Total du nombre"
	line "d'échanges"
	cont "effectués"
	cont "avec succès."
ENDM
DEF RANKING_TRADES_UNIT EQUS " échanges"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_TRADES_NAME EQUS "SCAMBI CONCLUSI" ; Max 17 chars
MACRO describe_ranking_TRADES
	para "Il numero di"
	line "scambi #MON"
	cont "effettuati."
ENDM
DEF RANKING_TRADES_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_TRADES_NAME EQUS "CAMBIOS HECHOS" ; Max 17 chars
MACRO describe_ranking_TRADES
	para "Cantidad total"
	line "de intercambios"
	cont "#MON con éxito."
ENDM
DEF RANKING_TRADES_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 21: Number of uses of field move Fly
DEF RANKING_FLY_ADDR EQUS "sTrainerRankingFly"
DEF RANKING_FLY_FMT  EQUS "3, 7"
DEF RANKING_FLY_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_FLY_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_FLY
	db   "?"
ENDM
DEF RANKING_FLY_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_FLY_NAME EQUS "FLY USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_FLY
	para "The total amount"
	line "of times FLY was"
	cont "used outside of"
	cont "battle."
ENDM
DEF RANKING_FLY_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_FLY_NAME EQUS "FLIEGEN-EINSATZ" ; Max 17 chars
MACRO describe_ranking_FLY
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "FLIEGEN außerhalb"
	cont "von Kämpfen."
ENDM
DEF RANKING_FLY_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_FLY_NAME EQUS "VOL HORS COMBAT" ; Max 17 chars
MACRO describe_ranking_FLY
	para "Total du nombre"
	line "d'utilisations de"
	cont "VOL hors combat."
ENDM
DEF RANKING_FLY_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_FLY_NAME EQUS "USI VOLO" ; Max 17 chars
MACRO describe_ranking_FLY
	para "Il numero di volte"
	line "VOLO è stato usato"
	cont "fuori dalla lotta."
ENDM
DEF RANKING_FLY_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_FLY_NAME EQUS "VUELO USADO" ; Max 17 chars
MACRO describe_ranking_FLY
	para "Cantidad total"
	line "de veces que VUELO"
	cont "se ha usado fuera"
	cont "de combate."	
ENDM
DEF RANKING_FLY_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 22: Number of uses of field move Surf
DEF RANKING_SURF_ADDR EQUS "sTrainerRankingSurf"
DEF RANKING_SURF_FMT  EQUS "3, 7"
DEF RANKING_SURF_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_SURF_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_SURF
	db   "?"
ENDM
DEF RANKING_SURF_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_SURF_NAME EQUS "SURF USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_SURF
	para "The total amount"
	line "of times SURF was"
	cont "used outside of"
	cont "battle."
ENDM
DEF RANKING_SURF_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_SURF_NAME EQUS "SURFER-EINSATZ" ; Max 17 chars
MACRO describe_ranking_SURF
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "SURFER außerhalb"
	cont "von Kämpfen."
ENDM
DEF RANKING_SURF_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_SURF_NAME EQUS "SURF HORS COMBAT" ; Max 17 chars
MACRO describe_ranking_SURF
	para "Total du nombre"
	line "d'utilisations de"
	cont "SURF hors combat."
ENDM
DEF RANKING_SURF_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_SURF_NAME EQUS "USI SURF" ; Max 17 chars
MACRO describe_ranking_SURF
	para "Il numero di volte"
	line "SURF è stato usato"
	cont "fuori dalla lotta."
ENDM
DEF RANKING_SURF_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_SURF_NAME EQUS "SURF USADO" ; Max 17 chars
MACRO describe_ranking_SURF
	para "Cantidad total"
	line "de veces que SURF"
	cont "se ha usado fuera"
	cont "de combate."	
ENDM
DEF RANKING_SURF_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 23: Number of uses of field move Waterfall
DEF RANKING_WATERFALL_ADDR EQUS "sTrainerRankingWaterfall"
DEF RANKING_WATERFALL_FMT  EQUS "3, 7"
DEF RANKING_WATERFALL_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_WATERFALL_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_WATERFALL
	db   "?"
ENDM
DEF RANKING_WATERFALL_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_WATERFALL_NAME EQUS "WATERFALL USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_WATERFALL
	para "The total amount"
	line "of times WATERFALL"
	cont "was used outside"
	cont "of battle."
ENDM
DEF RANKING_WATERFALL_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_WATERFALL_NAME EQUS "KASKADE-EINSATZ" ; Max 17 chars
MACRO describe_ranking_WATERFALL
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "KASKADE außerhalb"
	cont "von Kämpfen."
ENDM
DEF RANKING_WATERFALL_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_WATERFALL_NAME EQUS "CASCADE H. COMBAT" ; Max 17 chars
MACRO describe_ranking_WATERFALL
	para "Total du nombre"
	line "d'utilisations"
	cont "de CASCADE"
	cont "hors combat."
ENDM
DEF RANKING_WATERFALL_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_WATERFALL_NAME EQUS "USI CASCATA" ; Max 17 chars
MACRO describe_ranking_WATERFALL
	para "Il numero di volte"
	line "CASCATA è stata"
	cont "usata fuori dalla"
	cont "lotta."
ENDM
DEF RANKING_WATERFALL_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_WATERFALL_NAME EQUS "CASCADA USADA" ; Max 17 chars
MACRO describe_ranking_WATERFALL
	para "Cantidad total de"
	line "veces que CASCADA"
	cont "se ha usado fuera"
	cont "de combate."	
ENDM
DEF RANKING_WATERFALL_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 24: Number of times the player whited out
DEF RANKING_WHITE_OUTS_ADDR EQUS "sTrainerRankingWhiteOuts"
DEF RANKING_WHITE_OUTS_FMT  EQUS "3, 7"
DEF RANKING_WHITE_OUTS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_WHITE_OUTS_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_WHITE_OUTS
	db   "?"
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_WHITE_OUTS_NAME EQUS "TIMES WHITED OUT" ; Max 17 chars
; Custom Description
MACRO describe_ranking_WHITE_OUTS
	para "The total amount"
	line "of times whited"
	cont "out from battle."
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_WHITE_OUTS_NAME EQUS "ANZAHL OHNMÄCHTIG" ; Max 17 chars
MACRO describe_ranking_WHITE_OUTS
	para "Gesamtzahl der"
	line "Ohnmächtigkeiten"
	cont "während eines"
	cont "Kampfes."
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_WHITE_OUTS_NAME EQUS "DEFAITES COMBAT" ; Max 17 chars
MACRO describe_ranking_WHITE_OUTS
	para "Total du nombre de"
	line "hors-jeu subis"
	cont "en combat."
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_WHITE_OUTS_NAME EQUS "LOTTE PERSE" ; Max 17 chars
MACRO describe_ranking_WHITE_OUTS
	para "Il totale delle"
	line "lotte perse."
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_WHITE_OUTS_NAME EQUS "K.O. TOTALES" ; Max 17 chars
MACRO describe_ranking_WHITE_OUTS
	para "Cantidad total"
	line "de veces que"
	cont "te desmayaste."
ENDM
DEF RANKING_WHITE_OUTS_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 25: Number of Lucky Number Show prizes won
DEF RANKING_LUCKY_NUMBER_SHOW_ADDR EQUS "sTrainerRankingLuckyNumberShow"
DEF RANKING_LUCKY_NUMBER_SHOW_FMT  EQUS "3, 7"
DEF RANKING_LUCKY_NUMBER_SHOW_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	db   "?"
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "LUCKY NUMBER WINS" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	para "The total amount"
	line "of LUCKY NUMBER"
	cont "SHOW wins on the"
	cont "#GEAR RADIO's"
	cont "LUCKY CHANNEL."
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS " wins"

; German
ELIF DEF(_LANG_D)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "LOTTERIE-GEWINNE" ; Max 17 chars
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	para "Gesamtzahl der"
	line "Lotterie-Gewinne"
	cont "im GLÜCKSKANAL des"
	cont "#COM-RADIOs."
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS " Gewinne"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "GAINS BON NUMERO" ; Max 17 chars
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	para "Total du nombre de"
	line "prix remportés au"
	cont "BON NUMERO de"
	cont "l'ANTENNE LA CHANCE"
	cont "du #MATOS."
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS " prix"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "SHOW N.FOR. VINTI" ; Max 17 chars
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	para "Il numero di vin-"
	line "cite allo SHOW"
	cont "del NUMERO FORTU-"
	cont "NATO sul canale"
	cont "Radio Fortuna del"
	cont "#GEAR."
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LUCKY_NUMBER_SHOW_NAME EQUS "NÚMERO DE SUERTE" ; Max 17 chars
MACRO describe_ranking_LUCKY_NUMBER_SHOW
	para "Cantidad total"
	line "de NÚMERO DE LA"
	cont "SUERTE ganadores"
	cont "CANAL de la SUERTE"
	cont "en #GEAR RADIO."	
ENDM
DEF RANKING_LUCKY_NUMBER_SHOW_UNIT EQUS " premios"
ENDC


; --------------------------------
; Ranking 26: Number of Phone calls made and received
DEF RANKING_PHONE_CALLS_ADDR EQUS "sTrainerRankingPhoneCalls"
DEF RANKING_PHONE_CALLS_FMT  EQUS "3, 7"
DEF RANKING_PHONE_CALLS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_PHONE_CALLS_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_PHONE_CALLS
	db   "?"
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_PHONE_CALLS_NAME EQUS "TOTAL PHONE CALLS" ; Max 17 chars
; Custom Description
MACRO describe_ranking_PHONE_CALLS
	para "The total amount"
	line "of phone calls"
	cont "made and received."
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS " calls"

; German
ELIF DEF(_LANG_D)
DEF RANKING_PHONE_CALLS_NAME EQUS "GESAMTZAHL ANRUFE" ; Max 17 chars
MACRO describe_ranking_PHONE_CALLS
	para "Gesamtzahl der"
	line "ausgehenden und"
	cont "eingehenden"
	cont "Anrufe."
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS " Anrufe"

; French
ELIF DEF(_LANG_F)
DEF RANKING_PHONE_CALLS_NAME EQUS "APPELS TELEPHONE" ; Max 17 chars
MACRO describe_ranking_PHONE_CALLS
	para "Total du nombre de"
	line "coups de fil"
	cont "passés et reçus."
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS " appels"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_PHONE_CALLS_NAME EQUS "TOTALE TELEFONATE" ; Max 17 chars
MACRO describe_ranking_PHONE_CALLS
	para "Il totale delle"
	line "telefonate fatte"
	cont "e ricevute."
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS " chiamate"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_PHONE_CALLS_NAME EQUS "LLAMADAS TOTALES" ; Max 17 chars
MACRO describe_ranking_PHONE_CALLS
	para "Cantidad total"
	line "de llamadas"
	cont "hechas o recibidas"
ENDM
DEF RANKING_PHONE_CALLS_UNIT EQUS " llamadas"
ENDC


; --------------------------------
; Ranking 27: Unused 2
DEF RANKING_UNUSED_2_ADDR EQUS "sTrainerRankingUnused2"
DEF RANKING_UNUSED_2_FMT  EQUS "3, 8"
DEF RANKING_UNUSED_2_SPACING EQU 1

; Japanese
IF DEF(_LANG_J)
DEF RANKING_UNUSED_2_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	db   "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_UNUSED_2_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	para "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS "?"

; German
ELIF DEF(_LANG_D)
DEF RANKING_UNUSED_2_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	para "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS "?"

; French
ELIF DEF(_LANG_F)
DEF RANKING_UNUSED_2_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	para "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS "?"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_UNUSED_2_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	para "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_UNUSED_2_NAME EQUS "NO USADO 2" ; Max 17 chars
MACRO describe_ranking_UNUSED_2
	para "?"
ENDM
DEF RANKING_UNUSED_2_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 28: Number of Colosseum battles
DEF RANKING_LINK_BATTLES_ADDR EQUS "sTrainerRankingLinkBattles"
DEF RANKING_LINK_BATTLES_FMT  EQUS "3, 7"
DEF RANKING_LINK_BATTLES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LINK_BATTLES_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_LINK_BATTLES
	db   "?"
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_LINK_BATTLES_NAME EQUS "COLOSSEUM BATTLES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LINK_BATTLES
	para "The number of"
	line "#MON battles"
	cont "with other"
	cont "<TRAINER>S at the"
	cont "#COM CLUB"
	cont "COLOSSEUM."
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS " battles"

; German
ELIF DEF(_LANG_D)
DEF RANKING_LINK_BATTLES_NAME EQUS "KOLOSSEUM-KÄMPFE" ; Max 17 chars
MACRO describe_ranking_LINK_BATTLES
	para "Anzahl der #-"
	line "MON-Kämpfe mit"
	cont "anderen <TRAINER>N"
	cont "im #KOM-CLUB-"
	cont "KOLOSSEUM."
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS " Kämpfe"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LINK_BATTLES_NAME EQUS "COMBATS COLISEE" ; Max 17 chars
MACRO describe_ranking_LINK_BATTLES
	para "Nombre de combats"
	line "livrés contre"
	cont "d'autres <TRAINER>S"
	cont "au COLISEE du"
	cont "CLUB #COM."
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS " combats"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LINK_BATTLES_NAME EQUS "LOTTE COLOSSEO" ; Max 17 chars
MACRO describe_ranking_LINK_BATTLES
	para "Il numero di"
	line "lotte #MON"
	cont "con altri ALLENA-"
	cont "TORI al COLOSSEO"
	cont "del CLUB #COM."  
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS " lotte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LINK_BATTLES_NAME EQUS "COMBATES ENLACE" ; Max 17 chars
MACRO describe_ranking_LINK_BATTLES
	para "Número de"
	line "combates #MON"
	cont "con otros"
	cont "<TRAINER>S en el"
	cont "CLUB del COLISEO"
	cont "del Centro #COM"
ENDM
DEF RANKING_LINK_BATTLES_UNIT EQUS " combates"
ENDC


; --------------------------------
; Ranking 29: Number of times players Pokémon used Splash
DEF RANKING_SPLASH_ADDR EQUS "sTrainerRankingSplash"
DEF RANKING_SPLASH_FMT  EQUS "3, 7"
DEF RANKING_SPLASH_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_SPLASH_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_SPLASH
	db   "?"
ENDM
DEF RANKING_SPLASH_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_SPLASH_NAME EQUS "SPLASH USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_SPLASH
	para "The total amount"
	line "of times SPLASH"
	cont "was used in"
	cont "battle."
ENDM
DEF RANKING_SPLASH_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_SPLASH_NAME EQUS "PLATSCHER-EINSATZ" ; Max 17 chars
MACRO describe_ranking_SPLASH
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "PLATSCHER in"
	cont "Kämpfen."

ENDM
DEF RANKING_SPLASH_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
DEF RANKING_SPLASH_NAME EQUS "TREMPETTE FAITES" ; Max 17 chars
MACRO describe_ranking_SPLASH
	para "Total du nombre de"
	line "fois où TREMPETTE"
	cont "a été utilisée"
	cont "en combat."
ENDM
DEF RANKING_SPLASH_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_SPLASH_NAME EQUS "USI SPLASH" ; Max 17 chars
MACRO describe_ranking_SPLASH
	para "Il numero di volte"
	line "SPLASH è stato"
	cont "usato in lotta."
ENDM
DEF RANKING_SPLASH_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_SPLASH_NAME EQUS "SALPICADURA" ; Max 17 chars
MACRO describe_ranking_SPLASH
	para "Cantidad total"
	line "de veces que has"
	cont "usado SALPICADURA"
	cont "en combate."	
ENDM
DEF RANKING_SPLASH_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 30: Number of tree Pokémon encounters
; actually, it doesnt care about whether an encounter happened
; only that the player used headbutt on a tree
DEF RANKING_TREE_ENCOUNTERS_ADDR EQUS "sTrainerRankingTreeEncounters"
DEF RANKING_TREE_ENCOUNTERS_FMT  EQUS "3, 7"
DEF RANKING_TREE_ENCOUNTERS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "ずつきを　した　かいすう"; Max 17 chars
MACRO describe_ranking_TREE_ENCOUNTERS
	db   "?"
ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "HEADBUTT USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_TREE_ENCOUNTERS
	para "The total amount"
	line "of times HEADBUTT"
	cont "was used on trees"
	cont "outside of battle."
ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS " times"
REDEF RANKING_TREE_ENCOUNTERS_SPACING EQU 1

; German
ELIF DEF(_LANG_D)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "KOPFNUSS-EINSATZ" ; Max 17 chars
MACRO describe_ranking_TREE_ENCOUNTERS
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "KOPFNUSS außerhalb"
	cont "von Kämpfen."

ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS " Mal"
REDEF RANKING_TREE_ENCOUNTERS_SPACING EQU 3

; French
ELIF DEF(_LANG_F)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "COUPS D'BOULE" ; Max 17 chars
MACRO describe_ranking_TREE_ENCOUNTERS
	para "Total du nombre"
	line "d'utilisations de"
	cont "COUP D'BOULE sur"
	cont "des arbres"
	cont "hors combat."
ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "USI BOTTINTESTA" ; Max 17 chars
MACRO describe_ranking_TREE_ENCOUNTERS
	para "Il numero di volte"
	line "BOTTINTESTA è"
	cont "stata usata su"
	cont "alberi fuori dalla"
	cont "lotta."
ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_TREE_ENCOUNTERS_NAME EQUS "GOLPE CABEZA" ; Max 17 chars
MACRO describe_ranking_TREE_ENCOUNTERS
	para "Cantidad total"
	line "que GOLPE CABEZA"
	cont "se usó en árboles"
	cont "fuera de combate."
ENDM
DEF RANKING_TREE_ENCOUNTERS_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 31: Unused 3
DEF RANKING_UNUSED_3_ADDR EQUS "sTrainerRankingUnused3"
DEF RANKING_UNUSED_3_FMT  EQUS "3, 8"
DEF RANKING_UNUSED_3_SPACING EQU 1

; Japanese
IF DEF(_LANG_J)
DEF RANKING_UNUSED_3_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	db   "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_UNUSED_3_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	para "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS "?"

; German
ELIF DEF(_LANG_D)
DEF RANKING_UNUSED_3_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	para "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS "?"

; French
ELIF DEF(_LANG_F)
DEF RANKING_UNUSED_3_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	para "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS "?"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_UNUSED_3_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	para "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS "?"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_UNUSED_3_NAME EQUS "NO USADO 3" ; Max 17 chars
MACRO describe_ranking_UNUSED_3
	para "?"
ENDM
DEF RANKING_UNUSED_3_UNIT EQUS ""
ENDC


; --------------------------------
; Ranking 32: Number of Colosseum wins
DEF RANKING_LINK_WINS_ADDR EQUS "sTrainerRankingColosseumWins"
DEF RANKING_LINK_WINS_FMT  EQUS "3, 7"
DEF RANKING_LINK_WINS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LINK_WINS_NAME EQUS "コロシアムで　かった　かいすう" ; Max 17 chars
MACRO describe_ranking_LINK_WINS
	db   "?"
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS "かい"

; English
ELIF DEF(_LANG_E)
DEF RANKING_LINK_WINS_NAME EQUS "COLOSSEUM WINS" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LINK_WINS
	para "The number of"
	line "#MON battles"
	cont "won against other"
	cont "<TRAINER>S at the"
	cont "#COM CLUB"
	cont "COLOSSEUM."
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS " wins"

; German
ELIF DEF(_LANG_D)
DEF RANKING_LINK_WINS_NAME EQUS "KOLOSSEUM-SIEGE" ; Max 17 chars
MACRO describe_ranking_LINK_WINS
	para "Anzahl der"
	line "gewonnenen #-"
	cont "MON-Kämpfe gegen"
	cont "andere <TRAINER>"
	cont "im #KOM-CLUB-"
	cont "KOLOSSEUM."
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS " Siege"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LINK_WINS_NAME EQUS "VICTOIRES COLISEE" ; Max 17 chars
MACRO describe_ranking_LINK_WINS
	para "Nombre de combats"
	line "gagnés contre"
	cont "d'autres <TRAINER>S"
	cont "au COLISEE du"
	cont "CLUB #COM."
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS " victoires"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LINK_WINS_NAME EQUS "VITTORIE COLOSSEO" ; Max 17 chars
MACRO describe_ranking_LINK_WINS
	para "Il numero di"
	line "lotte #MON con-"
	cont "tro ALLENATORI"
	cont "vinte al COLOSSEO"
	cont "del CLUB #COM."  
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS " vittorie"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LINK_WINS_NAME EQUS "GANADAS ENLACE" ; Max 17 chars
MACRO describe_ranking_LINK_WINS
	para "Cantidad de"
	line "combates #MON"
	cont "ganados ante otros"
	cont "<TRAINER>S en el"
	cont "CLUB del COLISEO"
	cont "del Centro #COM"
ENDM
DEF RANKING_LINK_WINS_UNIT EQUS " ganadas"
ENDC


; --------------------------------
; Ranking 33: Number of Colosseum losses
DEF RANKING_LINK_LOSSES_ADDR EQUS "sTrainerRankingColosseumLosses"
DEF RANKING_LINK_LOSSES_FMT  EQUS "3, 7"
DEF RANKING_LINK_LOSSES_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LINK_LOSSES_NAME EQUS "?"
MACRO describe_ranking_LINK_LOSSES
	db   "?"
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_LINK_LOSSES_NAME EQUS "COLOSSEUM LOSSES" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LINK_LOSSES
	para "The number of"
	line "#MON battles"
	cont "lost against other"
	cont "<TRAINER>S at the"
	cont "#COM CLUB"
	cont "COLOSSEUM."
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS " losses"
REDEF RANKING_LINK_LOSSES_SPACING EQU 0

; German
ELIF DEF(_LANG_D)
DEF RANKING_LINK_LOSSES_NAME EQUS "KOLOSSEUM-NIEDERL." ; Max 17 chars
MACRO describe_ranking_LINK_LOSSES
	para "Anzahl der"
	line "verlorenen #-"
	cont "MON-Kämpfe gegen"
	cont "andere <TRAINER>"
	cont "im #KOM-CLUB-"
	cont "KOLOSSEUM."
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS " Niederlagen"
REDEF RANKING_LINK_LOSSES_SPACING EQU -5

; French
ELIF DEF(_LANG_F)
DEF RANKING_LINK_LOSSES_NAME EQUS "DEFAITES COLISEE" ; Max 17 chars
MACRO describe_ranking_LINK_LOSSES
	para "Nombre de combats"
	line "perdus contre"
	cont "d'autres <TRAINER>S"
	cont "au COLISEE du"
	cont "CLUB #COM."
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS " défaites"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LINK_LOSSES_NAME EQUS "SCONF. COLOSSEO" ; Max 17 chars
MACRO describe_ranking_LINK_LOSSES
	para "Il numero di"
	line "lotte #MON con-"
	cont "tro ALLENATORI"
	cont "perse al COLOSSEO"
	cont "del CLUB #COM."  
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS " sconfitte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LINK_LOSSES_NAME EQUS "PERDIDAS ENLACE" ; Max 17 chars
MACRO describe_ranking_LINK_LOSSES
	para "Cantidad de"
	line "combates #MON"
	cont "perdidos con otros"
	cont "<TRAINER>S en el"
	cont "CLUB del COLISEO"
	cont "del Centro #COM"
ENDM
DEF RANKING_LINK_LOSSES_UNIT EQUS " perdidas"
ENDC


; --------------------------------
; Ranking 34: Number of Colosseum ties
DEF RANKING_LINK_DRAWS_ADDR EQUS "sTrainerRankingColosseumDraws"
DEF RANKING_LINK_DRAWS_FMT  EQUS "3, 7"
DEF RANKING_LINK_DRAWS_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LINK_DRAWS_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_LINK_DRAWS
	db   "?"
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS "かい" ; a guess

; English
ELIF DEF(_LANG_E)
DEF RANKING_LINK_DRAWS_NAME EQUS "COLOSSEUM DRAWS" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LINK_DRAWS
	para "The number of"
	line "#MON battles"
	cont "against other"
	cont "<TRAINER>S at the"
	cont "#COM CLUB"
	cont "COLOSSEUM that"
	cont "resulted in a"
	cont "draw."
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS " draws"

; German
ELIF DEF(_LANG_D)
DEF RANKING_LINK_DRAWS_NAME EQUS "KOLOSSEUM-REMIS" ; Max 17 chars
MACRO describe_ranking_LINK_DRAWS
	para "Anzahl der"
	line "unentschiedenen"
	cont "#MON-Kämpfe"
	cont "gegen andere"
	cont "<TRAINER> im"
	cont "#KOM-CLUB-"
	cont "KOLOSSEUM."
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS " Remis"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LINK_DRAWS_NAME EQUS "EGALITES COLISEE" ; Max 17 chars
MACRO describe_ranking_LINK_DRAWS
	para "Nombre de combats"
	line "livrés contre"
	cont "d'autres <TRAINER>S"
	cont "au COLISEE du"
	cont "CLUB #COM qui se"
	cont "sont conclus par"
	cont "une égalité."
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS " égalités"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LINK_DRAWS_NAME EQUS "PAREGGI COLOSSEO" ; Max 17 chars
MACRO describe_ranking_LINK_DRAWS
	para "Il numero di"
	line "lotte #MON con-"
	cont "tro ALLENATORI"
	cont "finite in pareggio"
	cont "al COLOSSEO del"
	cont "CLUB #COM."  
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS " pareggi"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LINK_DRAWS_NAME EQUS "EMPATES ENLACE" ; Max 17 chars
MACRO describe_ranking_LINK_DRAWS
	para "Cantidad de"
	line "combates #MON"
	cont "empates con otros"
	cont "<TRAINER>S en el"
	cont "CLUB del COLISEO"
	cont "del Centro #COM"
ENDM
DEF RANKING_LINK_DRAWS_UNIT EQUS " empates"
ENDC


; --------------------------------
; Ranking 35: Number of times players Pokémon used SelfDestruct or Explosion
DEF RANKING_SELFDESTRUCT_ADDR EQUS "sTrainerRankingSelfdestruct"
DEF RANKING_SELFDESTRUCT_FMT  EQUS "3, 7"
DEF RANKING_SELFDESTRUCT_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_SELFDESTRUCT_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_SELFDESTRUCT
	db   "?"
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_SELFDESTRUCT_NAME EQUS "SELF-KO MOVE USED" ; Max 17 chars
; Custom Description
MACRO describe_ranking_SELFDESTRUCT
	para "The total amount"
	line "of times EXPLOSION"
	cont "or SELFDESTRUCT"
	cont "have been used in"
	cont "battle."
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS " times"

; German
ELIF DEF(_LANG_D)
DEF RANKING_SELFDESTRUCT_NAME EQUS "EIGEN-K.O.-EINSATZ" ; Max 17 chars
MACRO describe_ranking_SELFDESTRUCT
	para "Gesamtzahl der"
	line "Einsätze von"
	cont "EXPLOSION oder"
	cont "FINALE in Kämpfen."
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS " Mal"

; French
ELIF DEF(_LANG_F)
; "ATTAQUES SUICIDE" rend mieux, mais le S-word serait probablement rejeté dans un jeu Pokémon.
DEF RANKING_SELFDESTRUCT_NAME EQUS "ATQ. AUTO-DESTRUC" ; Max 17 chars
MACRO describe_ranking_SELFDESTRUCT
	para "Total du nombre"
	line "d'utilisations de"
	cont "DESTRUCTION ou"
	cont "d'EXPLOSION"
	cont "en combat."
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS " fois"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_SELFDESTRUCT_NAME EQUS "USI AUTODISTRUZ." ; Max 17 chars
MACRO describe_ranking_SELFDESTRUCT
	para "Il numero di volte"
	line "AUTODISTRUZIONE è"
	cont "stata usata in"
	cont "lotta."
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS " volte"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_SELFDESTRUCT_NAME EQUS "AUTODESTRUCCIÓN" ; Max 17 chars
MACRO describe_ranking_SELFDESTRUCT
	para "Cantidad total"
	line "que EXPLOSION o"
	cont "AUTODESTRUCCIÓN"
	cont "se usó en"
	cont "combate."
ENDM
DEF RANKING_SELFDESTRUCT_UNIT EQUS " veces"
ENDC


; --------------------------------
; Ranking 36: Current streak of consecutive slot machine wins
DEF RANKING_CURRENT_SLOTS_STREAK_ADDR EQUS "sTrainerRankingCurrentSlotsStreak"
DEF RANKING_CURRENT_SLOTS_STREAK_FMT  EQUS "2, 5"
DEF RANKING_CURRENT_SLOTS_STREAK_SPACING EQU 2

; Japanese
IF DEF(_LANG_J)
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	db   "?"
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "SLOT WIN STREAK" ; Max 17 chars
; Custom Description
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	para "The most recent"
	line "win streak"
	cont "achieved at the"
	cont "SLOTS in the"
	cont "GOLDENROD CITY"
	cont "GAME CORNER."
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS " wins"

; German
ELIF DEF(_LANG_D)
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "SPIELH.GEWINNSERIE" ; Max 17 chars
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	para "Die zuletzt er-"
	line "reichte Gewinn-"
	cont "serie beim Ein-"
	cont "armigen Banditen"
	cont "in der SPIELHALLE"
	cont "von DUKATIA CITY."
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS " Gewinne"

; French
ELIF DEF(_LANG_F)
; "Consécutive" est trop long pour rentrer, donc "série" fera l'affaire.
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "SERIE AU CASINO" ; Max 17 chars
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	para "La dernière série"
	line "de victoires"
	cont "consécutives aux"
	cont "machines à sous"
	cont "du CASINO de"
	cont "DOUBLONVILLE."
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS " victoires"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "SERIE CASINò" ; Max 17 chars
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	para "La più recente"
	line "serie di vittorie"
	cont "alle SLOT MACHINE"
	cont "del CASINò di"
	cont "FIORDOROPOLI."
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS " vittorie"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_CURRENT_SLOTS_STREAK_NAME EQUS "RACHA SLOTS HOY" ; Max 17 chars
MACRO describe_ranking_CURRENT_SLOTS_STREAK
	para "Racha de victorias"
	line "más reciente"
	cont "alcanzada en"
	cont "las máquinas"
	cont "del CASINO"
	cont "CIUDAD TRIGAL."
ENDM
DEF RANKING_CURRENT_SLOTS_STREAK_UNIT EQUS " victorias"
ENDC


; --------------------------------
; Ranking 37: Longest streak of consecutive slot machine wins
DEF RANKING_LONGEST_SLOTS_STREAK_ADDR EQUS "sTrainerRankingLongestSlotsStreak"
DEF RANKING_LONGEST_SLOTS_STREAK_FMT  EQUS "2, 5"
DEF RANKING_LONGEST_SLOTS_STREAK_SPACING EQU 2

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	db   "?"
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "BEST SLOT STREAK" ; Max 17 chars
; Custom Description
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	para "The highest win"
	line "streak achieved at"
	cont "the SLOTS in the"
	cont "GOLDENROD CITY"
	cont "GAME CORNER."
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS " wins"

; German
ELIF DEF(_LANG_D)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "SPIELH.-REKORD" ; Max 17 chars
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	para "Die am höchsten"
	line "erreichte Gewinn-"
	cont "serie beim Ein-"
	cont "armigen Banditen"
	cont "in der SPIELHALLE"
	cont "von DUKATIA CITY."
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS " Gewinne"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "MEILLEURE SERIE" ; Max 17 chars
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	para "La meilleure série"
	line "de victoires"
	cont "consécutives aux"
	cont "machines à sous"
	cont "du CASINO de"
	cont "DOUBLONVILLE."
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS " victoires"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "RECORD CASINò" ; Max 17 chars
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	para "La più lunga"
	line "serie di vittorie"
	cont "alle SLOT MACHINE"
	cont "del CASINò di"
	cont "FIORDOROPOLI."
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS " vittorie"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LONGEST_SLOTS_STREAK_NAME EQUS "MAYOR RACHA SLOTS" ; Max 17 chars
MACRO describe_ranking_LONGEST_SLOTS_STREAK
	para "Racha de victorias"
	line "más alta"
	cont "alcanzada en"
	cont "las máquinas"
	cont "del CASINO"
	cont "CIUDAD TRIGAL."
ENDM
DEF RANKING_LONGEST_SLOTS_STREAK_UNIT EQUS " victorias"
ENDC


; --------------------------------
; Ranking 38: Total coins won from slot machines
DEF RANKING_COINS_EARNED_ADDR EQUS "sTrainerRankingTotalSlotsPayouts"
DEF RANKING_COINS_EARNED_FMT  EQUS "4, 9"
DEF RANKING_COINS_EARNED_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_COINS_EARNED_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_COINS_EARNED
	db   "?"
ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS "?"

; English
ELIF DEF(_LANG_E)
DEF RANKING_COINS_EARNED_NAME EQUS "SLOT COINS WON" ; Max 17 chars
; Custom Description
MACRO describe_ranking_COINS_EARNED
	para "The total amount"
	line "of COINS won at"
	cont "the SLOTS in the"
	cont "GOLDENROD CITY"
	cont "GAME CORNER."

ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS " coins"
REDEF RANKING_COINS_EARNED_SPACING EQU -1

; German
ELIF DEF(_LANG_D)
DEF RANKING_COINS_EARNED_NAME EQUS "MÜNZEN GEWONNEN" ; Max 17 chars
MACRO describe_ranking_COINS_EARNED
	para "Gesamtzahl der"
	line "MÜNZEN, die beim"
	cont "Einamigen Banditen"
	cont "in der SPIELHALLE"
	cont "von DUKATIA CITY"
	cont "gewonnen wurden."
ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS " Münzen"

; French
ELIF DEF(_LANG_F)
DEF RANKING_COINS_EARNED_NAME EQUS "JETONS GAGNES"; Max 17 chars
MACRO describe_ranking_COINS_EARNED
	para "Total du nombre de"
	line "JETONS gagnés aux"
	cont "machines à sous"
	cont "du CASINO de"
	cont "DOUBLONVILLE."
ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS " jetons"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_COINS_EARNED_NAME EQUS "GETTONI VINTI" ; Max 17 chars
MACRO describe_ranking_COINS_EARNED
	para "Il totale dei"
	line "GETTONI vinti"
	cont "alle SLOT MACHINE"
	cont "del CASINò di"
	cont "FIORDOROPOLI."
ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS " gettoni"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_COINS_EARNED_NAME EQUS "FICHAS GANADAS" ; Max 17 chars
MACRO describe_ranking_COINS_EARNED
	para "Cantidad total"
	line "de FICHAS ganadas"
	cont "en las máquinas"
	cont "del CASINO"
	cont "CIUDAD TRIGAL."
ENDM
DEF RANKING_COINS_EARNED_UNIT EQUS " fichas"
ENDC


; --------------------------------
; Ranking 39: Total money earned from battles (including Pay Day)
DEF RANKING_MONEY_EARNED_ADDR EQUS "sTrainerRankingTotalBattlePayouts"
DEF RANKING_MONEY_EARNED_FMT  EQUS "4, 9"
DEF RANKING_MONEY_EARNED_SPACING EQU 0

; Japanese
IF DEF(_LANG_J)
DEF RANKING_MONEY_EARNED_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_MONEY_EARNED
	db   "?"
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS ""

; English
ELIF DEF(_LANG_E)
DEF RANKING_MONEY_EARNED_NAME EQUS "TOTAL MONEY" ; Max 17 chars
; Custom Description
MACRO describe_ranking_MONEY_EARNED
	para "The total amount"
	line "of money earned"
	cont "from #MON"
	cont "battles during"
	cont "your adventure."
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS "¥"
REDEF RANKING_MONEY_EARNED_SPACING EQU 4

; German
ELIF DEF(_LANG_D)
DEF RANKING_MONEY_EARNED_NAME EQUS "PREISGELD GESAMT" ; Max 17 chars
MACRO describe_ranking_MONEY_EARNED
	para "Gesamte Menge an"
	line "gewonnenem Preis-"
	cont "geld während der"
	cont "#MON-Kämpfe auf"
	cont "deinem Abenteuer."
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS "¥"
REDEF RANKING_MONEY_EARNED_SPACING EQU 4

; French
ELIF DEF(_LANG_F)
DEF RANKING_MONEY_EARNED_NAME EQUS "ARGENT REMPORTE" ; Max 17 chars
MACRO describe_ranking_MONEY_EARNED
	para "Total d'argent"
	line "obtenu lors de"
	cont "combats #MON au"
	cont "cours de votre"
	cont "aventure."
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS "¥"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_MONEY_EARNED_NAME EQUS "TOTALE SOLDI" ; Max 17 chars
MACRO describe_ranking_MONEY_EARNED
	para "Il totale di"
	line "soldi vinti dall'"
	cont "inizio della tua"
	cont "avventura."
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS "¥"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_MONEY_EARNED_NAME EQUS "DINERO TOTAL" ; Max 17 chars
MACRO describe_ranking_MONEY_EARNED
	para "Cantidad total"
	line "de dinero ganado"
	cont "en combates"
	cont "#MON a lo largo"
	cont "de tu aventura."
ENDM
DEF RANKING_MONEY_EARNED_UNIT EQUS "¥"
ENDC


; --------------------------------
; Ranking 40: Largest Magikarp measured
DEF RANKING_LONGEST_MAGIKARP_ADDR EQUS "sTrainerRankingLongestMagikarp"
DEF RANKING_LONGEST_MAGIKARP_ADDR_LO EQUS "sTrainerRankingLongestMagikarpLow"
DEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \"<DOT>\""
DEF RANKING_LONGEST_MAGIKARP_SPACING EQU 1

; Japanese
IF DEF(_LANG_J)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "つった　コイキング<NO>おおきさ" ; Max 17 chars
DEF RANKING_LONGEST_MAGIKARP_FULLNAME EQUS "コイキング<NO>おおきさ"
MACRO describe_ranking_LONGEST_MAGIKARP
	db   "いかりのみずうみ<NI>いる"
	cont "つりめいじん<NI>はか<TTE>もらった"
	cont "コイキング<NO>うち　いちばん"
	cont "おおきかった　もので　きそいます"
ENDM
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS "センチ"

; English
ELIF DEF(_LANG_E)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "LARGEST MAGIKARP" ; Max 17 chars
MACRO describe_ranking_LONGEST_MAGIKARP
	para "The size of the"
	line "largest MAGIKARP"
	cont "measured by the"
	cont "FISHING GURU at"
	cont "the LAKE OF RAGE."
ENDM
REDEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "1, 3, 0\nnts_end\ndb \"'\"\nnts_start\nnts_ranking_number $0015, 1, 2, 0"
DEF RANKING_LONGEST_MAGIKARP_FMT_PLAYER EQUS "1, 3, 0\nnts_end\ndb \"'\"\nnts_start\nnts_number {RANKING_LONGEST_MAGIKARP_ADDR_LO}, 1, 2, 0"
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS "”"
REDEF RANKING_LONGEST_MAGIKARP_SPACING EQU 7

; German
ELIF DEF(_LANG_D)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "GRÖSSTES KARPADOR" ; Max 17 chars
MACRO describe_ranking_LONGEST_MAGIKARP
	para "Das größte"
	line "KARPADOR, das je"
	cont "vom PROFI-ANGLER"
	cont "am SEE DES ZORNS"
	cont "gemessen wurde."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS " cm"

; French
ELIF DEF(_LANG_F)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "GIGA MAGICARPE" ; Max 17 chars
MACRO describe_ranking_LONGEST_MAGIKARP
	para "La taille du plus"
	line "grand MAGICARPE"
	cont "mesuré par le"
	cont "MAITRE PECHEUR"
	cont "au LAC COLERE."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS " cm"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "MAGIKARP PIÙ GR." ; Max 17 chars
DEF RANKING_LONGEST_MAGIKARP_FULLNAME EQUS "IL MAGIKARP PIÙ<LINE>GROSSO"
MACRO describe_ranking_LONGEST_MAGIKARP
	para "Le dimensioni del"
	line "MAGIKARP più"
	cont "grosso per il GURU"
	cont "PESCATORE al"
	cont "LAGO D'IRA."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS " cm"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_LONGEST_MAGIKARP_NAME EQUS "MAGIKARP LARGO" ; Max 17 chars
MACRO describe_ranking_LONGEST_MAGIKARP
	para "El tamaño del"
	line "MAGIKARP mayor"
	cont "medido por el"
	cont "GURÚ PESCADOR en"
	cont "LAGO DE LA FURIA."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_LONGEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_LONGEST_MAGIKARP_UNIT EQUS "”"
ENDC


; --------------------------------
; Ranking 41: Smallest Magikarp measured
DEF RANKING_SHORTEST_MAGIKARP_ADDR EQUS "sTrainerRankingShortestMagikarp"
DEF RANKING_SHORTEST_MAGIKARP_ADDR_LO EQUS "sTrainerRankingShortestMagikarpLow"
DEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \"<DOT>\""
DEF RANKING_SHORTEST_MAGIKARP_SPACING EQU 1

; Japanese
IF DEF(_LANG_J)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "?" ; Max 17 chars
MACRO describe_ranking_SHORTEST_MAGIKARP
	db   "?"
ENDM
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS "センチ"

; English
ELIF DEF(_LANG_E)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "SMALLEST MAGIKARP" ; Max 17 chars
; Custom Description
MACRO describe_ranking_SHORTEST_MAGIKARP
	para "The size of the"
	line "smallest MAGIKARP"
	cont "measured by the"
	cont "FISHING GURU at"
	cont "the LAKE OF RAGE."
ENDM
REDEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "1, 3\nnts_end\ndb \"'\"\nnts_start\nnts_ranking_number $0015, 1, 2"
DEF RANKING_SHORTEST_MAGIKARP_FMT_PLAYER EQUS "1, 3\nnts_end\ndb \"'\"\nnts_start\nnts_number {RANKING_SHORTEST_MAGIKARP_ADDR_LO}, 1, 2"
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS "”"
REDEF RANKING_SHORTEST_MAGIKARP_SPACING EQU 7

; German
ELIF DEF(_LANG_D)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "KLEINST. KARPADOR" ; Max 17 chars
MACRO describe_ranking_SHORTEST_MAGIKARP
	para "Das kleinste"
	line "KARPADOR, das je"
	cont "vom PROFI-ANGLER"
	cont "am SEE DES ZORNS"
	cont "gemessen wurde."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS " cm"

; French
ELIF DEF(_LANG_F)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "MINI MAGICARPE" ; Max 17 chars
MACRO describe_ranking_SHORTEST_MAGIKARP
	para "La taille du plus"
	line "petit MAGICARPE"
	cont "mesuré par le"
	cont "MAITRE PECHEUR"
	cont "au LAC COLERE."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS " cm"

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "MAGIKARP PIù PIC." ; Max 17 chars
DEF RANKING_SHORTEST_MAGIKARP_FULLNAME EQUS "IL MAGIKARP PIÙ<LINE>PICCOLO"
MACRO describe_ranking_SHORTEST_MAGIKARP
	para "Le dimensioni del"
	line "MAGIKARP più"
	cont "piccolo per il"
	cont "GURU PESCATORE al"
	cont "LAGO D'IRA."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS " cm"

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_SHORTEST_MAGIKARP_NAME EQUS "MAGIKARP CORTO" ; Max 17 chars
MACRO describe_ranking_SHORTEST_MAGIKARP
	para "El tamaño del"
	line "MAGIKARP menor"
	cont "medido por el"
	cont "GURÚ PESCADOR en"
	cont "LAGO DE LA FURIA."
ENDM
; uncomment to print with a ',' as the decimal separator
;REDEF RANKING_SHORTEST_MAGIKARP_FMT  EQUS "PRINTNUM_LEADINGZEROS | 2, 4, 5, 4, \",\""
DEF RANKING_SHORTEST_MAGIKARP_UNIT EQUS "”"
ENDC


; --------------------------------
; Ranking 42: Bug-Catching Contest high score
DEF RANKING_BUG_CONTEST_SCORE_ADDR EQUS "sTrainerRankingBugContestScore"
DEF RANKING_BUG_CONTEST_SCORE_FMT  EQUS "2, 5"
DEF RANKING_BUG_CONTEST_SCORE_SPACING EQU 1

; Japanese
IF DEF(_LANG_J)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "むしとりたいかい　こうとくてん" ; Max 17 chars
MACRO describe_ranking_BUG_CONTEST_SCORE
	db   "しぜんこうえんで　おこなわれる"
	cont "むしとりたいかいで　これまでに"
	cont "とった　いちばん　たかい"
	cont "てんすうで　きそいます"
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS "てん"

; English
ELIF DEF(_LANG_E)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "BUG CONTEST SCORE" ; Max 17 chars
MACRO describe_ranking_BUG_CONTEST_SCORE
	para "The highest score"
	line "obtained at the"
	cont "BUG-CATCHING Con-"
	cont "test held in the"
	cont "NATIONAL PARK."
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS " points"
REDEF RANKING_BUG_CONTEST_SCORE_SPACING EQU 2
; Rework in other languages

; German
ELIF DEF(_LANG_D)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "KÄFER-TURNIER" ; Max 17 chars
MACRO describe_ranking_BUG_CONTEST_SCORE
	para "Die am höchsten"
	line "erreichte Punkt-"
	cont "zahl beim KÄFER-"
	cont "TURNIER im"
	cont "NATIONALPARK."
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS " Punkte"
REDEF RANKING_BUG_CONTEST_SCORE_SPACING EQU 2

; French
ELIF DEF(_LANG_F)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "CAPTURE D'INSECTE" ; Max 17 chars
MACRO describe_ranking_BUG_CONTEST_SCORE
	para "Le plus haut score"
	line "obtenu au Concours"
	cont "de Capture d'inse-"
	cont "cte qui se déroule"
	cont "au PARC NATUREL."
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS " points"
REDEF RANKING_BUG_CONTEST_SCORE_SPACING EQU 2

; Italian
ELIF DEF(_LANG_I)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "GARA PIGLIAMOSCHE" ; Max 17 chars
MACRO describe_ranking_BUG_CONTEST_SCORE
	para "Il punteggio più"
	line "alto ottenuto alla"
	cont "GARA PIGLIAMOSCHE"
	cont "tenuta nel PARCO"
	cont "NAZIONALE."
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS " punti"
REDEF RANKING_BUG_CONTEST_SCORE_SPACING EQU 3

; Spanish
ELIF DEF(_LANG_S)
DEF RANKING_BUG_CONTEST_SCORE_NAME EQUS "PUNTOS CONCURSO"
MACRO describe_ranking_BUG_CONTEST_SCORE
	para "Máxima puntuación"
	line "conseguida en el"
	cont "Concurso Captura"
	cont "de Bichos del"
	cont "PARQUE NACIONAL."
ENDM
DEF RANKING_BUG_CONTEST_SCORE_UNIT EQUS " puntos"
ENDC
