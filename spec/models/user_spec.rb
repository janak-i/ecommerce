require 'rails_helper'
RSpec.describe User, type: :model do
  describe 'associations' do

    it { should have_many(:products).through(:orders) }
    it { should have_many (:orders)}
    it {should have_one (:cart)}
  end

end
