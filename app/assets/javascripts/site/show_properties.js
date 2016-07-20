/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var show_properties_callDocumentReady_called = false;
var handler = [];

$(document).ready(function () {
    if (!show_properties_callDocumentReady_called)
    {
        show_properties_callDocumentReady_called = true;
        if ($("#as_window").text() == "true")
        {
//  alert("it is a window");
        } else
        {
            show_properties_callDocumentReady();
        }
    }
});

function show_properties_callDocumentReady()
{
    //   alert("called");
//    $("img.property-image").load(function () {
//        this.src = this.src + '?' + new Date().getTime();
//        this.setAttribute('crossOrigin', 'Anonymous');
//        // this.crossOrigin = "Anonymous";
//        console.log(this);
//        context.drawImage(this, 0, 0);
//        $("body").append($canvas);
//        removeBlanks(this.width, this.height);
//    });

    initialize_maps();

    $("div.property-tabs").tabs({
        "show": function (event, ui) {
            //      console.log($(this).attr("class"));
            // google.maps.event.trigger(handler[0].getMap(), 'resize');


        },
        activate: function (event, ui) {
            var prop_index = $(this).attr("data-property-index");
            if ($(this).find("div.gm-style").length > 0) {
                google.maps.event.trigger(handler[prop_index].getMap(), 'resize');
                handler[prop_index].fitMapToBounds();
                handler[prop_index].getMap().setZoom(15);

                //               console.log($(this).attr("class"));

                //             console.log($(this));
            }
        }
    });

}

function initialize_maps() {
    var pageMaps = $("div.map-space");
    // var handler = [];
    $(pageMaps).each(function (index) {
        console.log($(this).attr("data-json"));
        var marker_json = $(this).attr("data-json");
        if (!marker_json == "")
        {
            handler[index] = Gmaps.build('Google');
            var that = this;
            console.log($(that).attr("id"));
            handler[index].buildMap({provider: {}, internal: {id: $(that).attr("id")}}, function () {
                markers = handler[index].addMarker(jQuery.parseJSON(marker_json));
//            markers = handler.addMarkers([
//                {
//                    "lat": 0,
//                    "lng": 0,
//                    "picture": {
//                        "url": "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png",
//                        "width": 32,
//                        "height": 32
//                    },
//                    "infowindow": "hello!"
//                }
//            ]);
                handler[index].bounds.extendWith(markers);
                handler[index].fitMapToBounds();
                handler[index].getMap().setZoom(15);
            });
        }

    });

}

function remove_white_space(image)
{
    $canvas = $("<canvas>"),
            canvas = $canvas[0],
            context = canvas.getContext("2d");

    $("body").append($canvas);

    image_item = $(image);
    console.log(image_item);
    $canvas.attr({width: image_item.width, height: image_item.height});

    context = canvas.getContext("2d");
    if (context) {
        context.drawImage(image_item, 0, 0);
        $("body").append("<p>original image:</p>").append($canvas);

        removeBlanks(this.width, this.height);
    }
}

var img = new Image(),
        $canvas = $("<canvas>"),
        canvas = $canvas[0],
        context = canvas.getContext("2d");

var removeBlanks = function (imgWidth, imgHeight) {
    var imageData = context.getImageData(0, 0, imgWidth, imgHeight),
            data = imageData.data,
            getRBG = function (x, y) {
                return {
                    red: data[(imgWidth * y + x) * 4],
                    green: data[(imgWidth * y + x) * 4 + 1],
                    blue: data[(imgWidth * y + x) * 4 + 2]
                };
            },
            isWhite = function (rgb) {
                return rgb.red == 255 && rgb.green == 255 && rgb.blue == 255;
            },
            scanY = function (fromTop) {
                var offset = fromTop ? 1 : -1;

                // loop through each row
                for (var y = fromTop ? 0 : imgHeight - 1; fromTop ? (y < imgHeight) : (y > -1); y += offset) {

                    // loop through each column
                    for (var x = 0; x < imgWidth; x++) {
                        if (!isWhite(getRBG(x, y))) {
                            return y;
                        }
                    }
                }
                return null; // all image is white
            },
            scanX = function (fromLeft) {
                var offset = fromLeft ? 1 : -1;

                // loop through each column
                for (var x = fromLeft ? 0 : imgWidth - 1; fromLeft ? (x < imgWidth) : (x > -1); x += offset) {

                    // loop through each row
                    for (var y = 0; y < imgHeight; y++) {
                        if (!isWhite(getRBG(x, y))) {
                            return x;
                        }
                    }
                }
                return null; // all image is white
            };


    var cropTop = scanY(true),
            cropBottom = scanY(false),
            cropLeft = scanX(true),
            cropRight = scanX(false);

    console.log(cropTop, cropBottom, cropLeft, cropRight);

};

img.crossOrigin = "anonymous";
img.onload = function () {
    console.log(this);
    context.drawImage(this, 0, 0);
    $("body").append($canvas);
    removeBlanks(this.width, this.height);
};