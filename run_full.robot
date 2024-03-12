*** Settings ***
Library     AppiumLibrary
Library     String
Library     Collections


*** Variables ***
${user}                         duc.hoc.automation@gmail.com
${password}                     123456zz
${btn_quick_add}                com.todoist:id/fab
${inp_task_name}                android:id/message
${inp_task_description}         com.todoist:id/description
${btn_choose_schedule}          com.todoist:id/schedule
${inp_schedule_input}           com.todoist:id/scheduler_input
${btn_submit_schedule}          com.todoist:id/scheduler_input_submit
${btn_more_signin_options}      com.todoist:id/more_sign_in_options
${btn_signin_by_email}          com.todoist:id/email_login
${inp_signin_form_email}        //android.widget.EditText[@resource-id="email"]
${inp_signin_form_password}     //android.widget.EditText[@resource-id="password"]
${btn_signin}                   //android.view.View[@resource-id="auth_button_tag"]
${btn_inbox_page}               //android.widget.TextView[@text="Inbox"]
${btn_submit_task}              //android.widget.ImageView[@content-desc="Add"]
${btn_set_task_due_date}        //android.widget.TextView[@text="Due date"]
${btn_current_day}              //android.view.View[@content-desc="dd MMMM yyyy selected"]
${var_timeout_30s}              30
${txt_date}                     Sun Feb 18 · 1 task due
${label_multi_tasks}            //android.widget.TextView[@resource-id="com.todoist:id/text"]
${label_tab_inbox}              //android.view.ViewGroup[@resource-id="com.todoist:id/toolbar"]/android.widget.TextView[@text="Inbox"]


*** Test Cases ***
Simple Follow
    Open App Todoist
    Signing With Email By Data    ${user}    ${password}
    Add Task

TC2-Mark_Done_Task
    Open App Todoist
    Signing With Email By Data    ${user}    ${password}
    Common - Click Element    ${btn_inbox_page}
    sleep    1s
    WAIT UNTIL ELEMENT IS VISIBLE    ${label_tab_inbox}    ${var_timeout_30s}
    Mark Done Task    Choi bong ban


*** Keywords ***
Common - Click Element
    [Arguments]    ${element_locator}
    wait until element is visible    ${element_locator}    ${var_timeout_30s}
    click element    ${element_locator}

Common - Input Element
    [Arguments]    ${element_locator}    ${data_input}
    wait until element is visible    ${element_locator}    ${var_timeout_30s}
    input text    ${element_locator}    ${data_input}

Common - Press Back Button
    press keycode    4

Open App Todoist
    open application    http://192.168.1.201:4723    platformName=Android
    ...    appium:appPackage=com.todoist
    ...    appium:appActivity=com.todoist.alias.HomeActivityDefault    appium:automationName=UiAutomator2
    ...    appium:noReset=false    appium:allowPermission=true

Signing With Email By Data
    [Arguments]    ${data_username}    ${data_password}
    Common - Click Element    ${btn_more_signin_options}
    Common - Click Element    ${btn_signin_by_email}
    Common - Input Element    ${inp_signin_form_email}    ${data_username}
    Common - Input Element    ${inp_signin_form_password}    ${data_password}
    Common - Click Element    ${btn_signin}
    sleep       5s
    hide keyboard
Add Task
    Common - Click Element    ${btn_inbox_page}
    Common - Click Element    ${btn_quick_add}
    Common - Input Element    ${inp_task_name}    Day som doc sach
    Common - Click Element    ${btn_choose_schedule}
    Set Due Date
    sleep       2s
    Common - Click Element    ${btn_submit_task}
    Common - Press Back Button

Set Due Date
    Common - Click Element    ${btn_current_day}
    Common - Click Element    ${inp_schedule_input}
    Common - Input Element    ${inp_schedule_input}    Mar 20
    Common - Click Element    ${btn_submit_schedule}

Mark Done Task
    [Arguments]    ${task_need_mark_done}
    wait until keyword succeeds    3x    1s    Get available Task On Current Screen    ${task_need_mark_done}

Get available Task On Current Screen
    [Arguments]    ${task_need_mark_done}
    @{list_tasks}    Get Webelements    ${label_multi_tasks}
    ${len_list}    Get Length    ${list_tasks}
    FOR    ${MyItem}    IN RANGE    ${1}    ${len_list + 1}
        ${text_task_get_from_app}    get text
        ...    xpath=(//android.widget.TextView[@resource-id="com.todoist:id/text"])[${MyItem}]
        ${check_tasks}    run keyword and return status
        ...    should be equal
        ...    ${text_task_get_from_app}
        ...    ${task_need_mark_done}
        IF    ${check_tasks}
            Common - Click Element    xpath=(//android.widget.CheckBox[@content-desc="Complete"])[${MyItem}]
            BREAK
        END
    END
    IF    not ${check_tasks}
        Swipe By Percent    50    80    50    20    duration=300
        sleep    5s
    END
    should be true    ${check_tasks}
