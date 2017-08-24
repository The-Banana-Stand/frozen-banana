class InvitesMailer < ApplicationMailer

  def invite_email(invite)
    @invite = invite
    mail(to: invite.email, subject: "#{invite.user&.full_name} invited you to MeetingSlice")
  end

end
