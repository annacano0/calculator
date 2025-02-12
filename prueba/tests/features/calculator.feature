Feature: Calculator

Background:
Given a user opens the app

Scenario: Default display screen
Then the display should show the following value: "0"

Scenario Outline: Pressing non-operators screen buttons
Given the display shows the following value: "<displayNumber>"
When the user presses the "<button>" button
Then the display should show the following value: "<displayResult>"

Examples:
| displayNumber | button | displayResult |	
|             1 |      0 |            10 |
|             0 |      1 |             1 |
|             0 |      2 |             2 |
|             0 |      3 |             3 |
|             0 |      4 |             4 |
|             0 |      5 |             5 |
|             0 |      6 |             6 |
|             0 |      7 |             7 |
|             0 |      8 |             8 |
|             0 |      9 |             9 |
|             0 |      . |            0. |
|             1 |      C |             0 |
|             1 |     +- |            -1 |
|            -1 |     +- |             1 |


Scenario Outline: Writing numbers 
Given the display shows the following value: "<displayNumber>"
When the user presses the "<button>" button
Then the display should show the following value: "<displayResult>"

Examples:
| displayNumber | button | displayResult |
|             0 |      0 |             0 | 
|             7 |      0 |            70 |
|             0 |      1 |             1 |
|           123 |      4 |          1234 |
|          1234 |      8 |         12348 |
|             0 |      . |            0. |
|          1234 |      . |         1234. |
|         1234. |      1 |        1234.1 |
|        1234.1 |      . |        1234.1 |
|             0 |     +- |             0 |
|            0. |     +- |            0. |
|           13. |     +- |           13. |
|          -0.5 |     +- |           0.5 |
|           0.5 |     +- |          -0.5 |
|             7 |     +- |            -7 |
|          1234 |     +- |         -1234 |
|         -1234 |     +- |          1234 |

Scenario Outline: Writing numbers of more than 9 digits
Given the display shows the following value: "<displayNumber>"
When the user presses the "<button>" button
Then the display should show the following value: "<displayResult>"

Examples:
| displayNumber | button | displayResult |
|     123456789 |      7 |     123456789 |
|     123456789 |     +- |     123456789 |
|     123456789 |      . |     123456789 |
|     123456789 |      . |     123456789 |
|     12345678. |      5 |     12345678. |
|     1234567.5 |     +- |     1234567.5 |

Scenario Outline: Performing two number operations
Given the display shows the following value: "<displayNumber>"
And the user presses the "<button>" button
And the user writes the number: "<userNumber>"
When the user presses the "=" button                             
Then the display should show the following value: "<displayResult>"

Examples:
| displayNumber | button | userNumber | displayResult |
|            24 |      + |          6 |            30 |
|          24.2 |      + |        6.4 |          30.6 |
|            10 |      + |         -5 |             5 |
|           -20 |      + |         10 |           -10 |
|            24 |      - |          6 |            18 |
|             6 |      - |         24 |           -18 |
|             6 |      - |        -24 |            30 |
|         13.14 |      - |      2.781 |        10.359 |
|            10 |      * |          8 |            80 |
|           5.2 |      * |          8 |          41.6 |
|         36.25 |      * |      7.496 |        271.73 |
|            10 |      * |         -8 |           -80 |
|           -10 |      * |         -8 |            80 |
|           -10 |      * |          8 |           -80 |
|            10 |      / |          2 |             5 |
|            84 |      / |        4.3 |     19.534883 |
|         23.58 |      / |      10.14 |     2.3254437 |
|            10 |      / |         -2 |            -5 |
|           -10 |      / |          2 |            -5 |
|           -10 |      / |         -2 |             5 |

Scenario Outline: Before clicking the equal button
Given the display shows the following value: "<displayNumber>"
And the user presses the "<button>" button
When the user writes the number: "<userNumber>"                    
Then the display should show the following value: "<userNumber>"

Examples:
| displayNumber | button | userNumber |
|            24 |      + |          6 |
|          24.2 |      - |        6.4 |
|         13.14 |      * |      2.781 |
|            84 |      / |       -4.3 |

Scenario Outline: Performing two number operations with a result number with more than 9 nondecimal digits
Given the display shows the following value: "<displayNumber>"
And the user presses the "<button>" button
And the user writes the number: "<userNumber>"     
When the user presses the "=" button
Then the display should show the following value: "ERROR"

Examples:
| displayNumber | button | userNumber |
|     999999999 |      + |          1 |
|            -1 |      - |  999999999 |
|     999999999 |      * |          2 |
|     999999999 |      / |        0.1 |

Scenario: Clicking the C button
Given the display shows the following value: "123"
When the user presses the "C" button
Then the display should show the following value: "0"

Scenario Outline: Clicking two different operation buttons
Given the display shows the following value: "<displayNumber>"
And the user presses the "<button>" button
And the user presses the "<button2>" button
And the user writes the number: "<userNumber>"
When the user presses the "=" button
Then the display should show the following value: "<displayResult>"

Examples:
| displayNumber | button | button2 | userNumber | displayResult |
|            12 |      + |       / |          6 |             2 |
|          1234 |      - |       + |         31 |          1265 |
|          9.26 |      * |       * |       2.15 |        19.909 |


Scenario Outline: Division with 0
Given the display shows the following value: "<displayNumber>"
And the user presses the "/" button
And the user writes the number: "0"
When the user presses the "=" button
Then the display should show the following value: "ERROR"

Examples:
| displayNumber |
|             1 |
|            -1 |
|             0 |

@current
Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "+" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be disabled
And the "-" button should be enabled
And the "*" button should be enabled
And the "/" button should be enabled
And the "=" button should be enabled

Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "-" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be disabled
And the "*" button should be enabled
And the "/" button should be enabled
And the "=" button should be enabled

Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "-" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be disabled
And the "*" button should be enabled
And the "/" button should be enabled
And the "=" button should be enabled

Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "*" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be enabled
And the "*" button should be disabled
And the "/" button should be enabled
And the "=" button should be enabled

Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "<button>" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be enabled
And the "*" button should be enabled
And the "/" button should be enabled

Examples:
|button|
|   C  |

Scenario Outline: Reenabling buttons with no error
Given the display shows the following value: "123456789"
When the user presses the "<button>" button
Then the "0" button should be enabled
And the "+-" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be enabled
And the "*" button should be enabled
And the "/" button should be enabled

Examples:
|   =  |

Scenario Outline: Disabling buttons
Given the display shows the following value: "<displayNumber>"
Then the "0" button should be disabled
And the "1" button should be disabled
And the "2" button should be disabled
And the "3" button should be disabled
And the "4" button should be disabled
And the "5" button should be disabled
And the "6" button should be disabled
And the "7" button should be disabled
And the "8" button should be disabled
And the "9" button should be disabled
And the "." button should be disabled

Examples:
| displayNumber |
|     123456789 |
|     -12345678 |
|     1234567.5 |
|     -123456.5 |

Scenario: Disabling the second comma
Given the display shows the following value: "3.141592"
Then the "." button should be disabled

Scenario: Reenabling buttons with error
Given the display shows the following value: "1"
And the user presses the "/" button
And the user writes the number: "0"
And the user presses the "=" button
When the user presses the "C" button
Then the "0" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be enabled
And the "+" button should be enabled
And the "-" button should be enabled
And the "*" button should be enabled
And the "/" button should be enabled
And the "+-" button should be enabled
And the "=" button should be enabled
And the "C" button should be enabled

Scenario: Blocking buttons after entering a comma
Given the display shows the following value: "1"
When the user presses the "." button
Then the "0" button should be enabled
And the "1" button should be enabled
And the "2" button should be enabled
And the "3" button should be enabled
And the "4" button should be enabled
And the "5" button should be enabled
And the "6" button should be enabled
And the "7" button should be enabled
And the "8" button should be enabled
And the "9" button should be enabled
And the "." button should be disabled
And the "+" button should be disabled
And the "-" button should be disabled
And the "*" button should be disabled
And the "/" button should be disabled
And the "+-" button should be disabled
And the "=" button should be disabled
And the "C" button should be enabled
