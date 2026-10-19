; SetPartnerObjDefByGender_<bank>, one copy in each of banks $13, $27.

SetPartnerObjDefByGender_{TWIN}:
	ld a, [wStoryPartnerGender]
	or a
	jr nz, .done
	script_set_objdef OBJ_HARRY, $0d
	script_set_anim $0d, ANIM_WALK
	set_flag FLAG_TEMP_SCENE_VARIANT_A
.done:
	ret
