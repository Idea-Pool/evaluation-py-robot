# evaluation-py-robot

This repository contains tests implemented using the Robot Framework.

## Prerequisites

1. Python 3.8+
1. Pip

## Framework used

* Name: Robot Framework
* Home page: https://robotframework.org/
* User Guide: https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html
* Libraries: https://robotframework.org/?tab=libraries#resources
  * Standard libraries: http://robotframework.org/robotframework/#standard-libraries
  * robotframework-requests: https://github.com/MarketSquare/robotframework-requests
  * robotframework-jsonschemalibrary: https://github.com/jstaffans/robotframework-jsonschemalibrary
  * robotframework-selenium2library: https://github.com/robotframework/SeleniumLibrary
  * RESTinstance: https://github.com/asyrjasalo/RESTinstance/

## Test cases

The implemented test cases can be found in [UI.md](test_cases/UI.md) and [API.md](test_cases/API.md).

## Setup

```shell
pip install -r requirements.txt
webdrivermanager chrome
```

## Execution

```shell
robot test_cases
```