# Gollum Wiki Easy Install

An [Ansible](https://docs.ansible.com/) playbook to provision a secure, private [Gollum Wiki](https://github.com/gollum/gollum) instance. Tested on Ubuntu 18.04/20.04.

## Features

- HTTPs-enabled via [LetsEncrypt/Certbot](https://certbot.eff.org/)
- Uses [Apache](https://httpd.apache.org/) HTTP Server with [mod_proxy](https://httpd.apache.org/docs/2.4/mod/mod_proxy.html).
- Authentication via Apache Basic Auth
- UFW Firewall enabled with 443 (SSL) port and rate-limited 22 (SSH) port exposed.
- Updates to wiki entries are automatically pushed to your Github repo storing wiki entries.

## Requirements

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Setup

First make sure there is a fresh _Ubuntu 18.04 or 20.04_ instance where you want to install Gollum on. Also, make sure you can ssh in, e.g. running the command `ssh root@my-gollum-wiki.com` should be successful.

### 1 - Create a Blank Github Repo to Store Your Wiki Notes

![Create Blank Github Repo](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/init-repo.png)

\* If you want your notes to be secret, make sure the repo is set to _Private_.

### 2 - Copy Clone URL

![Copy Clone URL](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/copy-clone-url.png)

### 3 - Update vars/site With Your Settings

For example:

```
gollum_login_username: jonmbake
gollum_login_password: "ykek88+>Foo"
certbot_contact_email: jonmbake@gmail.com
certbot_domain_name: notes.jonbake.com
github_ssh_repo_url: git@github.com:jonmbake/wiki-notes.git
```

### 4 - Update Inventory With Your Domain Name

```
[prod]
notes.jonbake.com ansible_user=root
```

### 5 - Run the Ansible Provisioning Playbook Script

```
ansible-playbook -i inventory site.yml
```

Towards the end of the playbook, the Github deploy public key will be logged:

![Copy Clone URL](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/log-deploy-key.png)

### 6 - Add Deploy Public Key to Your Github Repo

![Copy Clone URL](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/add-deploy-key-github.png)

**Make sure to click _Allow write access_**

### 7 - Navigate to Your Gollum Instance - Verify Things Work

1. Login with `gollum_login_username` and `gollum_login_password`

![Gollum Login](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/gollum_login.png)

2. Create a page and save.

![Create Page](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/create-page.png)

3. Verify page is added to Github repo.

![Create Page](https://raw.githubusercontent.com/jonmbake/screenshots/master/gollum-easy-install/repo-page-added.png)

## Running Locally

Add `github_ssh_repo_url` to _vars/local_. Then run:

```
vagrant up
```

Add the logged _deploy public key_ to your Github repo.

## Useful Server Commands

Restart gollum:

```
sudo service gollum restart
```

View the gollum logs:

```
tail /var/log/gollum.log
```

Navigate to local gollum wiki directory:

```
cd /home/gollum/data
```

Update gollum configuration:

```
sudo su gollum
vim /home/gollum/data/gollum-config.rb
```

## To Dos

- Add web hook so changes made outside of instance are synced
