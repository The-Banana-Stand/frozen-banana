# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview

  def invite_email
    InvitesMailer.invite_email(Invite.first)
  end
end
