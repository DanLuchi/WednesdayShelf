class Issue < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  has_many :variants
  belongs_to :series
  belongs_to :release

  has_attached_file :cover,
      styles: {
        :small => ["150x230", :png],
        :medium => ["300x460", :png]
        }
    #:url => "/system/assets/images/:class:attachment/:id_partition/:style/:basename.:extension",
    #:path => "app/assets/images/:class/:attachment/:id_partition/:style/:basename.:extension"

  def popup_url
    IssueUrlMaker.new(self.diamond_no).get_url
  end

  def update_shipping
    popup_hasher = PopupHasher.new(self.diamond_no)
    cancel_check = IssueCancelChecker.new(popup_hasher.get_html, self)
    puts "Updating shipping for #{self.title}"
    pp "test"
    return nil if cancel_check.check_for_not_found
    pp "test 2"
    return nil if cancel_check.check_for_cancelled
    pp" test 3 "
    pp self.id
    self.release = Release.where(:ship_date => DateFormatter.new(popup_hasher.to_hash["Est Ship Date"]).format_date).first_or_create
    self.save
    puts "Updated Shipping for #{self.title}"
  end

  def download_cover
    IssueImageDownloader.new(self, MASTER_LOGIN.agent).download_to_issue
  end
end
