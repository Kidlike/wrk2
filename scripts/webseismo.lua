-- example script that demonstrates use of setup() to pass
-- data to and from the threads

local counter = 1
local threads = {}

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

function init(args)
   requests  = 0
   response200 = 0
   responseOther = 0

   math.randomseed(os.time())

   local msg = "thread %d created"
   print(msg:format(id))
end

function request()
   requests = requests + 1
   n = math.random() * 100
   if n > 90 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=16&&ids=228036805438")
   elseif n > 80 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=3&ids=116664722545")
   elseif n > 70 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=5&ids=358924642456")
   elseif n > 60 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=6&ids=534071336846")
   elseif n > 50 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=13&ids=189630071838")
   elseif n > 40 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=6&ids=216538738218")
   elseif n > 30 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=12&ids=785254911016")
   elseif n > 20 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=6&ids=298766552865")
   elseif n > 10 then
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=16&ids=607959045540")
   else
      wrk.path = wrk.path:gsub("/kpi?.*","/kpi?target=2&ids=167289065548")
   end
   return wrk.request()
end

function response(status, headers, body)
   if status == 200 then
      response200 = response200 + 1
   else
      responseOther = responseOther + 1
   end
end

function done(summary, latency, requests)
   for index, thread in ipairs(threads) do
      local id        = thread:get("id")
      local requests  = thread:get("requests")
      local response200 = thread:get("response200")
      local responseOther = thread:get("responseOther")
      local msg = "thread %d made %d requests and got %d 200s and %d others"
      print(msg:format(id, requests, response200, responseOther))
   end
end
