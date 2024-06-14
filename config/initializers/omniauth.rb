Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '656605934885-k6gl0g8intiifl6buf64tblf5obm60mo.apps.googleusercontent.com', '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', {
      scope: 'userinfo.email, calendar',
      prompt: 'consent',
      access_type: 'offline'
    }
  end
  