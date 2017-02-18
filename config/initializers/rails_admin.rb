RailsAdmin.config do |config|
  
  config.model 'Rich' do
    visible false
  end
  
  config.included_models = ["User", 'Hotel', 'Apartment', 'Room', 'Client']
  
  
  require 'i18n'
  I18n.default_locale = 'pt-BR'

  ### Popular gems integration

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard do
      statistics true
    end
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
 
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.role.name == 'admin' || current_user.role.name == 'user'
  end
  
  config.current_user_method(&:current_user)
  
  config.main_app_name = Proc.new { |controller| [ "Eventos", "#{controller.params[:action].try(:titleize)}" ] }
  
end
