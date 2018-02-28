class NewProject
  include Shared::NormalizedUrl

  include ActiveModel::Model
  include ActiveModel::Validations::Callbacks

  attr_accessor :url

  validates :url, presence: true

  validate :real_url

  private

  # it can use a unique url
  # def unique_url
  #   errors.add(:phone, 'is already taken') if Project.exists?(url: normalized_url)
  # end

  def real_url
    URI.parse(normalized_url)

    errors.add(:url, 'is not a valid url') unless PublicSuffix.valid?(normalized_url)
  rescue URI::InvalidURIError
    errors.add(:url, 'is not a valid url')
  end
end

