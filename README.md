# Setup user management on a linux box using Chef-solo

For the Step2 of the exercise I've created a user_administration Chef cookbook to manage deletion and creations of the users. While it's not a CLI on its own, it's capable of managing user creation and deletion if you run it. 

I do understand that modifying a cookbook attributes to perform deletion and creation is not an action to be run often, but Configuration management tools are designed to maintain the state of the hosts and rollout changes to multiple instances rather than being used as a CLI.  

## Assumptions made:
1. Existing host with root repmissions to it
2. We'll be using Chef-solo as a config management (to install on a given host: `curl -L https://omnitruck.chef.io/install.sh | bash -s -- -v 13`)


## Requirements:
* Linux host
* Chef-solo installed on the host:
```
[root@example ~]# chef-solo -v
Chef: 13.12.14
```

## Chef folder structure on my remote Linux host:
content of `/etc/chef`:

```
- solo.rb
- repo
- - cookbooks
- - - user_administration
- - - - attributes
- - - - - default.rb
- - - - recipes
- - - - - default.rb
- - - - metadata.rb
- - nodes
- - - example.compute.internal.json
- - roles
```

## Usage 

* Creation and deletion of the users controlled by `repo/cookbooks/user_administration/attributes/default.rb` file

* Default arrays to delete and create users in `user_administration/attributes/default.rb`:
```ruby
default['user_administration']['create_users'] = ['gene-test-solo-create', 'gene-test-solo-create-1']
default['user_administration']['delete_users'] = ['gene-test-solo-1']
```

* In order to perform cookbook run from within a host: `chef-solo -o 'user_administration'`

Expected output:
```bash
Installing Cookbook Gems:
Compiling Cookbooks...
Converging 3 resources
Recipe: user_administration::default
  * linux_user[gene-test-solo-1] action create[2020-03-31T22:23:59+00:00] INFO: Processing linux_user[gene-test-solo-1] action create (user_administration::default line 2)
[2020-03-31T22:23:59+00:00] INFO: linux_user[gene-test-solo-1] created

    - create user gene-test-solo-1
  * linux_user[gene-test-solo-create] action remove[2020-03-31T22:23:59+00:00] INFO: Processing linux_user[gene-test-solo-create] action remove (user_administration::default line 12)
[2020-03-31T22:23:59+00:00] INFO: linux_user[gene-test-solo-create] removed

    - remove user gene-test-solo-create
  * linux_user[gene-test-solo-create-1] action remove[2020-03-31T22:23:59+00:00] INFO: Processing linux_user[gene-test-solo-create-1] action remove (user_administration::default line 12)
[2020-03-31T22:23:59+00:00] INFO: linux_user[gene-test-solo-create-1] removed

    - remove user gene-test-solo-create-1
[2020-03-31T22:23:59+00:00] WARN: Skipping final node save because override_runlist was given
[2020-03-31T22:23:59+00:00] INFO: Chef Run complete in 0.136979979 seconds
[2020-03-31T22:23:59+00:00] INFO: Skipping removal of unused files from the cache
```


