module LoginHelper
  def login(user)
    user.confirm
    visit new_user_session_path
    fill_in 'E-mail address', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
