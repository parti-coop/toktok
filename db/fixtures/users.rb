User.seed_once(:uid, :provider) do |u|
  u.email = ENV["DEFAULT_ADMIN_EMAIL"]
  u.uid = ENV["DEFAULT_ADMIN_UID"]
  u.provider = ENV["DEFAULT_ADMIN_PROVIDER"]
  u.nickname = '톡톡'
  u.role = 'staff'
end
