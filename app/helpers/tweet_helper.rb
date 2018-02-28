module TweetHelper
  def tweet_url(url)
    "http://twitter.com/share?url=#{project_url(url: url)}&text=Donate on @oscitizen to #{url} #FutureOfDonations #NewOSCitizen"
  end
end
