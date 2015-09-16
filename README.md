# Expenses a Volt bases app

This is an experimental app to test out Volt as a framework.
You can add expenses to track your outgoings. Expenses can only be added by authentificated users and each user can only delete his/her own entries.

## Installation

I use only Apache 2.4 with Passenger 5.0.6 on my Webserver, which does not support Websockets, [see this post](https://github.com/phusion/passenger/issues/1202).
Therefore you'll have to use Apache as a forward-proxy to [thin](http://code.macournoyer.com/thin/).
Your Apache will need the following modules enabled:
- [mod_proxy](http://httpd.apache.org/docs/2.4/mod/mod_proxy.html)
- [mod_proxy_wstunnel](http://httpd.apache.org/docs/2.4/mod/mod_proxy_wstunnel.html)

```
<VirtualHost *:80>
  ServerName YOUR.SERVER.NAME
  DocumentRoot /PATH/TO/APP_NAME/public

  ProxyRequests Off
  ProxyPreserveHost On

  # a2enmod proxy_wstunnel
  ProxyPass /socket  ws://localhost:3001/socket
  ProxyPassReverse /socket  ws://localhost:3001/socket
  ProxyPass / http://localhost:3001/
  ProxyPassReverse / http://localhost:3001/

  LogLevel warn

  CustomLog ${APACHE_LOG_DIR}/APP_NAME_access.log combined
  ErrorLog ${APACHE_LOG_DIR}/APP_NAME_error.log
</VirtualHost>
```

Install this as a service with `thin install` and add the following configuration file inside `/var/thin/volt.yml`

```
---
chdir: "/PATH/TO/APP_NAME"
environment: production
address: 0.0.0.0
port: 3001
timeout: 30
log: "/var/log/thin-expenses.log"
pid: tmp/pids/thin.pid
max_conns: 1024
max_persistent_conns: 100
require: []
wait: 30
threadpool_size: 20
servers: 1
daemonize: true
```

Start thin afterwards with `sudo /etc/init.d/thin start`

## Todo

- add pie-charts to track expenses over a certain time period
- extract categories into a YAML file

## New to Volt?
Be sure to read the volt docs at http://docs.voltframework.com
