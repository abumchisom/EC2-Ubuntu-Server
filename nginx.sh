# install 
sudo apt install nginx

#check for this in your output

Created symlink /etc/systemd/system/multi-user.target.wants/nginx.service → /usr/lib/systemd/system/nginx.service.
Processing triggers for man-db (2.12.0-4build2) ...


#check your EC2 instance for your public IP address or use ```ip a``` on your terminal if you aren't using AWS, or ```curl ifcongig.me```

sudo nano /etc/nginx/sites-available/graylog.conf

#add this:

server {
    listen 80;
    server_name server-public-ip; (add your external ip address)

    location / {
        proxy_pass http://127.0.0.1:9000;
        proxy_set_header Host $http_host;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Graylog-Server-URL http://$server_name/;
    }
}


# Save and exit the virtual host file, then validate that the NGINX configuration is successful with: 
sudo nginx -t

#output

nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful


#enable the virtual host file

sudo ln -s /etc/nginx/sites-available/graylog.conf /etc/nginx/sites-enabled/


#restart

sudo systemctl restart nginx
sudo systemctl status nginx


# If NGINX is running and is enabled, open up your web browser, and type in your server’s IP. i.e. http://server-ip/
