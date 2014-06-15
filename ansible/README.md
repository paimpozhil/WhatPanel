WhatPanel setup with Ansible
============================

This is to make the easy whatpanel setup MUCH more easy and automated.

```
## use this if you need to setup swap
 ansible-playbook [--ask-pass] addswap.yml -i [inventory]

## use this to install whatpanel on a server that has docker.
 ansible-playbook [--ask-pass] installwhatpanel.yml -i [inventory]

```


We will soon release a webgui that will do this so you dont have to touch terminals and commands at all.




