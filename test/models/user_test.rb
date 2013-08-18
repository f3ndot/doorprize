require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @omniauth_users = []
    @omniauth_users.push users(:twitter)
    @omniauth_users.push users(:github)
    @omniauth_users.push users(:facebook)
    @omniauth_users.push users(:google)
  end

  test "omniauth users don't have to set password" do
    @omniauth_users.each do |user|
      refute user.password_required?, 'password is not required for omniauth users'
    end
  end

  test "passwordless users don't have to check current password" do
    params = {name: 'New Name', email: 'new_email@example.com'}

    user = users(:one)
    refute user.update_with_password(params), 'traditional user was able to update attributes without password'

    @omniauth_users.each do |user|
      assert_not_equal params[:name], user.name
      assert_not_equal params[:email], user.email
      user.update_with_password(params)
      assert_equal params[:name], user.name
      assert_equal params[:email], user.email
    end
  end

  test "user names are required" do
    user = users(:one)
    assert user.valid?

    user.name = nil
    refute user.valid?

    user.name = ''
    refute user.valid?
  end
end
