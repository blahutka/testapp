Before("@logged_in_user") do
  steps %Q{
  Given I am logged in
  }
  puts 'logged in user'
end

Before '@logged_out_user' do
  steps %Q{
  Given I am logged out
  }
  puts 'logged out user'
end