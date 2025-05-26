# Update system
sudo apt update 


# add the MongoDB GPG signing key:

curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \

# Then add:
sudo gpg - -daemor -o /etc/apt/trusted.gpg.d/mongodb-server-6.0.gpg



# Add the MongoDB repository source list.d to Ubuntu.

echo "deb [ arch=amd64,arm64 signed=/etc/apt/trusted.gpg.d/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list


# Output 
deb [ arch=amd64,arm64 signed=/etc/apt/trusted.gpg.d/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse


# Update system again
sudo apt update


# install MongoDB:

sudo apt install mongodb-org -y


# Confirm installation:
mongod -version



# start on boot

sudo systemctl start mongod && sudo systemctl enable mongod && sudo systemctl status mongod


# output

Warning: The unit file, source configuration file, or drop-ins of mongod.service changed on disk. Run 'systemctl daemon-reload' to reload units.
● mongod.service - MongoDB Database Server
     Loaded: loaded (/usr/lib/systemd/system/mongod.service; enabled; preset: enabled)
     Active: active (running) since Sun 2025-05-04 17:56:43 UTC; 14min ago
       Docs: https://docs.mongodb.org/manual
   Main PID: 546 (mongod)
     Memory: 136.4M (peak: 307.1M)
        CPU: 8.135s
     CGroup: /system.slice/mongod.service
             └─546 /usr/bin/mongod --config /etc/mongod.conf

May 04 17:56:43 ip-<your ip> systemd[1]: Started mongod.service - MongoDB Database Server.
May 04 17:56:44 ip-<your ip> mongod[546]: {"t":{"$date":"2025-05-04T17:56:44.390Z"},"s":"I",  "c":"CONTROL",  "id":7484500, "ctx":"-","msg":"Environment variable MONGODB_CONFI>
lines 1-13/13 (END)



sudo systemctl daemon-reload
