# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_BP01_session',
  :secret      => '4cb2000190178ac881ba05501fbdd4ef34166fb0c3e4e7483c71300a877b326e5ef71c984d77f5d8288580b8fb62785238de4f148fb6669ffc427b8c33ee42f4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
