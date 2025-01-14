private ["_unit"];

_unit = _this select 0;

(group _unit) setVariable ["VCM_Disable",true];

private _firstname = OT_firstNames_local call BIS_fnc_selectRandom;
private _lastname = OT_lastNames_local call BIS_fnc_selectRandom;
private _fullname = [format["%1 %2",_firstname,_lastname],_firstname,_lastname];
[_unit,_fullname] remoteExec ["setCivName",0,_unit];

[_unit, (OT_faces_local call BIS_fnc_selectRandom)] remoteExecCall ["setFace", 0, _unit];
[_unit, "NoVoice"] remoteExecCall ["setSpeaker", 0, _unit];

removeAllWeapons _unit;
removeAllAssignedItems _unit;
removeGoggles _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeVest _unit;

_unit forceAddUniform (OT_clothes_harbor call BIS_fnc_selectRandom);

[_unit,"self"] call OT_fnc_setOwner;

/*_unit addEventHandler ["FiredNear", {
	_u = _this select 0;
	_u setUnitPos "DOWN";
}];
*/

//Prevents harbour guy from moving on firefight
//remove allowDamage if you want him to die
_unit disableAI "MOVE";
_unit allowdamage false;