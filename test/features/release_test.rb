require 'test_helper'

class ReleaseTest < FeatureTest
  include LateralNavigation

  def setup
    super
    @release = create :release, :current
    assemble_issues_for(release: @release)
    @next_release = create :release, :next
    assemble_issues_for(release: @next_release)
    @previous_release = create :release, :previous
    assemble_issues_for(release: @previous_release)
  end

  def test_basic_content
    visit release_path(@release)
    assert page.has_title? "WednesdayShelf"
    assert_content @release.pretty_date
    @release.issues.each do |issue|
      within "##{issue.diamond_number}" do
        assert_content issue.clean_title
        assert page.has_link?("", {href: issue_path(issue)})
        assert page.has_css?('.comic-issue-cover')
      end
    end
  end

  def test_lateral_nagivation
    assert_previous_nav(start_path: root_path, target_path: release_path(@previous_release))
    assert_next_nav(start_path:root_path, target_path: release_path(@next_release))
  end

  private

  def assemble_issues_for(release: release, count: 30)
    count.times do |i|
      string = "#{i}#{release.date.stamp("12-31-2006")}"
      create :issue, release: release, homing_string: string, diamond_number: string, series: (create :series)
    end
  end
end
