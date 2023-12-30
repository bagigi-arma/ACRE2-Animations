class CfgPatches {
	class Radio_Animations {
		author = "ASmallDinosaur & JetBlack164";
		url = "http://thespeshalplatoon.com/";
		units[] = {"Jet_Radio"};
		weapons[] = {};
		requiredAddons[] = {"A3_Structures_F","cba_common"};
	};
};

//-- Custom Handset Model
class CfgVehicles {
	class House_F;
	class Jet_Radio: House_F {
		scope = 2;
		displayName = "Jet's Radio";
		model = "\z\radio_animations\addons\main\h189.p3d"; // filepath
		vehicleClass = "Structures"; // Object in the in-game editor
		mapSize = 20.27;
		cost = 40000;		
	};
};

//-- Run init.sqf on player existance
class Extended_PostInit_EventHandlers {
	class Radio_Animations_PostInitHandler {
		init = "nul = [] execVM '\z\radio_animations\addons\main\fnc\Init.sqf'";
	};
};

//-- Add CBA settings
class Extended_PreInit_EventHandlers {
	class Radio_Animations_PreInitHandler {
		init = "call compile preprocessFileLineNumbers '\z\radio_animations\addons\main\fnc\cba_settings.sqf'";
	};
};

//--- EventHandlers
class CfgWeapons {
	class PistolCore;
	class Pistol: PistolCore {
		class EventHandlers {
			reload = "radioAnims_playerProbablyReloading = true";
			reloaded = "radioAnims_playerProbablyReloading = nil";
		};
	};
	class RifleCore;
	class Rifle: RifleCore {
		class EventHandlers {
			reload = "radioAnims_playerProbablyReloading = true";
			reloaded = "radioAnims_playerProbablyReloading = nil";
		};
	};
	class LauncherCore;
	class Launcher: LauncherCore {
		class EventHandlers {
			reload = "radioAnims_playerProbablyReloading = true";
			reloaded = "radioAnims_playerProbablyReloading = nil";
		};
	};
	class MGunCore;
	class MGun: MGunCore {
		class EventHandlers {
			reload = "radioAnims_playerProbablyReloading = true";
			reloaded = "radioAnims_playerProbablyReloading = nil";
		};
	};
	class GrenadeLauncher;
	class UGL_F: GrenadeLauncher {
		class EventHandlers {
			reload = "radioAnims_playerProbablyReloading = true";
			reloaded = "radioAnims_playerProbablyReloading = nil";
		};
	};
};

//-- Animations
class CfgMovesBasic {
	class ManActions {
		radioAnims_Ear = "radioAnims_Ear";
		radioAnims_Vest = "radioAnims_Vest";
		radioAnims_Hand = "radioAnims_Hand";		
		radioAnims_Vest_NoADS = "radioAnims_Vest_NoADS";
		radioAnims_Hand_NoADS = "radioAnims_Hand_NoADS";
		radioAnims_Stop = "radioAnims_Stop";
		radioAnims_Ear_NoADS = "radioAnims_Ear_NoADS";
	};
	class Actions {
		class NoActions: ManActions {
			radioAnims_Ear[] = {"radioAnims_Ear", "Gesture"};
			radioAnims_Vest[] = {"radioAnims_Vest", "Gesture"};
			radioAnims_Hand[] = {"radioAnims_Hand", "Gesture"};
			radioAnims_Vest_NoADS[] = {"radioAnims_Vest_NoADS", "Gesture"};
			radioAnims_Hand_NoADS[] = {"radioAnims_Hand_NoADS", "Gesture"};
			radioAnims_Stop[] = {"radioAnims_Stop", "Gesture"};	
			radioAnims_Ear_NoADS[] = {"radioAnims_Ear_NoADS", "Gesture"};		
		};
	};
};

class CfgGesturesMale {
	skeletonName = "OFP2_ManSkeleton";
	class Default {};
	class States {
		class radioAnims_main: Default {
			canPullTrigger = 1;
			connectAs = "";
			forceAim = 1;
			connectFrom[] = {};
			connectTo[] = {};
			disableWeapons = 0;
			disableWeaponsLong = 0;
			canReload = 0;
			enableBinocular = 1;
			enableMissile = 1;
			enableOptics = 1;
			equivalentTo = "";
			headBobMode = 0;
			headBobStrength = 0;
			interpolateFrom[] = {};
			interpolateTo[] = {};
			interpolateWith[] = {};
			interpolationRestart = 0;
			interpolationSpeed = 6;
			looped = 0;
			minPlayTime = 0.5;
			preload = 1;
			ragdoll = 0;
			relSpeedMax = 1;
			relSpeedMin = 1;
			showHandGun = 0;
			showItemInHand = 0;
			showItemInRightHand = 0;
			showWeaponAim = 1;
			soundEdge[] = {0.5,1};
			soundEnabled = 1;
			soundOverride = "";
			static = 0;
			terminal = 0;
			Walkcycles = 1;
			leftHandIKBeg = 0;
			leftHandIKCurve[] = {0};
			leftHandIKEnd = 0;
			rightHandIKBeg = 1;
			rightHandIKCurve[] = {1};
			rightHandIKEnd = 1;
			weaponLowered = 0;
			limitGunMovement = 0;
			speed = 0.30000001;
		};
		class radioAnims_Ear: radioAnims_main {	
			file = "a3\anims_f_epa\data\anim\sdr\cts\custom\a_in\acts_listeningtoradioloop.rtm";
			minPlayTime = 2;
			mask = "mask_OnlyAffectLeftArm";
		};
		class radioAnims_Vest: radioAnims_main {
			file = "a3\anims_f_bootcamp\data\anim\sdr\cts\acts_kore_talkingoverradio_loop.rtm";
			mask = "mask_OnlyAffectLeftArm";
		};
		class radioAnims_Hand: radioAnims_main {
			file = "\z\radio_animations\addons\main\radio_Hand.rtm";
			looped = 1;
			mask = "mask_OnlyAffectLeftArm";		
		};
		class radioAnims_Vest_NoADS: radioAnims_Vest {enableOptics=0;};
		class radioAnims_Hand_NoADS: radioAnims_Hand {enableOptics=0;};
		class GestureNod;
		class radioAnims_Stop: GestureNod {
			canPullTrigger = 1;
			disableWeapons = 0;
			disableWeaponsLong = 0;
			canReload = 0;
			enableBinocular = 1;
			enableMissile = 1;
			enableOptics = 1;
			mask = "empty";
			file = "a3\anims_f\data\anim\sdr\gst\gesturenod.rtm";
		};
		class radioAnims_Ear_NoADS: radioAnims_Ear {	
			file = "a3\anims_f_epa\data\anim\sdr\cts\custom\a_in\acts_listeningtoradioloop.rtm";
			minPlayTime = 2;
			mask = "mask_OnlyAffectLeftArm";
			enableOptics = 0;
		};
	};
	class BlendAnims {
		mask_OnlyAffectLeftArm[] = {
			"Weapon",0,
			"Pelvis",0,
			"Spine",0,
			"Spine1",0,
			"Spine2",0,
			"Spine3",0,
			"Camera",0,
			"launcher",0,
			"weapon",0,
			"launcher",0,
			"neck",0,
			"neck1",0,
			"head",0,
			"LeftShoulder",1,
			"LeftArm",1,
			"LeftArmRoll",1,
			"LeftForeArm",1,
			"LeftForeArmRoll",1,
			"LeftHand",1,
			"RightShoulder",0,
			"RightArm",0,
			"RightArmRoll",0,
			"RightForeArm",0,
			"RightForeArmRoll",0,
			"RightHand",0,
			"LeftUpLeg",0,
			"LeftUpLegRoll",0,
			"LeftLeg",0,
			"LeftLegRoll",0,
			"LeftFoot",0,
			"LeftToeBase",0,
			"RightUpLeg",0,
			"RightUpLegRoll",0,
			"RightLeg",0,
			"RightLegRoll",0,
			"RightFoot",0,
			"RightToeBase",0,
			"LeftHandIndex1",1,
			"LeftHandIndex2",1,
			"LeftHandIndex3",1,
			"LeftHandMiddle1",1,
			"LeftHandMiddle2",1,
			"LeftHandMiddle3",1,
			"LeftHandPinky1",1,
			"LeftHandPinky2",1,
			"LeftHandPinky3",1,
			"LeftHandThumb",1,
			"LeftHandThumb1",1,
			"LeftHandThumb2",1,
			"LeftHandThumb3",1,
			"RightHandIndex1",0,
			"RightHandIndex2",0,
			"RightHandIndex3",0,
			"RightHandMiddle1",0,
			"RightHandMiddle2",0,
			"RightHandMiddle3",0,
			"RightHandPinky1",0,
			"RightHandPinky2",0,
			"RightHandPinky3",0,
			"RightHandThumb",0,
			"RightHandThumb1",0,
			"RightHandThumb2",0,
			"RightHandThumb3",0
		};		
	};
};
