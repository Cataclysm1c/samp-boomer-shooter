/* Libraries */
#include <open.mp>

/* Modules */
#include "utilities.pwn"
#include "damage.pwn"
#include "spawn.pwn"
#include "player.pwn"
#include "powerups.pwn"

/* Server Versioning */
#define SERVER_VERSION_MAJOR 1
#define SERVER_VERSION_MINOR 0
#define SERVER_VERSION_PATCH 0

SetRandomPassword()
{
	new serverPassword[20];

	CreateRandomString(serverPassword, 10);
	strins(serverPassword, "password ", 0);
	
	SendRconCommand(serverPassword);
}

public OnGameModeInit()
{
	new year = 1900,
		month = 1,
		day = 1,
		version[16];

	format(version, sizeof version, "QUAKE %02d.%02d.%02d", SERVER_VERSION_MAJOR, SERVER_VERSION_MINOR, SERVER_VERSION_PATCH);
	SetGameModeText(version);

	SetRandomPassword();
	
	getdate(year, month, day);
	printf("Server starting at %02d/%02d/%d", day, month, year);

	// load whatever needs loading dynamically, then unlock the server
	InitializePowerups();

	SendRconCommand("password 0");
	AddPlayerClass(285, 0.0, 0.0, 0.0, 0.0, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
}