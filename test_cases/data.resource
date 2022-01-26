*** Settings ***
Library         JSONLibrary

*** Keywords ***
Load Data
  [Arguments]  ${type}  ${id}
  ${json}=  Load JSON From File  ${EXECDIR}${/}data${/}${type}${/}${id}.json
  [Return]  ${json}
