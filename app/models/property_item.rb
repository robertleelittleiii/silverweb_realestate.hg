class PropertyItem
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  
  attr_reader :listing_raw_data, :listing_data
  
  
  def initialize(listing_raw_data)
    meta_lookup =  SilverwebRealestate::Config.FLEXMLS_META_CACHE

    @listing_raw_data = listing_raw_data
    
    listing_data = []
    listing_raw_data.each do |key,value| 
      listing_data << [meta_lookup[key], lookup_value(meta_lookup[key],value)]
    end
    
    @listing_data=Hash[listing_data]
  
  end
  
  def photos
    client = SilverwebRealestate::Config.FLEXMLS_WEBSERVICE_CONNECTION
    
    #  begin
    photos = client.objects '*', {
      resource: 'Property',
      object_type: 'HiRes',
      resource_id: get_value("List Number Main"),
      location: 1
    }

    # rescue
    #   return []
    # end
    return photos
  end
  
  def lookup_value(lookup_name,value)
    full_lookup = SilverwebRealestate::Config.FLEXMLS_LOOKUP_CACHE
    return_values = ""
    items = value.split(",")
    items.each do |item|
      return_values << ((full_lookup[lookup_name].blank? or full_lookup[lookup_name][item].blank?) ? item : full_lookup[lookup_name][item]) +  (items.last == item ? "" : ", ")
    end
    return return_values
  end
  
    
  def get_location
    return {} if get_value("Longitude").blank? 
   
      location_hash = {:lng=>get_value("Longitude"),:lat=>get_value("Latitude")}
        
    return location_hash
  end
  
  def listing_data
    @listing_data
  end

  def persisted?
    return true
  end
  
  
  def get_value(value_name)
    @listing_data[value_name]    
    #  property[@meta_lookup.key("Street Name")]%> <%=@flex_mls_link.get_value("Street Suffix",property[@meta_lookup.key("Street Suffix")])
  end
  
  
end