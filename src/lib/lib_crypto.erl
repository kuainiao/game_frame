-module(lib_crypto).

-include("config_keys.hrl").

%% API
-export([encrypt/1, decrypt/2, encrypt/3, decrypt/3, md5/1]).

%% 密钥文件
-define(KEY_FILE,
  <<224,169,88,40,151,194,228,212,68,83,7,168,211,4,59,235,234,254,164,130,52,144,94,78,62,175,69,192,12,65,60,44,31,
    94,159,91,184,141,214,16,36,239,130,102,161,152,53,9,105,104,87,210,171,25,164,161,94,68,92,213,24,52,92,222,112,
    25,99,65,206,9,229,234,125,26,18,47,13,12,250,159,180,136,16,207,30,6,139,87,239,208,144,98,203,86,194,246,58,176,
    140,146,213,150,25,7,197,19,193,228,235,173,91,15,188,106,190,157,47,18,18,165,9,222,228,175,196,40,164,190,92,130,
    176,113,187,38,229,209,215,223,158,93,220,245,158,71,248,197,7,155,27,114,164,205,180,214,20,27,61,52,167,121,91,
    18,192,133,46,43,96,70,107,143,187,112,200,199,253,48,174,62,150,171,100,12,6,185,66,150,80,11,166,161,243,103,16,
    154,213,30,56,194,232,153,8,164,163,55,240,5,42,27,44,71,211,80,184,127,178,32,56,147,50,155,221,145,54,138,46,51,
    61,88,154,39,11,254,155,39,136,51,106,216,145,13,237,42,251,154,234,180,139,159,133,222,156,157,204,138,134,248,51,
    46,50,141,111,40,55,121,90,51,20,94,38,53,227,183,131,135,89,211,1,105,66,7,40,197,73,91,108,158,150,221,79,10,245,
    144,225,62,31,51,31,10,234,172,125,121,71,248,4,111,186,53,161,244,175,20,179,125,114,100,19,197,180,76,122,252,247,
    165,202,56,108,202,29,10,188,63,242,184,238,63,23,172,236,117,36,213,245,49,159,145,210,55,129,161,114,12,191,172,
    134,25,41,208,80,196,204,218,76,26,2,182,242,220,84,171,53,154,74,77,36,206,140,105,114,94,189,93,104,208,90,171,
    52,209,135,188,233,157,134,235,100,31,29,14,10,194,175,252,2,16,197,114,147,203,108,180,231,124,178,158,96,69,255,
    213,154,223,130,32,120,41,27,204,165,150,153,52,96,255,226,60,10,177,199,218,133,244,172,212,65,74,238,126,125,34,
    74,91,34,245,171,211,109,3,30,216,134,36,112,200,241,196,246,12,170,165,40,140,141,22,113,174,27,178,74,230,199,
    181,175,3,32,138,225,199,234,126,176,162,174,217,73,132,99,17,241,164,164,220,23,228,29,243,54,40,91,111,211,83,
    189,51,89,181,200,213,188,103,98,166,32,163,228,111,38,254,128,244,203,116,104,58,19,150,90,107,77,24,57,138,181,
    208,139,240,213,160,176,213,63,179,137,108,1,98,127,19,70,94,155,255,181,172,7,125,250,35,153,144,78,84,12,172,
    185,17,188,224,148,210,96,143,248,109,210,48,14,39,132,219,236,93,117,105,29,137,90,66,102,93,179,41,158,209,141,
    97,245,35,148,133,144,245,213,22,89,138,244,192,198,158,222,217,145,43,162,79,170,130,66,17,155,11,86,113,247,253,
    82,51,154,37,37,185,27,147,100,222,19,65,147,128,128,249,15,154,171,117,166,66,194,137,184,208,187,213,215,69,108,
    156,98,143,40,253,86,43,248,180,121,217,104,85,126,175,111,37,33,176,97,43,39,3,48,152,3,35,121,217,66,90,112,221,
    48,249,44,2,152,251,230,219,12,65,114,39,207,33,19,18,102,67,128,109,151,137,203,93,21,220,61,82,161,9,222,2,250,
    19,169,2,13,136,68,212,61,57,231,185,121,76,78,245,120,60,177,91,206,26,60,67,67,136,73,110,80,40,106,37,5,213,100,
    31,177,26,160,174,166,181,191,113,19,116,225,197,191,220,67,81,101,214,222,89,133,59,196,165,124,24,233,160,166,
    166,149,247,253,239,227,136,69,60,69,33,12,39,69,145,178,13,222,130,73,44,208,136,228,28,4,145,48,187,54,136,51,
    123,69,187,88,54,108,170,23,38,198,223,122,87,48,227,228,80,170,18,230,6,244,121,0,95,101,154,42,186,52,254,201,
    216,162,130,118,108,155,153,240,154,10,140,64,55,73,112,81,72,11,1,78,95,105,240,62,106,64,161,112,44,106,153,24,
    97,63,34,32,146,6,97,169,41,153,99,241,177,66,124,215,241,76,135,184,197,127,202,176,153,218,185,207,104,178,24,
    217,231,23,208,62,170,131,112,205,40,144,223,176,117,26,82,48,79,229,202,112,14,234,130,12,216,212,202,232,10,214,
    47,85,76,176,76,179,222,45,249,226,152,235,217,247,120,107,16,39,53,17,168,81,94,9,109,178,244,95,228,238,84,148,
    192,114,82,240,61,202,3,222,40,195,171,103,166,181,27,29,18,94,127,110,104,100,167,217,201,159,55,232,147,226,49,
    66,83,233,82,182,65,150,74>>).

%% 解密
decrypt(Req, Body) ->
  KeyIndex = cowboy_req:header(<<"content-vkey">>, Req, <<"0,0">>),
  [KIndex, IIndex] = string:tokens(binary_to_list(KeyIndex), ","),
  decrypt(list_to_integer(KIndex), list_to_integer(IIndex), Body).

%% 解密
decrypt(KIndex, IIndex, Body) ->
  case game_config:lookup_keys([?CF_APP, <<"crypto">>]) of
    true ->
      {ok, Key, Ivec} = get_key_ivec(KIndex, IIndex),
      Body2 = lib_crypto:aes_cbc128_decrypt(Key, Ivec, Body),
      {ok, Body2};
    false ->
      {ok, Body}
  end.

%% 加密
encrypt(Body) ->
  KIndex = util:rand(1,64) - 1,
  IIndex = util:rand(1,64) - 1,
  Head = {<<"CONTENT-VKEY">>, integer_to_list(KIndex) ++ "," ++ integer_to_list(IIndex)},
  {ok, Body2} = encrypt(KIndex, IIndex, Body),
  {ok, Body2, Head}.

%% 加密
encrypt(KIndex, IIndex, Body) ->
  case game_config:lookup_keys([?CF_APP, <<"crypto">>]) of
    true ->
      {ok, Key, Ivec} = get_key_ivec(KIndex, IIndex),
      Body2 = lib_crypto:aes_cbc128_encrypt(Key, Ivec, Body),
      {ok, Body2};
    false ->
      {ok, Body}
  end.

md5(S) ->
  StrS = conversion_utility:to_list(S),
  Md5_bin =  erlang:md5(StrS),
  Md5_list = binary_to_list(Md5_bin),
  % 转成16进制，再转成binary返回
  conversion_utility:to_binary(lists:flatten(conversion_utility:list_to_hex(Md5_list))).



%% ====================================================================
%% Internal functions
%% ====================================================================

%% 获得密钥和向量
get_key_ivec(KIndex, IIndex) ->
  Key = binary:part(?KEY_FILE, (KIndex * 16), 16),
  Ivec = binary:part(?KEY_FILE, (IIndex * 16), 16),
  {ok, Key, Ivec}.