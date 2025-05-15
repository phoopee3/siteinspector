# frozen_string_literal: true

module Api
  class WebsiteExportPdfController < ApiBaseController
    load_and_authorize_resource :website

    # This method gets the website and all of its associated data
    def show
      @website = Website.includes(
        pages: [
          :page_errors,
          :broken_links,
          :custom_rule_results
        ]
      ).find(@website.id)
    
      website_data = {
        'domain' => @website.domain,
        'pages' => @website.pages.map do |page|
          {
            'id' => page.id,
            'title' => page.title,
            'url' => page.url,
            'broken_links' => page.broken_links.map do |link|
              {
                'id' => link.id,
                'url' => link.url,
                'status' => link.status,
                # 'is_resolved' => link.is_resolved
              }
            end,
            'page_errors' => page.page_errors.map do |error|
              {
                'id' => error.id,
                'error_type' => error.error_type,
                # 'problem' => error.problem,
                # 'solution' => error.solution,
                'text' => error.text,
                'correction' => error.correction,
                'context' => error.context,
                'status' => error.status
              }
            end,
            'custom_rule_results' => page.custom_rule_results.map do |result|
              {
                'id' => result.id,
                'condition' => result.condition,
                'pattern' => result.pattern
              }
            end
          }
        end
      }
    
      # html = WebsitePdfExport.new(website_data).generate
      # render html: html.html_safe # Render the raw HTML for debugging

      pdf = WebsitePdfExport.new(website_data).generate
    
      send_data pdf,
                filename: "#{@website.domain.gsub(/[^a-z0-9]/i, '_')}_report_#{Time.current.strftime('%Y%m%d')}.pdf",
                type: 'application/pdf',
                disposition: 'attachment'
    end

    # To create a plain html file, uncomment this method

    # def show
    #   # @website = Website.find(1) # Ensure @website is set
    #   # Rails.logger.debug "Website: #{@website.inspect}"
    #   html = WebsitePdfExport.new(@website).generate
    #   render html: html.html_safe # Render the raw HTML for debugging
    # end

    # To create a PDF, uncomment this method
    # def show
    #   pdf = WebsitePdfExport.new(@website).generate

    #   filename = "#{@website.domain.gsub(/[^a-z0-9]/i, '_')}_report_#{Time.current.strftime('%Y%m%d')}.pdf"

    #   # Send the PDF as a response
    #   send_data pdf,
    #             filename: filename,
    #             type: 'application/pdf',
    #             disposition: 'attachment'
    # end

  end
end

