// This should initialize the player for the lobby.  Further initialization
// will occur after game start when all parameters have been finalized.

format ["initPlayerLocal called for %1", player] call shared_fnc_log;

call compile preprocessFileLineNumbers "lobby\lobby.sqf";

// Lower recoil, lower sway, remove stamina on respawn
CWS_ResetStaminaRecoil = {
    player setCustomAimCoef 0.2;
    player setUnitRecoilCoefficient 0.5;
    player enableStamina FALSE;
};

CWS_GetMedikitEquivalent = {
    private _playerItems = items player;
    private _allowedMedikits = ["Medikit", "PiR_apteka"];
    format ["Player items on revive: %1", _playerItems] call shared_fnc_log;

    {
        // Current result is saved in variable _x
       if (_x in _playerItems) exitWith {_x};
    } forEach _allowedMedikits;
};

call CWS_ResetStaminaRecoil;

player addEventHandler ['Respawn',{
    call CWS_ResetStaminaRecoil;
}];

// Player is immune to damage until the game starts
player addEventHandler ["HandleDamage", { 0 }];
