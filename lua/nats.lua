local nats = require 'nats'

local client = nats.connect({
    host = '172.19.0.2',
    port = 4222,
})

-- connect to the server
client:connect()

-- publish to a subject
--for i = 1, 1000000 do
local subscribe_id = client:publish('foo', 'message to be published')
ngx.say('message to be published')
--    local subscribe_id = client:publish('foo2', 'message to be published2: ' .. i)
--end
