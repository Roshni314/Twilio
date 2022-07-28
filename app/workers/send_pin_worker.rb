class SendPinWorker
    include Sidekiq::Worker
  
    def perform(phone_number_with_code)
      account_sid = ENV['ACCOUNT_SID']
      auth_token = ENV['AUTH_TOKEN']
      service_sid = ENV['SERVICE_SID']
  
      client = Twilio::REST::Client.new(account_sid, auth_token)
    #   binding pry
      verification_service = client.verify.services(service_sid)
  
      verification_service
        .verifications
        .create(to: phone_number_with_code, channel: 'sms')
    end
  end
  