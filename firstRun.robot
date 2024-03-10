*** Settings ***
Library     AppiumLibrary

*** Keywords ***
Custom Keyword - Click Element
    [Arguments]     ${element_locator}
    AppiumLibrary.wait until element is visible     ${element_locator}
    AppiumLibrary.click element    ${element_locator}

Open App Todoist
    AppiumLibrary.open application    http://192.168.1.201:4723    platformName=Android
    ...    appium:appPackage=com.todoist
    ...    appium:appActivity=com.todoist.alias.HomeActivityDefault    appium:automationName=UiAutomator2
    ...    appium:noReset=false    appium:allowPermission=true

Custom Keyword - Login Successfully
    Open App Todoist
    Custom Keyword - Click Element      ${button_login}
    Custom Keyword - Click Element      ${inp_username}




*** Variables ***
${rc}       9
*** Test Cases ***
Example
    RUN KEYWORD IF       ${rc} > 0       log to console         Positive keyword
                          ...    ELSE IF     ${rc} == 0         log to console         Zero keyword
                          ...    ELSE       log to console         Negative keyword



*** Variables ***
${txt_app_name}     Todoist
${button_login}     abc
${inp_username}     cdv