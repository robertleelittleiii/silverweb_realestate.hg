module SilverwebEcom
  module ControllerExtensions
  
    module MenusControllerExtensions
    
      def self.included(base)
        base.send(:include, InstanceMethods)
        # base.alias_method_chain :new, :my_module
      end

      module InstanceMethods
        
        def update_checkbox_tag
          @menu = Menu.find(params[:id])
          @tag_name=params[:tag_name] || "tag_list"
    
          if @menu.send(@tag_name).include?(params[:field]) then
            @menu.send(@tag_name).remove(params[:field])
          else
            @menu.send(@tag_name).add(params[:field])
          end
    
          @menu.save

          render(nothing: true)

      
        end
        
        def render_category_div
          @menu=Menu.find(params[:id])
          render(partial: "category_div")
        end
  
      end
      
      
    end
    
    module SiteControllerExtensions
     
      def self.included(base)
        base.send(:include, InstanceMethods)
        # base.alias_method_chain :new, :my_module
      end

      module InstanceMethods
        
      
        #       before_filter :find_cart, :except => :empty_cart

        def show_properties
          puts("in show properties...")
          
          session[:mainnav_status] = false
          @page_name = params["page_name"]
          #          session[:last_catetory] = request.env['REQUEST_URI']
          # @page_name = Menu.find(session[:parent_menu_id]).name rescue params[:current_page]
          #          @page_info = Page.where(:title => params[:page_name]).first || ""
          #          puts("---------the page=> #{@page_info.inspect}")
          #          @products_per_page = Settings.products_per_page.to_i || 8
          #          @category_id = params[:category_id].to_s.downcase || ""
          #          @department_id = params[:department_id].to_s.downcase || ""
          #          @category_children = params[:category_children] || false
          #          @get_first_submenu = params[:get_first_sub] || false
          #          @the_page = params[:page] || "1"
          #    
          #          @menu = Menu.where(:name=>@category_id).first 
          #  
          #          if params[:top_menu] and @get_first_submenu == "true" then
          #            # puts("top_menu id: #{@menu.menus[0].name}")
          #            session[:parent_menu_id] = @menu.id rescue 0
          #            @menu = @menu.menus[0]
          #            @category_id = @menu.name rescue "n/a"
          #
          #          end
          #      
          #@page_name=Menu.find(session[:parent_menu_id]).name rescue ""
          #          begin 
          #            if @category_children == "true" then
          #              @categories =  create_menu_lowest_child_list(@category_id, nil,false) + [@category_id]
          #              puts("categories: #{@categories.inspect} ")
          #              @products_list = Product.where(:product_active=>true).tagged_with(@categories, :any=>true, :on=>:category).tagged_with(@department_id, :on=>:department)
          #
          #            else
          #              if @category_id.blank? or @department_id.blank? then
          #                @products_list = Product.where(:product_active=>true)
          #              else
          #                @products_list = Product.where(:product_active=>true).tagged_with(@category_id, :on=>:category).tagged_with(@department_id, :on=>:department)
          #              end
          #              
          #            end
          #            # puts("=------------ product list found ---------------")
          #            # puts(@products_list.inspect)
          #          rescue
          #            #  @products_list = Product.all
          #          end
          
          limits = params[:limit].blank? ? 100 : params[:limit].to_i
          
          @properties = Property.find(params[:search_by],params[:search_class], params[:search_term], limits)
    
          #          @product_ids = @products_list.collect{|prod| prod.id }
          #
          #          @product_count = @products_list.length
          #
          #          # @products = Kaminari.paginate_array(@products).page(params[:page]).per(@products_per_page)
          #          @products = Product.where(:id=>@product_ids).order("product_ranking DESC").order("position ASC").order("created_at DESC").page(params[:page]).per(@products_per_page)
          #          #    @products = @products.page(params[:page]).per(@products_per_page)
          #
          #          @product_first = params[:page].blank? ? "1" : (params[:page].to_i*@products_per_page - (@products_per_page-1))
          #    
          #          @product_last = params[:page].blank? ? @products.length : ((params[:page].to_i*@products_per_page) - @products_per_page) + @products.length || @products.length
          #
          #          system_action_template = (Settings.product_list_template_name.blank? ? "show_products" : "show_products-" + Settings.product_list_template_name) rescue "show_products"
          #          @action_template = params[:template].blank? ? system_action_template :  params[:template]
          #
          #                
          #          @java_script_custom = (@action_template != "show_products")  ? @action_template + ".js" : "" rescue ""
          #          @style_sheet_custom = (@action_template != "show_products") ? @action_template + ".css" : "" rescue ""
          #   
          
          respond_to do |format|
            format.html { render :action=>@action_template}
            format.xml  { render :xml => @properties }
          end
        end
  


       
        def property_detail

          @property = Property.find(params[:id])
          
          #          if params[:next] then
          #            @product = @product.next_in_collection
          #            puts "=======NEXT========"
          #          end
          #    
          #          if params[:prev] then
          #            @product = @product.previous_in_collection
          #            puts "=======PREV======="
          #
          #          end
          #    
          session[:parent_menu_id] = 0
          
          @page_template = (not @product.custom_layout.blank?) ? "property_detail-" + @product.custom_layout : ("property_detail-" + Settings.product_template_name rescue "property_detail") rescue "property_detail" 
          
          @java_script_custom = (@page_template != "property_detail")  ? @page_template + ".js" : "" rescue ""
          @style_sheet_custom = (@page_template != "property_detail") ? @page_template + ".css" : "" rescue ""
          @page_name = @product.product_name rescue "'Property' not found!!"
    
          @pictures = @product.pictures.where(:active_flag=>true)
    
          @product_details = @product.product_details
    
    
          respond_to do |format|
            format.html { render :action=>@page_template} # show.html.erb
            format.xml  { render :xml => @page }
          end
    
        end




  
        private 
  
  
        
        
      end
    
    end
  
  


  end

end