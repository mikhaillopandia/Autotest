require 'rubygems'
require 'capybara'
require 'capybara/dsl'
include Capybara::DSL

Capybara.run_server = false
Capybara.current_driver = :selenium_chrome
Capybara.app_host = 'http://demoapp.strongqa.com/'

def tc_01
  visit('/')
  click_link('Login')
end

def tc_02
  visit('/users/sign_in')
  fill_in('user[email]', :with => 'lopandya96@gmail.com')
  fill_in('user[password]', :with => 'lopandya96').send_keys(:return)
  page
end


def tc_03_1
  visit('/users/sign_in')
  click_link('Login')
  fill_in('user[email]', :with => 'lopandya96@gmail.com')
  fill_in('user[password]', :with => 'lopandya96')
  check('user[remember_me]').send_keys(:return)
  page
end

def tc_03_2
  page = tc_03_1
  page.driver.quit
  page = tc_02
  click_link('Home')
end

def tc_03_3
  page = tc_03_1
  click_link('Logout')
  page.driver.quit
  page = tc_02
  click_link('Home')
end

def tc_04_1
  visit('/users/sign_in')
  fill_in('user[email]', :with => 'lopandya96@gmail.com').send_keys(:return)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
end

def tc_04_2
  visit('/users/sign_in')
  fill_in('user[password]', :with => 'lopandya96').send_keys(:return)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
end

def tc_04_3
  visit('/users/sign_in')
  fill_in('user[password]', with: '').send_keys(:enter)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
end

def tc_05_1
  visit('/users/sign_in')
  fill_in('user[email]', :with => 'FASLE@i.ua')
  fill_in('user[password]', :with => 'lopandya96').send_keys(:return)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
end

def tc_05_2
  visit('/users/sign_in')
  fill_in('user[email]', :with => 'lopandya96@gmail.com')
  fill_in('user[password]', :with => 'FALSE').send_keys(:return)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
end

def tc_05_3
  visit('/users/sign_in')
  fill_in('user[email]', :with => 'FASLE@i.ua')
  fill_in('user[password]', :with => 'FALSE').send_keys(:return)
  d = find(:xpath, ".//div[@id = 'flash_alert']")
  puts !!d ? 'OK' : 'Fail'
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

tc_05_3
sleep 5