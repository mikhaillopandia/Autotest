require "selenium-webdriver"


def tc_01
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/'
  element = driver.find_element(link_text: 'Login')
  element.click
  driver.quit
end

def tc_02
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_key 'lopandya96@gmail.com'
  driver.find_element(name: 'user[password]').send_keys('lopandya96', :enter)
  driver
end

def tc_03_1
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_key('lopandya96@gmail.com')
  # driver.find_element(name: 'user[remember_me]').click
  # sleep 5
  # it doesn't work!
  driver.find_element(name: 'user[password]').send_keys('lopandya96')
  driver
end

def tc_03_2
  driver = tc_03_1
  driver.quit

  driver = tc_02
  l = driver.find_element(class: 'navbar-brand')
  l.click
  driver
end

def tc_03_3
  driver = tc_03_1
  # driver.find_element(xpath: "//*[@data-method= 'delete']").click
  # driver.find_element(link_text: "Logout").click
  # doesn't work!
  driver.quit
  driver = tc_02
  driver.find_element(class: 'navbar-brand').click
  driver.quit
end


def tc_04_1
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_keys('lopandya96@gmail.com', :enter)
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end

def tc_04_2
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[password]').send_keys('lopandya96', :enter)
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end

def tc_04_3
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end


def tc_05_1
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_key('FALSE@i.ua')
  driver.find_element(name: 'user[password]').send_keys('lopandya96', :enter)
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end

def tc_05_2
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_key('lopandya96@gmail.com')
  driver.find_element(name: 'user[password]').send_keys('FALSE', :enter)
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end

def tc_05_3
  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'http://demoapp.strongqa.com/users/sign_in'
  driver.find_element(name: 'user[email]').send_key('FALSE@i.ua')
  driver.find_element(name: 'user[password]').send_keys('FALSE', :enter)
  d = driver.find_element(id: 'flash_alert')
  puts !!d ? 'OK' : 'Fail'
  driver.quit
end

=begin
tc_01
tc_02
tc_03_1
tc_03_2
tc_03_3
tc_04_1
tc_04_2
tc_04_3
tc_05_1
tc_05_2
tc_05_3
=end

tc_01