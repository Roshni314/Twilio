class VerificationService
    def initialize(phone_number, country_code)
      @phone_number = phone_number
      @country_code = country_code
      @phone_number_with_code = "#{@country_code}#{@phone_number}"
      @account_sid = ENV['ACCOUNT_SID']
      @auth_token = ENV['AUTH_TOKEN']
      @service_sid = ENV['SERVICE_SID']

      client = Twilio::REST::Client.new(@account_sid, @auth_token)
      @verification_service = client.verify.services(@service_sid)
    end
  
    def send_otp_code
      SendPinWorker.perform_async(
        @phone_number_with_code
      )
      'An activation code would be sent to your phonenumber!'
    end

    def verify_otp_code?(otp_code)
        verification_check =  @verification_service
                              .verification_checks
                              .create(to: @phone_number_with_code, code: otp_code)
    
        verification_check.status == 'approved'
    end
    # rescue
    #     render json: { message: 'otp code has expired. Resend code' }
end
