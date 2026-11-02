params [
    ["_item", objNull, [objNull, ""]],
    ["_veh", objNull, [objNull]]
];

private _pos = getPos _veh;
private _illegal = false;

// Check illegal status based on whether _item is an object or a classname string
if (_item isEqualType objNull) then {
    if (!isNull _item) then {
        _illegal = _item getVariable ["ace_illegalCargo", false];
    };
} else {
    if (_item isEqualType "") then {
        // If it's a string, read the property from CfgVehicles or CfgWeapons
        _illegal = ([configFile >> "CfgVehicles" >> _item, "ace_illegalCargo", 0] call BIS_fnc_returnConfigEntry) isEqualTo 1;
        
        // Fallback check in CfgWeapons if it's weapon cargo
        if (!_illegal) then {
            _illegal = ([configFile >> "CfgWeapons" >> _item, "ace_illegalCargo", 0] call BIS_fnc_returnConfigEntry) isEqualTo 1;
        };
    };
};

if (_illegal) then {
    {
        if (isPlayer _x) then {
            _x setCaptive false;
            [_x] call OT_fnc_revealToNATO;
        };
    } forEach (_pos nearEntities 30);
};