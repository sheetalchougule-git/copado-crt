*** Settings ***

Documentation           Example on how to use QForce REST API keywords
Library                 QForce
Library                 QWeb

*** Variables ***
${BROWSER}                chrome
${mfa}                    ${FALSE}                # True -> Run with App authentication.


*** Keywords ***
Setup Browser
    Open Browser          about:blank                 ${BROWSER}
    SetConfig             LineBreak                   ${EMPTY}               #\ue000
    SetConfig             DefaultTimeout              30s                    #sometimes salesforce is slow
    SetConfig             CSSSelectors                False    

End suite
    Close All Browsers


Login
    [Documentation]      Login to Salesforce instance
    GoTo                 ${login_url}
    TypeText             Username                    ${username}
    TypeSecret           Password                    ${password}
    ClickText            Log In
    Run Keyword If       ${mfa}                      Fill MFA


Fill MFA
    ${mfa_code}=         GetOTP    ${username}   ${secret}   ${login_url}    
    TypeSecret           Verification Code       ${mfa_code}      
    ClickText            Verify 


Home
    GoTo                 ${login_url}lightning/page/home  
    ${login_status} =    IsText                      To access this page, you have to log in to Salesforce.    2
    Run Keyword If       ${login_status}             Login            
    ClickText            Home
    VerifyTitle          Home | Salesforce