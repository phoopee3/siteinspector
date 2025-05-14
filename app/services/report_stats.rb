# filepath: /home/user/Desktop/siteinspector/app/services/report_stats.rb
class ReportStats
  def initialize(website)
    @website = website
  end

  def stats
    # Example logic to calculate stats
    {
      total_pages: @website.pages.count,
      total_errors: @website.errors.count,
      #uptime: @website.uptime_percentage
    }
  end
end