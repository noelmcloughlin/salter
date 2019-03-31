# Salt Desktop
![saltstack formulas logo](https://avatars2.githubusercontent.com/u/4683350?s=200&v=4)

Salt Desktop orchestrates useful software onto Linux/MacOS without fuss. Ubuntu and MacOS are recommended.

## Quick start

<code>curl -o salt.sh https://raw.githubusercontent.com/saltstack-formulas/salt-desktop/master/bin/salt.sh && sudo bash salt.sh</code>

<code>sudo vi /srv/salt/profiles/config.sls</code>        #Customize for your site (i.e. dns/ntp/domain)!!

<code>sudo /usr/local/bin/devsetup -u username</code>     #Provision a Desktop via Menu

**Menu choices are:**
- Oracle JDK/JCE 8u201
- Jetbrains IntelliJ IDEA latest
- Jetbrains Pycharm latest
- Postgresql
- Eclipse Java (with plugins) recent
- Maven 3.2.5 or later
- Tomcat 7 or later
- Apache2 or later
- SQLPlus 12.2 or later
- SQL Developer recent

OR even better

<code>sudo /usr/local/bin/devsetup -u username -s dev</code>          # Provision a Linux Desktop (with oracle jdk and tomcat)

OR 

<code>sudo /usr/local/bin/devsetup -u username -s corpsys/dev</code>  # Provision a Linux Desktop (without oracle jdk/tomcat)

OR 

<code>sudo /usr/local/bin/devsetup -u username -s macbook</code>  # Provision a Macbook Desktop

OR

<code>sudo /usr/local/bin/devsetup -u domainadm -s corpsys/joindomain</code>    # Join this Linux host to Active Directory

<code>sudo net ads join EXAMPLE.COM -U nmcloughlin</code>                   # Join the Domain

<code>sudo kinit -k UPPERCASE_HOSTNAME\\$@EXAMPLE.COM</code>                # On failure retry after 5-10mins.

<code>sudo systemctl restart winbind</code>                                   # Service should work now

<code>sudo /usr/local/bin/devsetup -u domainadm -s corpsys/linuxvda</code>      # Setup Citrix LinuxVDA software


OR

<code>sudo /usr/local/bin/devsetup -u domainadm -s corpsys/clean</code>         # Cleanup Samba & Citrix LinuxVDA software

OR

<code>sudo /usr/local/bin/devsetup -u username [-a|-s]  ... create your own ... </code>

<br></br>
## Ecosystem

These formulae, hosted at https://github.com/saltstack-formulas, are verfied with Salt-Desktop. All software is checksum verified. Some binaries are stored at example.com.

| Upstream formula  	| Linux | MacOS	| Notes         | 	
|---------------	|------	|-------|-------------	|
| apache        	|  yes  |   -  	|   	   	|
| ceph.repo        	|  yes  |   -  	|   	   	|
| chrony        	|  yes  |   -  	|   	   	|
| linuxVda        	|  yes  |   -  	|   	   	|
| deepsea        	|  yes  |   -  	|   	   	|
| devstack        	|  yes  |   -  	| + OSC CLI     |
| docker        	|  yes  |   	|   	   	|
| eclipse        	|  yes  |  yes 	|   	   	|
| etcd              	|  yes  |  yes 	|   	   	|
| etcd.docker        	|  yes  |  yes 	|   	   	|
| firewalld         	|  yes  |   -  	|   	   	|
| golang        	|  yes  |   	|   	   	|
| hadoop        	|  yes  |   -  	|   	   	|
| iscsi             	|  yes  |   -  	|   	   	|
| jetbrains-intelliJ 	|  yes  |  yes 	|   	   	|
| jetbrains-datagrip 	|  yes  |  yes 	|   	   	|
| jetbrains-phpstorm 	|  yes  |  yes 	|   	  	|
| jetbrains-webstorm 	|  yes  |  yes 	|   	   	|
| jetbrains-pycharm 	|  yes  |  yes 	|   	   	|
| jetbrains-goland 	|  yes  |  yes 	|   	   	|
| kerberos        	|  yes  |   -  	|   	   	|
| lxd              	|  yes  |   -  	|   	   	|
| lvm              	|  yes  |   - 	|   	   	|
| maven              	|  yes  |  yes	|   	   	|
| mysql              	|  yes  |  yes 	| +workbench  	|
| mariadb        	|  yes  |   -  	|   	   	|
| mongoDB        	|  yes  |  yes	| +BI connector	|
| opensds        	|  yes  |   -  	|   	   	|
| sun-java       	|  yes  |  yes 	| +JRE/JDK/JCE	|
| packages      	|  yes  |  yes 	|   	   	|
| postgres      	|  yes  |  yes 	|   	   	|
| resolver-ng      	|  yes  |   - 	|   	   	|
| salt            	|  yes  |  yes 	|   	   	|
| samba             	|  yes  |   -  	|   	   	|
| sqlplus       	|  yes  |  yes 	|   	  	|
| sqldeveloper       	|  yes  |  yes 	|   	   	|
| timezone       	|  yes  |   -  	|   	   	|
| tomcat            	|  yes  |  yes 	|   	  	|
| users                 |  yes  |   -  	|   	  	|
|                       |  	|   	|   	   	|

<br/><br/>
## EXAMPLES ..

### Join Active Directory Domain and setup Citrix Linux VDA
```bash
$ sudo /usr/local/bin/devsetup -u domainadm -s corpsys/joindomain-cleanup; sudo /usr/local/bin/devsetup -u domainadm -s corpsys/joindomain

.. etc ...

custom choice [ stacks/corpsys/joindomain ] selected
Logging to [ /tmp/saltdesktop/stacks/corpsys/joindomain/log.201804110644 ]
Orchestrating things, please be patient ...
Summary for local
--------------
Succeeded: 127 (changed=98)
Failed:      0
Warnings:    1
--------------


domainadm@myhost4:~$ sudo net ads join EXAMPLE.COM -U nmcloughlin
Enter nmcloughlin password:
Using short domain name -- EXAMPLE
Joined MYHOST4 to dns domain example.com
DNS Update for myhost4.example.com failed: ERROR_DNS_GSS_ERROR
DNS update failed: NT_STATUS_UNSUCCESSFUL

domainadm@myhost4:~$ sudo kinit -k MYHOST4\$@EXAMPLE.COM
domainadm@myhost4:~$ sudo systemctl restart winbind

domainadm@myhost4:~$ sudo /usr/local/bin/devsetup -u domainadm -s corpsys/linuxvda

```

### Sudo Access
```bash
$ sudo /usr/local/bin/devsetup -u jdoe -a sudo

custom choice [ apps/sudo ] selected
Logging to [ /tmp/saltdesktop/apps/sudo/log.201804110702 ]
Orchestrating things, please be patient ...

Summary for local
-------------
Succeeded: 11 (changed=5)
Failed:     2
-------------
Total states run:     13
Total run time:   25.748 s
See full log in [ /tmp/saltdesktop/apps/sudo/log.201804110702 ]
```
