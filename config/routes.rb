LivingToLearn::Application.routes.draw do
  #match "/application.manifest" => Rails::Offline

  #match 'curriculum/root', :to => 'curriculum#index', :as => 'curriculum_root'
  #match 'curriculum/age/:age', :to => 'curriculum#index', :as => 'curriculum_age'
  #match 'curriculum/:name/:node_id', :to => 'curriculum#index', :as => 'curriculum_node'

  #match 'curriculum/node/:node_id', :to => 'curriculum#node', :as => 'curriculum_node'

  match 'curriculum/node/:node_id/age/:age', :to => 'curriculum#index', :as => 'curriculum_node_age'
  match 'curriculum/age/:age', :to => 'curriculum#index', :as => 'curriculum_root_age'
  match 'curriculum', :to => 'curriculum#index', :as => 'curriculum_root'

  resources :curriculum_content_areas

  match 'curriculum_standards_for/:content_area_id', :to => 'curriculum_standards#for_content_area', :as => 'content_area_standards'
  resources :curriculum_standards

  match 'curriculum_strands_for/:standard_id', :to => 'curriculum_strands#for_standard', :as => 'standard_curriculum_strands'
  resources :curriculum_strands

  match 'curriculum_content_statements_for/:strand_id', :to => 'curriculum_content_statements#for_strand', :as => 'strand_content_statements'
  resources :curriculum_content_statements

  match 'curriculum_cumulative_progress_indicators_for/:content_statement_id', :to => 'curriculum_cumulative_progress_indicators#for_content_statement', :as => 'statement_cumulative_progress_indicators'

  resources :educational_resources

  resources :curriculum_cumulative_progress_indicators
  netzke

  devise_for :users, :controllers =>  {
    :registrations => 'registrations',
    :sessions => 'sessions'
  } do
    get "login", :to => "sessions#new"
    get "logout", :to => "sessions#destroy"
    get "register", :to => "registrations#new"
    get "register_context", :to => "registrations#new_context"
  end
  #devise_scope :user do
  #  get "sign_in/:context_id", :to => 'registrations#new', :as =>"new_user_registration_in_context"
  #end

  resources :users, :only => [:index, :show]
  resources :marketing_context_types
  resources :site_contents

  resources :subdomains

  match 'activities/open_list', :to => 'time_logs#open_list', :as => 'open_time_logs'
  match 'activities/start', :to => 'activities#start', :as => 'activities_start'
  match 'activities/list', :to => 'activities#list', :as => 'activities_list'
  match 'activities/time_logged', :to => 'activities#time_logged', :as => 'activity_time_logged'

  match 'activities/:id/delete', :to => 'activities#delete', :as => 'delete_activity'

  match 'activities/:activity_id/start', :to => 'time_logs#start', :as => 'start_activity'
  match 'activities/:activity_id/time_logs/:time_log_id/continue', :to => 'time_logs#continue', :as => 'continue_activity'
  match 'activities/:activity_id/time_logs/:time_log_id/end', :to => 'time_logs#end', :as => 'end_activity'

  #TODO RESTFUL form of this caused loss of session!
  match 'activities/:activity_id/time_logs/:id/delete.:format', :to => 'time_logs#delete', :as => 'delete_time_log'

  match '/activities/new_sub_for_:parent_activity_id', :to => 'activities#new_sub', :as => 'new_sub_activity'
  resources :activities do
     resources :time_logs
  end
  resources :activities

  match 'user_private/index', :to => 'user_private#index', :as =>"user_private"

  match 'user/:user_id/add_marketing_context/:marketing_context_id', :to => 'users#add_marketing_context', :as => 'add_user_marketing_context'
  match 'user/:user_id/delete_marketing_context/:marketing_context_id', :to => 'users#delete_marketing_context', :as => 'delete_user_marketing_context'
  match 'user/:user_id/select_marketing_context/:marketing_context_id', :to => 'users#select_marketing_context', :as => 'select_user_marketing_context'
  match 'log_into/:email', :to => 'welcome#log_into', :as => 'log_into'

################

  match '/nj/gc/district_:district_nickname/site', :to => 'district#site', :as => 'district_site'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/site', :to => 'school#site', :as => 'school_site'

################

  match '/nj/gc/district_:district_nickname/character_book', :to => 'character#district', :as => 'district_character_page'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/character_book', :to => 'character#school', :as => 'school_character_book'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/character_book/content_area_:content_area_code/standard_code_:standard_code', :to => 'character#standard', :as => 'school_character_book_standard'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/character_book/content_area_:content_area_code/standard_:standard_code/strand_:strand_code', :to => 'character#strand', :as => 'school_character_book_strand'

  match '/nj/gc/district_character_book_pages', :to => 'district#character_book_pages', :as => 'district_character_book_pages'

################

  match '/nj/gc/district_:district_nickname/career_book', :to => 'career#district', :as => 'district_career_page'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/career_book', :to => 'career#school', :as => 'school_career_book'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/career_book/content_area_:content_area_code/standard_code_:standard_code', :to => 'career#standard', :as => 'school_career_book_standard'

  match '/nj/gc/district_:district_nickname/school_:school_nickname/career_book/content_area_:content_area_code/standard_:standard_code/strand_:strand_code', :to => 'career#strand', :as => 'school_career_book_strand'

  match '/nj/gc/district_career_book_pages', :to => 'district#career_book_pages', :as => 'district_career_book_pages'

#################

  match '/for_:topic_symbol/service_:service_symbol', :to => 'welcome#goto_topic_service', :as => 'goto_topic_service'
  match '/for_:topic_symbol', :to => 'welcome#goto_topic', :as => 'goto_topic'

#################

  match '/site', :to => 'welcome#site', :as => 'site_root'
  match '/sites', :to => 'welcome#sites', :as => 'sites_root'

  #match '/' => 'welcome#subdomain_index', :constraints => { :subdomain => /.+/ }
  match 'index' => 'welcome#index'
  root :to => "welcome#index"

end
