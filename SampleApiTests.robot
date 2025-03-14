*** Settings ***
Documentation     Resource provides keywords to work with REST web services. Implementation is based on RequestsLibrary.
Library           RequestsLibrary
Suite Setup       Create Session    PostmanSession    https://postman-echo.com    verify=True
Suite Teardown    Teardown REST

*** Test Cases ***
Simple Get
    ${resp}=    Do GET    PostmanSession    /get

Simple Post
    ${resp}=    Do POST    PostmanSession    /post    {test}

Simple Put
    ${resp}=    Do PUT    PostmanSession    /put    {test}

Simple Delete
    ${resp}=    Do DELETE    PostmanSession    /delete

*** Keywords ***
Teardown REST
    [Documentation]    Deletes all sessions that were opened by RequestsLibrary.
    Delete All Sessions

Do GET
    [Arguments]    ${session}    ${uri}    ${interruptonfail}=True    ${headers}=${None}
    [Documentation]    Sends HTTP GET request and returns object that represents server response.
    ...
    ...    _session_ alias of opened RequestsLibrary session.
    ...
    ...    _uri_ identifier of the resource where to send request.
    ...
    ...    _interruptonfail_ optional parameter, if equals True keyword will fail if response status is not equal to 200.
    ...
    ...    _headers_ optional parameter to send list of HTTP headers.
    ...
    ...    Returns _resp_ object that represents server response. E.g. _resp.status_code_ is the status of request execution and _resp.content_ is the body of response.
    ...
    ...    Example:
    ...    Assume Restful web service with URL https://postman-echo.com has /get resource
    ...
    ...    If you want to get info and continue the test only in case request was successful:
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do GET | APISession | /get |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ...    If you want to get info and continue the test even if request was unsuccessful (e.g. print response and do manual error handling):
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do GET | APISession | /get | False |
    ...    | Should Be Equal As Strings | ${resp.status_code} | 200 |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ${resp}=    Get On Session    alias=${session}    url=${uri}    headers=${headers}
    Log    ${resp.content}
    Run Keyword If    '${interruptonfail}' == 'True'    Should Be Equal As Strings    ${resp.status_code}    200    Do GET: request has failed with status code <${resp.status_code}> and response <${resp.content}>.    False
    RETURN    ${resp}

Do POST
    [Arguments]    ${session}    ${uri}    ${body}    ${interruptonfail}=True    ${headers}=${None}
    [Documentation]    Sends HTTP POST request and returns object that represents server response.
    ...
    ...    _session_ alias of opened RequestsLibrary session.
    ...
    ...    _uri_ identifier of the resource where to send request.
    ...
    ...    _body_ request body to be sent.
    ...
    ...    _interruptonfail_ optional parameter, if equals True keyword will fail if response status is not equal to 200.
    ...
    ...    _headers_ optional parameter to send list of HTTP headers.
    ...
    ...    Returns _resp_ object that represents server response. E.g. _resp.status_code_ is the status of request execution and _resp.content_ is the body of response.
    ...
    ...    Example:
    ...    Assume RESTful web service with URL https://postman-echo.com has /post resource.
    ...
    ...    If you want to create new customer and continue the test only in case request was successful:
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do POST | APISession | /post | test message |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ...    If you want to create new customer and continue the test even if request was unsuccessful (e.g. print response and do manual error handling):
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do POST | APISession | /post | test message | False |
    ...    | Should Be Equal As Strings | ${resp.status_code} | 200 |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    Log    ${body}
    ${resp}=    Post On Session    alias=${session}    url=${uri}    data=${body}    headers=${headers}
    Log    ${resp.content}
    Run Keyword If    '${interruptonfail}' == 'True'    Should Be Equal As Strings    ${resp.status_code}    200    Do POST: request has failed with status code <${resp.status_code}> and response <${resp.content}>.    False
    RETURN    ${resp}

Do PUT
    [Arguments]    ${session}    ${uri}    ${body}    ${interruptonfail}=True    ${headers}=${None}
    [Documentation]    Sends HTTP PUT request and returns object that represents server response.
    ...
    ...    _session_ alias of opened RequestsLibrary session.
    ...
    ...    _uri_ identifier of the resource where to send request.
    ...
    ...    _body_ request body to be sent.
    ...
    ...    _interruptonfail_ optional parameter, if equals True keyword will fail if response status is not equal to 200.
    ...
    ...    _headers_ optional parameter to send list of HTTP headers.
    ...
    ...    Returns _resp_ object that represents server response. E.g. _resp.status_code_ is the status of request execution and _resp.content_ is the body of response.
    ...
    ...    Example:
    ...    Assume RESTful web service with URL https://postman-echo.com has /put resource, which supports PUT request with XML body to create new entity.
    ...
    ...    If you want to create new entity and continue the test only in case request was successful:
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${xml}= | Set Variable | <request><firstname>Captain</firstname><lastname>America</lastname></request> |
    ...    | ${resp}= | Do PUT | APISession | /put | ${xml} |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ...    If you want to create new entity and continue the test even if request was unsuccessful (e.g. print response and do manual error handling):
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${xml}= | Set Variable | <request><firstname>Captain</firstname><lastname>America</lastname></request> |
    ...    | ${resp}= | Do PUT | APISession | /put | ${xml} | False |
    ...    | Should Be Equal As Strings | ${resp.status_code} | 200 |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    Log    ${body}
    ${resp}=    Put On Session    alias=${session}    url=${uri}    data=${body}    headers=${headers}
    Log    ${resp.content}
    Run Keyword If    '${interruptonfail}' == 'True'    Should Be Equal As Strings    ${resp.status_code}    200    Do PUT: request has failed with status code <${resp.status_code}> and response <${resp.content}>.    False
    RETURN    ${resp}

Do DELETE
    [Arguments]    ${session}    ${uri}    ${interruptonfail}=True    ${headers}=${None}
    [Documentation]    Sends HTTP DELETE request and returns object that represents server response.
    ...
    ...    _session_ alias of opened RequestsLibrary session.
    ...
    ...    _uri_ identifier of the resource where to send request.
    ...
    ...    _interruptonfail_ optional parameter, if equals True keyword will fail if response status is not equal to 200.
    ...
    ...    _headers_ optional parameter to send list of HTTP headers.
    ...
    ...    Returns _resp_ object that represents server response. E.g. _resp.status_code_ is the status of request execution and _resp.content_ is the body of response.
    ...
    ...    Example:
    ...    Assume RESTful web service with URL https://postman-echo.com has /delete resource, which supports DELETE request to deletes entity.
    ...
    ...    If you want to delete entity and continue the test only in case request was successful:
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do DELETE | APISession | /delete |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ...    If you want to delete entity and continue the test even if request was unsuccessful (e.g. print response and do manual error handling):
    ...    | Create Session | APISession | https://postman-echo.com |
    ...    | ${resp}= | Do DELETE | APISession | /delete | False |
    ...    | Should Be Equal As Strings | ${resp.status_code} | 200 |
    ...    | Log | ${resp.content} |
    ...    | Teardown REST |
    ${resp}=    Delete On Session    alias=${session}    url=${uri}    headers=${headers}
    Log    ${resp.content}
    Run Keyword If    '${interruptonfail}' == 'True'    Should Be Equal As Strings    ${resp.status_code}    200    Do DELETE: request has failed with status code <${resp.status_code}> and response <${resp.content}>.    False
    RETURN    ${resp}
