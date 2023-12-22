module("luci.controller.zerotier", package.seeall)

I18N = require "luci.i18n"
translate = I18N.translate

function index()
	entry({"admin", "zerotier"}, firstchild(), translate("Remote Access"), 27).dependent=false
	local page
	page = entry({"admin", "zerotier", "zerotier"}, template("zerotier/zerotier"), translate("Remote Access"), 7)
	page.dependent = true
	entry({"admin", "zerotier", "mail"}, template("zerotier/mail"), translate("Mail Server Settings"), 20)
	
	entry({"admin", "services", "getid"}, call("action_getid"))
	entry({"admin", "services", "sendid"}, call("action_sendid"))
	entry({"admin", "services", "get_ids"}, call("action_get_ids"))
	entry({"admin", "services", "sendenable"}, call("action_sendenable"))
	entry({"admin", "services", "get_zstatus"}, call("action_get_zstatus"))
	entry({"admin", "zerotier", "getmail"}, call("action_getmail"))
	entry({"admin", "zerotier", "setmail"}, call("action_setmail"))
	entry({"admin", "zerotier", "setenable"}, call("action_setenable"))
	entry({"admin", "zerotier", "sendcust"}, call("action_sendcust"))
end

function action_getid()
	local rv = {}
	id = luci.model.uci.cursor():get("zerotier", "zerotier", "join")
	rv["netid"] = id
	secret = luci.model.uci.cursor():get("zerotier", "zerotier", "secret")
	if secret == nil then
		secret = "xxxxxxxxxx"
	end
	rv["enable"] = luci.model.uci.cursor():get("zerotier", "zerotier", "enabled")
	rv["routerid"] = string.sub(secret,1,10)
	rv["password"] = luci.model.uci.cursor():get("custom", "zerotier", "password")
	rv["cust"] = luci.model.uci.cursor():get("zerotier", "zerotier", "cust")
	luci.http.prepare_content("application/json")
	luci.http.write_json(rv)
end

function action_sendid()
	local set = luci.http.formvalue("set")
	os.execute("/usr/lib/zerotier/netid.sh 1 " .. set)
end

function action_sendenable()
	local set = luci.http.formvalue("set")
	os.execute("/usr/lib/zerotier/enable.sh 1 " .. set)
end

function action_get_ids()
	local rv = {}
	id = luci.model.uci.cursor():get("zerotier", "zerotier", "join")
	rv["netid"] = id
	secret = luci.model.uci.cursor():get("zerotier", "zerotier", "secret")
	if secret ~= nil then
		rv["routerid"] = string.sub(secret,1,10)
	else
		rv["routerid"] = "xxxxxxxxxx"
	end
	luci.http.prepare_content("application/json")
	luci.http.write_json(rv)
end

function action_get_zstatus()
	local rv = {}
	os.execute("/usr/lib/zerotier/status.sh")
	file = io.open("/tmp/zstatus", "r")
	rv['status'] = file:read("*line")
	rv['mac'] = file:read("*line")
	rv['ip'] = file:read("*line")
	file:close()
	
	luci.http.prepare_content("application/json")
	luci.http.write_json(rv)
end

function action_getmail()
	local rv ={}
	
	rv['smtp'] = luci.model.uci.cursor():get("zerotier", "configuration", "smtp")
	rv['euser'] = luci.model.uci.cursor():get("zerotier", "configuration", "euser")
	rv['epass'] = luci.model.uci.cursor():get("zerotier", "configuration", "epass")
	rv['password'] = luci.model.uci.cursor():get("zerotier", "configuration", "password")
	rv['sendto'] = luci.model.uci.cursor():get("zerotier", "configuration", "sendto")
	rv['enabled'] = luci.model.uci.cursor():get("zerotier", "configuration", "enabled")
	
	luci.http.prepare_content("application/json")
	luci.http.write_json(rv)
end

function action_setmail()
	local set = luci.http.formvalue("set")
	os.execute("/usr/lib/zerotier/mail.sh " .. set)
end

function action_setenable()
	local set = luci.http.formvalue("set")
	os.execute("/usr/lib/zerotier/mailenable.sh " .. set)
end

function action_sendcust()
	local rv ={}
	local set = luci.http.formvalue("set")
	os.execute("/usr/lib/zerotier/sendcust.sh '" .. set .. "'")
	
	rv['csent'] = "0"
	file = io.open("/tmp/sendcust", "r")
	if file ~= nil then
		rv['csent'] = "1"
		file:close()
	end
	luci.http.prepare_content("application/json")
	luci.http.write_json(rv)
end