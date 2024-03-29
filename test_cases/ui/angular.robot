*** Settings ***
Library         SeleniumLibrary
Library         String
Force Tags      level:ui
Default Tags    type:positive
Suite Setup     Load Page Data
Test Teardown   Close Browser
Resource        ../../resources/data.resource

*** Variables ***
${BASE_URL}     https://angular.io
${BROWSER}      Chrome

*** Test Cases ***
TC-01 Checking landing page elements
  Given Angular.io is opened
  Then Element Should Be Visible  ${PAGE}[angular_logo_navbar]
  And Element Should Be Visible  ${PAGE}[angular_logo_hero]
  And Element Text Should Be  ${PAGE}[hero_text]  ${TEXTS}[hero]
  And Element Should Be Visible  ${PAGE}[hero_button]
  When Click Element  ${PAGE}[hero_button]
  And Sleep    1s
  And Wait Until Element Is Visible  ${PAGE}[title]
  Then Location Should Be  ${BASE_URL}/quick-start
  And Element Text Should Be  ${PAGE}[title]  ${TEXTS}[getting_started_title]

TC-02 Checking search field on the landing page
  Given Angular.io is opened
  Then Element Should Be Visible  ${PAGE}[search_input]
  And Element Text Should be  ${PAGE}[search_input]  ${EMPTY}
  And Element Attribute Value Should Be  ${PAGE}[search_input]  placeholder  Search
  When Click Element  ${PAGE}[search_input]
  And Input Text  ${PAGE}[search_input]  directive
  # And Click Element  ${PAGE}[search_input]
  Then Element Should Be Visible  ${PAGE}[search_clear_icon]
  And Menu Item Should Be In Section  ${TEXTS}[item]  ${TEXTS}[section]
  When Menu Item Is Clicked In Section  ${TEXTS}[item]  ${TEXTS}[section]
  Then Location Should Be  ${BASE_URL}/api/core/${TEXTS}[item]
  And Sleep    1s
  And Wait Until Element Is Visible  ${PAGE}[title]
  And Element Text Should Be  ${PAGE}[title]  ${TEXTS}[item]

*** Keywords ***
Angular.io is opened
  Open Browser  ${BASE_URL}  ${BROWSER}
  Maximize Browser Window

Load Page Data
  ${selectors}=  Load Data  type=selectors  id=angular
  Set Suite Variable  ${PAGE}  ${selectors}
  ${texts}=  Load Data  type=texts  id=angular
  Set Suite Variable  ${TEXTS}  ${texts}

Menu Item Should Be In Section
  [Arguments]  ${item}  ${section}
  Wait Until Element Is Visible  ${PAGE}[search_results]
  ${section_selector}=  Replace String  ${PAGE}[section_by_text]  TEXT  ${section}
  Wait Until Element Is Visible  ${section_selector}
  ${item_selector}=  ReplaceString  ${PAGE}[item_by_text]  TEXT  ${item}
  Element Should Be Visible  ${section_selector} >> ${item_selector}

Menu Item Is Clicked In Section
  [Arguments]  ${item}  ${section}
  Wait Until Element Is Visible  ${PAGE}[search_results]
  ${section_selector}=  Replace String  ${PAGE}[section_by_text]  TEXT  ${section}
  Wait Until Element Is Visible  ${section_selector}
  ${item_selector}=  ReplaceString  ${PAGE}[item_by_text]  TEXT  ${item}
  Click Element  ${section_selector} >> ${item_selector}
  Wait Until Location Contains  ${item}