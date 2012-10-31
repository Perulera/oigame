namespace :oigame do
  desc "Enviar mensaje a los participantes de una campana"
  task(:mailing_for_participants_in_html => :environment) do
    message = File.open(ENV['FILENAME'], 'r').read
    subject = ENV['SUBJECT']
    campaign_id = ENV['CAMPAIGN_ID']
    
    emails = []
    campaign = Campaign.find(campaign_id)

    unless campaign.petitions.empty?
      petitions = Petition.where(:campaign_id => campaign_id, :validated => true).all
      petitions.each do |p|
        emails << p.email
      end
    else
      messages = Message.where(:campaign_id => campaign_id, :validated => true).all
      messages.each do |m|
        emails << m.email
      end
    end

    i = 1
    emails.each do |email|
      Mailman.send_mailing_to_participants_in_html(email, subject, message).deliver
      puts "Mensaje #{i} enviado"
      i += 1
    end
  end
end
