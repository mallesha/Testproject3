*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           OperatingSystem
Library           Process

*** Variables ***
${username}       mchari
${password}       Team-Devo#1203
@{login_auth}     ${username}    ${password}
${service_create_path}    /home/mallesha/robot/config_files/
${ipaddr}         213.160.72.239
${baseurl_service}    https://${ipaddr}:443/restconf/data/tailf-ncs:services
#${device}        device=T01-ntsm-ci-ios38
${ser-device}     T02-ntsm-ci-ios38

*** Test Cases ***
create_service
    service-create
    #${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    #create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    #${json_result}=    run process    python    /home/mallesha/robot/config_files/service_create.py
    #log    ${json_result.stdout}
    #${response}=    post request    myssion    /    data=${json_result.stdout}
    #should be equal as strings    ${response.status_code}    201

get_service_device_hostname
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${response}=    get request    myssion    /hname-banner-rfs:hname-banner-rfs=${ser-device}/hostname
    Log    ${response.content}
    should be equal as strings    ${response.status_code}    200

get_service_device_banner
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${response}=    get request    myssion    /hname-banner-rfs:hname-banner-rfs=${ser-device}/login-banner
    log    ${response.content}
    ${jsonresponse}=    to json    ${response.content}
    log    ${response.headers}
    ${status_list}=    get value from json    ${jsonresponse}    "hname-banner-rfs:login-banner"
    log    ${status_list}
    ${status}=    get from list    ${status_list}    0
    should be equal as strings    ${status}    test123-banner
    should be equal as strings    ${response.status_code}    200

update_service_hostname_banner
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${json_result}=    run process    python    /home/mallesha/robot/config_files/hostname_banner_update.py
    log    ${json_result.stdout}
    ${response}=    patch request    myssion    /    data=${json_result.stdout}
    log    ${response.content}
    should be equal as strings    ${response.status_code}    204

get_updated_service_device_hostname
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${response}=    get request    myssion    /hname-banner-rfs:hname-banner-rfs=${ser-device}/hostname
    log to console    ${response.content}
    ${jsonresponse}=    to json    ${response.content}
    log    ${response.headers}
    ${status_list}=    get value from json    ${jsonresponse}    "hname-banner-rfs:hostname"
    log    ${status_list}
    ${status}=    get from list    ${status_list}    0
    should be equal as strings    ${status}    test123-updated-hostname
    should be equal as strings    ${response.status_code}    200

get_updated_service_device_banner
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${response}=    get request    myssion    /hname-banner-rfs:hname-banner-rfs=${ser-device}/login-banner
    log    ${response.content}
    ${jsonresponse}=    to json    ${response.content}
    log    ${response.headers}
    ${status_list}=    get value from json    ${jsonresponse}    "hname-banner-rfs:login-banner"
    log    ${status_list}
    ${status}=    get from list    ${status_list}    0
    should be equal as strings    ${status}    test123-updated-banner
    should be equal as strings    ${response.status_code}    200

del_service
    sleep    60s
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${response}=    delete request    myssion    /hname-banner-rfs:hname-banner-rfs=${ser-device}/
    log    ${response.content}
    should be equal as strings    ${response.status_code}    204

*** Keywords ***
service-create
    ${headers}=    Create Dictionary    Content-Type    application/yang-data+json
    create session    myssion    ${baseurl_service}    headers=${headers}    auth=${login_auth}
    ${json_result}=    run process    python    /home/mallesha/robot/config_files/service_create.py
    log    ${json_result.stdout}
    ${response}=    post request    myssion    /    data=${json_result.stdout}
    should be equal as strings    ${response.status_code}    201
