module SilverwebRealestate
  class Railtie < Rails::Railtie
    initializer "silverweb_realestate.update_cloud_menu" do
          
      SilverwebCms::Config.add_nav_item({:name=>"Realestate", :controller=>'properties', :action=>'index'})
        
      SilverwebCms::Config.add_menu_class(["Show Properties","menu_show_properties"])

       SilverwebCms::Config.add_menu_fields(["re_search_type","re_search_term", "re_search_param","re_search_class"])

    end
    
    initializer "Include your code in the controller" do
      ActiveSupport.on_load(:action_controller) do

       #  include SilverwebRealestate
       # SilverwebRealestate::Config.flexmls_initialize
      end
    end
    
     config.to_prepare do
      SiteController.send(:include, SilverwebEcom::ControllerExtensions::SiteControllerExtensions)
      MenusController.send(:include, SilverwebEcom::ControllerExtensions::MenusControllerExtensions)

    end
  end
end