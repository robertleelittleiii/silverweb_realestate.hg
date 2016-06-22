class Property
  include ActiveModel::Model
  attr_accessor :client, :property_hash, :meta_lookup, :full_lookup
  
  #  :status_lookup, :property_subtype_lookup,
  #    :street_suffix_lookup, :postal_city_lookup, :state_lookup, :county_lookup, :zipcode_lookup,
  #    :special_assignment_lookup,:deed_restricted_lookup, :complex_subdivision_lookup, :area_section_lookup,
  #    :fireplace_lookup, :sub_type_lookup, :farm_assessed_lookup, :waterview_lookup, :garage_lookup,
  #    :handycapped_access_lookup, :basement_lookup, :hoa_lookup, :pool_lookup, :waterfront_lookup, 
  #    :assessment_status_lookup, :exterior_lookup, :heat_fuel_lookup, :heat_ac_lookup, :roof_lookup,
  #    :style_lookup, :water_heater_lookup, :water_sewer_lookup, 
  

  def initialize(attributes={})
    super
    #    @client = Rets::Client.new({
    #        login_url: 'http://retsgw.flexmls.com/rets2_2/Login',
    #        username: 'mo.rets.Silverweb',
    #        password: 'taxed-acean54',
    #        version: 'RETS/1.5'
    #      })
    #    @client.login
    
    @client = SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION
    @meta_lookup = SilverwebRealestate::Config.FLEXMLS_META_CACHE
    @full_lookup = SilverwebRealestate::Config.FLEXMLS_LOOKUP_CACHE
    
    #    @meta_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").collect {|x| [x.instance_eval("name"),x.instance_eval("long_name")] }]
    #    
    #    @full_lookup = build_lookup_hash("Status")
    #    @full_lookup.merge!(build_lookup_hash("Property Sub-Type"))
    #    @full_lookup.merge!(build_lookup_hash("Street Suffix"))
    #    @full_lookup.merge!(build_lookup_hash("Postal City"))
    #    @full_lookup.merge!(build_lookup_hash("Municipality"))
    #    @full_lookup.merge!(build_lookup_hash("State"))
    #    @full_lookup.merge!(build_lookup_hash("County"))
    #    @full_lookup.merge!(build_lookup_hash("Zip Code"))
    #    @full_lookup.merge!(build_lookup_hash("Special Assessment"))
    #    @full_lookup.merge!(build_lookup_hash("Deed Restricted"))
    #    @full_lookup.merge!(build_lookup_hash("Complex/Subdivision"))
    #    @full_lookup.merge!(build_lookup_hash("Area/Section"))
    #    @full_lookup.merge!(build_lookup_hash("Fireplace"))
    #    @full_lookup.merge!(build_lookup_hash("Sub-Type"))
    #    @full_lookup.merge!(build_lookup_hash("Farm Assessed"))
    #    @full_lookup.merge!(build_lookup_hash("Waterview"))
    #    @full_lookup.merge!(build_lookup_hash("Garage"))
    #    @full_lookup.merge!(build_lookup_hash("Handicap Access"))
    #    @full_lookup.merge!(build_lookup_hash("Basement"))
    #    @full_lookup.merge!(build_lookup_hash("HOA"))
    #    @full_lookup.merge!(build_lookup_hash("Pool"))
    #    @full_lookup.merge!(build_lookup_hash("Waterfront"))
    #    @full_lookup.merge!(build_lookup_hash("Assessment Status"))
    #    @full_lookup.merge!(build_lookup_hash("Exterior"))
    #    @full_lookup.merge!(build_lookup_hash("Heat Fuel"))
    #    @full_lookup.merge!(build_lookup_hash("Heat/AC"))
    #    @full_lookup.merge!(build_lookup_hash("Roof"))
    #    @full_lookup.merge!(build_lookup_hash("Style"))
    #    @full_lookup.merge!(build_lookup_hash("Water Heater"))
    #    @full_lookup.merge!(build_lookup_hash("Water/Sewer"))
    #    
    
    #    @status_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Status"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @property_subtype_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Property Sub-Type"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @street_suffix_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Street Suffix"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @postal_city_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Postal City"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #    
    #    @state_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="State"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @county_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="County"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @zipcode_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Zip Code"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @special_assignment_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Special Assessment"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @deed_restricted_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Deed Restricted"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @complex_subdivision_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Complex/Subdivision"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @area_section_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Area/Section"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @fireplace_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Fireplace"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @sub_type_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Sub-Type"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @farm_assessed_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Farm Assessed"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @waterview_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Waterview"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @garage_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Garage"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @handycapped_access_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Handicap Access"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @basement_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Basement"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @hoa_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="HOA"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @pool_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Pool"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @waterfront_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Waterfront"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @assessment_status_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Assessment Status"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @exterior_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Exterior"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @heat_fuel_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Heat Fuel"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @heat_ac_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Heat/AC"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #  
    #    @roof_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Roof"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #  
    #    @style_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Style"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @water_heater_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Water Heater"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #
    #    @water_sewer_lookup = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Water/Sewer"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    #    
  end
  
  def get_value(lookup_name,value)
    return_values=""
    # puts("----------------  start --> get value debug --------------")
    # puts("lookup_name: '#{lookup_name}'")
    # puts("value: '#{value}'")
    # puts("@full_lookup[lookup_name] '#{@full_lookup[lookup_name]}'")
    # puts("@full_lookup '#{@full_lookup.inspect}'")
    
    items = value.split(",")
    
    items.each do |item|
      return_values << ((@full_lookup[lookup_name].blank? or @full_lookup[lookup_name][item].blank?) ? item : @full_lookup[lookup_name][item]) +  (items.last == item ? "" : ", ")
    end
    
    #   puts("----------------  end --> get value debug --------------")

    return return_values
  end
  
  def build_lookup_hash(lookup_name)
    # lookup_hash = Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] }]
    lookup_hash =Hash[@client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")==lookup_name}.each{|x| x.instance_eval("lookup_types").collect {|x| [x.instance_eval("value"),x.instance_eval("long_value")] } }.collect{|x| x.instance_eval("lookup_types")}.collect{|y| (y.collect{|x| [x.instance_eval("value"),x.instance_eval("long_value")]})}.flatten(1)]
    return_lookup = Hash[ lookup_name => lookup_hash ]
    
  end
  
  def meta_lookup
    @meta_lookup
  end
  
  
  def photos(property_id)
    #  begin
    photos = @client.objects '*', {
      resource: 'Property',
      object_type: 'HiRes',
      resource_id: property_id,
      location: 1
    }

    # rescue
    #   return []
    # end
    return photos
  end
  
  def self.find(search_by, search_class, search_term, limit=100)
    case search_by
    when "office"
      return find_by_office(search_term, search_class, limit)
    when "realtor"
      return find_by_realtor(search_term, search_class, limit)
    when 'municipality'
      return find_by_municipality(search_term, search_class, limit)
    else
      return ['nothing']
    end
  end
  
  def self.find_by_office(office_id, search_class, limit=100)
    
                properties = SilverwebRealestate::Config.flex_mls_search_properties("(LIST_106=\"#{office_id}\" )",search_class)[0..limit]

#    begin
#      properties= @client.find :all, {
#        search_type: 'Property',
#        class: search_class,
#          limit: limit.to_s,
#          query: "(LIST_106=\"#{office_id}\" )",
#        }
#      rescue
#        return []
#      end
        
      return make_property_array(properties)
     
    end
  
    def self.make_property_array(given_array)
      return given_array.collect{|each| PropertyItem.new(each)}
    end
    
    def self.find_by_realtor(realtor_id, search_class, limit=100)
    
      properties = SilverwebRealestate::Config.flex_mls_search_properties("(LIST_5=\"#{realtor_id}\" )",search_class)[0..limit]
      
      #        puts("*********** properties ************ ")
      #        puts("class: #{properties.class}")
      #        puts("inspect: ") 
      #        puts(properties.inspect)
      #        puts("cache:")
      #        puts(SilverwebRealestate::Config.FLEXMLS_QUERY_CACHE)
      #        puts("*********** properties ************ ")

      #      begin
      #        properties = @client.find :all, {
      #          search_type: 'Property',
      #          class: 'A',
      #            query: "(LIST_5=\"#{realtor_id}\" )",
      #            limit: limit.to_s
      #          }
      #
      #        rescue
      #          return []
      #        end
        
      return make_property_array(properties)
        

    end
  
    def self.find_by_municipality(municipality_id, search_class, limit=100)
      
            properties = SilverwebRealestate::Config.flex_mls_search_properties("(LIST_29=#{municipality_id})",search_class)[0..limit]

#      begin
#        properties = client.find :all, {
#          search_type: 'Property',
#          class: search_class,
#            query: "(LIST_29=#{municipality_id})",
#            limit: limit.to_s
#          }
#        rescue
#          return []
#        end
#        
#        # return properties
#          
        return make_property_array(properties)

      end
    
#      def find(property_id)
#        begin
#          property = client.find :first, {
#            search_type: 'Property',
#            class: 'A',
#              query: "(LIST_0=#{property_id})",
#              limit:1
#            }
#          rescue
#            return []
#          end
#        
#          return property
#        end
#      
        def self.municipality_list() 
          @client = Rets::Client.new({
              login_url: 'http://retsgw.flexmls.com/rets2_2/Login',
              username: 'mo.rets.Silverweb',
              password: 'taxed-acean54',
              version: 'RETS/1.5'
            })
          @client.login
    
          return_value = @client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Municipality"}[0].instance_eval("lookup_types").collect {|x| [x.instance_eval("long_value"),x.instance_eval("value")] } 
          @client.logout

          return return_value
        end
      
        def self.search_municipality(municipality_name)
          @client = Rets::Client.new({
              login_url: 'http://retsgw.flexmls.com/rets2_2/Login',
              username: 'mo.rets.Silverweb',
              password: 'taxed-acean54',
              version: 'RETS/1.5'
            })
          @client.login
    
          return_value =   @client.metadata.tree["property"].instance_eval("rets_classes")[0].instance_eval("tables").select {|a| a.instance_eval("long_name")=="Municipality"}[0].instance_eval("lookup_types").select {|a| a.instance_eval("long_value")==municipality_name}.first.instance_eval("value")
          @client.logout
          return return_value
        end
   
      end