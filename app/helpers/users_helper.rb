module UsersHelper

  def gravatar_for(user, methodParams = {})
    methodParams[:size] = 52 unless methodParams[:size]
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}?s=#{methodParams[:size]}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", target: '_link')
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}"
  end

end
