# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gradmx_session',
  :secret      => '635e12121d71659b8900a19258245e197cfbc0cdb041480e9003badd20028f851425a25254b170b130007f7a830cb5e58d9b7f2bc7ffc4a82b5bc40e64dae8f5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
