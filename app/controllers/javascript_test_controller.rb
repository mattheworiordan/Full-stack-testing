class JavascriptTestController < ApplicationController
  layout 'javascript_test'
  before_filter :ensure_suitable_environment

  def render_test
    render :layout => 'javascript_test', :template => "../../spec/javascript/#{params[:script].gsub(/[^A-Za-z0-9_-]/,'')}_spec.js", :content_type => 'text/html'
  end

  private
    def ensure_suitable_environment
      render :status => :forbidden unless ['development','test'].include?(Rails.env)
    end
end