# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_miktest_session',
  :secret      => '605ef62e0c3071c6499d40aa68ed7cf35b34e8c467b8f9c38562e443b872f167c6dadbe132d9c120b7a5aa329205f505d93018184fbf4ca6431d23f2e6454f62'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
