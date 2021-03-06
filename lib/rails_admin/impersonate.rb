# lib/rails_admin/impersonate_user.rb

module RailsAdmin
  module Config
    module Actions
      class Impersonate < RailsAdmin::Config::Actions::Base
        # This ensures the action only shows up for Users

        # We want the action on members, not the Users collection
        register_instance_option :member do
          true
        end

        register_instance_option :visible? do
          bindings[:object].class == User

        end

        register_instance_option :link_icon do
          'icon-eye-open'
        end

        register_instance_option :controller do
          Proc.new do
            # Note: This is dummy code. The thing to note is that we aren't
            # rendering a view, just redirecting after taking an action on @object, which
            # will be the user instance in this case.
            sign_in @object
            redirect_to back_or_index
          end
        end




      end
    end
  end
end