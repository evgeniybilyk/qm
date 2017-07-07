local nats = require 'nats'

local client = nats.connect({
    host = '127.0.0.1',
    port = 4222,
})

-- connect to the server
client:connect()

-- publish to a subject
for i = 1, 1000000 do
    local subscribe_id = client:publish('foo', 'message to be published: ' .. i)
--    local subscribe_id = client:publish('foo2', 'message to be published2: ' .. i)
end
