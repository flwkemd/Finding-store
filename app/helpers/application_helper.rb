module ApplicationHelper
    def user_roles(user)
        user.roles.map(&:name).join(',').titleize
    end
        # [{name:'user'}, {name:'admin'}]
        # ['user','admin']
        # 'user,admin'
end
