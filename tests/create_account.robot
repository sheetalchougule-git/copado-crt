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
   
    # Create Account Record 
    ${my_account}=                         CreateRecord     Account                          Name=Rest Account Test
    Should Be Equal As Strings                              ${my_account}\[Name]              Rest Account Test            #validating the name match from my_account and the name we provided

    #Create contact
    ${my_contact}                          CreateRecord      Contact                         FirstName = Jane    LastName=Roberts      

    # Id is stored in these variables
    # Set these on suite level for reuse
    Set Suite Variable                     ${my_account}
    Set Suite Variable                     ${my_contact}
    
Get Record Create Account
    [Documentation]                        Retrive the record created
    [tags]                                 REST API                                        GET
    
    ${new_account}=                        GetRecord        Account                         ${my_account}
    Should Be Equal As Strings                              ${new_account}[Name]            Rest Account Test
    Log                                    ${new_account}

Get Contact Record using SOQl
    #Jane % = Starts with
    #%Jane = ends with
    # %Jane% = contains
    ${results}=                            QueryRecords      SELECT Id,FirstName,LastName FROM Contact WHERE Name LIKE 'Jane%'
    Log                                    ${results}

Verify from UI in salesforce
    [Documentation]                        Valdiate data created using REST API through UI
    [Tags]                                 Validation through UI

    Appstate                               Home
    LaunchApp                              Sales
    ClickText                              Contacts
    VerifyPageHeader                       Contacts
    VerifyText                             New
    VerifyText                             Jana Doe
    ClickText                              Jana Doe

    ClickText                              Details
    VerifyField                            Name                     Jana Doe
    VerifyField                            Email                    jana.doe@fake.com
    VerifyField                            Account Name             TestCorp123    tag=a

    # We'll take a screenshot to the log
    LogScreenshot