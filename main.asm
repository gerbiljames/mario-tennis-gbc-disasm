; Mario Tennis (GBC): every ROM bank, one SECTION each, built from the
; fragment files it INCLUDEs. RAM is laid out in ram.asm. A bank's
; `<Template>_<bank>_NAME EQUS` lines name its copies of the shared
; templates in src/twins that call one another (Unused_<bank>_... for a copy
; nothing reaches).

INCLUDE "lz_sizes.inc"

SECTION "ROM Bank $00", ROM0[$0000]

INCLUDE "src/home/vectors_00.asm"
INCLUDE "src/home/memory_00.asm"
INCLUDE "src/home/palettes_00.asm"
INCLUDE "src/home/mul_00.asm"
INCLUDE "src/home/sine_00.asm"
INCLUDE "src/home/div_00.asm"
INCLUDE "src/home/trig_00.asm"
INCLUDE "src/home/decompress_00.asm"
INCLUDE "src/home/debugtext_00.asm"
INCLUDE "src/home/colorfade_00.asm"
INCLUDE "src/home/fade_00.asm"
INCLUDE "src/home/numberfont_00.asm"
INCLUDE "src/home/flags_00.asm"
INCLUDE "src/home/vblank_00.asm"
INCLUDE "src/home/timer_00.asm"
INCLUDE "src/home/view_00.asm"
INCLUDE "src/audio/sound_00.asm"
INCLUDE "src/audio/note_00.asm"
INCLUDE "src/audio/tables_00.asm"

SECTION "ROM Bank $01", ROMX[$4000], BANK[$01]

INCLUDE "src/engine/menus/boot_01.asm"

SECTION "ROM Bank $02", ROMX[$4000], BANK[$02]

INCLUDE "src/engine/story/slots_02.asm"
INCLUDE "src/engine/story/story_02.asm"
INCLUDE "src/engine/story/stat_02.asm"
INCLUDE "src/engine/story/equip_02.asm"
INCLUDE "src/engine/story/records_02.asm"
INCLUDE "src/engine/story/debug_02.asm"

SECTION "ROM Bank $03", ROMX[$4000], BANK[$03]

INCLUDE "src/engine/cutscenes/slots_03.asm"
INCLUDE "src/engine/save/saveheader_03.asm"
INCLUDE "src/engine/save/signature_03.asm"
INCLUDE "src/engine/save/storyslots_03.asm"
INCLUDE "src/engine/save/saveslots_03.asm"
INCLUDE "src/engine/save/results_03.asm"
INCLUDE "src/engine/save/repair_03.asm"
INCLUDE "src/engine/cutscenes/scrolltext_03.asm"
INCLUDE "src/engine/cutscenes/cutsceneanim_03.asm"
INCLUDE "src/engine/cutscenes/cutscenewindow_03.asm"
INCLUDE "src/engine/cutscenes/palettefade_03.asm"

SECTION "ROM Bank $04", ROMX[$4000], BANK[$04]

INCLUDE "src/engine/story/slots_04.asm"
INCLUDE "src/engine/story/actor_04.asm"
INCLUDE "src/engine/story/actor2_04.asm"
INCLUDE "src/engine/story/actor3_04.asm"
INCLUDE "src/engine/story/scripted_04.asm"
INCLUDE "src/engine/story/player_04.asm"
INCLUDE "src/engine/story/actor4_04.asm"

SECTION "ROM Bank $05", ROMX[$4000], BANK[$05]

INCLUDE "src/engine/text/slots_05.asm"
INCLUDE "src/engine/text/window_05.asm"
INCLUDE "src/engine/text/shadow_05.asm"
INCLUDE "src/engine/text/window2_05.asm"
INCLUDE "src/engine/text/paged_05.asm"
INCLUDE "src/engine/text/cursor_05.asm"
INCLUDE "src/engine/text/arg_05.asm"
INCLUDE "src/engine/text/control_05.asm"
INCLUDE "src/engine/text/window3_05.asm"
INCLUDE "src/engine/text/dialogue_05.asm"
INCLUDE "src/engine/text/proportional_05.asm"
INCLUDE "src/engine/text/window4_05.asm"
INCLUDE "src/engine/text/debug_05.asm"
INCLUDE "src/engine/text/debug2_05.asm"
INCLUDE "src/engine/text/window5_05.asm"
INCLUDE "src/engine/text/rows_05.asm"
INCLUDE "src/engine/text/glyph_05.asm"
INCLUDE "src/engine/text/glyph2_05.asm"

SECTION "ROM Bank $06", ROMX[$4000], BANK[$06]

INCLUDE "src/engine/menus/match_06.asm"
INCLUDE "src/engine/menus/match2_06.asm"
INCLUDE "src/engine/menus/scoreboard_06.asm"
INCLUDE "src/engine/menus/match3_06.asm"
INCLUDE "src/engine/menus/storymenu_06.asm"
INCLUDE "src/engine/menus/storymenu2_06.asm"

SECTION "ROM Bank $07", ROMX[$4000], BANK[$07]

INCLUDE "src/engine/match/slots_07.asm"
INCLUDE "src/engine/match/link_07.asm"
INCLUDE "src/engine/match/nibble_07.asm"
INCLUDE "src/engine/match/link2_07.asm"
INCLUDE "src/engine/match/link3_07.asm"
INCLUDE "src/engine/match/placement_07.asm"
INCLUDE "src/engine/match/shot2_07.asm"
INCLUDE "src/engine/match/execute_07.asm"
INCLUDE "src/engine/match/char_07.asm"
INCLUDE "src/engine/match/debugmatch_07.asm"

SECTION "ROM Bank $08", ROMX[$4000], BANK[$08]

INCLUDE "src/engine/match/slots_08.asm"
INCLUDE "src/engine/match/match_08.asm"
INCLUDE "src/engine/match/ball_08.asm"
INCLUDE "src/engine/match/char_08.asm"
INCLUDE "src/engine/match/point_08.asm"
INCLUDE "src/engine/match/ball2_08.asm"
INCLUDE "src/engine/match/ball3_08.asm"
INCLUDE "src/engine/match/project_08.asm"
INCLUDE "src/engine/match/court_08.asm"
INCLUDE "src/engine/match/char2_08.asm"
INCLUDE "src/engine/match/minigame_08.asm"
INCLUDE "src/engine/match/char3_08.asm"
INCLUDE "src/engine/match/char4_08.asm"
INCLUDE "src/engine/match/ball4_08.asm"
INCLUDE "src/engine/match/char5_08.asm"
INCLUDE "src/engine/match/char6_08.asm"
INCLUDE "src/engine/match/ai_08.asm"
INCLUDE "src/engine/match/ai2_08.asm"

SECTION "ROM Bank $09", ROMX[$4000], BANK[$09]

INCLUDE "src/engine/match/slots_09.asm"
INCLUDE "src/engine/match/obj_09.asm"
INCLUDE "src/engine/match/indicators_09.asm"

SECTION "ROM Bank $0a", ROMX[$4000], BANK[$0a]

INCLUDE "src/engine/story/slots_0a.asm"
INCLUDE "src/engine/story/script_0a.asm"
INCLUDE "src/engine/story/actor_0a.asm"
INCLUDE "src/engine/story/actor2_0a.asm"
INCLUDE "src/engine/story/match_0a.asm"
INCLUDE "src/engine/story/story_0a.asm"
INCLUDE "src/engine/story/story2_0a.asm"
INCLUDE "src/engine/story/scene_0a.asm"
INCLUDE "src/engine/story/scene2_0a.asm"
INCLUDE "src/engine/story/scene3_0a.asm"
INCLUDE "src/engine/story/scene4_0a.asm"
INCLUDE "src/engine/story/minigame_0a.asm"
INCLUDE "src/engine/story/credits_0a.asm"

SECTION "ROM Bank $0b", ROMX[$4000], BANK[$0b]

INCLUDE "src/engine/minigames/drill_0b.asm"
INCLUDE "src/engine/minigames/drill2_0b.asm"
INCLUDE "src/engine/minigames/service_0b.asm"
INCLUDE "src/engine/minigames/service2_0b.asm"
INCLUDE "src/engine/minigames/service3_0b.asm"
INCLUDE "src/engine/minigames/net_0b.asm"
INCLUDE "src/engine/minigames/net2_0b.asm"
INCLUDE "src/engine/minigames/stroke_0b.asm"
INCLUDE "src/engine/minigames/stroke2_0b.asm"
INCLUDE "src/engine/minigames/stroke3_0b.asm"

SECTION "ROM Bank $0c", ROMX[$4000], BANK[$0c]

INCLUDE "src/audio/sound_0c.asm"

SECTION "ROM Bank $0d", ROMX[$4000], BANK[$0d]

INCLUDE "src/engine/minigames/minigame_0d.asm"
INCLUDE "src/engine/minigames/minigame2_0d.asm"
INCLUDE "src/engine/minigames/tennis_0d.asm"
INCLUDE "src/engine/minigames/wall_0d.asm"
INCLUDE "src/engine/minigames/minigame3_0d.asm"
INCLUDE "src/engine/minigames/booblast_0d.asm"
INCLUDE "src/engine/minigames/treasure_0d.asm"
INCLUDE "src/engine/minigames/medallion_0d.asm"

SECTION "ROM Bank $0e", ROMX[$4000], BANK[$0e]

DEF ComputeRankingProgressIndex_0e_NAME EQUS "ComputeRankingProgressIndex_0e"

INCLUDE "src/story/training_0e.asm"
INCLUDE "src/story/actor_0e.asm"
INCLUDE "src/story/repair_0e.asm"
INCLUDE "src/story/mario_0e.asm"
INCLUDE "src/story/actor2_0e.asm"
INCLUDE "src/story/mario2_0e.asm"
INCLUDE "src/story/specialcourt_0e.asm"
INCLUDE "src/story/actor3_0e.asm"

SECTION "ROM Bank $0f", ROMX[$4000], BANK[$0f]

INCLUDE "src/story/testmaps_0f.asm"
INCLUDE "src/story/awards_0f.asm"
INCLUDE "src/story/island_0f.asm"
INCLUDE "src/story/island2_0f.asm"
INCLUDE "src/story/actor_0f.asm"

SECTION "ROM Bank $10", ROMX[$4000], BANK[$10]

INCLUDE "src/story/match_10.asm"
INCLUDE "src/story/lessonmenu_10.asm"
INCLUDE "src/story/devmap_10.asm"
INCLUDE "src/story/modeflow_10.asm"
INCLUDE "src/story/restaurant_10.asm"
INCLUDE "src/story/academy_10.asm"
INCLUDE "src/story/academy2_10.asm"
INCLUDE "src/story/walks_10.asm"

SECTION "ROM Bank $11", ROMX[$4000], BANK[$11]

DEF ComputeRankingProgressIndex_11_NAME EQUS "ComputeRankingProgressIndex_11"

INCLUDE "src/story/center_11.asm"
INCLUDE "src/story/student_11.asm"
INCLUDE "src/story/junior_11.asm"
INCLUDE "src/story/doubles_11.asm"
INCLUDE "src/story/junior2_11.asm"
INCLUDE "src/story/actor_11.asm"
INCLUDE "src/story/actor2_11.asm"

SECTION "ROM Bank $12", ROMX[$4000], BANK[$12]

DEF ComputeRankingProgressIndex_12_NAME EQUS "ComputeRankingProgressIndex_12"

INCLUDE "src/story/wall_12.asm"
INCLUDE "src/story/wall2_12.asm"
INCLUDE "src/story/senior_12.asm"
INCLUDE "src/story/senior2_12.asm"
INCLUDE "src/story/actor_12.asm"
INCLUDE "src/story/actor2_12.asm"
INCLUDE "src/story/actor3_12.asm"

SECTION "ROM Bank $13", ROMX[$4000], BANK[$13]

DEF ComputeRankingProgressIndex_13_NAME EQUS "Unused_13_ComputeRankingProgressIndex"

INCLUDE "src/story/restaurant_13.asm"
INCLUDE "src/story/dorm_13.asm"
INCLUDE "src/story/academy_13.asm"
INCLUDE "src/story/varsity_13.asm"
INCLUDE "src/story/actor_13.asm"
INCLUDE "src/story/varsity2_13.asm"
INCLUDE "src/story/actor2_13.asm"

SECTION "ROM Bank $14", ROMX[$4000], BANK[$14]

DEF ComputeRankingProgressIndex_14_NAME EQUS "Unused_14_ComputeRankingProgressIndex"

INCLUDE "src/story/tennis_14.asm"
INCLUDE "src/story/court2_14.asm"
INCLUDE "src/story/court1_14.asm"
INCLUDE "src/story/plane_14.asm"
INCLUDE "src/story/firework_14.asm"
INCLUDE "src/story/island_14.asm"

SECTION "ROM Bank $15", ROMX[$4000], BANK[$15]

DEF ComputeRankingProgressIndex_15_NAME EQUS "Unused_15_ComputeRankingProgressIndex"

INCLUDE "src/story/training_15.asm"
INCLUDE "src/story/training2_15.asm"
INCLUDE "src/story/water_15.asm"
INCLUDE "src/story/challenger_15.asm"
INCLUDE "src/story/actor_15.asm"
INCLUDE "src/story/actor2_15.asm"
INCLUDE "src/story/net_15.asm"
INCLUDE "src/story/net2_15.asm"
INCLUDE "src/story/actor3_15.asm"

SECTION "ROM Bank $16", ROMX[$4000], BANK[$16]

DEF ApplySpriteWobbleX_16_NAME EQUS "Unused_16_ApplySpriteWobbleX"
DEF ApplySpriteWobbleY_16_NAME EQUS "Unused_16_ApplySpriteWobbleY"
DEF DrawAsciiDigitChar_16_NAME EQUS "Unused_16_DrawAsciiDigitChar"

INCLUDE "src/engine/menus/menu_16.asm"
INCLUDE "src/engine/menus/diagram_16.asm"
INCLUDE "src/engine/menus/result_16.asm"
INCLUDE "src/engine/menus/match_16.asm"
INCLUDE "src/engine/menus/winlose_16.asm"

SECTION "ROM Bank $17", ROMX[$4000], BANK[$17]

DEF ApplySpriteWobbleX_17_NAME EQUS "Unused_17_ApplySpriteWobbleX"
DEF ApplySpriteWobbleY_17_NAME EQUS "ApplySpriteWobbleY_17"
DEF DrawAsciiDigitChar_17_NAME EQUS "Unused_17_DrawAsciiDigitChar"

INCLUDE "src/engine/menus/slots_17.asm"
INCLUDE "src/engine/menus/menu_17.asm"
INCLUDE "src/engine/menus/briefing_17.asm"
INCLUDE "src/engine/menus/briefing2_17.asm"
INCLUDE "src/engine/menus/spin_17.asm"
INCLUDE "src/engine/menus/pole_17.asm"
INCLUDE "src/engine/menus/drill_17.asm"
INCLUDE "src/engine/menus/lob_17.asm"
INCLUDE "src/engine/menus/rules_17.asm"

SECTION "ROM Bank $18", ROMX[$4000], BANK[$18]

INCLUDE "src/engine/menus/slots_18.asm"
INCLUDE "src/engine/menus/cursorbox_18.asm"
INCLUDE "src/engine/menus/prompts_18.asm"
INCLUDE "src/engine/menus/char_18.asm"
INCLUDE "src/engine/menus/sequences_18.asm"
INCLUDE "src/engine/menus/object_18.asm"

SECTION "ROM Bank $19", ROMX[$4000], BANK[$19]

INCLUDE "src/data/gfx/gfx_19.asm"

SECTION "ROM Bank $1a", ROMX[$4000], BANK[$1a]

INCLUDE "src/engine/menus/options_1a.asm"
INCLUDE "src/engine/menus/expeditor_1a.asm"
INCLUDE "src/engine/menus/exp_1a.asm"
INCLUDE "src/engine/menus/expscreen_1a.asm"
INCLUDE "src/engine/menus/exp2_1a.asm"
INCLUDE "src/engine/menus/exp3_1a.asm"
INCLUDE "src/engine/menus/char_1a.asm"
INCLUDE "src/engine/menus/char2_1a.asm"

SECTION "ROM Bank $1b", ROMX[$4000], BANK[$1b]

DEF DrawAsciiDigitChar_1b_NAME EQUS "Unused_1b_DrawAsciiDigitChar"
DEF DrawCornerBrackets_1b_NAME EQUS "Unused_1b_DrawCornerBrackets"

INCLUDE "src/engine/menus/slots_1b.asm"
INCLUDE "src/engine/menus/menu_1b.asm"
INCLUDE "src/engine/menus/ranking_1b.asm"
INCLUDE "src/engine/menus/ranking2_1b.asm"
INCLUDE "src/engine/menus/ranking3_1b.asm"
INCLUDE "src/engine/menus/char_1b.asm"
INCLUDE "src/engine/menus/debugmenu_1b.asm"
INCLUDE "src/engine/menus/minigame_1b.asm"
INCLUDE "src/engine/menus/minigame2_1b.asm"
INCLUDE "src/engine/menus/minigame3_1b.asm"
INCLUDE "src/engine/menus/minigame4_1b.asm"

SECTION "ROM Bank $1c", ROMX[$4000], BANK[$1c]

INCLUDE "src/engine/menus/char_1c.asm"
INCLUDE "src/engine/menus/char2_1c.asm"
INCLUDE "src/engine/menus/char3_1c.asm"
INCLUDE "src/engine/menus/char4_1c.asm"
INCLUDE "src/engine/menus/char5_1c.asm"

SECTION "ROM Bank $1d", ROMX[$4000], BANK[$1d]

INCLUDE "src/engine/menus/char_1d.asm"
INCLUDE "src/engine/menus/name_1d.asm"
INCLUDE "src/engine/menus/char2_1d.asm"
INCLUDE "src/engine/menus/partner_1d.asm"
INCLUDE "src/engine/menus/char3_1d.asm"
INCLUDE "src/engine/menus/char4_1d.asm"
INCLUDE "src/engine/menus/exp_1d.asm"
INCLUDE "src/engine/menus/exp2_1d.asm"
INCLUDE "src/engine/menus/exp3_1d.asm"

SECTION "ROM Bank $1e", ROMX[$4000], BANK[$1e]

INCLUDE "src/engine/menus/results_1e.asm"
INCLUDE "src/engine/menus/exhibresults_1e.asm"
INCLUDE "src/engine/menus/results2_1e.asm"
INCLUDE "src/engine/menus/exp_1e.asm"
INCLUDE "src/engine/menus/exp2_1e.asm"
INCLUDE "src/engine/menus/exp3_1e.asm"
INCLUDE "src/engine/menus/reward_1e.asm"
INCLUDE "src/engine/menus/trophy_1e.asm"
INCLUDE "src/engine/menus/gameprogress_1e.asm"
INCLUDE "src/engine/menus/progress_1e.asm"

SECTION "ROM Bank $1f", ROMX[$4000], BANK[$1f]

INCLUDE "src/data/text/text_1f.asm"

SECTION "ROM Bank $20", ROMX[$4000], BANK[$20]

DEF ApplyBallTrajectory4_20_NAME EQUS "Unused_20_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_20_NAME EQUS "Unused_20_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_20_NAME EQUS "BallTrajEntryPtr6_20"
DEF SeekBallTrajEntry4_20_NAME EQUS "Unused_20_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_20_NAME EQUS "SeekBallTrajEntry6_20"
DEF SetBallTargetFromAim_20_NAME EQUS "SetBallTargetFromAim_20"
DEF SetBallVelocityFromEntry4_20_NAME EQUS "Unused_20_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_20_NAME EQUS "SetBallVelocityFromEntry6_20"

INCLUDE "src/data/shots/slice.asm"

SECTION "ROM Bank $21", ROMX[$4000], BANK[$21]

DEF ApplyBallTrajectory4_21_NAME EQUS "Unused_21_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_21_NAME EQUS "Unused_21_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_21_NAME EQUS "BallTrajEntryPtr6_21"
DEF SeekBallTrajEntry4_21_NAME EQUS "Unused_21_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_21_NAME EQUS "SeekBallTrajEntry6_21"
DEF SetBallTargetFromAim_21_NAME EQUS "SetBallTargetFromAim_21"
DEF SetBallVelocityFromEntry4_21_NAME EQUS "Unused_21_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_21_NAME EQUS "SetBallVelocityFromEntry6_21"

INCLUDE "src/data/shots/power_slice.asm"

SECTION "ROM Bank $22", ROMX[$4000], BANK[$22]

DEF ApplyBallTrajectory4_22_NAME EQUS "Unused_22_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_22_NAME EQUS "Unused_22_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_22_NAME EQUS "BallTrajEntryPtr6_22"
DEF SeekBallTrajEntry4_22_NAME EQUS "Unused_22_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_22_NAME EQUS "SeekBallTrajEntry6_22"
DEF SetBallTargetFromAim_22_NAME EQUS "SetBallTargetFromAim_22"
DEF SetBallVelocityFromEntry4_22_NAME EQUS "Unused_22_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_22_NAME EQUS "SetBallVelocityFromEntry6_22"

INCLUDE "src/data/shots/topspin.asm"

SECTION "ROM Bank $23", ROMX[$4000], BANK[$23]

DEF ApplyBallTrajectory4_23_NAME EQUS "Unused_23_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_23_NAME EQUS "Unused_23_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_23_NAME EQUS "BallTrajEntryPtr6_23"
DEF SeekBallTrajEntry4_23_NAME EQUS "Unused_23_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_23_NAME EQUS "SeekBallTrajEntry6_23"
DEF SetBallTargetFromAim_23_NAME EQUS "SetBallTargetFromAim_23"
DEF SetBallVelocityFromEntry4_23_NAME EQUS "Unused_23_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_23_NAME EQUS "SetBallVelocityFromEntry6_23"

INCLUDE "src/data/shots/power_topspin.asm"

SECTION "ROM Bank $24", ROMX[$4000], BANK[$24]

DEF ApplyBallTrajectory4_24_NAME EQUS "Unused_24_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_24_NAME EQUS "BallTrajEntryPtr4_24"
DEF BallTrajEntryPtr6_24_NAME EQUS "BallTrajEntryPtr6_24"
DEF SeekBallTrajEntry4_24_NAME EQUS "SeekBallTrajEntry4_24"
DEF SeekBallTrajEntry6_24_NAME EQUS "Unused_24_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_24_NAME EQUS "SetBallTargetFromAim_24"
DEF SetBallVelocityFromEntry4_24_NAME EQUS "SetBallVelocityFromEntry4_24"
DEF SetBallVelocityFromEntry6_24_NAME EQUS "SetBallVelocityFromEntry6_24"

INCLUDE "src/data/shots/lob_drop_neutral_smash.asm"

SECTION "ROM Bank $25", ROMX[$4000], BANK[$25]

INCLUDE "src/data/text/text_25.asm"

SECTION "ROM Bank $26", ROMX[$4000], BANK[$26]

INCLUDE "src/data/text/text_26.asm"

SECTION "ROM Bank $27", ROMX[$4000], BANK[$27]

DEF ComputeRankingProgressIndex_27_NAME EQUS "Unused_27_ComputeRankingProgressIndex"

INCLUDE "src/story/slots_27.asm"
INCLUDE "src/story/end16_27.asm"
INCLUDE "src/story/end12_27.asm"
INCLUDE "src/story/end10_27.asm"
INCLUDE "src/story/end4_27.asm"
INCLUDE "src/story/restaurant_27.asm"
INCLUDE "src/story/actor_27.asm"

SECTION "ROM Bank $28", ROMX[$4000], BANK[$28]

INCLUDE "src/engine/match/variants_28.asm"

SECTION "ROM Bank $29", ROMX[$4000], BANK[$29]

DEF ApplyBallTrajectory4_29_NAME EQUS "Unused_29_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_29_NAME EQUS "Unused_29_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_29_NAME EQUS "Unused_29_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_29_NAME EQUS "Unused_29_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_29_NAME EQUS "Unused_29_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_29_NAME EQUS "Unused_29_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_29_NAME EQUS "Unused_29_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_29_NAME EQUS "Unused_29_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_topspin.asm"

SECTION "ROM Bank $2a", ROMX[$4000], BANK[$2a]

DEF ApplyBallTrajectory4_2a_NAME EQUS "Unused_2a_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_2a_NAME EQUS "Unused_2a_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_2a_NAME EQUS "Unused_2a_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_2a_NAME EQUS "Unused_2a_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_2a_NAME EQUS "Unused_2a_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_2a_NAME EQUS "Unused_2a_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_2a_NAME EQUS "Unused_2a_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_2a_NAME EQUS "Unused_2a_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_slice.asm"

SECTION "ROM Bank $2b", ROMX[$4000], BANK[$2b]

DEF ApplyBallTrajectory4_2b_NAME EQUS "Unused_2b_ApplyBallTrajectory4"
DEF BallTrajEntryPtr4_2b_NAME EQUS "Unused_2b_BallTrajEntryPtr4"
DEF BallTrajEntryPtr6_2b_NAME EQUS "Unused_2b_BallTrajEntryPtr6"
DEF SeekBallTrajEntry4_2b_NAME EQUS "Unused_2b_SeekBallTrajEntry4"
DEF SeekBallTrajEntry6_2b_NAME EQUS "Unused_2b_SeekBallTrajEntry6"
DEF SetBallTargetFromAim_2b_NAME EQUS "Unused_2b_SetBallTargetFromAim"
DEF SetBallVelocityFromEntry4_2b_NAME EQUS "Unused_2b_SetBallVelocityFromEntry4"
DEF SetBallVelocityFromEntry6_2b_NAME EQUS "Unused_2b_SetBallVelocityFromEntry6"

INCLUDE "src/data/shots/serve_flat.asm"

SECTION "ROM Bank $2c", ROMX[$4000], BANK[$2c]

DEF ApplyBallTrajectory4_2c_NAME EQUS "ApplyBallTrajectory4_2c"
DEF BallTrajEntryPtr4_2c_NAME EQUS "BallTrajEntryPtr4_2c"
DEF BallTrajEntryPtr6_2c_NAME EQUS "BallTrajEntryPtr6_2c"
DEF SeekBallTrajEntry4_2c_NAME EQUS "SeekBallTrajEntry4_2c"
DEF SeekBallTrajEntry6_2c_NAME EQUS "SeekBallTrajEntry6_2c"
DEF SetBallTargetFromAim_2c_NAME EQUS "SetBallTargetFromAim_2c"
DEF SetBallVelocityFromEntry4_2c_NAME EQUS "SetBallVelocityFromEntry4_2c"
DEF SetBallVelocityFromEntry6_2c_NAME EQUS "SetBallVelocityFromEntry6_2c"

INCLUDE "src/data/shots/reach.asm"

SECTION "ROM Bank $2d", ROMX[$4000], BANK[$2d]

INCLUDE "src/data/shots/tables_2d.asm"

SECTION "ROM Bank $2e", ROMX[$4000], BANK[$2e]

INCLUDE "src/data/shots/tables_2e.asm"

SECTION "ROM Bank $2f", ROMX[$4000], BANK[$2f]

INCLUDE "src/data/shots/tables_2f.asm"

SECTION "ROM Bank $30", ROMX[$4000], BANK[$30]

INCLUDE "src/data/text/text_30.asm"

SECTION "ROM Bank $31", ROMX[$4000], BANK[$31]

INCLUDE "src/data/text/text_31.asm"

SECTION "ROM Bank $32", ROMX[$4000], BANK[$32]

INCLUDE "src/data/text/text_32.asm"

SECTION "ROM Bank $33", ROMX[$4000], BANK[$33]

INCLUDE "src/data/text/text_33.asm"

SECTION "ROM Bank $34", ROMX[$4000], BANK[$34]

INCLUDE "src/data/text/text_34.asm"

SECTION "ROM Bank $35", ROMX[$4000], BANK[$35]

INCLUDE "src/data/text/text_35.asm"

SECTION "ROM Bank $36", ROMX[$4000], BANK[$36]

INCLUDE "src/data/text/text_36.asm"

SECTION "ROM Bank $37", ROMX[$4000], BANK[$37]

INCLUDE "src/data/text/text_37.asm"

SECTION "ROM Bank $38", ROMX[$4000], BANK[$38]

DEF DrawCornerBrackets_38_NAME EQUS "Unused_38_DrawCornerBrackets"

INCLUDE "src/engine/menus/menu_38.asm"
INCLUDE "src/engine/menus/matchtype_38.asm"
INCLUDE "src/engine/menus/character_38.asm"
INCLUDE "src/engine/menus/char_38.asm"
INCLUDE "src/engine/menus/player_38.asm"
INCLUDE "src/engine/menus/char2_38.asm"
INCLUDE "src/engine/menus/char3_38.asm"
INCLUDE "src/engine/menus/cpu_38.asm"
INCLUDE "src/engine/menus/cpu2_38.asm"
INCLUDE "src/engine/menus/remote_38.asm"
INCLUDE "src/engine/menus/link_38.asm"
INCLUDE "src/engine/menus/name_38.asm"
INCLUDE "src/engine/menus/link2_38.asm"

SECTION "ROM Bank $39", ROMX[$4000], BANK[$39]

INCLUDE "src/engine/menus/slots_39.asm"
INCLUDE "src/engine/menus/animated_39.asm"
INCLUDE "src/engine/menus/menu_39.asm"
INCLUDE "src/engine/menus/assets_39.asm"
INCLUDE "src/engine/menus/menu2_39.asm"

SECTION "ROM Bank $3a", ROMX[$4000], BANK[$3a]

INCLUDE "src/data/gfx/gfx_3a.asm"

SECTION "ROM Bank $3b", ROMX[$4000], BANK[$3b]

DEF DrawAsciiDigitChar_3b_NAME EQUS "Unused_3b_DrawAsciiDigitChar"
DEF DrawCornerBrackets_3b_NAME EQUS "Unused_3b_DrawCornerBrackets"

INCLUDE "src/engine/menus/slots_3b.asm"
INCLUDE "src/engine/menus/menu_3b.asm"
INCLUDE "src/engine/menus/n64_3b.asm"
INCLUDE "src/engine/menus/n64exhib_3b.asm"
INCLUDE "src/engine/menus/n64trophies_3b.asm"
INCLUDE "src/engine/menus/n64tnmt_3b.asm"
INCLUDE "src/engine/menus/ring_3b.asm"
INCLUDE "src/engine/menus/menu2_3b.asm"
INCLUDE "src/engine/menus/saveslots_3b.asm"
INCLUDE "src/engine/menus/minigame_3b.asm"
INCLUDE "src/engine/menus/saved_3b.asm"
INCLUDE "src/engine/menus/erase_3b.asm"
INCLUDE "src/engine/menus/n64transfer_3b.asm"
INCLUDE "src/engine/menus/bracket_3b.asm"
INCLUDE "src/engine/menus/victory_3b.asm"

SECTION "ROM Bank $3c", ROMX[$4000], BANK[$3c]

INCLUDE "src/data/gfx/gfx_3c.asm"

SECTION "ROM Bank $3d", ROMX[$4000], BANK[$3d]

INCLUDE "src/data/gfx/gfx_3d.asm"

SECTION "ROM Bank $3e", ROMX[$4000], BANK[$3e]

DEF DrawAsciiDigitChar_3e_NAME EQUS "Unused_3e_DrawAsciiDigitChar"
DEF DrawCornerBrackets_3e_NAME EQUS "Unused_3e_DrawCornerBrackets"

INCLUDE "src/engine/menus/slots_3e.asm"
INCLUDE "src/engine/menus/selection_3e.asm"
INCLUDE "src/engine/menus/rules_3e.asm"
INCLUDE "src/engine/menus/linkrules_3e.asm"
INCLUDE "src/engine/menus/racket_3e.asm"
INCLUDE "src/engine/menus/choicetab_3e.asm"
INCLUDE "src/engine/menus/racket2_3e.asm"
INCLUDE "src/engine/menus/equip_3e.asm"
INCLUDE "src/engine/menus/courtselect_3e.asm"
INCLUDE "src/engine/menus/courtselect2_3e.asm"

SECTION "ROM Bank $3f", ROMX[$4000], BANK[$3f]

INCLUDE "src/engine/menus/slots_3f.asm"
INCLUDE "src/engine/menus/dictionary_3f.asm"
INCLUDE "src/engine/menus/dictionary2_3f.asm"

SECTION "ROM Bank $40", ROMX[$4000], BANK[$40]

DataPtr_AlexSpriteDesc:
	dw AlexSpriteDesc ; $4000

INCLUDE "src/data/sprites/alex_40.asm"

SECTION "ROM Bank $41", ROMX[$4000], BANK[$41]

DataPtr_NinaSpriteDesc:
	dw NinaSpriteDesc ; $4000

INCLUDE "src/data/sprites/nina_41.asm"

SECTION "ROM Bank $42", ROMX[$4000], BANK[$42]

DataPtr_KateSpriteDesc:
	dw KateSpriteDesc ; $4000

INCLUDE "src/data/sprites/kate_42.asm"

SECTION "ROM Bank $43", ROMX[$4000], BANK[$43]

DataPtr_HarrySpriteDesc:
	dw HarrySpriteDesc ; $4000

INCLUDE "src/data/sprites/harry_43.asm"

SECTION "ROM Bank $44", ROMX[$4000], BANK[$44]

DataPtr_EmilySpriteDesc:
	dw EmilySpriteDesc ; $4000

INCLUDE "src/data/sprites/emily_44.asm"

SECTION "ROM Bank $45", ROMX[$4000], BANK[$45]

DataPtr_MarkSpriteDesc:
	dw MarkSpriteDesc ; $4000

INCLUDE "src/data/sprites/sprite_45.asm"

SECTION "ROM Bank $46", ROMX[$4000], BANK[$46]

DataPtr_SammiSpriteDesc:
	dw SammiSpriteDesc ; $4000

INCLUDE "src/data/sprites/sammi_46.asm"

SECTION "ROM Bank $47", ROMX[$4000], BANK[$47]

DataPtr_SeanSpriteDesc:
	dw SeanSpriteDesc ; $4000

INCLUDE "src/data/sprites/sean_47.asm"

SECTION "ROM Bank $48", ROMX[$4000], BANK[$48]

DataPtr_SpikeSpriteDesc:
	dw SpikeSpriteDesc ; $4000

INCLUDE "src/data/sprites/spike_48.asm"

SECTION "ROM Bank $49", ROMX[$4000], BANK[$49]

DataPtr_EldenSpriteDesc:
	dw EldenSpriteDesc ; $4000

INCLUDE "src/data/sprites/elden_49.asm"

SECTION "ROM Bank $4a", ROMX[$4000], BANK[$4a]

DataPtr_ACozSpriteDesc:
	dw ACozSpriteDesc ; $4000

INCLUDE "src/data/sprites/coz_4a.asm"

SECTION "ROM Bank $4b", ROMX[$4000], BANK[$4b]

DataPtr_BCozSpriteDesc:
	dw BCozSpriteDesc ; $4000

INCLUDE "src/data/sprites/coz_4b.asm"

SECTION "ROM Bank $4c", ROMX[$4000], BANK[$4c]

DataPtr_AllieSpriteDesc:
	dw AllieSpriteDesc ; $4000

INCLUDE "src/data/sprites/allie_4c.asm"

SECTION "ROM Bank $4d", ROMX[$4000], BANK[$4d]

DataPtr_BrianSpriteDesc:
	dw BrianSpriteDesc ; $4000

INCLUDE "src/data/sprites/brian_4d.asm"

SECTION "ROM Bank $4e", ROMX[$4000], BANK[$4e]

DataPtr_CurtSpriteDesc:
	dw CurtSpriteDesc ; $4000

INCLUDE "src/data/sprites/curt_4e.asm"

SECTION "ROM Bank $4f", ROMX[$4000], BANK[$4f]

DataPtr_BobSpriteDesc:
	dw BobSpriteDesc ; $4000

INCLUDE "src/data/sprites/bob_4f.asm"

SECTION "ROM Bank $50", ROMX[$4000], BANK[$50]

DataPtr_MarioSpriteDesc:
	dw MarioSpriteDesc ; $4000

INCLUDE "src/data/sprites/mario_50.asm"

SECTION "ROM Bank $51", ROMX[$4000], BANK[$51]

DataPtr_WaluigiSpriteDesc:
	dw WaluigiSpriteDesc ; $4000

INCLUDE "src/data/sprites/waluigi_51.asm"

SECTION "ROM Bank $52", ROMX[$4000], BANK[$52]

DataPtr_YoshiSpriteDesc:
	dw YoshiSpriteDesc ; $4000

INCLUDE "src/data/sprites/yoshi_52.asm"

SECTION "ROM Bank $53", ROMX[$4000], BANK[$53]

DataPtr_BowserSpriteDesc:
	dw BowserSpriteDesc ; $4000

INCLUDE "src/data/sprites/bowser_53.asm"

SECTION "ROM Bank $54", ROMX[$4000], BANK[$54]

DataPtr_PeachSpriteDesc:
	dw PeachSpriteDesc ; $4000

INCLUDE "src/data/sprites/peach_54.asm"

SECTION "ROM Bank $55", ROMX[$4000], BANK[$55]

DataPtr_WarioSpriteDesc:
	dw WarioSpriteDesc ; $4000

INCLUDE "src/data/sprites/wario_55.asm"

SECTION "ROM Bank $56", ROMX[$4000], BANK[$56]

DataPtr_JoySpriteDesc:
	dw JoySpriteDesc ; $4000

INCLUDE "src/data/sprites/joy_56.asm"

SECTION "ROM Bank $57", ROMX[$4000], BANK[$57]

DataPtr_PamSpriteDesc:
	dw PamSpriteDesc ; $4000

INCLUDE "src/data/sprites/pam_57.asm"

SECTION "ROM Bank $58", ROMX[$4000], BANK[$58]

DataPtr_BethSpriteDesc:
	dw BethSpriteDesc ; $4000

INCLUDE "src/data/sprites/beth_58.asm"

SECTION "ROM Bank $59", ROMX[$4000], BANK[$59]

DataPtr_FaySpriteDesc:
	dw FaySpriteDesc ; $4000

INCLUDE "src/data/sprites/fay_59.asm"

SECTION "ROM Bank $5a", ROMX[$4000], BANK[$5a]

DataPtr_BallMachineSpriteDesc:
	dw BallMachineSpriteDesc ; $4000

INCLUDE "src/data/sprites/ball_5a.asm"

SECTION "ROM Bank $5b", ROMX[$4000], BANK[$5b]

DataPtr_LuigiSpriteDesc:
	dw LuigiSpriteDesc ; $4000

INCLUDE "src/data/sprites/luigi_5b.asm"

SECTION "ROM Bank $5c", ROMX[$4000], BANK[$5c]

DataPtr_DKSpriteDesc:
	dw DKSpriteDesc ; $4000

INCLUDE "src/data/sprites/sprite_5c.asm"

SECTION "ROM Bank $5d", ROMX[$4000], BANK[$5d]

DataPtr_BabyMarioSpriteDesc:
	dw BabyMarioSpriteDesc ; $4000

INCLUDE "src/data/sprites/baby_5d.asm"

SECTION "ROM Bank $5e", ROMX[$4000], BANK[$5e]

INCLUDE "src/data/text/text_5e.asm"

SECTION "ROM Bank $5f", ROMX[$4000], BANK[$5f]

INCLUDE "src/data/scenes/scenes_5f.asm"

SECTION "ROM Bank $60", ROMX[$4000], BANK[$60]

INCLUDE "src/data/scenes/scenes_60.asm"

SECTION "ROM Bank $61", ROMX[$4000], BANK[$61]

INCLUDE "src/data/scenes/scenes_61.asm"

SECTION "ROM Bank $62", ROMX[$4000], BANK[$62]

INCLUDE "src/data/scenes/scenes_62.asm"

SECTION "ROM Bank $63", ROMX[$4000], BANK[$63]

INCLUDE "src/data/scenes/scenes_63.asm"

SECTION "ROM Bank $64", ROMX[$4000], BANK[$64]

INCLUDE "src/data/scenes/scenes_64.asm"

SECTION "ROM Bank $65", ROMX[$4000], BANK[$65]

INCLUDE "src/data/scenes/scenes_65.asm"

SECTION "ROM Bank $66", ROMX[$4000], BANK[$66]

INCLUDE "src/data/scenes/scenes_66.asm"

SECTION "ROM Bank $67", ROMX[$4000], BANK[$67]

INCLUDE "src/data/scenes/scenes_67.asm"

SECTION "ROM Bank $68", ROMX[$4000], BANK[$68]

INCLUDE "src/data/scenes/scenes_68.asm"

SECTION "ROM Bank $69", ROMX[$4000], BANK[$69]

INCLUDE "src/data/scenes/scenes_69.asm"

SECTION "ROM Bank $6a", ROMX[$4000], BANK[$6a]

INCLUDE "src/data/sprites/walk_6a.asm"

SECTION "ROM Bank $6b", ROMX[$4000], BANK[$6b]

INCLUDE "src/engine/cutscenes/slots_6b.asm"
INCLUDE "src/engine/cutscenes/intro_6b.asm"
INCLUDE "src/engine/cutscenes/intro2_6b.asm"
INCLUDE "src/engine/cutscenes/intro3_6b.asm"
INCLUDE "src/engine/cutscenes/title_6b.asm"

SECTION "ROM Bank $6c", ROMX[$4000], BANK[$6c]

INCLUDE "src/data/gfx/gfx_6c.asm"

SECTION "ROM Bank $6d", ROMX[$4000], BANK[$6d]

INCLUDE "src/data/gfx/gfx_6d.asm"

SECTION "ROM Bank $6e", ROMX[$4000], BANK[$6e]

INCLUDE "src/data/text/text_6e.asm"

SECTION "ROM Bank $6f", ROMX[$4000], BANK[$6f]

INCLUDE "src/data/sprites/walk_6f.asm"

SECTION "ROM Bank $70", ROMX[$4000], BANK[$70]

INCLUDE "src/data/sprites/walk_70.asm"

SECTION "ROM Bank $71", ROMX[$4000], BANK[$71]

INCLUDE "src/data/sprites/walk_71.asm"

SECTION "ROM Bank $72", ROMX[$4000], BANK[$72]

INCLUDE "src/data/sprites/walk_72.asm"

SECTION "ROM Bank $73", ROMX[$4000], BANK[$73]

INCLUDE "src/data/sprites/walk_73.asm"

SECTION "ROM Bank $74", ROMX[$4000], BANK[$74]

INCLUDE "src/data/sprites/walk_74.asm"

SECTION "ROM Bank $75", ROMX[$4000], BANK[$75]

INCLUDE "src/data/sprites/walk_75.asm"

SECTION "ROM Bank $76", ROMX[$4000], BANK[$76]

INCLUDE "src/data/sprites/walk_76.asm"

SECTION "ROM Bank $77", ROMX[$4000], BANK[$77]

INCLUDE "src/data/sprites/walk_77.asm"

SECTION "ROM Bank $78", ROMX[$4000], BANK[$78]

INCLUDE "src/audio/sound_78.asm"

SECTION "ROM Bank $79", ROMX[$4000], BANK[$79]

INCLUDE "src/audio/sound_79.asm"

SECTION "ROM Bank $7a", ROMX[$4000], BANK[$7a]

INCLUDE "src/audio/sound_7a.asm"

SECTION "ROM Bank $7b", ROMX[$4000], BANK[$7b]

INCLUDE "src/audio/sound_7b.asm"

SECTION "ROM Bank $7c", ROMX[$4000], BANK[$7c]

INCLUDE "src/audio/sound_7c.asm"

SECTION "ROM Bank $7d", ROMX[$4000], BANK[$7d]

INCLUDE "src/audio/sound_7d.asm"

SECTION "ROM Bank $7e", ROMX[$4000], BANK[$7e]

INCLUDE "src/audio/sound_7e.asm"

SECTION "ROM Bank $7f", ROMX[$4000], BANK[$7f]

INCLUDE "src/audio/sound_7f.asm"
