require 'bcrypt'

class User < ActiveRecord::Base
  has_many :appeals, dependent: :destroy

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /.*@.*[.].*/, message: "Please format your email address like 'sample@email.com'"}
  validates :password, presence: true
  validates :password_digest, presence: true
  validates :account_number, presence: true
  validate do |user|
    AccountNumberValidator.new(user).check_account_number
  end

  include BCrypt

  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

end

class AccountNumberValidator

  def initialize(user)
    @user = user
  end

  def check_account_number
    digit_string = @user.account_number
    raise ArgumentError.new("Need 7 digits") if digit_string.length != 7
    array = digit_string.split("")
    last_digit = array.pop.to_i
    array.map!.with_index{ |x, i| x.to_i * (i + 3)}
    sum = array.inject(:+)
    raise ArgumentError.new("Invalid account number") if sum % 11 != last_digit
  end

end