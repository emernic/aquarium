namespace :init do

  task :initialize, [:name, :login, :password, :admin] => [:environment] do |t, args|

    puts 'Initializer'

    # Create admin group
    admin_group = Group.find_by_name('admin')
    if not admin_group
      puts 'Creating Admin group'
      admin_group = Group.new
      admin_group.name = 'admin'
      admin_group.description = 'users with administrator privileges'
      admin_group.save
    end

    # Create user
    user = User.find_by_name(:name)
    if not user
      puts 'Creating user #{user.name}'
      user = User.new(name: :name, login: :login, password: :password, password_confirmation: :password)
      user.admin = :admin
      user.save
    end

    # Create user group
    group = Group.find_by_name(user.login)
    if not group
      puts 'Creating user group'
      group = Group.new
      group.name = user.login
      group.description = "A group containing only user #{user.name}"
      group.save
    end

    # Create user membership
    user_membership = Membership.where(user_id: user.id, group_id: group.id)
    if not user_membership
      puts 'Creating user membership'
      user_membership = Membership.new
      user_membership.group_id = group.id
      user_membership.user_id = user.id
      user_membership.save
    end

    # Create admin membership
    if user.admin
      admin_membership = Membership.where({user_id: user.id, group_id: admin_group.id})
      if not admin_membership
        puts 'Creating admin membership'
        admin_membership = Membership.new
        admin_membership.user_id = user.id
        admin_membership.group_id = admin_group.id
        admin_membership.save
      end
    end

    puts 'Initializer complete'

  end

end

# Usage
# rake init:initialize[name,login,password,admin]