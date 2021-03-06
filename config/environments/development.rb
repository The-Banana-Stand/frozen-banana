Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.seconds.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  config.action_mailer.raise_delivery_errors = true


  config.action_mailer.delivery_method = :test
  config.action_mailer.default_url_options = {host: 'localhost:3000'}


  # SMTP settings for Amazon SES
  config.action_mailer.smtp_settings = {
      :address        => 'smtp.sendgrid.net',
      :port           => '587',
      :authentication => :login,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => 'meetingslice.com',
      :enable_starttls_auto => true
  }
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.assets.prefix = "/dev-assets"

  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
  end

  #paperclip S3
  config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
          # s3_host_name: ENV["AWS_S3_HOST_NAME"],
          bucket: ENV["AWS_S3_BUCKET"],
          s3_region: ENV["AWS_S3_REGION"],
          access_key_id: ENV["AWS_S3_ACCESS_KEY_ID"],
          secret_access_key: ENV["AWS_S3_SECRET_ACCESS_KEY"]
      }
  }

  # Rails.application.config.middleware.use ExceptionNotification::Rack,
  #                                         :slack => {
  #                                             :webhook_url => ENV['SLACK'],
  #                                             :channel => "#exceptions",
  #                                             :additional_parameters => {
  #                                                 :mrkdwn => true
  #                                             }
  #                                         }
end
