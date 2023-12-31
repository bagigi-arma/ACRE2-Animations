//-- Main
[
	"radioAnims_cba_main",
	"CHECKBOX",
	["Enable Addon", "Turns addon on/off."],
	"ACRE2 Animations",
	true,
	false,
	{}
] call CBA_Settings_fnc_init;

//-- Earpieces
[
	"radioAnims_cba_Earpieces", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
	"EDITBOX", // setting type
	["Headset List", "Array containing helmets/goggles that should be considered when doing the ear animation. Use '[headgear player, goggles player]' to allow all helmets/goggles."], // Pretty name of the category where the setting can be found. Can be stringtable entry.
	"ACRE2 Animations", // Pretty name shown inside the ingame settings menu. Can be stringtable entry.
	'["G_WirelessEarpiece_F"]', // data for this setting
	false, // "_isGlobal" flag. Set this to true to always have this setting synchronized between all clients in multiplayer
	{radioAnims_cba_Earpieces = call compile radioAnims_cba_Earpieces} // function that will be executed once on mission start and every time the setting is changed.
] call CBA_Settings_fnc_init;

//-- Vests
[
	"radioAnims_cba_vests",
	"EDITBOX",
	["Vests List", "Array containing vests that should be considered when doing the vest animation. Use '[vest player]' to allow all vests."],
	"ACRE2 Animations",
	'[]',
	false,
	{radioAnims_cba_vests = call compile radioAnims_cba_vests}
] call CBA_Settings_fnc_init;

[
	"radioAnims_cba_vestarmor",
	"CHECKBOX",
	["Add Vests with Armor to List", "If enabled, all vests that have an armor value will be automatically added to the Vests List."],
	"ACRE2 Animations",
	true,
	false,
	{}
] call CBA_Settings_fnc_init;

//-- Aiming Down Sights
[
	"radioAnims_cba_ads",
	"CHECKBOX",
	["Aiming while Talking", "If enabled, players will be able to aim while using a radio."],
	"ACRE2 Animations",
	true,
	false,
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
] call CBA_Settings_fnc_init;

//-- Vehicles
[
	"radioAnims_cba_vehicles",
	"CHECKBOX",
	["Disable Animation in Vehicles", "If enabled, the animations will not be played in vehicles."],
	"ACRE2 Animations",
	true,
	false,
	{}
] call CBA_Settings_fnc_init;

//-- Individual Radio Settings
{
	_x params ["_radio", "_default"];
	[
		"radioAnims_cba_preference_"+_radio,
		"LIST",
		[
			"Preferred Animation ("+_radio+")", "Preferred Animation for this radio.\nDoesn't mean that it will always be used as the vest/ear animations are only used when the player has\na vest/headset from the vest/headset listPreferred Animation for this radio."
		],
		"ACRE2 Animations",
		[
			["Vest","Ear","Hand"],
			["Vest","Ear","Hand"],
			(_default)
		],
		false,
		{}
	] call CBA_Settings_fnc_init;
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
