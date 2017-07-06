require 'rails_helper'

RSpec.describe User, type: :model do

  describe User, 'validations' do
    it {is_expected.to validate_presence_of(:first_name)}
    it {is_expected.to validate_presence_of(:last_name)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:company_name)}
    it {is_expected.to validate_presence_of(:company_address)}
    it {is_expected.to validate_presence_of(:city)}
    it {is_expected.to validate_presence_of(:state)}
    it {is_expected.to validate_presence_of(:zip_code)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it {is_expected.to validate_presence_of(:username)}
    it {is_expected.to validate_uniqueness_of(:username)}
    it {is_expected.to validate_presence_of(:phone_number)}
  end

end
