class AuthenticatedUserPrivacyTest < ActionDispatch::IntegrationTest
  test "authenticated user cannot see another user's data" do
    lender = create_lender
    lender_two = User.create!(first_name: 'Jane',
                              last_name:  'Doe',
                              username:   'janedoe',
                              password:   'password',
                              bio: 'my bio')
    lender_two.roles << Role.find_by(name: "lender")

    visit root_path
    click_link "Login"

    fill_in "Username", with: "janedoe"
    fill_in "Password", with: "password"
    click_button "Login"

    visit lender_dashboard_path

    assert page.has_content?("Lender Profile")
    assert page.has_content?("First name: Jane")
    assert page.has_content?("Username: janedoe")
    refute page.has_content?("First name: John")
    refute page.has_content?("Username: mdoe")
  end
end
