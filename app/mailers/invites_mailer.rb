class InvitesMailer < ApplicationMailer

  def invite_email(invite)
    headers['X-SMTPAPI'] = {
        category: ['invite'],
        asm_group_id: 3317
    }.to_json
    @invite = invite
    mail(to: invite.email, subject: "#{invite.user&.full_name} invited you to MeetingSlice")
  end

end
