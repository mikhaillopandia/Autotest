def test_case(ref, name)
  @driver = Watir::Browser.new :chrome
  puts "**#{ref} - #{name}"
  yield
rescue StandardError => e
  puts "[FAILED] #{e.message}"
ensure
  @driver.quit
end

def visit_login_page
  puts ' Action: Visit login page'
  @driver.goto LOGIN_PAGE
end

def visit_home_page
  puts ' Action: Visit home page'
  @driver.goto HOME_PAGE
end

def assert_login_page_open
  puts '  Verify: login page should be open'
  result = @driver.url == LOGIN_PAGE
  raise "Expected Login page, Actual: #{@driver.url}" unless result
  puts '[PASS]'
end

def assert_home_page_open
  puts '  Verify: home page should be open'
  result = @driver.url == HOME_PAGE
  raise "Expected Home page, Actual: #{@driver.url}" unless result
  puts '[PASS]'
end

def assert_user_logged
  puts '  Verify: User should be logged on'
  r = @driver.element(xpath: "//div[text()='Signed in successfully.']").exists?
  raise "There is no 'Signed in successfully.' on the page" unless r
  puts '[PASS]'
end

def assert_login_error_message
  puts '  Verify: Login error message exists'
  r = @driver.element(xpath: "//div[text()='Invalid email or password.']")
             .exists?
  raise "There is no 'Invalid email or password.' on the page" unless r
  puts '[PASS]'
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  result = @driver.element(xpath: "//a[text()='Login']").exists?
  raise 'User has been logged on!' unless result
  puts '[PASS]'
end

def assert_login_error
  assert_login_error_message
  assert_login_interrupted
end

def click_login
  puts ' Action: Click on Login item'
  @driver.element(link_text: 'Login').click
end

def click_enter
  puts ' Action: Click Enter'
  @driver.element(name: 'user[password]').send_keys(:enter)
end

def fill_form(email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  @driver.text_field(name: 'user[email]').set(email)
  @driver.text_field(name: 'user[password]').set(password)
end

def watir_test_run
  yield
end
