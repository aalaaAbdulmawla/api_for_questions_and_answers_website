require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:birth_date) }
  it { should respond_to(:location) }
  it { should respond_to(:job) }
  it { should respond_to(:about) }
  it { should respond_to(:experience) }
end
