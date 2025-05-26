# get the Graylog server Debian package.

wget https://packages.graylog2.org/repo/packages/graylog-6.0-repository_latest.deb


# output

HTTP request sent, awaiting response... 200 OK
Length: 2098 (2.0K) [application/x-debian-package]
Saving to: 'graylog-6.0-repository_latest.deb'

graylog-6.0-repository_lat 100%[========================================>]   2.05K  --.-KB/s    in 0s

2025-05-05 15:17:24 (4.77 MB/s) - 'graylog-6.0-repository_latest.deb' saved [2098/2098]

# enable dpkg
sudo dpkg -i graylog-6.0-repository_latest.deb


# output

Selecting previously unselected package graylog-6.0-repository.
(Reading database ... 40825 files and directories currently installed.)
Preparing to unpack graylog-6.0-repository_latest.deb ...
Unpacking graylog-6.0-repository (1-1) ...
Setting up graylog-6.0-repository (1-1) ...


# update system

sudo apt update


# install graylog

sudo apt install graylog-server -y


# output

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following NEW packages will be installed:
  graylog-server
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
Need to get 299 MB of archives.
After this operation, 420 MB of additional disk space will be used.
Get:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1 [299 MB]
Ign:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1
Get:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1 [299 MB]
Ign:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1
Get:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1 [299 MB]
Ign:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1
Get:1 https://downloads.graylog.org/repo/debian stable/6.0 amd64 graylog-server amd64 6.0.14-1 [299 MB]
Fetched 192 MB in 8min 42s (368 kB/s)
Selecting previously unselected package graylog-server.
(Reading database ... 43101 files and directories currently installed.)
Preparing to unpack .../graylog-server_6.0.14-1_amd64.deb ...
Unpacking graylog-server (6.0.14-1) ...
Setting up graylog-server (6.0.14-1) ...
################################################################################

Graylog does NOT start automatically!

Please run the following commands if you want to start Graylog automatically on system boot:

   
 sudo systemctl enable graylog-server.service

    sudo systemctl start graylog-server.service

################################################################################



sudo systemctl enable graylog-server && sudo systemctl start graylog-server


# set up secret passwords

< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-96};echo;

# This will generate the hashed value. Save that hash somewhere safe, because you’ll need it soon.

# Next is to generate your own admin password. To do that, type in:
echo -n "Enter Password: " && head -1 </dev/stdin | tr -d '\n' | sha256sum | cut -d" " -f1

# This will output a prompt to enter your password. This is the password you’d use when logging into your Graylog’s WebUI. Hitting Enter will generate the password hash. 
#To ensure that Graylog can associate that password with your account (default username is admin), you are expected to save the password hash to Graylog’s config file, so you should also save the hash somewhere safe.
#Enter your config file via: 

sudo nano /etc/graylog/server/server.conf

#The config file is filled with commented lines. Only remove the comments from the lines you want graylog to execute.



# find ```password_secret```, uncomment it, if it is commented, and add the first hash from when you ran: < /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-96}; echo;
# Then, scroll a bit downwards, and find root_password_ssh2, add the saved hash for your admin password.
#Next, scroll downwards, and under the

###############
# HTTP settings
###############


# Locate ```http_bind_address```, and add the bind address for your Graylog server. This is typically the localhost address, but instead of adding: http_bind_address = localhost:9000, you should add 
```http_bind_address = 127.0.0.1:9000```

# Next, locate elasticsearch_hosts, and add this: 
elasticsearch_hosts = http://localhost:9200

#The last modification on your Graylog conf is the MongoDB settings. To do that, locate the MongoDB settings by either scrolling downwards or searching for it with CTRL/CMD + W.
# Uncomment or add this: 
mongodb_uri = mongodb://localhost:27017/graylog
# After this, save and exit the configuration file.
# Once you are back on the command prompt, reload daemon with 
sudo systemctl daemon-reload && sudo systemctl restart graylog-server

sudo systemctl status graylog-server