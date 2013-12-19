def getFullTitle(page_title)
  title = "Ruby on Rails Tutorial Sample App"
  title = page_title.empty? ? title : "#{title} | #{page_title}"
end

def sign_in(user)
  visit signin_path
  fill_in "session_email", with: user.email
  fill_in "session_password", with: user.password
  click_button "Sign in"

  #sign in when not using capybara as well
  cookies[:remember_token] = user.remember_token
end