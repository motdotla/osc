module ApplicationHelper
  def library_name(github_url)
    URI.parse(github_url).path.split('/')[-1] 
  end
end
