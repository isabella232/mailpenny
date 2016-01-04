require 'test_helper'
# User tests
class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new
    @user.name = 'John Smith'
    @user.email = 'john@example.com'
    @user.password = 'foobarbe'
    @user.password_confirmation = 'foobarbe'
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '     '
    assert_not @user.valid?
  end

  test 'name should not be greater than 100 char' do
    @user.name = 'a' * 101
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '   '
    assert_not @user.valid?
  end

  test 'email should not be longer than 255 char' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'email should accept valid addresses' do
    valid_addresses = %w( john@example.com john.smith@example.com
                          John+smith@hello.pk John_smith@hello.pk
                          john32.999jack@example.pk jay@john.org.pk )
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address} should be valid"
    end
  end

  test 'email should not accept invalid addresses' do
    invalid_addresses = %w( john_AT_example.com john.smith#example.com
                            John+smith@hello John_smith@hell_o.com lalal@ )
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"
    end
  end

  test 'emails should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'password should have a minimum length of 8' do
    @user.password = @user.password_confirmation = 'a' * 7
    assert_not @user.valid?
  end
end
