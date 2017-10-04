module SlackWrapper
  extend self

  def new_change_request_notification(obj)
    meeting = obj.meeting
    notification = {
        text: 'New Change Request',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New Change Request From:',
                value: "#{obj.user.full_name} (#{obj.user_id}) - #{obj.user.email} - #{obj.user.phone_number} - #{obj.user.company_name}"
            },
            {
                title: 'For Meeting:',
                value: "ID: #{obj.meeting_id} | Confirmation#: #{meeting.confirmation_number} | Meeting Status: #{meeting.status}"
            },
            {
                title: 'Request:',
                value: "#{obj.request}"
            },
            {
                title: 'Decision Maker',
                value: "#{meeting.dm.full_name} (#{meeting.dm_id}) - #{meeting.dm.email} - #{meeting.dm.phone_number} - #{meeting.dm.company_name}"
            },
            {
                title: 'Decision Maker Address',
                value: "#{meeting.dm.full_address}"
            },
            {
                title: 'Salesperson',
                value: "#{meeting.sp.full_name} (#{meeting.sp_id}) - #{meeting.sp.email} - #{meeting.sp.phone_number} - #{meeting.sp.company_name}"
            },
            {
                title: 'Desired Time',
                value: "#{meeting.display_desired_day}, between #{meeting.show_desired_start_time} to #{meeting.show_desired_end_time}"
            },
            {
                title: 'Scheduled Time',
                value: "#{meeting.show_date}, from #{meeting.show_start_time} to #{meeting.show_end_time}"
            },
            {
                title: 'Price/Hr',
                value: "#{meeting.price.format} (total: #{meeting.total_price.format}"
            },
            {
                title: 'Comments from Salesperson',
                value: "#{meeting.sp_requested_comments}"
            }

        ]
    }
    send_to_slack(notification)
  end

  def new_user_notification(obj)
    notification = {
        text: 'New User',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New User',
                value: "#{obj.full_name}"
            },
            {
                title: 'ID',
                value: "#{obj.id}"
            },
            {
                title: 'Email',
                value: "#{obj.email}"
            },
            {
                title: 'Company',
                value: "#{obj.company_name}"
            },
            {
                title: 'Phone Number',
                value: "#{obj.phone_number}"
            }
        ]
    }
    send_to_slack notification
  end

  def confirmation_help_request(obj, phone_number)
    notification = {
        text: 'A User needs help Confirming Email',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'User',
                value: "#{obj.full_name}"
            },
            {
                title: 'ID',
                value: "#{obj.id}"
            },
            {
                title: 'Email',
                value: "#{obj.email}"
            },
            {
                title: 'Company',
                value: "#{obj.company_name}"
            },
            {
                title: 'Phone Number',
                value: "#{phone_number}"
            }
        ]
    }

    send_to_slack notification
  end

  def new_meeting_notification(obj)
    notification = {
        text: 'New Meeting',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New Meeting',
                value: "ID: #{obj.id}, CONFIRMATION: #{obj.confirmation_number}"
            },
            {
                title: 'Decision Maker',
                value: "#{obj.dm.full_name} (#{obj.dm_id}) - #{obj.dm.email} - #{obj.dm.phone_number} - #{obj.dm.company_name}"
            },
            {
                title: 'Decision Maker Address',
                value: "#{obj.dm.full_address}"
            },
            {
                title: 'Salesperson',
                value: "#{obj.sp.full_name} (#{obj.sp_id}) - #{obj.sp.email} - #{obj.sp.phone_number} - #{obj.sp.company_name}"
            },
            {
                title: 'Desired Time',
                value: "#{obj.display_desired_day}, between #{obj.show_desired_start_time} to #{obj.show_desired_end_time}"
            },
            {
                title: 'Price/Hr',
                value: "#{obj.price.format} (total: #{obj.total_price.format}"
            },
            {
                title: 'Comments from Salesperson',
                value: "#{obj.sp_requested_comments}"
            }
        ]
    }
    send_to_slack notification
  end

  def new_bid_notification(obj)
    dm = obj.meeting_queue.user
    notification = {
        text: 'New Bid',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New Bid',
                value: "ID: #{obj.id}"
            },
            {
                title: 'Decision Maker',
                value: "#{dm.full_name} (#{dm.id}) - #{dm.email} - #{dm.phone_number} - #{dm.company_name}"
            },
            {
                title: 'Salesperson',
                value: "#{obj.user.full_name} (#{obj.user_id}) - #{obj.user.email} - #{obj.user.phone_number} - #{obj.user.company_name}"
            },
            {
                title: 'Bid amount',
                value: "#{obj.price.format}"
            }
        ]
    }
    send_to_slack notification
  end

  def new_question_notification(obj)
    dm = obj.paid_inbox.user
    notification = {
        text: 'New Question',
        username: "Awesom-O",
        icon_emoji: ":loudspeaker:",
        fields: [
            {
                title: 'New Question',
                value: "ID: #{obj.id}"
            },
            {
                title: 'To Decision Maker:',
                value: "#{dm.full_name} (#{dm.id}) - #{dm.email} - #{dm.phone_number} - #{dm.company_name}"
            },
            {
                title: 'From Salesperson:',
                value: "#{obj.user.full_name} (#{obj.user_id}) - #{obj.user.email} - #{obj.user.phone_number} - #{obj.user.company_name}"
            },
            {
                title: 'Question:',
                value: "#{obj.question}"
            },
            {
                title: 'Price: ',
                value: "$#{obj.price} ( + $#{obj.platform_fee} as platform fee)"
            }
        ]
    }
    send_to_slack notification
  end

  private

  def send_to_slack(notification)
    if Rails.env.production?
      SLACK.ping notification
    end
  end

end