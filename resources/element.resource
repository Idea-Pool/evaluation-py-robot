*** Settings ***
Library         SeleniumLibrary   implicit_wait=2
Library         OperatingSystem
Library         String
Library         Collections

*** Keywords ***
Is Element In View
  [Arguments]  ${element}
  ${js}=  Get File  resources${/}is_in_viewport.js
  ${visible}=  Execute JavaScript  ${js} return isInViewport(arguments[0]);  ARGUMENTS  ${element}
  [Return]  ${visible}

Page Is Scrolled Down By Page
  [Arguments]  ${n}=1
  ${js}=  Get File  resources${/}scroll_by_page.js
  Execute JavaScript  ${js} scrollByPage(arguments[0]);  ARGUMENTS  ${n}

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

Page Should Contain Button With Text
  [Arguments]  ${text}
  ${selector}=  Replace String  xpath://button[normalize-space(.)="TEXT"]  TEXT  ${text}
  Element Should Be Visible  ${selector}

Element Should Be A Multi Select
  [Arguments]  ${element}
  ${multiple}=  Get Element Attribute  ${element}  multiple
  Should Be Equal  ${multiple}  true

List Should Have Option
  [Arguments]  ${list}  ${text}
  ${labels}=  Get List Items  ${list}
  List Should Contain Value  ${labels}  ${text}

List Should Not Have Option
  [Arguments]  ${list}  ${text}
  ${labels}=  Get List Items  ${list}
  List Should Not Contain Value  ${labels}  ${text}

List Should Have Options
  [Arguments]  ${list}  ${n}=1
  ${labels}=  Get List Items  ${list}
  ${l}=  Get Length  ${labels}
  Should Be Equal As Integers  ${l}  ${n}