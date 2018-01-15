#if defined _gg_included
  #endinput
#endif
#define _gg_included

public SharedPlugin __pl_group = {
  name = "fucca_group",
  file = "fucca_group.smx",
#if defined REQUIRE_PLUGIN
  required = 1
#else
  required = 0
#endif
};


native bool:IsClientGroup(client);

#if !defined REQUIRE_PLUGIN
public __pl_group_SetNTVOptional() {
  MarkNativeAsOptional("IsClientGroup");
}
#endif
