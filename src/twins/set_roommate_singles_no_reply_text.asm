; Shared by SetRoommateSinglesNoReplyText_13, SetRoommateSinglesYesReplyText_13 (bank $13).

{TWIN_LABEL}:
	call GetDormRoomStoryStage_13
	cp $01
	jp nz, .done
	test_flag FLAG_TEMP_SCENE_VARIANT_A
	jr z, .setText
	script_set_text Text_31_276
	jr .done
.setText:
	script_set_text Text_31_271
.done:
	ret
