module Helpers

  # Log in as a particular user.
  def log_in_as(user)
    page.set_rack_session(user_id: user.id)
  end

end