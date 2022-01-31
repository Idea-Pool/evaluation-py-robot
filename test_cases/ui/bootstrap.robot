*** Settings ***
Library         SeleniumLibrary   implicit_wait=2
Library         OperatingSystem
Library         String
Force Tags      level:ui
Default Tags    type:positive
Suite Setup     Load Page Data
Test Teardown   Close Browser
Resource        ../../resources/data.resource

*** Variables ***
${BASE_URL}     https://getbootstrap.com/docs/4.4
${BROWSER}      Chrome

*** Test Cases ***
TC-03 Checking form elements
  Given Bootstrap is opened  forms
  # There is some encoding issue with JSON file with the "·" character
  # Then Title Should Be  ${TEXTS}[forms_title]
  Then Title Should Be  Forms · Bootstrap
  And Element Should Not Be In View  ${PAGE}[readonly_input]
  When Scroll Element Into View  ${PAGE}[readonly_input]
  And Sleep  2s
  Then Element Should Be In View  ${PAGE}[readonly_input]
  And Element Should Be ReadOnly  ${PAGE}[readonly_input]

TC-04 Interaction with checkbox form elements
  Given Bootstrap is opened  forms  checkboxes-and-radios
  Then Element Should Be Enabled  ${PAGE}[default_checkbox]
  And Element Should Be Disabled  ${PAGE}[disabled_checkbox]
  And Checkbox Should Not Be Selected  ${PAGE}[default_checkbox]
  When Select Checkbox  ${PAGE}[default_checkbox]
  Then Checkbox Should Be Selected  ${PAGE}[default_checkbox]

*** Keywords ***
Bootstrap is opened
  [Arguments]  ${component}  ${hash}=${EMPTY}
  Open Browser  ${BASE_URL}/components/${component}/#${hash}  ${BROWSER}
  Maximize Browser Window

Load Page Data
  ${selectors}=  Load Data  type=selectors  id=bootstrap
  Set Suite Variable  ${PAGE}  ${selectors}
  ${texts}=  Load Data  type=texts  id=bootstrap
  Set Suite Variable  ${TEXTS}  ${texts}

Is Element In View
  [Arguments]  ${element}
  ${js}=          Get File    resources${/}is_in_viewport.js
  ${visible}=     execute javascript    ${js} return isInViewport(arguments[0]);    ARGUMENTS    ${element}
  [Return]        ${visible}

Element Should Be In View
  [Arguments]  ${element}
  ${visible}=  Is Element In View  ${element}
  Should Be True  ${visible}

Element Should Not Be In View
  [Arguments]  ${element}
  ${visible}=  Is Element In View  ${element}
  Should Not Be True  ${visible}

Element Should Be ReadOnly
  [Arguments]  ${element}
  ${readonly}=  Get Element Attribute  ${element}  readonly
  Should Be Equal  ${readonly}  true