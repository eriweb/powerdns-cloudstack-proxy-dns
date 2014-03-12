logger(log_error,"cloudstack-dns.lua starting")

-- TODO: eventually we should support getting our domain name from pdns.conf
-- but for some reason it doesn't work..
-- TODO: when this works, we'll provide it as an option called lua-domain in pdns.conf
-- domain = getarg("domain")
domain = "realhostip.com"

if domain == nil or domain == "" then
  logger(log_error,"cloudstack-dns.lua is missing the domain parameter in pdns.conf")
end
local res = {}

function list(target,domain_id)
  -- we are not providing this feature
end

function lookup(qtype,qname,domain_id)
  res = {}
  nofr = 0
  counter = 0
  -- we only care about 'A' or 'ANY' requests
  if qtype == 'A' or qtype == 'ANY' then
    if string.match(qname,'^%d+%-%d+%-%d+%-%d+%.' .. domain) then

      -- capture the ip, reformat and save the ip to a variable
      -- captured from the format 1-2-3-4.yourdomain.com and saved as 1.2.3.4
      ip = string.gsub(qname,'^(%d+)%-(%d+)%-(%d+)%-(%d+)%.' .. domain,'%1.%2.%3.%4')

      res = {
        domain_id = domain_id,
        name      = qname,
        type      = 'A',
        ttl       = 3600,
        content   = ip
      }
      -- TODO: preferably we should return the calculated length of res
      -- we're only supposed to return 1 answer, so won't bother with iterating and counting the records
      nofr = 1
      end
  end
end

function get()
  while counter < nofr do
    counter = counter + 1
    return res
  end
end

function getsoa(name)
  -- we are not providing this feature
end
