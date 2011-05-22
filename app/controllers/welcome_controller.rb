class WelcomeController < ApplicationController

  before_filter :no_users
  before_filter :get_marketing_contexts

  before_filter :get_topic
  before_filter :get_service

  before_filter :only_for_site , :only => :site

  def no_users
    @disable_logins = true
  end

  def get_marketing_contexts
    if user_signed_in?
      @existing_marketing_context_types =
        current_user.marketing_context_types
      @possible_marketing_context_types =
        MarketingContextType.all_except(@existing_marketing_context_types)
    end
  end

  def get_topic
    @goto_topic_symbol = session[:goto_topic_symbol] = if  params[:topic_symbol]
      params[:topic_symbol]
    elsif user_signed_in? and current_user.marketing_contexts.length > 0
      current_user.current_marketing_context_type.name
    else
      'welcome'
    end
    @marketing_context_type = MarketingContextType.find_by_name(@goto_topic_symbol.gsub('_',' '))
  end

  def get_service
    @goto_service_symbol = session[:goto_service_symbol] = if params[:service_symbol]
      params[:service_symbol]
    else
      @goto_topic_symbol
    end
  end

################

  def goto_topic_service
   render "index"
  end

  def goto_topic
    render "index"
  end

  def site
  end

  def sites
  end

  def index
      render
  end

end
