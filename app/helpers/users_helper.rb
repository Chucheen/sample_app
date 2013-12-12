module UsersHelper

  def gravatar_for(user, methodParams = {})
    methodParams[:size] = 52 unless methodParams[:size]
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{methodParams[:size]}"
    puts gravatar_url
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png"
  end

end
