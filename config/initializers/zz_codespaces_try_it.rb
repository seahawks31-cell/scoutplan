# frozen_string_literal: true

# Only on the try-it branch, and only when started via .devcontainer/start.sh.
# GitHub Codespaces' port forwarding sends an Origin header (http://localhost:3000) that
# doesn't match the public codespace URL, so Rails' CSRF origin check rejects every form
# post. The authenticity token is still checked.
if ENV["SCOUTPLAN_TRY_IT"] == "1"
  ActiveSupport.on_load(:action_controller_base) do
    self.forgery_protection_origin_check = false
  end
end
