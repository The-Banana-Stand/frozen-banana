FactoryGirl.define do
  factory :change_request do
    request 'test request'
    user
    meeting


  end

end
