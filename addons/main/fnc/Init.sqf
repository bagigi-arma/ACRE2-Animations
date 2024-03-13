fn_radioAnims_hand = {
	if (isNil "radioAnims_radioModel") then {
		//-- Select radio attributes (Returns "radioAnims_modelToUse","radioAnims_dattach","radioAnims_dvector")
		switch ([call acre_api_fnc_getCurrentRadio] call acre_api_fnc_getBaseRadio) do {
			case "ACRE_PRC152": {
				radioAnims_dvector = [
					[[0.956,-0.176,0.231],[-0.288,-0.465,0.836]],
					[[0.656,-0.876,0.231],[-0.288,-0.465,1.236]]
				];
				if (isClass(configFile >> "CfgPatches" >> "rhsusf_c_radio")) then {
					radioAnims_modelToUse = "rhsusf\addons\rhsusf_commskit\RHS_ANPRC152.p3d";
					radioAnims_dattach = [ [-0.1,-0.14,0.15], [-0.13,-0.055,0.18] ];
				} else {
					radioAnims_modelToUse = "idi\acre\addons\sys_prc152\Data\Models\PRC152.p3d";
					radioAnims_dattach = [ [-.01,-0.05,-0.05], [-.01,-0.05,-0.05] ];
				};
			};
			case "ACRE_PRC343": {
				radioAnims_modelToUse = "idi\acre\addons\sys_prc343\Data\Models\acre_prc343_model.p3d";
				radioAnims_dattach = [ [-.01,0.01,-0.05], [0.02,-0.01,-0.04] ];
				radioAnims_dvector = [
					[[0.956,-0.176,0.231],[-0.288,-0.465,0.836]],
					[[0.656,-0.876,0.231],[-0.288,-0.465,1.236]]
				];
			};
			case "ACRE_PRC148": {
				radioAnims_modelToUse = "idi\acre\addons\sys_prc148\Data\Models\PRC148.p3d";
				radioAnims_dattach = [ [-0.09,-0.14,0.14], [-0.12,-0.05,0.17] ];
				radioAnims_dvector = [
					[[0.956,-0.176,0.231],[-0.288,-0.465,0.836]],
					[[0.656,-0.876,0.231],[-0.288,-0.465,1.236]]
				];
			};
			case "ACRE_SEM52SL": {
				radioAnims_modelToUse = "idi\acre\addons\sys_sem52sl\Data\model\sem52sl.p3d";
				radioAnims_dattach = [ [0.02,-0.03,-0.05], [-0.01,-0.05,-0.03] ];
				radioAnims_dvector = [
					[[0.956,-0.176,0.231],[-0.288,-0.465,0.836]],
					[[0.656,-0.876,0.231],[-0.288,-0.465,1.236]]
				];
			};
			case "ACRE_BF888S": {
				radioAnims_modelToUse = "idi\acre\addons\sys_bf888s\Data\models\acre_bf888s_model.p3d";
				radioAnims_dattach = [ [-0.14,-0.05,-0.01], [-0.11,0.03,0.02] ];
				radioAnims_dvector = [
					[[0.956,-0.176,0.231],[-0.288,-0.465,0.836]],
					[[0.656,-0.876,0.231],[-0.288,-0.465,1.236]]
				];
			};
			default {
				radioAnims_modelToUse = "Jet_radio";
				radioAnims_dattach = [ [0,-0.04,-0.01], [-0.01,-0.04,0] ];
				radioAnims_dvector = [
					[[0.334,0.788,-0.516],[0.917,-0.398,-0.014]],
					[[1.434,0.588,-1.916],[0.917,-0.298,-0.024]]
				];
			};
		};

		//-- Use different values if player has weapon
		if (currentWeapon player != "") then {
			radioAnims_dattach = radioAnims_dattach select 1;
			radioAnims_dvector = radioAnims_dvector select 1;
		} else {
			radioAnims_dattach = radioAnims_dattach select 0;
			radioAnims_dvector = radioAnims_dvector select 0;
		};

		//-- Create radio and play animation
		player playActionNow radioAnims_Hand;
		radioAnims_radioModel = createSimpleObject [radioAnims_modelToUse,position player];
		radioAnims_radioModel attachto [player,radioAnims_dattach,"lefthand"];
		[radioAnims_radioModel, radioAnims_dvector] remoteExec ["setVectorDirAndUp"];
	};
};

fn_radioAnims_canDoEar = {
	(headgear player in radioAnims_cba_Earpieces) || (goggles player in radioAnims_cba_Earpieces)
};

fn_radioAnims_canDoVest = {
	private _vestConfig = configFile >> "CfgWeapons" >> (vest player) >> "itemInfo";

	(
		vest player in radioAnims_cba_vests || 
		(
			radioAnims_cba_vestarmor && 
			(
				(getNumber (_vestConfig >> "HitpointsProtectionInfo" >> "Chest" >> "armor") > 5) || 
				(getNumber (_vestConfig >> "armor") > 5)
			)
		)
	)
};

//-- Start speaking on radio
["acre_startedSpeaking", {
	//-- Exceptions
	if (!radioAnims_cba_main) exitWith {};
	if (!(_this select 1)) exitWith {};
	if (isWeaponDeployed player) exitWith {};
	if (!isNil "radioAnims_playerProbablyReloading") exitWith {};
	if ((radioAnims_cba_vehicles) && (vehicle player != player)) exitWith {};
	if ((radioAnims_cba_ads) && (currentWeapon player != primaryWeapon player) && (cameraView == "GUNNER")) exitWith {};
	if ((binocular player != "") && (currentWeapon player == binocular player)) exitWith {};
	if (!isNull (findDisplay 312)) exitWith {};

	//-- Figure out which setting to use
	radioAnims_animToUse = 0;
	switch ([_this select 2] call acre_api_fnc_getBaseRadio) do {
		case "ACRE_PRC152": {radioAnims_animToUse = radioAnims_cba_preference_PRC152};
		case "ACRE_PRC343": {radioAnims_animToUse = radioAnims_cba_preference_PRC343};
		case "ACRE_PRC148": {radioAnims_animToUse = radioAnims_cba_preference_PRC148};
		case "ACRE_SEM52SL": {radioAnims_animToUse = radioAnims_cba_preference_SEM52SL};
		case "ACRE_BF888S": {radioAnims_animToUse = radioAnims_cba_preference_BF888S};
		default {radioAnims_animToUse = radioAnims_cba_preference_Others};
	};

	//-- Use the setting
	radioAnims_playerAnimated = true;
	switch (radioAnims_animToUse) do {
		case "Hand": {
			call fn_radioAnims_hand;
		};
		case "Ear": {
			if (call fn_radioAnims_canDoEar) exitWith {
				player playActionNow radioAnims_Ear;
			};
			if (call fn_radioAnims_canDoVest) exitWith {
				player playActionNow radioAnims_Vest;
			};
			call fn_radioAnims_hand;
		};
		case "Vest": {
			if (call fn_radioAnims_canDoVest) exitWith {
				player playActionNow radioAnims_Vest;
			};
			if (call fn_radioAnims_canDoEar) exitWith {
				player playActionNow radioAnims_Ear;
			};
			call fn_radioAnims_hand;
		};
	};
}, Player] call CBA_fnc_addEventHandler;

//-- Stop speaking on radio
["acre_stoppedSpeaking", {
	//-- Exceptions
	if (!radioAnims_cba_main) exitWith {};
	if (!(_this select 1)) exitWith {};
	if (!isNil "radioAnims_radioModel") then {deletevehicle radioAnims_radioModel;radioAnims_radioModel = nil};  //-- If radio model exists, delete it
	if ((isWeaponDeployed player) && (isNil "radioAnims_playerAnimated")) exitWith {};  //-- If bipoded and not currently animated, dont do stopping animation
	If (!isNil "radioAnims_playerProbablyReloading") exitWith {deletevehicle radioAnims_radioModel;radioAnims_radioModel = nil};  //-- If reloading, dont do stopping animation
	if ((radioAnims_cba_ads) && (currentWeapon player != primaryWeapon player) && (cameraView == "GUNNER")) exitWith {};
	if ((binocular player != "") && (currentWeapon player == binocular player)) exitWith {};
	if (!isNull (findDisplay 312)) exitWith {};

	player playActionNow "radioAnims_Stop";
	radioAnims_playerAnimated = nil;
}, Player] call CBA_fnc_addEventHandler;


//-- Eventhandler (Returns radioAnims_playerProbablyReloading = true if reloading)
[] spawn {
	while {true} do {
		_playerMagsPast = magazines player;  //-- Save past state of magazines
		sleep 0.25;
		if (getText (configfile >> "CfgWeapons" >> (currentWeapon player) >> "EventHandlers" >> "reload") != "radioAnims_playerProbablyReloading = true") then {
			if ((!(magazines player isEqualTo _playerMagsPast)) && (isnull (findDisplay 602))) then {
				radioAnims_playerProbablyReloading = true;
				sleep 15; //-- Buffer
				radioAnims_playerProbablyReloading = nil;
			};
		};
	};
};
