module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = {class: "ui small left floated circular gravatar image"})
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=identicon"
    image_tag(gravatar_url, alt: user.username, class: options[:class])
  end
end
