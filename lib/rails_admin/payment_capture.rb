# lib/rails_admin/impersonate_user.rb

module RailsAdmin
  module Config
    module Actions
      class PaymentCapture < RailsAdmin::Config::Actions::Base
        # This ensures the action only shows up for Users

        # We want the action on members, not the Users collection
        register_instance_option :member do
          true
        end

        register_instance_option :visible? do
          bindings[:object].class == Meeting && bindings[:object].payment_status != 'succeeded'

        end

        register_instance_option :link_icon do
          'icon-barcode'
        end

        register_instance_option :pjax? do
          false
        end


        register_instance_option :controller do
          Proc.new do
            # Note: This is dummy code. The thing to note is that we aren't
            # rendering a view, just redirecting after taking an action on @object, which
            # will be the user instance in this case.
            @object.capture_payment
            flash[:success] = "Payment Status: #{@object.payment_status}"
            redirect_to back_or_index
          end
        end




      end
    end
  end
end