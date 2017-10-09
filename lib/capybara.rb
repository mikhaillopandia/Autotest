require 'capybara/dsl'
include Capybara::DSL

Capybara.run_server = false
Capybara.current_driver = :selenium_chrome
Capybara.app_host = 'http://demoapp.strongqa.com/'

def test_case(ref, name)
  puts "**#{ref} - #{name}"
  yield
rescue StandardError => e
  puts "[FAILED] #{e.message}"
ensure
  page.driver.quit
end

def visit_login_page
  puts ' Action: Visit login page'
  visit('/users/sign_in')
end

def visit_home_page
  puts ' Action: Visit home page'
  visit('/')
end

def assert_login_page_open
  puts '  Verify: login page should be open'
  result = current_path == '/users/sign_in'
  raise "Expected Login page, Actual: #{current_path}" unless result
  puts '[PASS]'
end

def assert_home_page_open
  puts '  Verify: home page should be open'
  result = current_path == '/'
  raise "Expected Home page, Actual: #{current_path}" unless result
  puts '[PASS]'
end

def assert_user_logged
  puts '  Verify: User should be logged on'
  result = has_xpath?("//div[text()='Signed in successfully.']")
  raise "There is no 'Signed in successfully.' on the page" unless result
  puts '[PASS]'
end

def assert_login_error_message
  puts '  Verify: Login error message exists'
  result = has_xpath?("//div[text()='Invalid email or password.']")
  raise "There is no 'Invalid email or password.' on the page" unless result
  puts '[PASS]'
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  raise 'User has been logged on!' unless has_xpath?("//a[text()='Login']")
  puts '[PASS]'
end

def assert_login_error
  assert_login_error_message
  assert_login_interrupted
end

def click_login
  puts ' Action: Click on Login item'
  click_link('Login')
end

def click_enter
  puts ' Action: Click Enter'
  find_field('user[password]').send_keys(:enter)
end

def fill_form(email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  fill_in('user[email]', with: email)
  fill_in('user[password]', with: password)
end

def capybara_test_run
  yield
end
