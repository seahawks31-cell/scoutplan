# frozen_string_literal: true

# Only on the try-it branch, and only when SCOUTPLAN_TRY_IT=1 (set by .devcontainer/env.sh).
# GitHub Codespaces' port forwarding sends an Origin header (http://localhost:3000) that
# doesn't match the public codespace URL, so Rails' CSRF origin check rejects every form
# post. The authenticity token is still checked.
if ENV["SCOUTPLAN_TRY_IT"] == "1"
  ActiveSupport.on_load(:action_controller_base) do
    self.forgery_protection_origin_check = false
  end

  # Development is configured for DigitalOcean Spaces; keep uploads on local disk instead.
  Rails.application.config.active_storage.service = :local if Rails.env.development?
end
