module UsersHelper

  def gravatar_for(user, size=40)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
