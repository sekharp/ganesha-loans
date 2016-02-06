class UserAuthenticationTest < ActionDispatch::IntegrationTest
  test "visitor can see login link" do
    visit root_path

    within("#primary-navigation") do
      assert page.has_content?("Login")
    end
  end

  test "lender can login" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end
  end

  test "lender can logout" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "password"
    click_button "Login"

    assert_equal "/lender_dashboard", current_path
    within("#primary-navigation") do
      refute page.has_content?("Login")
      assert page.has_content?("Logout")
    end

    click_link "Logout"
    assert page.has_content?("Goodbye!")
    assert_equal login_path, current_path
  end

  test "logged in user sees cart contents" do
    create_roles_borrower_project_and_lender
    login_lender
    visit root_path

    click_button "Learn More"
    within(".lend-btn") do
    click_link "Lend"
    end
    fill_in "Amount", with: "50"
    click_button "Lend!"

    assert_equal cart_index_path, current_path

    within("#cart-contents") do
      assert page.has_content?("50")
    end
  end

  test "guest cannot login with invalid credentials" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "terrible"
    fill_in "Password", with: "stupid"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid login. Please create account or try again.")
  end

  test "user cannot login with invalid password" do
    create_roles_borrower_project_and_lender
    visit root_path

    click_link "Login"
    fill_in "Username", with: "mdoe"
    fill_in "Password", with: "stupid"
    click_button "Login"

    assert_equal login_path, current_path
    assert page.has_content?("Invalid login. Please create account or try again.")
  end
end
