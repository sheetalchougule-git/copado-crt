*** Settings ***
Resource    ../resources/common.resource
Library    QForce
Library    DataDriver    reader_class=TestDataApi    name=Leads__1_.xlsx


Suite Setup       Open Browser        about:blank     Chrome
Suite Teardown    Close All Browsers
Test Template     Test Data with REST API

*** Variables ***
#${username}                     # SHOULD BE GIVEN IN CRT VARIABLES SECTION
#${login_url}                    # SHOULD BE GIVEN IN CRT VARIABLES SECTION
#${password}                     # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION
#${client_id}                    # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION
#${client_secret}                # SHOULD BE GIVEN IN CRT SENSITIVE VARIABLES SECTION

*** Test Cases ***
Example Test with ${last_name} ${first_name} ${salutation}

*** Keywords ***
Test Data with REST API
    [Arguments]    ${last_name}    ${first_name}    ${salutation}    ${company}    ${phone}    ${email}    ${lead_status}
    # Your tests here, this is just an example
    # just use the values from excel using variable names
    # ClickText     ${last_name}
    # VerifyText    ${first_name}
    # VerifyText    ${salutation}
    # VerifyText    ${company}
    # VerifyText    ${phone}

    # --------------------------NOTE-------------------------------------------------------- 
    # Authentication needs to be done once prior to using other REST API keywords
    # For authentication a client_id and client secret from a Connected oauth app are needed
    # in addition to test user's credentials     
    # --------------------------------------------------------------------------------------           
    Authenticate                ${client_id}                ${client_secret}    ${sfdc_username}           ${sfdc_password}     sandbox=false 
  
    # --------------------------NOTE--------------------------------------------------------
    # For creating data, just use keyword "Create Record" with data type you want to
    # create + fields and values
    # --------------------------------------------------------------------------------------
    # To see what data is available for object (Lead), get one known id and check
    # the returned data
    #${my_lead}=    Get Record    Lead    00Q5E000008uv5kUAA
    # Log           ${my_lead}
    ${new_lead}=    CreateRecord  Lead    LastName=${last_name}
                    ...                   FirstName=${first_name}
                    ...                   Salutation=${salutation}
                    ...                   Company=${company}
                    ...                   Email=${email}



    Log           ${new_lead}             console=True

    Revoke