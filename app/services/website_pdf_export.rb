# frozen_string_literal: true

class WebsitePdfExport
  def initialize(website)
    @website = website
    @report_presenter = ReportPresenter.new(website)
    @stats = ReportStats.new(website).stats
  end

  # To create an html file, uncomment these method

  # def generate
  #   render_html
  # end

  # To create a PDF, uncomment this method

  def generate
    WickedPdf.new.pdf_from_string(
      render_html,
      # header: { content: header_html },
      # footer: { content: footer_html },
      margin: { top: 20, bottom: 20, left: 10, right: 10 },
      page_size: 'A4'
    )
  end

  private

  def render_html
    # Rails.logger.debug "Rendering HTML with website: #{@website.inspect}"

    ApplicationController.render(
      template: 'pdf/website_report',
      layout: false, # No layout for simplicity
      locals: { website: @website }
    )
  end

  # def render_html
  #   ApplicationController.render(
  #     template: 'pdf/website_report',
  #     layout: 'pdf',
  #     locals: { 
  #       website: @website,
  #       stats: @stats,
  #       pages: @report_presenter.pages
  #     }
  #   )
  # end
  
  def header_html
    ApplicationController.render(
      template: 'pdf/header',
      layout: false,
      locals: { website: @website }
    )
  end

  def footer_html
    ApplicationController.render(
      template: 'pdf/footer',
      layout: false,
      locals: { website: @website }
    )
  end
end

