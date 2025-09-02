*** Settings ***
Library            QForce                #For using REST API, use the QForce library's REST API keywprds.
Library            DataDriver            reader_class=TestDataApi    name=Leads_New.xlsx
Resource           ../resources/common.resource

Suite Setup       Open Browser            about:blank                 Chrome
Suite Teardown    Close All Browsers
Test Template     Create Lead with REST API

*** Test Cases ***
Create Lead with ${last_name} ${first_name} ${salutation}

*** Keywords ***
Create Lead with REST API
    [Arguments]    ${last_name}    ${first_name}    ${salutation}    ${company}    ${phone}    ${email}    ${lead_status}
    # Your tests here, this is just an example
    # just use the values from excel using variable names
    # ClickText     ${last_name}
    # VerifyText    ${first_name}
    # VerifyText    ${salutation}
    # VerifyText    ${company}
    # VerifyText    ${phone}

    Authenticate    ${client_id}     ${client_secret}     ${username}      ${password}      sandbox=false 
    ${new_lead}=    CreateRecord     Lead                 LastName=${last_name}
                    ...                                   FirstName=${first_name}    
                    ...                                   salutation=${salutation}
                    ...                                   Company=${company}
                    ...                                   Email=${email}
                    ...                                   ProductInterest__c=Sales Cloud Implementation

    Log             ${new_lead}                           console=true      

    Revoke           

  