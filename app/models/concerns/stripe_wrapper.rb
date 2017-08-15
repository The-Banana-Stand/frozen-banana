module StripeWrapper


  def process_payment_info(stripe_token)
    customer = fetch_stripe_customer
    customer.source = stripe_token
    customer.save
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(
        :email => self.email,
        :description => "#{self.full_name} ID: #{self.id}"
    )
    self.update_attribute(:customer_token, customer.id)
    customer
  end

  def stripe_customer
    Stripe::Customer.retrieve(self.customer_token)
  end

  def fetch_stripe_customer
    if self.customer_token
      customer = self.stripe_customer
      customer.deleted? ? create_stripe_customer : customer
    else
      create_stripe_customer
    end
  end

end