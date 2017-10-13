require 'capybara/dsl'
include Capybara::DSL

# General menu section for Login & Home pages
class MenuSection < SitePrism::Section
  # general elements
  element :articles, :xpath, "//a[text()='Articles']"
  element :home, :xpath, "//a[text()='Home']"
  # for not logged in user
  element :login, :xpath, "//a[text()='Login']"
  element :sign_up, :xpath, "//a[text()='Sign up']"
  # for logged in user
  element :edit_account, :xpath, "//a[text()='Edit account']"
  element :logout, :xpath, "//a[text()='Logout']"
  element :users, :xpath, "//a[text()='Users']"
end
# Home page
class Home < SitePrism::Page
  set_url '/'
  set_url_matcher %r{demoapp.strongqa.com/?}

  element :login_success, :xpath, "//div[text()='Signed in successfully.']"
  section :menu, MenuSection, '#main_menu'
end
# Login page
class Login < SitePrism::Page
  set_url '/users/sign_in'
  set_url_matcher %r{demoapp.strongqa.com/users/sign_in}

  element :email, "input[name='user[email]']"
  element :password, "input[name='user[password]']"
  element :login_fail, :xpath, "//div[text()='Invalid email or password.']"
  section :menu, MenuSection, '#main_menu'
end

def prerequisites
  Capybara.run_server = false
  Capybara.current_driver = :selenium
  Capybara.app_host = 'http://demoapp.strongqa.com'
  @login = Login.new
  @home = Home.new
end
prerequisites

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
  @login.load
end

def visit_home_page
  puts ' Action: Visit home page'
  @home.load
end

def assert_login_page_open
  puts '  Verify: login page should be open'
  raise "Expected Login page, Actual: #{current_path}" unless @login.displayed?
  puts '[PASS]'
end

def assert_home_page_open
  puts '  Verify: home page should be open'
  raise "Expected Home page, Actual: #{current_path}" unless @home.displayed?
  puts '[PASS]'
end

def assert_user_logged
  puts '  Verify: User should be logged on'
  @home.wait_for_login_success
  result = @home.has_login_success?
  raise "There is no 'Signed in successfully.' on the page" unless result
  puts '[PASS]'
end

def assert_login_error_message
  puts '  Verify: Login error message exists'
  @login.wait_for_login_fail
  result = @login.has_login_fail?
  raise "There is no 'Invalid email or password.' on the page" unless result
  puts '[PASS]'
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  raise 'User has been logged on!' unless @login.menu.has_login?
  puts '[PASS]'
end

def assert_login_error
  assert_login_error_message
  assert_login_interrupted
end

def click_login
  puts ' Action: Click on Login item'
  @home.menu.login.click
end

def click_enter
  puts ' Action: Click Enter'
  @login.password.send_keys :enter
end

def fill_form(email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  @login.email.set email
  @login.password.set password
end

def capybara_test_run
  yield
end
