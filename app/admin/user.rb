ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :email, :password, :password_confirmation, :active
  scope :active_user
  scope :deactive_user
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
form do |f|
      f.inputs "User" do
        f.input :email
        f.input :password
        f.input :password_confirmation
        f.input :active
      end
      f.actions
    end


   member_action :activate, method: :put do
    user = User.find(params[:id])
    user.update(active: true) unless user.active?
    #user.update(active: false) unless !user.active?
    redirect_to admin_user_path(user)
  end

  action_item :activate, :only => :show do
    link_to "Activate", activate_admin_user_path(user), :method=> :put unless user.active?
    #link_to "Deactivate", activate_admin_user_path(user), method: :put unless !user.active?

  end
  member_action :deactivate, method: :put do
    user = User.find(params[:id])
    user.update(active: false) unless !user.active?
    #user.update(active: false) unless !user.active?
    redirect_to admin_user_path(user)
  end
  action_item :activate, :only => :show do
    link_to "Deactivate", deactivate_admin_user_path(user), :method=> :put unless !user.active?
    #link_to "Deactivate", activate_admin_user_path(user), method: :put unless !user.active?

  end

end
