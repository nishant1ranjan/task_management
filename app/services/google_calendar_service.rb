require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
APPLICATION_NAME = 'Task Management Application'.freeze
REDIRECT_URI = 'http://localhost:3000/oauth2callback'.freeze    
CLIENT_SECRETS_PATH = './config/initializers/google_client_secret.json'.freeze
CREDENTIALS_PATH = 'token.yaml'.freeze
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR

class GoogleCalendarService
  def initialize
    @service = Google::Apis::CalendarV3::CalendarService.new
    @service.client_options.application_name = APPLICATION_NAME
    @service.authorization = authorize
  end

  def add_event(task)
    event = Google::Apis::CalendarV3::Event.new(
      summary: task.title,
      description: task.description,
      start: {
        date_time: task.deadline.iso8601
      },
      end: {
        date_time: (task.deadline + 1.hour).iso8601
      },
      reminders: {
        use_default: false,
        overrides: [
          { method: 'email', minutes: 24 * 60 },
          { method: 'email', minutes: 60 }
        ]
      }
    )

    @service.insert_event('primary', event)
  end

  private

  def authorize
    client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
    if credentials.nil?
      url = authorizer.get_authorization_url(base_url: OOB_URI)
      puts "Open the following URL in the browser and enter the resulting code after authorization:"
      puts url
      code = gets
      credentials = authorizer.get_and_store_credentials_from_code(user_id: user_id, code: code, base_url: OOB_URI)
    end
    credentials
  end
end
