require 'spec_helper'

describe UserEnvironmentAssociation do
  subject { Factory(:user_environment_association) }

  it { should belong_to :user }
  it { should belong_to :environment }

  # FIXME Problema de tradução
  xit { should validate_uniqueness_of(:user_id).scoped_to(:environment_id)}

  context "finders" do
    it "retrieves user environment associations with specified roles" do
      assoc = (1..3).collect { Factory(:user_environment_association, :role => :tutor) }
      assoc2 = (1..3).collect { Factory(:user_environment_association, :role => :admin) }
      t = Factory(:user_environment_association, :role => :teacher)

      UserEnvironmentAssociation.with_roles([ Role[:admin].id, Role[:teacher].id ]).
        should == (assoc2 << t)
    end

    it "retrieves user environment associations with specified keyword" do
      user = Factory(:user, :first_name => "Andrew")
      assoc = Factory(:user_environment_association, :user => user)
      user2 = Factory(:user, :first_name => "Joe Andrew")
      assoc2 = Factory(:user_environment_association, :user => user2)
      user3 = Factory(:user, :first_name => "Alice")
      assoc3 = Factory(:user_environment_association, :user => user3)

      UserEnvironmentAssociation.with_keyword("Andrew").
        should == [user.user_environment_associations.last,
          user2.user_environment_associations.last]
    end

    it "retrieves user_environment_association with specified environment" do
      assoc = Factory(:user_environment_association, :environment => subject.environment)
      assoc2 = Factory(:user_environment_association, :environment => subject.environment)
      assoc3 = Factory(:user_environment_association)

      UserEnvironmentAssociation.of_environment(subject.environment).
        should == subject.environment.user_environment_associations
    end
  end
end
