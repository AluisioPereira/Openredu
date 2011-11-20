# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    statement "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
  end

  factory :complete_question, :parent => :question do
    after_create do |q|
      Factory(:alternative, :correct => true, :question => q)
      Factory(:alternative, :correct => false, :question => q)
      Factory(:alternative, :correct => false, :question => q)
    end
  end
end
