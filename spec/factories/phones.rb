FactoryGirl.define do
  factory :phone do
    association :contact
    phone '123-555-1234'

    factory :work_phone do
      phone_type 'home'
    end

    factory :mobile_phone do
      phone_type 'mobile'
    end

    factory :home_phone do
      phone_type 'home'
    end
  end
end
