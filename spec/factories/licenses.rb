# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :license do
      name "Fulano de Tal"
      login "fulano"
      email "fulano@redu.com.br"
      period_start "2012-02-02"
      period_end "2012-02-02"
      role 1
      invoice nil
    end
end
