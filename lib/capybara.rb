require 'capybara/dsl'
include Capybara::DSL

Capybara.run_server = false
Capybara.current_driver = :selenium_chrome
Capybara.app_host = 'http://demoapp.strongqa.com/'

def test_case(ref, name)
  puts "**#{ref} - #{name}"
  yield
rescue => e
  puts "[FAILED] #{e.message}"
ensure
  page.driver.quit
end

def visit_login_page
  puts " Action: Visit login page"
  visit('/users/sign_in')
end

def visit_home_page
  puts " Action: Visit home page"
  visit('/')
end

def assert_login_page_open
  puts "  Verify: login page should be open"
  if current_path == '/users/sign_in'
    puts '[PASS]'
  else
    raise "Expected Login page, Actual: #{current_path}"
  end
end

def assert_home_page_open
  puts "  Verify: home page should be open"
  if current_path == '/'
    puts '[PASS]'
  else
    raise "Expected Home page, Actual: #{current_path}"
  end
end

def assert_user_logged
  puts "  Verify: User should be logged on"
  e = find(:xpath, "//div[text()='Signed in successfully.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Signed in successfully.' on the page"
  end
end

def assert_login_error_message
  puts "  Verify: Login error message exists"
  e = find(:xpath, "//div[text()='Invalid email or password.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Invalid email or password.' on the page"
  end
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  e = find(:xpath, "//a[text()='Login']")
  if !!e
    puts '[PASS]'
  else
    raise "User has been logged on!"
  end
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

def fill_form (email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  fill_in('user[email]', :with => email)
  fill_in('user[password]', :with => password)
end

def capybara_test_run
  yield
end