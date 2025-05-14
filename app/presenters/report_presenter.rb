# filepath: /home/user/Desktop/siteinspector/app/presenters/report_presenter.rb
class ReportPresenter
  def initialize(website)
    @website = website
  end

  def pages
    # Example logic to return pages for the report
    @website.pages.map { |page| { title: page.title, url: page.url } }
  end
end