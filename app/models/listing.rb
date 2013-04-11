class Listing < ActiveRecord::Base
  belongs_to :preview

  def is_comic?
    case category
    when "1"
      return true
    else
      return false
    end
  end

  def digest
    ListingDigester.new(self).digest
  end

end
