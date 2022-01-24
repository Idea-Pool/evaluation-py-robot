*** Settings ***
Library           RequestsLibrary

*** Test Cases ***
Quick get request
    ${response}=    GET    http://www.google.com
    Status Should Be    201    ${response}
