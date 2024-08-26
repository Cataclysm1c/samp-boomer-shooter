new static g_PlayerScores[MAX_PLAYERS] = {0, ...};

AddScore(playerid, score = 1)
{
	g_PlayerScores[playerid] += score;
	SetPlayerScore(playerid, g_PlayerScores[playerid]);
}