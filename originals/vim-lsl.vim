" Vim syntax file
" Language:	Linden scripting language
" Maintainer:	Gabriel Spinnaker (gs@geekmafia.net)
" Last Change:	2004 Sep 11

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Basic syntax
syn case match
syn keyword	lStatement	jump return default state
syn match	lLabel		"@.\+;"
syn keyword	lConditional	if else 
syn keyword	lRepeat		while for do
syn keyword	lTodo		contained TODO FIXME XXX
syn keyword	lType		integer float list vector rotation quaternion string key
syn match	lOperator	"[-=+%^&|*!~]"
syn match	lOperator	"[-+]="
syn match	lOperator	"&&"
syn match	lOperator	"||"
syn match	lOperator	"[!=<>]="
syn match	lOperator	"[<>]"
syn match	lOperator	"[<>][<>]"
syn cluster	lCommentGroup	contains=lTodo
syn match	lComment	"//.*$" contains=@lCommentGroup

syn region 	lString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn match	lNumber		"-\=\<\d\+\>"
syn match	lHexNumber	"0x\<\d\+\>"
syn match	lFloat		"-\=\<\d\+\.\d\+\>"
syn region	lBlock		matchgroup=lSpecial start=/{/ end=/}/ contains=ALL
syn cluster	lListGroup	contains=lNumber,lFloat,lString,lOperator
syn region	lList		matchgroup=lSpecial start=/\[/ end=/\]/ contains=@lListGroup
syn region	lParen		matchgroup=lSpecial start=/(/ end=/)/ contains=ALL
syn match	lVecQuatXYZS	".\[xyzs\]"

syn keyword	lConstant	PI TWO_PI PI_BY_TWO DEG_TO_RAD RAD_TO_DEG SQRT2 ALL_SIDES
syn keyword	lConstant	TRUE FALSE
syn keyword	lConstant	NULL_KEY EOF
syn keyword	lConstant	ZERO_ROTATION
syn keyword	lConstant	ZERO_VECTOR
syn keyword	lConstant	AGENT ACTIVE PASSIVE SCRIPTED
syn keyword	lConstant	CHANGED_INVENTORY CHANGED_COLOR CHANGED_SHAPE CHANGED_SCALE CHANGED_TEXTURE CHANGED_LINK CHANGED_ALLOWED_DROP
syn keyword	lConstant	STATUS_BLOCK_GRAB STATUS_DIE_AT_EDGE STATUS_RETURN_AT_EDGE STATUS_PHANTOM STATUS_PHYSICS STATUS_ROTATE_X STATUS_ROTATE_Y STATUS_ROTATE_Z STATUS_SANDBOX
syn keyword	lConstant	CONTROL_FWD CONTROL_BACK CONTROL_LEFT CONTROL_ROT_LEFT CONTROL_RIGHT CONTROL_ROT_RIGHT CONTROL_UP CONTROL_DOWN CONTROL_LBUTTON CONTROL_ML_LBUTTON
syn keyword	lConstant	INVENTORY_TEXTURE INVENTORY_SOUND INVENTORY_OBJECT INVENTORY_SCRIPT INVENTORY_LANDMARK INVENTORY_CLOTHING INVENTORY_BODYPART INVENTORY_NOTECARD INVENTORY_ANIMATION INVENTORY_GESTURE
syn keyword	lConstant	TYPE_INTEGER TYPE_FLOAT TYPE_STRING TYPE_KEY TYPE_VECTOR TYPE_ROTATION TYPE_INVALID
syn keyword	lConstant	PRIM_BUMP_SHINY PRIM_COLOR PRIM_MATERIAL PRIM_PHANTOM PRIM_PHYSICS PRIM_POSITION PRIM_ROTATION PRIM_SIZE PRIM_TEMP_ON_REZ PRIM_TYPE PRIM_TEXTURE
syn keyword	lConstant	PRIM_TYPE_BOX PRIM_TYPE_CYLINDER PRIM_TYPE_PRISM PRIM_TYPE_SPHERE PRIM_TYPE_TORUS PRIM_TYPE_TUBE
syn keyword	lConstant	PRIM_BUMP_NONE PRIM_BUMP_BRIGHT PRIM_BUMP_DARK PRIM_BUMP_WOOD PRIM_BUMP_BARK PRIM_BUMP_BRICKS PRIM_BUMP_CHECKER PRIM_BUMP_CONCRETE PRIM_BUMP_TILE PRIM_BUMP_STONE PRIM_BUMP_DISKS PRIM_BUMP_GRAVEL PRIM_BUMP_BLOBS PRIM_BUMP_SIDING PRIM_BUMP_LARGETILE PRIM_BUMP_STUCCO PRIM_BUMP_SUCTION PRIM_BUMP_WEAVE
syn keyword	lConstant	PRIM_SHINY_NONE PRIM_SHINY_LOW PRIM_SHINY_MEDIUM PRIM_SHINY_HIGH
syn keyword	lConstant	PRIM_MATERIAL_STONE PRIM_MATERIAL_METAL PRIM_MATERIAL_GLASS PRIM_MATERIAL_WOOD PRIM_MATERIAL_FLESH PRIM_MATERIAL_PLASTIC PRIM_MATERIAL_RUBBER PRIM_MATERIAL_LIGHT
syn keyword	lConstant	PRIM_HOLE_DEFAULT PRIM_HOLE_SQUARE PRIM_HOME_CIRCLE PRIM_HOLE_TRIANGLE
syn keyword	lConstant	PERMISSION_DEBIT PERMISSION_TAKE_CONTROLS PERMISSION_TRIGGER_ANIMATION PERMISSION_ATTACH PERMISSION_CHANGE_LINKS
syn keyword	lConstant	PSYS_PART_FLAGS PSYS_PART_BOUNCE_MASK PSYS_PART_WIND_MASK PSYS_PART_INTERP_COLOR_MASK PSYS_PART_INTERP_SCALE_MASK PSYS_PART_FOLLOW_SRC_MASK PSYS_PART_FOLLOW_VELOCITY_MASK PSYS_PART_TARGET_POS_MASK PSYS_PART_EMISSIVE_MASK PSYS_PART_TARGET_LINEAR_MASK
" these are listed on the wiki, but are not implemented or highlighted by the
" official editor
" syn keyword	lConstant	PSYS_PART_RANDOM_ACCEL_MASK PSYS_PART_RANDOM_VEL_MASK PSYS_PART_TRAIL_MASK
syn keyword	lConstant	PSYS_SRC_PATTERN PSYS_SRC_PATTERN_DROP PSYS_SRC_PATTERN_EXPLODE PSYS_SRC_PATTERN_ANGLE PSYS_SRC_PATTERN_ANGLE_CONE PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY
syn keyword	lConstant	PSYS_PART_START_COLOR PSYS_PART_START_ALPHA PSYS_PART_START_SCALE PSYS_PART_END_COLOR PSYS_PART_END_ALPHA PSYS_PART_END_SCALE PSYS_PART_MAX_AGE PSYS_SRC_ANGLE_BEGIN PSYS_SRC_ANGLE_END PSYS_SRC_BURST_RATE PSYS_SRC_BURST_PART_COUNT PSYS_SRC_BURST_RADIUS PSYS_SRC_BURST_SPEED_MIN PSYS_SRC_BURST_SPEED_MAX PSYS_SRC_MAX_AGE PSYS_SRC_ACCEL PSYS_SRC_TEXTURE PSYS_SRC_TARGET_KEY PSYS_SRC_OMEGA
syn keyword	lConstant	DATA_ONLINE DATA_NAME DATA_BORN DATA_RATING
syn keyword	lConstant	VEHICLE_TYPE_NONE VEHICLE_TYPE_AIRPLANE VEHICLE_TYPE_BALLOON VEHICLE_TYPE_BOAT VEHICLE_TYPE_CAR VEHICLE_TYPE_SLED
syn keyword	lConstant	VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY VEHICLE_ANGULAR_DEFLECTION_TIMESCALE VEHICLE_ANGULAR_FRICTION_TIMESCALE VEHICLE_ANGULAR_MOTOR_DECAY_TIMESCALE VEHICLE_ANGULAR_MOTOR_DIRECTION VEHICLE_ANGULAR_MOTOR_TIMESCALE VEHICLE_BANKING_EFFICIENCY VEHICLE_BANKING_MIX VEHICLE_BANKING_TIMESCALE VEHICLE_BUOYANCY VEHICLE_HOVER_HEIGHT VEHICLE_HOVER_EFFICIENCY VEHICLE_HOVER_TIMESCALE VEHICLE_LINEAR_DEFLECTION_EFFICIENCY VEHICLE_LINEAR_DEFLECTION_TIMESCALE VEHICLE_LINEAR_FRICTION_TIMESCALE VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE VEHICLE_LINEAR_MOTOR_DIRECTION VEHICLE_LINEAR_MOTOR_TIMESCALE VEHICLE_REFERENCE_FRAME VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY VEHICLE_VERTICAL_ATTRACTION_TIMESCALE
syn keyword	lConstant	VEHICLE_FLAG_NO_DEFLECTION_UP VEHICLE_FLAG_LIMIT_ROLL_ONLY VEHICLE_FLAG_HOVER_WATER_ONLY VEHICLE_FLAG_HOVER_TERRAIN_ONLY VEHICLE_FLAG_HOVER_GLOBAL_HEIGHT VEHICLE_FLAG_HOVER_UP_ONLY VEHICLE_FLAG_LIMIT_MOTOR_UP VEHICLE_FLAG_MOUSELOOK_STEER VEHICLE_FLAG_MOUSELOOK_BANK VEHICLE_FLAG_CAMERA_DECOUPLED
syn keyword	lConstant	LAND_LEVEL LAND_RAISE LAND_LOWER LAND_SMOOTH LAND_NOISE LAND_REVERT LAND_SMALL_BRUSH LAND_MEDIUM_BRUSH LAND_LARGE_BRUSH
syn keyword	lConstant	LINK_SET LINK_ALL_OTHERS LINK_ALL_CHILDREN LINK_ROOT

" Events
syn keyword	lEvent		at_rot_target at_target attach changed collision collision_end collision_start control dataserver email land_collision land_collision_end land_collision_start link_message listen money moving_end moving_start no_sensor not_at_rot_target not_at_target object_rez on_rez remote_data run_time_permissions state_entry state_exit timer touch touch_end touch_start

" Built-in functions (as of 1.4.11)
syn keyword lFunction llAbs llAcos llAddToLandPassList llAdjustSoundVolume llAllowInventoryDrop llAngleBetween llApplyImpulse llApplyRotationalImpulse llAsin llsyn keyword lFunction Atan2 llAttachToAvatar llAvatarOnSitTarget llAxes2Rot llAxisAngle2Rot
syn keyword lFunction llBase64ToString llBreakAllLinks llBreakLink
syn keyword lFunction llCSV2List llCeil llCloseRemoteDataChannel llCloud llCollisionFilter llCollisionSound llCollisionSprite llCos llCreateLink
syn keyword lFunction llDeleteSubList llDeleteSubString llDetachFromAvatar llDetectedGrab llDetectedGroup llDetectedKey llDetectedLinkNumber llDetectedName llDetectedOwner llDetectedPos llDetectedRot llDetectedType llDetectedVel llDialog llDie llDumpList2String
syn keyword lFunction llEdgeOfWorld llEjectFromLand llEmail llEuler2Rot
syn keyword lFunction llFabs llFloor llFrand
syn keyword lFunction llGetAccel llGetAgentInfo llGetAgentSize llGetAlpha llGetAndResetTime llGetAnimation llGetAttached llGetCenterOfMass llGetColor llGetDate llGetEnergy llGetForce llGetFreeMemory llGetInventoryKey llGetInventoryName llGetInventoryNumber llGetKey llGetLandOwnerAt llGetLinkKey llGetLinkName llGetLinkNumber llGetListEntryType llGetListLength llGetLocalPos llGetLocalRot llGetMass llGetNextEmail llGetNotecardLine llGetNumberOfSides llGetObjectName llGetOmega llGetOwner llGetOwnerKey llGetPermissions llGetPermissionsKey llGetPos llGetRegionCorner llGetRegionFPS llGetRegionName llGetRegionTimeDilation llGetRot llGetScale llGetScriptName llGetScriptState llGetStartParameter llGetStatus llGetSubString llGetSunDirection llGetTexture llGetTextureOffset llGetTextureRot llGetTextureScale llGetTime llGetTimeOfDay llGetTorque llGetVel llGetWallclock llGiveInventory llGiveInventoryList llGiveMoney llGodLikeRezObject llGround llGroundContour llGroundNormal llGroundRepel llGroundSlope
syn keyword lFunction llInsertString llInstantMessage
syn keyword lFunction llKey2Name
syn keyword lFunction llList2CSV llList2Float llList2Integer llList2Key llList2List llList2ListStrided llList2Rot llList2String llList2Vector llListFindList llListInsertList llListRandomize llListSort llListen llListenControl llListenRemove llLog llLog10 llLookAt llLoopSound llLoopSoundMaster llLoopSoundSlave
syn keyword lFunction llMD5String llMessageLinked llMinEventDelay llModifyLand llMoveToTarget
syn keyword lFunction llOffsetTexture llOpenRemoteDataChannel llOverMyLand
syn keyword lFunction llParseString2List llParticleSystem llPassCollisions llPassTouches llPlaySound llPlaySoundSlave llPointAt llPow llPreloadSound llPushObject 
syn keyword lFunction llReleaseCamera llReleaseControls llRemoteDataReply llRemoteDataSetRegion llRemoteLoadScriptPin llRemoveInventory llRemoveVehicleFlags llRequestAgentData llRequestInventoryData llRequestPermissions llResetOtherScript llResetScript llResetTime llRezObject llRot2Angle llRot2Axis llRot2Euler llRot2Fwd llRot2Left llRot2Up 
syn keyword lFunction  llRotBetween llRotLookAt llRotTarget llRotTargetRemove llRotateTexture llRound
syn keyword lFunction llSameGroup llSay llScaleTexture llScriptDanger llSendRemoteData llSensor llSensorRemove llSensorRepeat llSetAlpha llSetBuoyancy llSetCameraAtOffset llSetCameraEyeOffset llSetColor llSetDamage llSetForce llSetForceAndTorque llSetHoverHeight llSetLinkColor llSetObjectName llSetPos llSetPrimitiveParams llSetRemoteScriptAccessPin llSetRot llSetScale llSetScriptState llSetSitText llSetSoundQueueing llSetSoundRadius llSetStatus llSetText llSetTexture llSetTextureAnim llSetTimerEvent llSetTorque llSetTouchText llSetVehicleFlags llSetVehicleFloatParam llSetVehicleRotationParam llSetVehicleType llSetVehicleVectorParam llShout llSin llSitTarget llSleep llSqrt llStartAnimation llStopAnimation llStopHover llStopLookAt llStopMoveToTarget llStopPointAt llStopSound llStringLength llStringToBase64 llSubStringIndex
syn keyword lFunction llTakeCamera llTakeControls llTan llTarget llTargetOmega llTargetRemove llTeleportAgentHome llToLower llToUpper llTriggerSound llTriggerSoundLimited
syn keyword lFunction llUnSit
syn keyword lFunction llVecDist llVecMag llVecNorm llVolumeDetect
syn keyword lFunction llWater llWhisper llWind llXorBase64Strings

" New functions as of 1.5.0
syn keyword lFunction llGetGMTClock llGetObjectDesc llSetObjectDesc llGetCreator llGetTimestamp llSetLinkAlpha llSetLinkColor llGetNumberOfPrims llGetNumberOfNotecardLines llGetPrimitiveParams llGetRootPosition llGetRootRotation llIntegerToBase64 llBase64ToInteger llGetGeometricCenter llGetBoundingBox
" 1.5.1
syn keyword lFunction llGetSimulatorHostname

" Deprecated functions
syn keyword lDeprecated llSound llSoundPreload llRemoteLoadScript llMakeExplosion llMakeFire llMakeFountain llMakeSmoke
" Deprecated constants (as of 1.5.x)
syn keyword lDeprecated PSYS_SRC_INNERANGLE PSYS_SRC_OUTERANGLE

if version >= 508 || !exists("did_b_syntax_inits")
   if version < 508
      let did_b_syntax_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif
  HiLink lLabel			Label
  HiLink lConditional		Conditional
  HiLink lRepeat		Repeat
"  HiLink cCharacter		Character
  HiLink lNumber		Number
"  HiLink cOctalZero		PreProc	 " link this to Error if you want
  HiLink lFloat			Float
  HiLink lOperator		Operator
  HiLink lVecQuatXYZS		Operator
  HiLink lFunction		Function
  HiLink lEvent			Statement
"  HiLink cStorageClass		StorageClass
"  HiLink cInclude		Include
"  HiLink cPreProc		PreProc
"  HiLink cDefine		Macro
"  HiLink cError		Error
  HiLink lStatement		Statement
"  HiLink cPreCondit		PreCondit
  HiLink lSpecial		SpecialChar
  HiLink lType			Type
  HiLink lConstant		Constant
  HiLink lString		String
  HiLink lComment		Comment
  HiLink lDeprecated		Error
  HiLink lTodo			Todo

  delcommand HiLink
endif

let b:current_syntax = "lsl"

" vim: ts=8
