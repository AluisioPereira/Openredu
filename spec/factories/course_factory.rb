# -*- encoding : utf-8 -*-
FactoryGirl.define do
  factory :course do
    sequence(:name){ |n| "Curso #{n}" }
    sequence(:path){ |n| "curso-#{n}" }
    association :owner, :factory => :user
    environment { |course| FactoryGirl.create(:environment, :owner => course.owner) }
  end

  factory :complete_course, :parent => :course do
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    workload 40

    after(:create) do |c, _|
      c.spaces << FactoryGirl.create(:complete_space, :owner => c.owner, :course => c)
    end
  end

end
