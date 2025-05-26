# I first have to add its GPG key

$ curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elastic.gpg

# The above doesn't return anything, next, I added this line:

$ echo "deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
deb [signed-by=/usr/share/keyrings/elastic.gpg] https://artifacts.elastic.co/packages/7.x/apt stable main


# update system

sudo apt update -y


# I verifed my update by checking that it ends with these lines:

...
Get:6 https://artifacts.elastic.co/packages/7.x/apt stable/main amd64 Packages [143 kB]
Fetched 157 kB in 5s (30.6 kB/s)
Reading package lists... Done
Building a dependency tree... Done
Reading state information... Done
83 packages can be upgraded. Run 'apt list --upgradable' to see them.


# install elasticsearch

sudo apt install elasticsearch 


# I verifed my installation by checking for this:


Created elasticsearch keystore in /etc/elasticsearch/elasticsearch.keystore


# configure elasticsearch to start on boot

sudo systemctl start elasticsearch && sudo systemctl enable elasticsearch


# I verified that it starts on boot by checking for these lines at the end.



Synchronizing state of elasticsearch.service with SysV service script with /usr/lib/systemd/systemd-sysv-install.
Executing: /usr/lib/systemd/systemd-sysv-install enable elasticsearch
Created symlink /etc/systemd/system/multi-user.target.wants/elasticsearch.service → /usr/lib/systemd/system/elasticsearch.service.

#check for its status

sudo systemctl status elasticsearch


#output

● elasticsearch.service - Elasticsearch
     Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; enabled; preset: enabled)
     Active: active (running) since Thu 2025-04-24 15:48:14 WAT; 1min 52s ago
       Docs: https://www.elastic.co
   Main PID: 914 (java)
      Tasks: 70 (limit: 4615)
     Memory: 2.3G ()
     CGroup: /system.slice/elasticsearch.service
             ├─ 914 /usr/share/elasticsearch/jdk/bin/java -Xshare:auto -Des.networkaddress.cache.ttl=60 -De>
             └─1104 /usr/share/elasticsearch/modules/x-pack-ml/platform/linux-x86_64/bin/controller

Apr 24 15:47:20 DESKTOP-SOH8LGJ systemd[1]: Starting elasticsearch.service - Elasticsearch...
Apr 24 15:47:36 DESKTOP-SOH8LGJ systemd-entrypoint[914]: Apr 24, 2025 3:47:36 PM sun.util.locale.provider.L>
Apr 24 15:47:36 DESKTOP-SOH8LGJ systemd-entrypoint[914]: WARNING: COMPAT locale provider will be removed in>
Apr 24 15:48:14 DESKTOP-SOH8LGJ systemd[1]: Started elasticsearch.service - Elasticsearch.
lines 1-15/15 (END)...skipping...




# edited the config file

sudo nano /etc/elasticsearch/elasticsearch.yml


#This will open the Elasticsearch configuration file in the nano text editor.
#When the file is opened, you would see that most of what’s there is commented. Leave them that way, unless it’s necessary to edit any. What we are looking for is the cluster name. 

#Search for it and uncomment it, or add this:

cluster.name: Graylog
action.auto_create_index: false




sudo systemctl daemon-reload && sudo systemctl restart elasticsearch.

#test elasticsearch 

curl -X GET http://localhost:9200


#output

{
  "name" : "DESKTOP-SOH8LGJ",
  "cluster_name" : "Graylog",
  "cluster_uuid" : "UOGjoaTvT-q5ZgyOcyCI4A",
  "version" : {
    "number" : "7.17.28",
    "build_flavor" : "default",
    "build_type" : "deb",
    "build_hash" : "139cb5a961d8de68b8e02c45cc47f5289a3623af",
    "build_date" : "2025-02-20T09:05:31.349013687Z",
    "build_snapshot" : false,
    "lucene_version" : "8.11.3",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
