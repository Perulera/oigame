require 'spec_helper'

describe SubOigame do
  let(:sub_oigame) { create :sub_oigame }
  describe '#admin_users' do
    it 'return the list of user#mail join by "\r\n"' do
      users = 3.times.map {|i| create :user, email: "user#{i}@email.com" }
      sub_oigame.stub(:users) { users }
      sub_oigame.admin_users.should eq("user0@email.com\r\nuser1@email.com\r\nuser2@email.com")
    end

  end

  describe 'admin_users=' do
    describe 'passed the emails with spaces and backspaces' do
      before(:each) do
        @users = 3.times.map {|i| create :user, email:"email#{i}@gmail.com" }
        sub_oigame.admin_users = <<EOF
            email0@gmail.com    email1@gmail.com

                                 email2@gmail.com
EOF
      end

      it 'assign to #user the new two users' do
        sub_oigame.users.should eq(@users)
      end
      
    end



  end
  
end
