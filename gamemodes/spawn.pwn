#include <YSI_Coding\y_hooks>

static Float:g_playerSpawnPoints[][4] =
{
	{-1425.2196, 81.6086, 1031.1018, 320.5571}, // sw
	{-1425.4335, 131.3056, 1030.8605, 225.2384}, // nw
	{-1375.4576, 131.4744, 1030.8530, 124.5565}, // ne
	{-1375.2388, 81.4462, 1030.8574, 43.0889} // se
};

forward LoginSpawnPlayer(playerid);
public LoginSpawnPlayer(playerid)
{
	TogglePlayerSpectating(playerid, false);
}

GiveRandomWeapon(playerid)
{
	new t_WEAPON:randomWeapon = t_WEAPON:RandomRange(WEAPON_COLT45, WEAPON_SNIPER);

	if (randomWeapon == WEAPON_SAWEDOFF || randomWeapon == WEAPON_SHOTGSPA)
	{
		randomWeapon = WEAPON_SHOTGUN;
	}

	GivePlayerWeapon(playerid, t_WEAPON:randomWeapon, 9999);
}

SetPlayerSkills(playerid)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SAWNOFF_SHOTGUN, 200);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MICRO_UZI, 200);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 200);
}

SetPlayerSpawn(playerid)
{
	SetPlayerSkills(playerid);
	SetPlayerInterior(playerid, 1);

	new randomSpawnPoint = random((sizeof g_playerSpawnPoints) - 1);
	SetPlayerPos(playerid, g_playerSpawnPoints[randomSpawnPoint][0], g_playerSpawnPoints[randomSpawnPoint][1], g_playerSpawnPoints[randomSpawnPoint][2]);
	SetPlayerFacingAngle(playerid, g_playerSpawnPoints[randomSpawnPoint][3]);
	SetCameraBehindPlayer(playerid);
}


hook OnPlayerSpawn(playerid)
{
	SetPlayerTeam(playerid, 1);
	SetPlayerSpawn(playerid);

	ServerSetHealth(playerid, 150);
	GiveRandomWeapon(playerid);
}

hook OnPlayerDeath(playerid)
{
	SpawnPlayer(playerid);
	return 1;
}

hook OnPlayerConnect(playerid)
{
	TogglePlayerSpectating(playerid, true);
	SetSpawnInfo(playerid, 1, 285, 0.0, 0.0, 0.0, 0.0, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);

	SetTimerEx("LoginSpawnPlayer", 100, false, "i", playerid);
	return 1;
}