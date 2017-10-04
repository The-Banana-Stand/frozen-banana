module PayStripeHelpers
  # must be used with driver: :selenium (or :sauce?)
  def pay_stripe
    sleep(0.7) # wait for the js to create the popup in response to pressing the button
      stripe_card_number = '4242424242424242'

    within 'stripe-element' do
      # must use `find_field` since the credit card field does not have a static ID
      find_field('Card number').send_keys(stripe_card_number)
      find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
      find_field('CVC').send_keys '123'
      find_field('ZIP Code').send_keys '11111'

      find('button[type="submit"]').click
      sleep(2)
    end
    # wait for stripe to finish and change the page; default is 2 seconds
    # find("body[data-tests-page='member/dashboard']", wait: 30)
  end

  def fill_stripe_elements
    using_wait_time(15) { within_frame('__privateStripeFrame4') do
      find_field('cardnumber').send_keys('4242424242424242')

      find_field('exp-date').send_keys("0122")
      find_field('cvc').send_keys '123'
      find_field('postal').send_keys '19335'
    end }
  end

end


