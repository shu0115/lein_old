# coding: utf-8
class PaypalApi
  private
  
  # PayPal Setting
  PAYPAL_USER_NAME = ENV['PAYPAL_USER_NAME']
  PAYPAL_PASSWORD  = ENV['PAYPAL_PASSWORD']
  PAYPAL_SIGNATURE = ENV['PAYPAL_SIGNATURE']
  BILLING_AGREEMENT_DESCRIPTION = "Lein Supporter Charges"
#  PAYPAL_EXPRESS_SUCCESS = ""
#  PAYPAL_EXPRESS_CANCEL = ""

  #------------------#
  # self.get_request #
  #------------------#
  def self.get_request
    request = Paypal::Express::Request.new(
      username: PAYPAL_USER_NAME,
      password: PAYPAL_PASSWORD,
      signature: PAYPAL_SIGNATURE,
    )
    
    return request
  end

  #---------------------------#
  # self.set_express_checkout #
  #---------------------------#
  def self.set_express_checkout( calback_url )
    # サンドボックス
    Paypal.sandbox! if ENV['PAYPAL_SANDBOX'] == "ON"
    
    request = self.get_request
    
    payment_request = Paypal::Payment::Request.new(
      currency_code: :JPY, # if nil, PayPal use USD as default
      billing_type: :RecurringPayments,
      billing_agreement_description: BILLING_AGREEMENT_DESCRIPTION
    )
    
    response = request.setup(
      payment_request,
      calback_url,  # SUCCESS_CALBACK_URL
      calback_url,  # CANCEL_CALBACK_URL
    )
    
    return response.redirect_uri
  end
  
  #-----------------------#
  # self.create_recurring #
  #-----------------------#
  def self.create_recurring( token )
    # サンドボックス
    Paypal.sandbox! if ENV['PAYPAL_SANDBOX'] == "ON"
    
    request = self.get_request
    
    profile = Paypal::Payment::Recurring.new(
      start_date: Time.now,
      description: BILLING_AGREEMENT_DESCRIPTION,
      billing: {
#        period: :Month, # ie.) :Month, :Week
        period: :Day, # ie.) :Month, :Week
        frequency: 1,
        amount: 150,
        currency_code: :JPY, # if nil, PayPal use USD as default
      }
    )
    
    response = request.subscribe!( token, profile )
    response.recurring
    
    return response.recurring.identifier # => profile_id

  # rescue Paypal::Exception::APIError => e
  #   puts ; puts "[ e.message ] : " ; e.message.tapp ; puts ;
  #   puts ; puts "[ e.response ] : " ; e.response.tapp ; puts ;
  #   puts ; puts "[ e.response.details ] : " ; e.response.details.tapp ; puts ;
  #   raise e.message
  end

  #----------------------------#
  # self.get_recurring_profile #
  #----------------------------#
  def self.get_recurring_profile( profile_id )
    # サンドボックス
    Paypal.sandbox! if ENV['PAYPAL_SANDBOX'] == "ON"
    
    request = self.get_request
    response = request.subscription(profile_id)
    
    return response.recurring
  end

  #-----------------------#
  # self.cancel_recurring #
  #-----------------------#
  def self.cancel_recurring( profile_id )
    # サンドボックス
    Paypal.sandbox! if ENV['PAYPAL_SANDBOX'] == "ON"
    
    request = self.get_request
    response = request.renew!( profile_id, :Cancel )
    
    puts ; puts "[ response ] : " ; response.tapp ; puts ;
    
    return response.ack
  end
  
end
