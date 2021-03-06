Bundler.require(:default)
require_relative 'lib/capybara'
require_relative 'lib/selenium'
require_relative 'lib/watir'

LOGIN_PAGE = 'http://demoapp.strongqa.com/users/sign_in'.freeze
HOME_PAGE = 'http://demoapp.strongqa.com/'.freeze

allowed_drivers = %w[capybara selenium watir]
puts 'Enter drivers names you want to use for the test, separate'\
'their names via coma :'
drivers = gets.chomp.split(',').map(&:strip).uniq & allowed_drivers

tests = lambda do
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

if drivers.empty?
  puts "Drivers haven't been chosen"
else
  puts "Tests will run for: #{drivers.join(', ')}"
end
drivers.each do |driver|
  case driver
  when 'capybara'
    capybara_test_run &tests
  when 'selenium'
    selenium_test_run &tests
  when 'watir'
    watir_test_run &tests
  end
end
