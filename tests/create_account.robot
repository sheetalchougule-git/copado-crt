*** Settings ***
Documentation            Use REst API to create new Account
Library                  QForce
Resource                 ../resources/common.resource
Suite Setup              Setup Browser
Suite Teardown           End suite


*** Variables ***
#${username}            # should be declard in CRT variables on suite level
#${login_url}           # should be declard in CRT variables on suite level
#${password}             # should be declard in CRT sensitive variables on suite level
#${client_id}             # should be declard in CRT sensitive variables on suite level
#${client_secret}         # should be declard in CRT sensitive variables on suite level


*** Test Cases ***
Create New Account via REST API
    [Documentation]        Create test account using REST API
    # Authenticate via client_id and client_secret from a connected oAuth app
    # in addition to user credential
    
    Authenticate           ${client_id}    ${client_secret}    ${username}    ${password}    sandbox=false