module ApplicationHelper
  def getFullTitle(page_title)
    title = "Ruby on Rails Tutorial Sample App"
    title = page_title.empty? ? title : "#{title} | #{page_title}"

    #if(page_title)
    #  return "Ruby On Rai"
    #else
    #
    #end
  end
end
