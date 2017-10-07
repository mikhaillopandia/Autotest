require 'watir'
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

