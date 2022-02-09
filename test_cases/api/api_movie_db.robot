*** Settings ***
Library           RequestsLibrary
Library           JSONSchemaLibrary    schema
Library           Process
Force Tags        level:api
Default Tags      type:positive
Suite Setup       Run Keywords    Create A Guest Session
...               AND    Load Movie
Resource          ../../resources/data.resource

*** Variables ***
${API_KEY}        e231ae412af0eaab685d11c26505bda6
${BASE_URL}       https://api.themoviedb.org/3
${MOVIE}          Load JSON From File    data/movie/76341
${MOVIE_ID}       76341
${MOVIE_TITLE}    Mad Max: Fury Road

*** Test Cases ***
TC-01 A movie can be retrived by ID
    Get A Movie By ID    ${MOVIE}[id]    200

TC-02 The retrieved movie has a proper schema
    ${response}=    Get A Movie By ID    ${MOVIE}[id]
    Should Be Equal As Strings    ${MOVIE}[title]    ${response.json()}[title]
    Validate Json    movie.json    ${response.json()}

TC-03 A rating can be added to a movie
    [Template]  Rate A Movie
    FOR  ${rate}  IN RANGE  1  11
        ${MOVIE}[id]    ${rate}  201
    END

TC-04 The movie rating should return a proper message
    ${response}=    Rate A Movie    ${MOVIE}[id]    ${8.0}
    Should Be Equal As Strings    The item/record was updated successfully.    ${response.json()}[status_message]

TC-05 Invalid rating cannot be aded to a movie
    [Tags]    type:negative
    ${response}=    Rate A Movie    ${MOVIE}[id]    ${10.1}    400
    Should Be Equal As Strings    Value too high: Value must be less than, or equal to 10.0.
    ...    ${response.json()}[status_message]

TC-06 Movie rating can be deleted
    Rate A Movie    ${MOVIE}[id]    ${9}
    Delete Movie Rating    ${MOVIE}[id]    200

TC-07 Proper status message should be returned when rating is deleted
    Rate A Movie    ${MOVIE}[id]    ${9}
    ${response}=    Delete Movie Rating    ${MOVIE}[id]
    Should Be Equal As Strings    The item/record was deleted successfully.
    ...    ${response.json()}[status_message]

TC-08 Missing ID should be handled properly
    [Tags]    type:negative
    Get A Movie By ID    ${null}    404

*** Keywords ***
Get A Movie By ID
    [Arguments]    ${movie_id}    ${status}=200
    ${response}=    GET    ${BASE_URL}/movie/${movie_id}
    ...    params=api_key=${API_KEY}
    ...    expected_status=${status}
    [Return]    ${response}

Rate A Movie
    [Arguments]    ${movie_id}    ${rating}    ${status}=201
    &{params}=    Create Dictionary    api_key=${API_KEY}    guest_session_id=${GUEST_SESSION_ID}
    &{body}=    Create Dictionary    value=${rating}
    ${response}=    POST    ${BASE_URL}/movie/${movie_id}/rating
    ...    params=${params}
    ...    json=${body}
    ...    expected_status=${status}
    [Return]    ${response}

Delete Movie Rating
    [Arguments]    ${movie_id}    ${status}=200
    &{params}=    Create Dictionary    api_key=${API_KEY}    guest_session_id=${GUEST_SESSION_ID}
    ${response}=    DELETE    ${BASE_URL}/movie/${movie_id}/rating
    ...    params=${params}
    ...    expected_status=${status}
    [Return]    ${response}

Create A Guest Session
    ${response}=    GET    ${BASE_URL}/authentication/guest_session/new
    ...    params=api_key=${API_KEY}
    Set Suite Variable    ${GUEST_SESSION_ID}    ${response.json()}[guest_session_id]

Load Movie
    ${data}=    Load Data    type=movie    id=76341
    Set Suite Variable    ${MOVIE}    ${data}
