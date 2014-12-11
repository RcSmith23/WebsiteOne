require 'spec_helper'

describe FormHelper do
  let(:user) { FactoryGirl.create(:user) }
  let(:valid_attributes) { {status: nil, user_id: user.friendly_id} }

  it 'should change status if nil' do
    set_status(user)
    expect(user.status).not_to be_nil
  end
end
