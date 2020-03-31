repo = '/etc/chef/repo'

# Paths
cookbook_path  repo + '/cookbooks'
role_path      repo + '/roles'

# Logging
log_level      :info   # Log additional info
log_location   STDOUT  # Write logs to the terminal