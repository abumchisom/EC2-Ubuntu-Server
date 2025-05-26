## Overview

On this project, I configured an Ubuntu EC2 instance on AWS specifically for running a Graylog server, while maintaining consistent 24/7 uptime.

## Requirements

Since I am running everything on AWS, I only used my AWS ROOT account.


# First Phase: Creating the EC2 Instance

I began by navigating to my account dashboard, and on the menu, I located EC2, clicked on it, and hit Launch Instances. 

Next, I selected the Ubuntu Server 24.04 Long Term Support (LTS), to ensure that the server handles the load, I chose an r5.xlarge with a minimum of 4 vCPUs and 16GB RAM instead of the micro or medium types. 

After that, I created a new .pem key pair for my SSH login, which I downloaded to my computer. Afterwards, I created a security policy that allows SSH traffic on port 22 from anywhere using the 0.0.0.0 IP address. This is to ensure that I can SSH into my server from any device instead of a fixed device. Alternatively, I can set my IP address if I only want to access my server from a fixed computer.

For my storage, I ensured that I added enough storage space, using a root volume of 100GB, and three extra EBS volumes totaling 150GB. The reason for this is to ensure that I don't run into storage issues when dealing with large amount of logs.

## Second Phase: Advanced Settings - Creating a Robust Server

The next important thing I did was to ensure that my server is robust enough that it doesn't stop suddenly, disrupting to flow of logs.

To do this, I began by setting instance auto recovery to default, ensuring that my instance auto recovers itself if by chance, it fails.

Secondly, I leave my shutdown behavior to stop: This ensures that my server doesn't terminate when it gets stopped--manually.

Lastly, I enabled Termination protection, stop protection and CloudWatch Monitoring to ensure that the instance can only be manually verified before it stops, significantly reducing the chances of it being stopped suddenly, while CloudWatch monitors it constantly. 

Lastly, I clicked launch instance, and waited for it to boot.

