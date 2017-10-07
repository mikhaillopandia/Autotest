require 'watir'


@login_page = 'http://demoapp.strongqa.com/users/sign_in'
@home_page = 'http://demoapp.strongqa.com/'

def test_case(ref, name)
  @driver = Watir::Browser.new :chrome
  puts "**#{ref} - #{name}"
  yield
rescue => e
  puts "[FAILED] #{e.message}"
ensure
  @driver.quit
end

def visit_login_page
  puts " Action: Visit login page"
  @driver.goto @login_page
end

def visit_home_page
  puts " Action: Visit home page"
  @driver.goto @home_page
end

def assert_login_page_open
  puts "  Verify: login page should be open"
  if @driver.url == @login_page
    puts '[PASS]'
  else
    raise "Expected Login page, Actual: #{@driver.url}"
  end
end

def assert_home_page_open
  puts "  Verify: home page should be open"
  if @driver.url == @home_page
    puts '[PASS]'
  else
    raise "Expected Home page, Actual: #{@driver.url}"
  end
end

def assert_user_logged
  puts "  Verify: User should be logged on"
  e = @driver.element(xpath: "//div[text()='Signed in successfully.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Signed in successfully.' on the page"
  end
end

def assert_login_error_message
  puts "  Verify: Login error message exists"
  e = @driver.element(xpath: "//div[text()='Invalid email or password.']")
  if !!e
    puts '[PASS]'
  else
    raise "There is no 'Invalid email or password.' on the page"
  end
end

def assert_login_interrupted
  puts "  Verify: User isn't logged on"
  e = @driver.element(xpath: "//a[text()='Login']")
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
  @driver.element(link_text: 'Login').click
end

def click_enter
  puts ' Action: Click Enter'
  @driver.element(name: 'user[password]').send_keys(:enter)
end

def fill_form (email: nil, password: nil)
  puts " Action: Filling in: email = #{email}, password = #{password}"
  @driver.text_field(name: 'user[email]').set(email)
  @driver.text_field(name: 'user[password]').set(password)
end


def watir_test_run
  test_case 'tc_01', 'User can open login page via menu' do
    visit_home_page
    click_login
    assert_login_page_open
  end

  test_case 'tc_02', 'User can login with correct credentials' do
    visit_login_page
    fill_form(email: 'lopandya96@gmail.com', password: 'lopandya96')
    click_enter
    assert_user_logged
    assert_home_page_open
  end

  test_case 'tc_04.1', 'User can not login with blank password' do
    visit_login_page
    fill_form(email: 'lopandya96@gmail.com', password: '')
    click_enter
    assert_login_error
  end

  test_case 'tc_04.2', 'User can not login with blank email' do
    visit_login_page
    fill_form(email: '', password: 'lopandya96')
    click_enter
    assert_login_error
  end

  test_case 'tc_04.3', 'User can not login with blank data' do
    visit_login_page
    fill_form(email: '', password: '')
    click_enter
    assert_login_error
  end

  test_case 'tc_05.1', 'User can not login with incorrect email' do
    visit_login_page
    fill_form(email: 'FASLE@i.ua', password: 'lopandya96')
    click_enter
    assert_login_error
  end

  test_case 'tc_05.2', 'User can not login with incorrect password' do
    visit_login_page
    fill_form(email: 'lopandya96@i.ua', password: 'FALSE')
    click_enter
    assert_login_error
  end

  test_case 'tc_05.3', 'User can not login with incorrect data' do
    visit_login_page
    fill_form(email: 'FALSE@i.ua', password: 'FALSE')
    click_enter
    assert_login_error
  end
end

watir_test_run


def tc_01
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/'
  l = browser.link text: 'Login'
  l.click
  browser.quit
end

def tc_02
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'lopandya96@gmail.com'
  browser.text_field(name: 'user[password]').set 'lopandya96'
  browser.send_keys :enter
  # browser.quit
  browser
end

def tc_03_1
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'lopandya96@gmail.com'
  browser.text_field(name: 'user[password]').set 'lopandya96'
  browser.checkbox(name: 'user[remember_me]').check
  browser.send_keys :enter
  # browser.quit
  browser
end

def tc_03_2
  browser = tc_03_1
  browser.quit

  browser = tc_02
  l = browser.link text: 'Home'
  l.click
  browser
end

def tc_03_3
  browser = tc_03_1
  l = browser.link text: 'Logout'
  l.click
  browser.quit
  browser = tc_02
  l = browser.link text: 'Home'
  l.click
  browser.close
end

def tc_04_1
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'lopandya96@gmail.com'
  browser.send_keys :enter
  d = browser.div text: 'Invalid email or password.'
  puts d.exists? ? 'OK' : 'Fail'
  browser.quit
end

def tc_04_2
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[password]').set 'lopandya96'
  browser.send_keys :enter
  d = browser.div text: 'Invalid email or password.'
  puts d.exists? ? 'OK' : 'Fail'
  browser.quit
end

def tc_04_3
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.send_keys :enter
  d = browser.div text: 'Invalid email or password.'
  puts d.exists? ? 'OK' : 'Fail'
  browser.quit
end

def tc_05_1
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'FALSE'
  browser.text_field(name: 'user[password]').set 'lopandya96'
  browser.send_keys :enter
  browser.quit
end

def tc_05_2
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'lopandya96@gmail.com'
  browser.text_field(name: 'user[password]').set 'FALSE'
  browser.send_keys :enter
  d = browser.div text: 'Invalid email or password.'
  puts d.exists? ? 'OK' : 'Fail'
  browser.quit
end

def tc_05_3
  browser = Watir::Browser.new :chrome
  browser.goto 'http://demoapp.strongqa.com/users/sign_in'
  browser.text_field(name: 'user[email]').set 'FALSE@i.ua'
  browser.text_field(name: 'user[password]').set 'FALSE'
  browser.send_keys :enter
  d = browser.div text: 'Invalid email or password.'
  puts d.exists? ? 'OK' : 'Fail'
  browser.quit
end
