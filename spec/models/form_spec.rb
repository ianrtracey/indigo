require 'spec_helper'

describe Form do
  let(:form) { FactoryGirl.build :form }
  subject { form }

  it { should respond_to(:name) }
  it { should respond_to(:body) }
  it { should respond_to(:submitted) }
  it { should respond_to(:user_id) }

  it { should not_be_submitted }

  it { should validate_presence_of :name }
  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
end