*** Settings ***
Library         SeleniumLibrary   implicit_wait=2
Library         OperatingSystem
Library         String
Force Tags      level:ui
Default Tags    type:positive
Suite Setup     Load Page Data
Test Teardown   Close Browser
Resource        ../../resources/data.resource
Resource        ../../resources/element.resource

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

TC-05 Interaction with radio form elements
  Given Bootstrap is opened  forms  checkboxes-and-radios
  Then Element Should Be Enabled  ${PAGE}[default_radio]
  And Element Should Be Disabled  ${PAGE}[disabled_radio]
  And Radio Button Should Be Set To  ${TEXTS}[radio_group]  option1
  # A radio button cannot be checked if selected
  # it is derived from the radio value
  # And Radio Button Should Not Be Selected  ${PAGE}[second_default_radio]
  When Click Element  ${PAGE}[second_default_radio]
  # A radio button cannot be checked if selected
  # it is derived from the radio value
  # Then Radio Button Should Not Be Selected  ${PAGE}[default_radio]
  Then Radio Button Should Be Set To  ${TEXTS}[radio_group]  option2

TC-06 Checking button form elements
  Given Bootstrap is opened  buttons  disabled-state
  Then Page Should Contain Button With Text  ${TEXTS}[primary_button]
  And Element Should Be Disabled  ${PAGE}[primary_button]
  When Page Is Scrolled Down By Page  ${1}
  Then Element Should Be Enabled  ${PAGE}[primary_link_button]

TC-07 Checking select form elements
  Given Bootstrap is opened  forms  form-controls
  Then Element Should Be Visible  ${PAGE}[example_select]
  And Element Should Be A Multi Select  ${PAGE}[example_multi_select]
  And List Selection Should Be  ${PAGE}[example_select]  1
  And List Should Not Have Option  ${PAGE}[example_select]  hello
  And List Should Have Option  ${PAGE}[example_select]  2
  When Select From List By Label  ${PAGE}[example_select]  2
  Then List Selection Should Be  ${PAGE}[example_select]  2
  And List Should Have Options  ${PAGE}[example_select]  5

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

