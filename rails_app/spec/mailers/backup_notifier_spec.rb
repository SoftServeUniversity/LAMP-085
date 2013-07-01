require "spec_helper"

describe BackupNotifier do
  describe 'backup_email' do
    let(:user) { mock_model(User, :email => 'mihvaren@gmail.com') }
    let(:mail) { BackupNotifier.backup_email(user) }
 
    it 'renders the subject' do
      mail.subject.should == 'Backup was created'
    end
 
    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
 
    it 'renders the sender email' do
      mail.from.should == ['mihvaren@gmail.com']
    end
 
    it 'renders the body text' do
      mail.body.encoded.should match("Backup was created succesfuly.")
    end
  end

  describe 'restore_email' do
    let(:user) { mock_model(User, :email => 'mihvaren@gmail.com') }
    let(:mail) { BackupNotifier.restore_email(user) }
 
    it 'renders the subject' do
      mail.subject.should == 'Databse was restored succesfuly'
    end
 
    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end
 
    it 'renders the sender email' do
      mail.from.should == ['mihvaren@gmail.com']
    end
 
    it 'renders the body text' do
      mail.body.encoded.should match("Database was restored succesful!")
    end
  end
end
