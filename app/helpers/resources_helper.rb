module ResourcesHelper

def login_link
template = <<-eos
<div id="login-link">
  <% if flash[:notice] -%> <div id="notice"><%= flash[:notice] %></div>
  <% end -%>
  <% if admin? %>
  <%= link_to 'New Folder', new_folder_path %> | <%= link_to 'New Entry', new_entry_path %> | <%= link_to 'New Attachment', new_attachment_path %> | <%= link_to 'Logout', logout_path %>
  <% else %>
  <%= link_to 'Login', login_path+"?redirect="+request.env['PATH_INFO'] %> to add/edit <%= params[:controller] %>
  <% end %>
</div>

eos
    return render_to_string(:inline => template, :type => :erb)
end

end
