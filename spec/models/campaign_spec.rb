require 'spec_helper'

describe Campaign do
  describe 'same sub_oigame' do
    let!(:sub_oigame) { create :sub_oigame }
    describe '#name' do
      it 'should be uniq' do
        camp = create :campaign, name:'test-1', sub_oigame: sub_oigame
        campaign = build :campaign, name: 'test-1', sub_oigame: sub_oigame
        campaign.should_not be_valid
      end
      it 'should not be blank' do
        campaign = build :campaign, name: ''
        campaign.should_not be_valid
      end
    end

    describe '#partition_of_emails' do
      describe 'size 30 with 69 emails' do
        let(:emails) { 69.times.map {|i| "activist#{i}@person.com" } }
        it 'should return' do
        end          
      end
    end
  end
end
