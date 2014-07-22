Given /^a user visits the signin page$/ do
  visit signin_path
end

When /^he submits invalid signin information$/ do
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.alert.alert-error')
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid signin information$/ do
  visit signin_path
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password 
  click_button "Sign in"
end

Then /^he should see his profile page$/ do
  page.should have_title(@user.name)
end

Then /^he should see a profile link$/ do
  page.should have_link('Profile', href: user_path(@user))
end

Then /^he should see a signout link$/ do
  page.should have_link('Sign out', href: signout_path)
end

Then /^he should not see a signin link$/ do
  page.should_not have_link('Sign in', href: signin_path)
end
