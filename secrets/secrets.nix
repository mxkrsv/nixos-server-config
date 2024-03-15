let
  mxkrsv-sayaka = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkupsms0fUp4SflgKwVBfKRXi8eY51cgbex4aXerC5B mxkrsv@sayaka";
  users = [ mxkrsv-sayaka ];

  kyoko = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINTaDclKz6lF3VYdHX+ty/hEeF3CPrpQdY3bRJqyUI6b";
  systems = [ kyoko ];
in
{
  "porkbun_api_key.age".publicKeys = systems ++ users;
  "porkbun_secret_api_key.age".publicKeys = systems ++ users;
}
