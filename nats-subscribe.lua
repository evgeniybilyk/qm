local nats = require 'nats'

local client = nats.connect({
    host = '127.0.0.1',
    port = 4222,
})

-- connect to the server
client:connect()

-- callback function for subscriptions
local function subscribe_callback(payload)
    print('Received data: ' .. payload .. ' replyTo ')
end

-- callback function for subscriptions
--local function subscribe_callback2(payload)
--    print('Received data2: ' .. payload)
--end

-- subscribe to a subject
client:subscribe('foo', subscribe_callback)

-- subscribe to a subject
--local subscribe_id2 = client:subscribe('foo2', subscribe_callback2)

-- wait until 2 messages come
while true
do
    client:wait(0)
end

-- unsubscribe from the subject
--client:unsubscribe(subscribe_id)
--client:unsubscribe(subscribe_id2)
