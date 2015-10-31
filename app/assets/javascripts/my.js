function changeBoundsOnLink(link_id, bounds) {
  var ne_lat = bounds._northEast.lat;
  var ne_lng = bounds._northEast.lng;
  var sw_lat = bounds._southWest.lat;
  var sw_lng = bounds._southWest.lng;
  href = $('#'+link_id).attr("href");
  if (href.indexOf("?") != -1)
    href = href.substring(0, href.indexOf("?"));
  href = href + "?ne_lat="+ne_lat+"&ne_lng="+ne_lng+"&sw_lat="+sw_lat+"&sw_lng="+sw_lng;
  $('#'+link_id).attr("href",href);
}

function enable_top_menu(menuname) {
  $('.top-menu').removeClass('active');
  $('#'+menuname).addClass('active');
}

function onClick(e) {
    $('#popup-mine-edit').remove();
    $.ajax({
        url:  '/mines/' + this._popup_id+"/edit",
        type: "GET",
    });
    $('#popup-mine-edit').modal('show');
}
    
function addMarker(e){
  $('#latitude').val(e.latlng.lat);
  $('#longitude').val(e.latlng.lng);
  $('#popup-mine-new').modal('show');
}
function select_typ(index) {
  markers.clearLayers();
  if (index == 99) {
    for (var i = 0; i < addressPoints.length; i++) {
      var a = addressPoints[i];
      markers.addLayer(markersId[a[3]]);
    }
    return;
  }
  for (var i = 0; i < addressPoints.length; i++) {
    var a = addressPoints[i];
    if (a[5] == index) {
      markers.addLayer(markersId[a[3]]);
    }
  }
}
function select_zustand(index) {
  markers.clearLayers();
  if (index == 99) {
    for (var i = 0; i < addressPoints.length; i++) {
      var a = addressPoints[i];
      markers.addLayer(markersId[a[3]]);
    }
    return;
  }
  for (var i = 0; i < addressPoints.length; i++) {
    var a = addressPoints[i];
    if (a[4] == index) {
      markers.addLayer(markersId[a[3]]);
    }
  }
}