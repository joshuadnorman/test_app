module ApplicationHelper
    
    def gravatar_for(user,options = {size:80})
        require 'digest/md5'
        email_address = user.email.downcase
        size = options[:size]
        hash = Digest::MD5.hexdigest(email_address)
        image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
        # below is what i wanted to do , so this would be the correct html but it is not rendered like that , can return image_tag
        #   "<img src=\"#{image_src}\" alt=\"#{user.username}'s avatar'\" width=\"500\" height=\"600\">"
        image_tag(image_src,alt:"#{user.username}'s Avatar",class:"rounded mx-auto d-block")
    end 
end
