function iconForSort(sort) {
  var color = "red";
  switch (sort) {
    case 0:
      color = 'red';
      break;
    case 1:
      color = 'darkred';
      break;
    case 2:
      color = 'orange';
      break;
    case 3:
      color = 'green';
      break;
    case 4:
      color = 'darkgreen';
      break;
    case 5:
      color = 'blue';
      break;
    case 6:
      color = 'purple';
      break;
    case 7:
      color = 'cadetblue';
      break;
    case 8:
      color = 'darkpurple';
      break;
    case 9:
      color = 'darkblue';
      break;
    case 10:
      color = 'red';
      break;
    case 11:
      color = 'orange';
      break;
    case 12:
      color = 'green';
      break;

  }

  var icon = L.AwesomeMarkers.icon({
            icon: 'search', 
            markerColor: color,
            prefix: 'fa'
  })
  return icon;
}

function changeBoundsOnLink(link_id, bounds) {
  ne_lat = bounds._northEast.lat;
  ne_lng = bounds._northEast.lng;
  sw_lat = bounds._southWest.lat;
  sw_lng = bounds._southWest.lng;
  href = $('#'+link_id).attr("href");
  if (href.indexOf("?") != -1)
    href = href.substring(0, href.indexOf("?"));
  href = href + "?ne_lat="+ne_lat+"&ne_lng="+ne_lng+"&sw_lat="+sw_lat+"&sw_lng="+sw_lng;
  $('#'+link_id).attr("href",href);
  $.cookie('map.lat', map.getCenter().lat, { expires: 7});
  $.cookie('map.lng', map.getCenter().lng, { expires: 7});
  $.cookie('map.zoomlevel', map.getZoom(), { expires: 7});
}

function changeBoundsCookie(bounds) {
  ne_lat = bounds._northEast.lat;
  ne_lng = bounds._northEast.lng;
  sw_lat = bounds._southWest.lat;
  sw_lng = bounds._southWest.lng;
  $.cookie('map.lat', map.getCenter().lat, { expires: 7});
  $.cookie('map.lng', map.getCenter().lng, { expires: 7});
  $.cookie('map.zoomlevel', map.getZoom(), { expires: 7});
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
  function showNew(e) {
    $('#popup-mine-new').modal('show');
  }