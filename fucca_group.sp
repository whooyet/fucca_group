#include <sdktools>
#include <sdkhooks>
#include <steamtools>

new Handle:Cvar_GroupID = INVALID_HANDLE;

new bool:bIsInGroup[MAXPLAYERS+1] = false;
new String:g_groupid[32];

public Plugin myinfo = 
{
	name = "Simple Fucca Group",
	author = "뿌까",
	description = "하하하하",
	version = "1.2",
	url = "x"
};

public OnPluginStart()
{
	Cvar_GroupID = CreateConVar("fucca_groupid", "31278663", "그룹 아이디");
	HookConVarChange(Cvar_GroupID, ConVarChanged);
	GetConVarString(Cvar_GroupID, g_groupid, sizeof(g_groupid));
}

public ConVarChanged(Handle:cvar, const String:oldVal[], const String:newVal[]) GetConVarString(Cvar_GroupID, g_groupid, sizeof(g_groupid));

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, err_max)
{
	CreateNative("IsClientGroup", Native_IsGroup);
	RegPluginLibrary("fucca_group");
	return APLRes_Success;
}

public Native_IsGroup(Handle:plugin, numParams)
{
	new client = GetNativeCell(1);
	if(!PlayerCheck(client)) {
		ThrowNativeError(SP_ERROR_PARAM, "Client index is invalid");
		return false;
	}
	return bIsInGroup[client];
}

public OnClientPutInServer(client)
{
	bIsInGroup[client] = false;
	CreateTimer(5.0, abc, client);
}
	
public Action:abc(Handle:timer, any:client) Steam_RequestGroupStatus(client, StringToInt(g_groupid));

public Steam_GroupStatusResult(client, groupID, bool:bIsMember, bool:bIsOfficer)
{
	if(!PlayerCheck) return;
	if(groupID != StringToInt(g_groupid)) return;
	bIsInGroup[client] = bIsMember;
}


stock bool:PlayerCheck(Client){
	if(Client > 0 && Client <= MaxClients){
		if(IsClientConnected(Client) == true){
			if(IsClientInGame(Client) == true){
				return true;
			}
		}
	}
	return false;
}