module PropertyHelper
  
  def base64_image image_data
  "<img src='data:image/png;base64,#{image_data}' />".html_safe
end

  def remote_image(url, html_options={})
    data = open(url).read
    image_tag(:src=>"data:image/png;base64,#{data}",:options=>html_options).html_safe
   # send_data data,
  end

  
  def show_flexslider_carousel(property, slider_id="flexslider", slider_class="property-image")
    if not property.blank?then
      
      # info for javascript 
      
      returnval = "<div class='slider-container' id='" + slider_id + "'>"
      
      returnval = returnval + "<div class='flexslider #{slider_class}'> \n"
      returnval = returnval + "<ul class='slides'> \n"

#     maybe not needed.
#                           if slide_count == 0 then
#          returnval =  returnval + "<li> \n"
#        else
#          returnval =  returnval + "<div class='flexslider' style='display:none'>"
#        end

      property.photos.each_with_index do |photo, photo_count| 
        puts("slide count #{photo_count}")
        returnval = returnval + "<li> \n"
        
        returnval = returnval + "<div class='hidden-item'>"
        returnval = returnval + "<div id='slider-id'>" + photo.headers["content-id"].to_s + "</div>"
        returnval = returnval + "</div>"
        
        returnval =  returnval +  "<div class='" + action_name + " slider-content-float'>" + image_tag(photo.headers["location"], class: slider_class) + "</div> \n"
#        returnval =  returnval +  "<div class='" + action_name + " slider-content-float'>" + image_tag(url_for(:controller=>"properties",:action=>"get_image", :url=>photo.headers["location"]), class: slider_class) + "</div> \n"
        returnval =  returnval + "</li> \n"
      end
      returnval =  returnval + "</ul> \n"
      returnval =  returnval + "</div> \n"
      returnval =  returnval + "</div> \n"

      return returnval.html_safe
    else
      return "" 
    end rescue ""
  end  
  
end