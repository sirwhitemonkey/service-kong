#!/bin/bash

if [ "$1" != "" ] ; then

    #asset.test.service /asset/test
    curl -i -X DELETE "$1"/apis/asset.test.service
    upstream_url="upstream_url=http://$2:7000/asset/test"
    curl -i -X POST \
    --url "$1"/apis/ \
    --data 'name=asset.test.service' \
    --data "$upstream_url" \
    --data 'uris=/asset/test'
    
    #metadata.test.service /metadata/test
     curl -i -X DELETE "$1"/apis/metadata.test.service
    upstream_url="upstream_url=http://$2:7002/metadata/test"
    curl -i -X POST \
    --url "$1"/apis/ \
    --data 'name=metadata.test.service' \
    --data "$upstream_url" \
    --data 'uris=/metadata/test'
   
    #moxion.service
    curl -i -X DELETE "$1"/apis/moxion.service
    upstream_url="upstream_url=http://$2:7004"
    curl -i -X POST \
    --url "$1"/apis/ \
    --data 'name=moxion.service' \
    --data "$upstream_url" \
    --data 'uris=/'
     
    #plugins
    curl -i -X POST \
    --url "$1"/plugins/ \
    --data 'name=cors' \
    --data 'config.origins=*' \
    --data 'config.methods=GET,POST,DELETE,PUT' \
    --data 'config.headers=X-Frame-Options,Access-Control-Allow-Origin, Access-Control-Allow-Headers, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Auth-Token, Host' \
    --data 'config.exposed_headers=X-Frame-Options,Access-Control-Allow-Origin, Access-Control-Allow-Headers, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Auth-Token, Host' \
    --data 'config.credentials=true' \
    --data 'config.max_age=3600' \
    --data 'config.preflight_continue=false'
    
  
else
     echo "Error: syntax <kong-admin> <resource-ip>"
fi