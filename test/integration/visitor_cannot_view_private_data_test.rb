class AuthenticatedUserPrivacyTest < ActionDispatch::IntegrationTest
  test "visitor cannot see user data" do
    visit borrower_dashboard_path
    assert page.has_content?("Stranger danger!")

    visit lender_dashboard_path
    assert page.has_content?("Stranger danger!")

    visit '/admin/dashboard'
    assert page.has_content?("Stranger danger!")
  end

  test "visitor cannot see admin data" do
    visit '/admin/dashboard'
    assert page.has_content?("Stranger danger!")
  end
end
