module OmniAuthHelpers

  def set_omniauth(opts={})

    linkedin_data = {
        :provider => :linkedin,
        :uuid     => "1234",
        info: {
            :email => opts.fetch(:email, 'foobar@example.com'),
            :first_name => "foo",
            :last_name => "bar",
            nickname: 'foobar123'
        },
        extra:{
            raw_info:{
                positions: {
                    total: 1,
                    values:
                        [
                            {
                                title: 'CEO',
                                company: {name: 'Some Company LLC'},
                                isCurrent: true
                            }
                        ]


                }
            }
        }
    }

    OmniAuth.config.test_mode = true

    OmniAuth.config.add_mock(:linkedin, linkedin_data)
  end



  def set_invalid_omniauth(opts = {})

    credentials = { :provider => :linkedin,
                    :invalid  => :invalid_crendentials
    }.merge(opts)

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[credentials[:provider]] = credentials[:invalid]

  end

end