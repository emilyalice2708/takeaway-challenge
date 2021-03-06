require 'twilio-ruby'

class Confirmation
    
  def initialize(env = ENV, client = nil)
    @env = env
    @client = client || Twilio::REST::Client.new(env["TWILIO_ACCOUNT_SID"], env["TWILIO_AUTH_TOKEN"])
  end
  
  def send_message(time_class = Time)
    @client.messages.create(
      message_contents(time_class)
    )
  end

  def message_contents(time_class)
    { from: @env['TWILIO_PHONE_NO'],
    to: @env['PHONE_NO'],
    body: "Thank you! Your order was placed and will be delivered before #{eta(time_class)}." }
  end

  def eta(time_class)
    time = time_class.now
    "#{time.hour + 1}:#{time.min}"
  end

end
