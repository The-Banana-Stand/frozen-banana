require 'rails_helper'

RSpec.describe Invite, type: :model do

  describe '#name' do
    it 'combines first and last name' do
      invite = create(:invite)

      expect(invite.name).to eq('Foo Bar')

    end
  end

end
