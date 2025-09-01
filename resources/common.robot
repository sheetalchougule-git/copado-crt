*** Settings ***
Library                   QWeb
Library                   QForce
Library                   String


*** Variables ***
${home_url}               ${sfdc_login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    Set Library Search Order                          QWeb                   QForce
    Open Browser          about:blank                 chrome
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              20s                    #sometimes salesforce is slow


End suite
    Set Library Search Order                          QWeb                   QForce
    Close All Browsers


Login
    [Documentation]       Login to Salesforce instance
    Set Library Search Order                          QWeb                   QForce
    GoTo                  ${sfdc_login_url}
    TypeText              Username                    ${sfdc_username}             delay=1
    TypeText              Password                    ${sfdc_password}
    ClickText             Log In

Logout From Salesforce
    [Documentation]    Logs out from the current Salesforce session
    # Click on the user profile/avatar icon in the top right corner
    ClickText           View profile
    
    # Click on the Logout option from the dropdown menu
    ClickText           Log Out

Home
    [Documentation]       Navigate to homepage, login if needed
    Set Library Search Order                          QWeb                   QForce
    GoTo                  ${home_url}
    ${login_status} =     IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If        ${login_status}             Login
    ClickText             Home
    VerifyTitle           Home | Salesforce