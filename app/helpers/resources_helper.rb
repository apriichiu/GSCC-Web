module ResourcesHelper




def login_link
template = <<-eos
<div id="login-link">
  <% if flash[:notice] -%> <div id="notice"><%= flash[:notice] %></div>
  <% end -%>
  <% if admin? %>
  <%= link_to 'New Folder', new_folder_path+"?from="+request.env['PATH_INFO'] %> | <%= link_to 'New Entry', new_entry_path+"?from="+request.env['PATH_INFO'] %> | <%= link_to 'New Attachment', new_attachment_path+"?from="+request.env['PATH_INFO'] %> | <%= link_to 'Logout', logout_path %> <br />
  <%= link_to 'List Folders', "/folders" %> | <%= link_to 'List Entries', "/entries" %> | <%= link_to 'List Attachments', "/attachments" %>
  <% else %>
  <%= link_to 'Login', login_path+"?redirect="+request.env['PATH_INFO'] %> to add/edit <%= params[:controller] %>
  <% end %>
</div>

eos
    return render_to_string(:inline => template, :type => :erb)
end

def get_filetype_image(attachment)
  if attachment.object_content_type == "application/pdf"
    return image_tag( "/images/filetypes/pdf.png", :size => "25x25");
  elsif attachment.object_content_type == "application/msword"
    return image_tag("/images/filetypes/word.png", :size => "25x25");
  elsif attachment.object_content_type == "audio/mp3"
    return image_tag("/images/filetypes/mp3.png", :size => "35x35");
  elsif attachment.object_content_type == "text/plain"
    return image_tag("/images/filetypes/txt.png", :size => "25x25");
  elsif attachment.object_content_type == "image/png"
    return image_tag("/images/filetypes/png.png", :size => "25x25");
  elsif attachment.object_content_type == "application/zip"
    return image_tag("/images/filetypes/zip.png", :size => "25x25");
  elsif attachment.object_content_type == "image/jpeg"
    return image_tag("/images/filetypes/jpeg.png", :size => "25x25");
  else 
    return image_tag("/images/filetypes/others.png", :size => "25x25");
  end
end

def fetch_attachments (entry)
  output = "";
  entry.attachments.each do |a|
    output += link_to(get_filetype_image(a), a.object.url, :title => a.name+" - "+a.object_file_name);
    output += "&nbsp;"
  end
  return output;
end

end
