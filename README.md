powerdns-cloudstack-console-proxy-dns
=====================================

PowerDNS Lua script to provide realhostip.com like feature for cloudstack and others



Installation
============

1. First, make sure to have Lua enabled in your PowerDNS authorative server.
If you are using a RHEL based distribution with EPEL you could probably do
something like `yum install pdns-backend-lua`

2. Place the cloudstack-dns.lua file somewhere where your powerdns can access and
read it. Ie. in your /etc/pdns folder.


Configuration
=============

1. In your pdns.conf, add lua to launch after your existing backends.
2. If this is a dedicated domain, you have to provide NS and SOA records as you
normally would, as that's outside the scope of this script.

3. If you are using the bind backend, your pdns.conf should look like this:
```
launch=bind,lua
lua-filename=/etc/pdns/cloudstack-dns.lua
```
4. In cloudstack-dns.lua, specify the domain variable. This will be 
configurable from pdns.conf once that works, but is hard coded as a workaround

Testing
=======

```
[vagrant@pdns ~]$ dig +short 1-2-3-4.realhostip.com @localhost
1.2.3.4
```
