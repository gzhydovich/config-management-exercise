node['user_administration']['create_users'].each do |u|
    user u do
        action :create
        shell '/sbin/bash'
        comment 'User created by the chef-solo user_administration cookbook'
    end
end
  
  
  
node['user_administration']['delete_users'].each do |u|
    user u  do
        action :remove
        shell '/sbin/nologin'
        comment 'Test attempt'
    end
end