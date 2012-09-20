require 'spec_helper'

describe Campaign do
  describe 'same sub_oigame' do
    let!(:sub_oigame) { create :sub_oigame, name: 'testing_sin_fronteras' }
    describe 'when creating first time as default' do
      
    end
    describe '#user' do
      it 'should not be blank' do
        campaign = build :campaign, user: nil
        campaign.should_not be_valid
      end
    end
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
        let!(:emails) { 69.times.map {|i| "activist#{i}@person.com" } }
        let(:campaign) { create :campaign, emails: emails }
        it 'should return three arrays' do
          campaign.partition_of_emails(30).size.should eq(3)
        end
      end
    end

    describe '#activate!' do
      describe 'when moderated is true' do
        let(:campaign) { create :campaign, moderated: true }
        it 'should change the status #moderated to false' do
          lambda {
            campaign.activate!
          }.should change(campaign,:moderated?).from(true).to(false)
        end

        it 'set published_at to Time.now' do
          now = 2.days.ago
          Time.stub(:now) { now } 
          campaign.activate!
          campaign.reload.published_at.should eq(now.to_s)
        end

        it 'return the campaign' do
          campaign.activate!.should eq(campaign)
        end
      end
    end

    describe '#published?' do
      context 'when moderated is true' do
        let(:campaign) { create :campaign, moderated: true }
        it { campaign.should_not be_published }
      end

      context 'when moderated is false' do
        let(:campaign) { create :campaign, moderated: false }
        specify { campaign.should be_published }
      end
    end

    describe '#recipients=' do
      let(:campaign) { create :campaign }
      it 'should save an array of emails' do
        campaign.recipients = 'peRsOn1@gmail.com person2@gmail.com '
        campaign.emails.should eq(['person1@gmail.com','person2@gmail.com'])
      end
    end

    describe '#recipients' do
      let(:campaign) { create :campaign }
      it 'should return the @emails with \r\n at the end' do
        campaign.emails = ['person1@gmail.com','person2@gmail.com']
        campaign.recipients.should eq("person1@gmail.com\r\nperson2@gmail.com")
      end
    end

    describe '#archive' do
      context 'when in status a' do
        let(:campaign) { create :campaign, status:'a' }
        it do
          lambda { campaign.archive }.should change(campaign,:status).from('a').to('archived')
        end
      end
    end

    describe '#trash' do
      context 'when in status a' do
        let(:campaign) { create :campaign, status:'a' }
        it do
          lambda { campaign.trash }.should change(campaign,:status).from('a').to('deleted')
        end
      end      
    end

    describe '#other_campaigns' do
      let(:campaign) { create :campaign }
      it 'should return the last 5 pririty campaigns' do
        campaigns_pri = 6.times.map do |i|
          build :campaign, priority: true
        end
        campaigns_more = 10.times.map do |i|
          build :campaign, priority: false
        end
        camp = campaigns_pri + campaigns_more
        pri = []
        16.times.each do |i|
          ca = camp.delete_at(rand(16-i))
          ca.activate!
          pri.push(ca) if ca.priority
        end
        campaign.other_campaigns.should eq(pri[0..4])
      end 
    end

    describe '#get_absolute_url' do
      let(:campaign) { create :campaign,sub_oigame:sub_oigame }
      it 'should return the url with the sub_oigame#name' do
        campaign.get_absolute_url.should eq(APP_CONFIG[:domain]+'/o/testing_sin_fronteras/campaigns/'+campaign.slug)
      end
    end
    
  end
end
