#This file is more of a draft then a finished runnable bash file
# You should probably be root for most of these, so run
# sudo su
#!/bin/bash

##################################
# Run this only once for your site
##################################

# FOLDER is a folder that contains a .well-known directory, and is expsed by your Tomcat, this can be achieved by adding this to your server.xml under host section
# <Context docBase="FOLDER/.well-known" path="/.well-known" />
# You can add domains, like -d www.example.com -d example.com
# Your email is used for emergency contact
certbot certonly --webroot -w FOLDER_TO_A_FOLDER_THAT_IS_EXPOSED_BY_YOUR_CONTAINER_AS_IS -d FIRST_DOMAIN -d SECOND_DOMAIN -m YOUR_EMAIL

######################################
# Run these every time renew is needed
######################################
certbot renew --quiet --no-self-upgrade

#####################################
# Run these both for renew and create
#####################################

# Go under the folder generated
#cd under /etc/letsencrypt/live/YOURSITE

# Get root certificate
wget https://letsencrypt.org/certs/letsencryptauthorityx3.pem -O isrg_root.pem

# Concatenate with the certificate letsencrypt have given you to create the full chain up to root certificate authority
cat fullchain.pem isrg_root.pem > ca_cert_chain.pem

# Create a Java keystore from the chain
openssl pkcs12 -export -in cert.pem -inkey privkey.pem -name YOUR_FILE_NAME -chain -CAfile ca_cert_chain.pem -out OUTPUT_FILE.pk12 -pass pass:YOUR_KEYSTORE_PASSWORD

# Move it to a location your Tomcat can read
# The created keystore has to be added to your tomcat server.xml, something like:
#    <Connector port="443" protocol="org.apache.coyote.http11.Http11NioProtocol"
#                SSLEnabled="true" scheme="https" secure="true"
#               clientAuth="false" sslProtocol="TLS" keystoreFile="YOUR_KEYSTORE_PATH_AND_FILENAME" keystorePass="YOUR_KEYSTORE_PASSWORD" />

# The renew part should be scripted, TBD...
