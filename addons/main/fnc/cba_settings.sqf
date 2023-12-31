//-- Main
[
	"radioAnims_cba_main",
	"CHECKBOX",
	[
		"Enable Addon",
		"Turns addon on/off."
	],
	"ACRE2 Animations",
	true
] call CBA_fnc_addSetting;

//-- Earpieces
[
	"radioAnims_cba_Earpieces",
	"EDITBOX",
	[
		"Headset List",
		"Array containing helmets/goggles that should be considered when doing the ear animation. Use '[headgear player, goggles player]' to allow all helmets/goggles."
	],
	"ACRE2 Animations",
	'["G_WirelessEarpiece_F", "H_Watchcap_blk", "H_Watchcap_cbr", "H_Watchcap_camo", "H_Watchcap_khk", "H_Booniehat_khk_hs", "H_Cap_oli_hs", "H_HeadSet_black_F", "H_HeadSet_orange_F", "H_HeadSet_red_F", "H_HeadSet_white_F", "H_HeadSet_yellow_F", "H_Cap_marshal", "H_MilCap_blue", "H_MilCap_gen_F", "H_MilCap_ghex_F", "H_MilCap_grn", "H_MilCap_gry", "H_MilCap_ocamo", "H_MilCap_mcamo", "H_MilCap_taiga", "H_MilCap_tna_F", "H_MilCap_wdl", "H_MilCap_dgtl", "H_MilCap_eaf", "H_Shemag_olive_hs"]',
	0,
	{radioAnims_cba_Earpieces = call compile radioAnims_cba_Earpieces}
] call CBA_fnc_addSetting;

//-- Vests
[
	"radioAnims_cba_vests",
	"EDITBOX",
	[
		"Vests List",
		"Array containing vests that should be considered when doing the vest animation. Use '[vest player]' to allow all vests."
	],
	"ACRE2 Animations",
	'[]',
	0,
	{radioAnims_cba_vests = call compile radioAnims_cba_vests}
] call CBA_fnc_addSetting;

[
	"radioAnims_cba_vestarmor",
	"CHECKBOX",
	[
		"Add Vests with Armor to List",
		"If enabled, all vests that have an armor value will be automatically added to the Vests List."
	],
	"ACRE2 Animations",
	true
] call CBA_fnc_addSetting;

//-- Aiming Down Sights
[
	"radioAnims_cba_ads",
	"CHECKBOX",
	[
		"Aiming while Talking",
		"If enabled, players will be able to aim while using a radio."
	],
	"ACRE2 Animations",
	true,
	0,
	{
		if (radioAnims_cba_ads) then {
			radioAnims_Ear = "radioAnims_Ear";
			radioAnims_Vest = "radioAnims_Vest";
			radioAnims_Hand = "radioAnims_Hand";
		} else {
			radioAnims_Ear = "radioAnims_Ear_NoADS";
			radioAnims_Vest = "radioAnims_Vest_NoADS";
			radioAnims_Hand = "radioAnims_Hand_NoADS";
		};
	}
] call CBA_fnc_addSetting;

//-- Vehicles
[
	"radioAnims_cba_vehicles",
	"CHECKBOX",
	[
		"Disable Animation in Vehicles",
		"If enabled, the animations will not be played in vehicles."
	],
	"ACRE2 Animations",
	true
] call CBA_fnc_addSetting;

//-- Individual Radio Settings
{
	_x params ["_radio", "_default"];
	[
		"radioAnims_cba_preference_"+_radio,
		"LIST",
		[
			"Preferred Animation ("+_radio+")",
			"Preferred Animation for this radio.\nDoesn't mean that it will always be used as the vest/ear animations are only used when the player has\na vest/headset from the vest/headset listPreferred Animation for this radio."
		],
		"ACRE2 Animations",
		[
			["Vest","Ear","Hand"],
			["Vest","Ear","Hand"],
			(_default)
		]
	] call CBA_fnc_addSetting;
} forEach [["PRC343",0], ["PRC152",0], ["PRC148",2], ["SEM52SL",0], ["BF888S",2], ["Others",2]];

//-- Controls
[
	"ACRE2 Animations",
	"radioAnims_cba_listenKey",
	"Listen to Radio",
	{
		if ([player] call acre_api_fnc_hasRadio) exitWith {
			call fn_radioAnims_hand;
		};
	},
	{
		if ([player] call acre_api_fnc_hasRadio) exitWith {
			if (!isNil "radioAnims_radioModel") then {
				deletevehicle radioAnims_radioModel;
				radioAnims_radioModel = nil;
			};
			player playActionNow "radioAnims_Stop";
			radioAnims_playerAnimated = nil;
		};
	},
	[null, [false, false, false]]
] call cba_fnc_addKeybind;
