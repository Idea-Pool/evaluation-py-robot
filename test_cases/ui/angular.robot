*** Settings ***
Library         SeleniumLibrary
Force Tags      level:ui
Default Tags    type:positive
Suite Setup     Load Page Data
Suite Teardown  Close Browser
Resource        ../data.resource

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
  And Wait Until Element Is Visible  ${PAGE}[title]
  Then Location Should Be  ${BASE_URL}/start
  And Element Text Should Be  ${PAGE}[title]  ${TEXTS}[getting_started_title]

*** Keywords ***
Angular.io is opened
  Open Browser  ${BASE_URL}  ${BROWSER}

Load Page Data
  ${selectors}=  Load Data  type=selectors  id=angular
  Set Suite Variable  ${PAGE}  ${selectors}
  ${texts}=  Load Data  type=texts  id=angular
  Set Suite Variable  ${TEXTS}  ${texts}
