# frozen_string_literal: true

module ApiAuthHelpers
  def authenticated_header(user)
    user.create_new_auth_token
  end
end
