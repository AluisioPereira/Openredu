require 'spec_helper'

describe Choice do
  subject { Factory(:choice) }

  it { should belong_to(:alternative) }
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:question_id) }
end
