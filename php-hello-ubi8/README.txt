
[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ cat Dockerfile 
FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum --disableplugin=subscription-manager -y module enable php:7.3 \
  && yum --disableplugin=subscription-manager -y install httpd php \
  && yum --disableplugin=subscription-manager clean all

ADD index.php /var/www/html

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && mkdir /run/php-fpm \
  && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm \
  && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm

EXPOSE 8080
USER 1001
CMD php-fpm & httpd -D FOREGROUND

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ podman build -f Dockerfile -t php-hello-ubi8 .
STEP 1: FROM registry.access.redhat.com/ubi8/ubi:8.1
Getting image source signatures
Copying blob befb03b11956 done  
Copying blob ee2244abc66f done  
Copying config 8121a9f530 done  
Writing manifest to image destination
Storing signatures
STEP 2: RUN yum --disableplugin=subscription-manager -y module enable php:7.3   && yum --disableplugin=subscription-manager -y install httpd php   && yum --disableplugin=subscription-manager clean all
Red Hat Universal Base Image 8 (RPMs) - BaseOS                                   1.7 MB/s | 767 kB     00:00    
Red Hat Universal Base Image 8 (RPMs) - AppStream                                7.1 MB/s | 4.0 MB     00:00    
Red Hat Universal Base Image 8 (RPMs) - CodeReady Builder                         59 kB/s |  12 kB     00:00    
Dependencies resolved.
=================================================================================================================
 Package                   Architecture             Version                      Repository                 Size
=================================================================================================================
Enabling module streams:
 httpd                                              2.4                                                         
 nginx                                              1.14                                                        
 php                                                7.3                                                         

Transaction Summary
=================================================================================================================

Complete!
Last metadata expiration check: 0:00:01 ago on Mon Sep 14 18:45:57 2020.
Dependencies resolved.
=================================================================================================================
 Package                  Architecture Version                                       Repository             Size
=================================================================================================================
Installing:
 httpd                    x86_64       2.4.37-21.module+el8.2.0+5008+cca404a3        ubi-8-appstream       1.4 M
 php                      x86_64       7.3.20-1.module+el8.2.0+7373+b272fdef         ubi-8-appstream       1.5 M
Installing dependencies:
 libedit                  x86_64       3.1-23.20170329cvs.el8                        ubi-8-baseos          102 k
 redhat-logos-httpd       noarch       81.1-1.el8                                    ubi-8-baseos           26 k
 mailcap                  noarch       2.1.48-3.el8                                  ubi-8-baseos           39 k
 apr                      x86_64       1.6.3-9.el8                                   ubi-8-appstream       125 k
 apr-util                 x86_64       1.6.1-6.el8                                   ubi-8-appstream       105 k
 nginx-filesystem         noarch       1:1.14.1-9.module+el8.0.0+4108+af250afe       ubi-8-appstream        24 k
 php-cli                  x86_64       7.3.20-1.module+el8.2.0+7373+b272fdef         ubi-8-appstream       3.0 M
 httpd-filesystem         noarch       2.4.37-21.module+el8.2.0+5008+cca404a3        ubi-8-appstream        36 k
 httpd-tools              x86_64       2.4.37-21.module+el8.2.0+5008+cca404a3        ubi-8-appstream       103 k
 php-common               x86_64       7.3.20-1.module+el8.2.0+7373+b272fdef         ubi-8-appstream       669 k
 mod_http2                x86_64       1.11.3-3.module+el8.2.0+7758+84b4ca3e.1       ubi-8-appstream       156 k
Installing weak dependencies:
 apr-util-openssl         x86_64       1.6.1-6.el8                                   ubi-8-appstream        27 k
 apr-util-bdb             x86_64       1.6.1-6.el8                                   ubi-8-appstream        25 k
 php-fpm                  x86_64       7.3.20-1.module+el8.2.0+7373+b272fdef         ubi-8-appstream       1.6 M

Transaction Summary
=================================================================================================================
Install  16 Packages

Total download size: 8.9 M
Installed size: 30 M
Downloading Packages:
(1/16): libedit-3.1-23.20170329cvs.el8.x86_64.rpm                                1.2 MB/s | 102 kB     00:00    
(2/16): redhat-logos-httpd-81.1-1.el8.noarch.rpm                                 267 kB/s |  26 kB     00:00    
(3/16): mailcap-2.1.48-3.el8.noarch.rpm                                          332 kB/s |  39 kB     00:00    
(4/16): apr-1.6.3-9.el8.x86_64.rpm                                               2.2 MB/s | 125 kB     00:00    
(5/16): apr-util-1.6.1-6.el8.x86_64.rpm                                          1.9 MB/s | 105 kB     00:00    
(6/16): apr-util-openssl-1.6.1-6.el8.x86_64.rpm                                  743 kB/s |  27 kB     00:00    
(7/16): nginx-filesystem-1.14.1-9.module+el8.0.0+4108+af250afe.noarch.rpm        1.3 MB/s |  24 kB     00:00    
(8/16): apr-util-bdb-1.6.1-6.el8.x86_64.rpm                                      686 kB/s |  25 kB     00:00    
(9/16): httpd-filesystem-2.4.37-21.module+el8.2.0+5008+cca404a3.noarch.rpm       440 kB/s |  36 kB     00:00    
(10/16): httpd-tools-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64.rpm           1.3 MB/s | 103 kB     00:00    
(11/16): php-cli-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64.rpm                5.6 MB/s | 3.0 MB     00:00    
(12/16): httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64.rpm                 2.3 MB/s | 1.4 MB     00:00    
(13/16): php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64.rpm                3.9 MB/s | 1.6 MB     00:00    
(14/16): php-common-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64.rpm             4.9 MB/s | 669 kB     00:00    
(15/16): mod_http2-1.11.3-3.module+el8.2.0+7758+84b4ca3e.1.x86_64.rpm            1.7 MB/s | 156 kB     00:00    
(16/16): php-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64.rpm                    5.3 MB/s | 1.5 MB     00:00    
-----------------------------------------------------------------------------------------------------------------
Total                                                                            8.4 MB/s | 8.9 MB     00:01     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                         1/1 
  Installing       : php-common-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                1/16 
  Running scriptlet: httpd-filesystem-2.4.37-21.module+el8.2.0+5008+cca404a3.noarch                         2/16 
  Installing       : httpd-filesystem-2.4.37-21.module+el8.2.0+5008+cca404a3.noarch                         2/16 
  Installing       : apr-1.6.3-9.el8.x86_64                                                                 3/16 
  Running scriptlet: apr-1.6.3-9.el8.x86_64                                                                 3/16 
  Installing       : apr-util-openssl-1.6.1-6.el8.x86_64                                                    4/16 
  Installing       : apr-util-bdb-1.6.1-6.el8.x86_64                                                        5/16 
  Installing       : apr-util-1.6.1-6.el8.x86_64                                                            6/16 
  Running scriptlet: apr-util-1.6.1-6.el8.x86_64                                                            6/16 
  Installing       : httpd-tools-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                              7/16 
  Running scriptlet: nginx-filesystem-1:1.14.1-9.module+el8.0.0+4108+af250afe.noarch                        8/16 
  Installing       : nginx-filesystem-1:1.14.1-9.module+el8.0.0+4108+af250afe.noarch                        8/16 
  Installing       : php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                   9/16 
  Running scriptlet: php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                   9/16 
  Installing       : mailcap-2.1.48-3.el8.noarch                                                           10/16 
  Installing       : redhat-logos-httpd-81.1-1.el8.noarch                                                  11/16 
  Installing       : mod_http2-1.11.3-3.module+el8.2.0+7758+84b4ca3e.1.x86_64                              12/16 
  Installing       : httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                   13/16 
  Running scriptlet: httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                   13/16 
  Installing       : libedit-3.1-23.20170329cvs.el8.x86_64                                                 14/16 
  Installing       : php-cli-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                  15/16 
  Installing       : php-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                      16/16 
  Running scriptlet: httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                   16/16 
  Running scriptlet: php-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                      16/16 
  Running scriptlet: php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                  16/16 
  Verifying        : libedit-3.1-23.20170329cvs.el8.x86_64                                                  1/16 
  Verifying        : redhat-logos-httpd-81.1-1.el8.noarch                                                   2/16 
  Verifying        : mailcap-2.1.48-3.el8.noarch                                                            3/16 
  Verifying        : apr-1.6.3-9.el8.x86_64                                                                 4/16 
  Verifying        : apr-util-1.6.1-6.el8.x86_64                                                            5/16 
  Verifying        : apr-util-openssl-1.6.1-6.el8.x86_64                                                    6/16 
  Verifying        : nginx-filesystem-1:1.14.1-9.module+el8.0.0+4108+af250afe.noarch                        7/16 
  Verifying        : apr-util-bdb-1.6.1-6.el8.x86_64                                                        8/16 
  Verifying        : httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                    9/16 
  Verifying        : php-cli-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                  10/16 
  Verifying        : httpd-filesystem-2.4.37-21.module+el8.2.0+5008+cca404a3.noarch                        11/16 
  Verifying        : httpd-tools-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                             12/16 
  Verifying        : php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                  13/16 
  Verifying        : php-common-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                               14/16 
  Verifying        : mod_http2-1.11.3-3.module+el8.2.0+7758+84b4ca3e.1.x86_64                              15/16 
  Verifying        : php-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                      16/16 
Installed products updated.

Installed:
  httpd-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                                            
  php-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                                               
  apr-util-openssl-1.6.1-6.el8.x86_64                                                                            
  apr-util-bdb-1.6.1-6.el8.x86_64                                                                                
  php-fpm-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                                           
  libedit-3.1-23.20170329cvs.el8.x86_64                                                                          
  redhat-logos-httpd-81.1-1.el8.noarch                                                                           
  mailcap-2.1.48-3.el8.noarch                                                                                    
  apr-1.6.3-9.el8.x86_64                                                                                         
  apr-util-1.6.1-6.el8.x86_64                                                                                    
  nginx-filesystem-1:1.14.1-9.module+el8.0.0+4108+af250afe.noarch                                                
  php-cli-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                                           
  httpd-filesystem-2.4.37-21.module+el8.2.0+5008+cca404a3.noarch                                                 
  httpd-tools-2.4.37-21.module+el8.2.0+5008+cca404a3.x86_64                                                      
  php-common-7.3.20-1.module+el8.2.0+7373+b272fdef.x86_64                                                        
  mod_http2-1.11.3-3.module+el8.2.0+7758+84b4ca3e.1.x86_64                                                       

Complete!
24 files removed
--> 345007fc88f
STEP 3: ADD index.php /var/www/html
--> a97010ae409
STEP 4: RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf   && mkdir /run/php-fpm   && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm   && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm
--> dfd9f00bb9e
STEP 5: EXPOSE 8080
--> 2f7fbf82a9a
STEP 6: USER 1001
--> ee6500175f2
STEP 7: CMD php-fpm & httpd -D FOREGROUND
STEP 8: COMMIT php-hello-ubi8
--> bfb2cc147b8
bfb2cc147b8147119a1165eec15793654bab82b66b4ec0cf950b7caceba2befb

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ podman run --name=php-hello-ubi8 -dt -p 8080:8080 php-hello-ubi8
ce7ba4a0f9c830dd186bcd7f2a2df78a389ca16f6f58ce996ec2c7431cbd3ac2

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ curl http://localhost:8080/
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>503 Service Unavailable</title>
</head><body>
<h1>Service Unavailable</h1>
<p>The server is temporarily unable to service your
request due to maintenance downtime or capacity
problems. Please try again later.</p>
</body></html>

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ podman logs php-hello-ubi8
[14-Sep-2020 18:46:37] NOTICE: [pool www] 'user' directive is ignored when FPM is not running as root
[14-Sep-2020 18:46:37] NOTICE: [pool www] 'group' directive is ignored when FPM is not running as root
[14-Sep-2020 18:46:37] ERROR: [pool www] failed to read the ACL of the socket '/run/php-fpm/www.sock': Operation not supported (95)
[14-Sep-2020 18:46:37] ERROR: FPM initialization failed
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.0.2.100. Set the 'ServerName' directive globally to suppress this message

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ date
Mon Sep 14 14:48:28 EDT 2020

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ uname -a
Linux rhel8-server-01-zcsi.local 4.18.0-193.19.1.el8_2.x86_64 #1 SMP Wed Aug 26 15:29:02 EDT 2020 x86_64 x86_64 x86_64 GNU/Linux

[worsco@rhel8-server-01-zcsi php-hello-ubi8]$ cat /etc/redhat-release 
Red Hat Enterprise Linux release 8.2 (Ootpa)
