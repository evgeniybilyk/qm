local strlen = string.len
local cjson = require "cjson"
local rabbitmq = require "resty.rabbitmqstomp"

local opts = {
    username = "guest",
    password = "guest",
    vhost = "/"
}

local mq, err = rabbitmq:new(opts)

if not mq then
    ngx.say("<p>WTF</p>")
    return
end

--mq:set_timeout(10000)

local ok, err = mq:connect("172.19.0.3", 61613)

if not ok then
    ngx.say(err)
    return
end

local msg = { key = "value1", key2 = "value2" }
local headers = {}
headers["destination"] = "/exchange/test/binding"
headers["receipt"] = "msg#1"
headers["app-id"] = "luaresty"
headers["persistent"] = "true"
headers["content-type"] = "application/json"

local ok, err = mq:send(cjson.encode(msg), headers)
if not ok then
    ngx.say(err)
    return
end
ngx.say(cjson.encode(msg))
ngx.log(ngx.INFO, "Published: " .. cjson.encode(msg))

local headers = {}
headers["destination"] = "/amq/queue/queuename"
headers["persistent"] = "true"
headers["id"] = "123"

local ok, err = mq:subscribe(headers)
if not ok then
    return
end
--
--local data, err = mq:receive()
--if not ok then
--    return
--end
--ngx.say(cjson.encode(data))
--ngx.log(ngx.INFO, "Consumed: ")
--
--local headers = {}
--headers["persistent"] = "true"
--headers["id"] = "123"
--
--local ok, err = mq:unsubscribe(headers)

local ok, err = mq:set_keepalive(10000, 10000)
if not ok then
    return
end