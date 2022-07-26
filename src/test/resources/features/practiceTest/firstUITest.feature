Feature: Demonstrating the UI Automation using Karate

  Scenario: To demonstrate the UI Automation using Karate
    Given driver "http://tek-school.com/retail/"
    And delay(2000)
    When input("//input[@name='search']", 'Camera')
    And click("//span//button[@type='button']")
    Then match driver.title == "Search - Camera"

