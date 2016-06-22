module SilverwebRealestate
  class Config
    @FLEXMLS_WEBSERVICE_CONNECTION = nil
    @CONFIG = {}
    @FLEXMLS_QUERY_CACHE = {}
    @FLEXMLS_LOOKUP_CACHE = {}
    @FLEXMLS_META_CACHE = {}

    @FLEXMLS_SEARCH_TYPES = ["office","realtor","municipality"]
      
    def self.FLEXMLS_SEARCH_TYPES
      @FLEXMLS_SEARCH_TYPES
    end
    
    @FLEXMLS_SEARCH_CLASSES = [["Residential","A"],["Land/Lots","C"],["Multi-Family","D"],["Commercial","E"],["Residential Rental","F"]]

     def self.FLEXMLS_SEARCH_CLASSES
      @FLEXMLS_SEARCH_CLASSES
    end
    
    def self.FLEXMLS_WEBSERVICE_CONNECTION
      @FLEXMLS_WEBSERVICE_CONNECTION
    end
    
    def self.CONFIG 
      @CONFIG
    end
    
    def self.FLEXMLS_QUERY_CACHE
      @FLEXMLS_QUERY_CACHE
    end
    
    def self.FLEXMLS_LOOKUP_CACHE
      @FLEXMLS_LOOKUP_CACHE
    end
    
    def self.FLEXMLS_META_CACHE
      @FLEXMLS_META_CACHE
    end
    
    def self.add_query(query_string, results)
      if @FLEXMLS_QUERY_CACHE[query_string].blank? then
        @FLEXMLS_QUERY_CACHE.merge!({query_string=>{:age=>Time.now,:results=>results}})
        return true
      else
        @FLEXMLS_QUERY_CACHE[query_string][:age] = Time.now
        @FLEXMLS_QUERY_CACHE[query_string][:results] = results
        return false
      end
    end
    
    def self.flexmls_meta_init
 #     @FLEXMLS_META_CACHE = Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }]
      @FLEXMLS_META_CACHE = Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|meta_types| meta_types.instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }}.flatten(1)]
   end
    
    def self.build_lookup_multi_hash(lookup_name)
      # lookup_hash = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
     # lookup_hash = Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #  was for only class A ==> lookup_hash = Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }] rescue {}
                                lookup_hash = Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types")}}.flatten(1).collect{|x| x.instance_eval("lookup_types")}.flatten(1).collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")]}] rescue {}
     # lookup_hash = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Kitchen Level"}[0].instance_eval("lookup_types")]
        return_lookup = Hash[ lookup_name => lookup_hash ]
    end
    
    def self.build_lookup_hash(lookup_name)
      # lookup_hash = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    # was for only class A -->  lookup_hash =Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)]
     lookup_hash =Hash[@FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)}.flatten(1)]
     return_lookup = Hash[ lookup_name => lookup_hash ]
    
    end
  
    def self.flexmls_get_lookup_table_names
      return @FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("table_fragment")["Interpretation"]=="Lookup"}.collect{|a| a.instance_eval("long_name")} #+ 
     #   @FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("table_fragment")["Interpretation"]=="LookupMulti"}.collect{|a| a.instance_eval("long_name")}
    end
    
    def self.flexmls_get_lookup_multi_table_names
      return @FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("table_fragment")["Interpretation"]=="LookupMulti"}.collect{|a| a.instance_eval("long_name")}
    end
    
    def self.flexmls_lookup_init
      @FLEXMLS_LOOKUP_CACHE = {}

      # flexmls_get_lookup_multi_table_names.each do |lookup_table_name|
      #   @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_multi_hash(lookup_table_name))
      # end
      
      flexmls_get_lookup_table_names.each do |lookup_table_name|
        @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash(lookup_table_name))
      end
      
#      @FLEXMLS_LOOKUP_CACHE = build_lookup_hash("Status")
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Property Sub-Type"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Street Suffix"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Postal City"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Municipality"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("State"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("County"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Zip Code"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Special Assessment"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Deed Restricted"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Complex/Subdivision"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Area/Section"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Fireplace"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Sub-Type"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Farm Assessed"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Waterview"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Garage"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Handicap Access"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Basement"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("HOA"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Pool"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Waterfront"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Assessment Status"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Exterior"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Heat Fuel"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Heat/AC"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Roof"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Style"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Water Heater"))
#      @FLEXMLS_LOOKUP_CACHE.merge!(build_lookup_hash("Water/Sewer"))
    end
    
    def self.flexmls_login(username, password, host_url)
      client = Rets::Client.new({
          login_url: host_url,
          username: username,
          password: password,
          version: 'RETS/1.5'
        })    
      @FLEXMLS_WEBSERVICE_CONNECTION = client
      @FLEXMLS_WEBSERVICE_CONNECTION.login
    end
    
    def self.flexmls_logout
      @FLEXMLS_WEBSERVICE_CONNECTION.logout
      @FLEXMLS_WEBSERVICE_CONNECTION = nil
    end
    
    def self.flex_mls_search_properties(query_string, search_class)
      properties = []
      
      if ((@FLEXMLS_QUERY_CACHE[search_class+query_string].blank?) or (@FLEXMLS_QUERY_CACHE[search_class+query_string][:age]+ 1.hour < Time.now) ) # nothing there need to run query.
        begin
          properties = @FLEXMLS_WEBSERVICE_CONNECTION.find :all, {
            search_type: 'Property',
            class: search_class,
            query: query_string,
            limit: "100"
            }
        rescue err
          puts("failed with:")
          puts(err.inspect)
        end
        
        add_query(search_class+query_string, properties)

      else
        properties = @FLEXMLS_QUERY_CACHE[search_class+query_string][:results]
      end
      return properties
    end
    
    def self.flexmls_initialize
      # config = YAML.load(File.read(Rails.root.join('config','silverweb_realestate.yml').to_s))[Rails.env]
      relative = File.join("..","..","config", "silverweb_realestate.base.yml")
      with_dir = File.join(File.dirname(__FILE__), relative)
      config = YAML.load_file(with_dir)
     
      #   puts SilverwebRealestate::Engine.root
      #   puts(Rails.root.to_s) rescue puts("rails root not found!")
      #   puts File.expand_path $0
      #   puts(Rails.application.root) rescue puts("Rails.application.root not found!")
      #   
      #   puts File.expand_path(File.join('config', 'vtools_gateway.yml'), __FILE__).to_s
      #   
      #   my_rails_root = File.expand_path('../..', __FILE__)
      #   puts my_rails_root
      
      #  configfile = File.join('config', 'vtools_gateway.yml')
      # File.join(Rails.root,'config', 'silverweb_realestate.yml')
    
      configfile = Rails.root.join('config','silverweb_realestate.yml').to_s
      puts configfile
     
      
      if (File.exists?(configfile))
        appconfig = YAML.load_file(configfile)
        config.merge!(appconfig)
        
      end
      
      @CONFIG = config[Rails.env]

      flexmls_login(@CONFIG["username"], @CONFIG["password"],@CONFIG["url"])
      flexmls_meta_init()
      flexmls_lookup_init()
   
    end
  
  
  end

end

SilverwebRealestate::Config.flexmls_initialize rescue puts("init failed!")

# lookup_hash =Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_class| prop_class.instance_eval("tables")}.select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)]
# lookup_hash = SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_evaeach{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}}
#  
#  
#lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }] rescue {}
#
#lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[3].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }] rescue {}
#
#
#      @FLEXMLS_META_CACHE = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }]
#      @FLEXMLS_META_CACHE = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|meta_types| meta_types.instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }}]
#      @FLEXMLS_META_CACHE = SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").size
#        
#      @FLEXMLS_META_CACHE = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|meta_types| meta_types.instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }}.flatten(1)]
#
#
#      lookup_hash =Hash[SilverwebRealestate::Config..metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)]
#      lookup_hash =Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)]
#
#      lookup_hash =Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)}.flatten(1)]
#
#
#     lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }] 
#
#     lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")]}}}]
#
#     SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")]}}}
# 
#     SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")]}}}
#
#
#    lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types")}}.flatten(1).collect{|x| x.instance_eval("lookup_types")}.flatten(1).collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")]}]
#
#
#     lookup_hash = Hash[SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION.metadata.tree["property"].instance_eval("rets_classes").collect{|prop_classes| prop_classes.instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }}]
