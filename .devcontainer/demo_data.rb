# Demo troop for trying Scoutplan in a codespace. Safe to run more than once.
Flipper.enable(:deliver_email)
Flipper.enable(:digest)

unit = Unit.find_by(name: "Demo Troop") ||
       Unit.create!(name: "Demo Troop", location: "Chicago, IL", email: "demo-troop@example.com")
unit.settings(:communication).update!(digest: "true")

user = User.find_or_initialize_by(email: "admin@example.com")
user.assign_attributes(first_name: "Demo", last_name: "Admin", password: "scoutplan123")
user.save!

membership = unit.unit_memberships.find_or_initialize_by(user: user)
membership.assign_attributes(role: "admin", status: "active", member_type: "adult")
membership.save!

category = unit.event_categories.first || unit.event_categories.create!(name: "Troop Meeting")

[["Troop Meeting", 2.days], ["Fall Campout", 5.days], ["Service Project", 12.days]].each do |title, offset|
  next if unit.events.exists?(title: title)

  starts = (Time.current + offset).change(hour: 19)
  unit.events.create!(title: title, starts_at: starts, ends_at: starts + 2.hours,
                      status: "published", event_category: category)
end

paths = Rails.application.routes.url_helpers
puts "Demo troop ready. After signing in, go to #{paths.unit_automated_messages_path(unit)}"
