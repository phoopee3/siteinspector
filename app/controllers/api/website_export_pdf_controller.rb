# frozen_string_literal: true

module Api
  class WebsiteExportPdfController < ApiBaseController
    load_and_authorize_resource :website

    def show
      pdf = WebsitePdfExport.new(@website).generate

      filename = "#{@website.domain.gsub(/[^a-z0-9]/i, '_')}_report_#{Time.current.strftime('%Y%m%d')}.pdf"

      # Send the PDF as a response
      send_data pdf,
                filename: filename,
                type: 'application/pdf',
                disposition: 'attachment'
    end
  end
end

