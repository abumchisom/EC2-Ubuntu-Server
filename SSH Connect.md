# SSH Connect

## What is SSH?
SSH (Secure Shell) is a protocol used to securely connect to remote systems over a network.

## Basic SSH Command

```bash
ssh username@hostname
```

- `username`: Your account name on the remote system.
- `hostname`: The IP address or domain name of the remote system.

## Example

```bash
ssh alice@192.168.1.10
```

For my EC2 instance, there are different ways I can connect to it, but for this project, I used SSH due to its ease, and security.

To do that, I clicked the connect button on my already launched instance, and navigated to the SSH client tab.

Next, I opened up my Terminal on my computer, and since I was using Windows, I had to use the GitBash Command Line Interface due to its close resemblance with Linux.

I navigated to my Downloads folder using 
``` 
cd Downloads 
```
Next, I used the change mode command to read my ssh .pem key file which is stored in my Downloads folder. 

```
chmod 400 "key.pem"
```
Once I now have read access to my SSH key, I SSH into it using:
ssh -i "key.pem" ubuntu@ec2-my-ip-add-ress.compute-1.amazonaws.com (I redacted my actual IP, but on your dashboard, AWS will display everything for you to copy and paste)

I got a prompt to save my instance, and responded with a 'yes'.

