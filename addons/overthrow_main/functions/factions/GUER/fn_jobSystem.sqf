
OT_allJobs = []; 
{
    private _code = gettext (_x >> "condition");
    private _target = gettext (_x >> "target");
    private _script = gettext (_x >> "script");
    private _repeat = getnumber (_x >> "repeatable");
    private _chance = getnumber (_x >> "chance");
    private _expires = getnumber (_x >> "expires");
    private _requestable = (getnumber (_x >> "requestable")) isEqualTo 1;
    //Script compilation was added from Community edition of overthrow. -Dorf 2023
    OT_allJobs pushback [configName _x, _target, compileFinal _code, compileScript [_script, true], _repeat, _chance, _expires, _requestable];
}foreach("true" configClasses ( configFile >> "CfgOverthrowMissions" ));
if(isServer) then {
	job_system_counter = 12;
	["job_system","_counter%10 isEqualTo 0","call OT_fnc_jobLoop"] call OT_fnc_addActionLoop;
};
