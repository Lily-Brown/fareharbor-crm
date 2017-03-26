// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

console.log('Assets connected.');

// Drag function
function drag(ev) {
  ev.dataTransfer.setData('image', ev.target.id);
}

// Prevent default for AllowDrop
function allowDrop(ev) {
  ev.preventDefault();
}

// Drop function
function drop(ev) {
  ev.preventDefault();
  var target = ev.target;
  var data = ev.dataTransfer.getData('image');
  if (!target.classList.contains('drop')) {
    target = findDroppable(target);
  }
  start = parseInt(target.id.replace('div-',''));
  end = parseInt(data);
  if (start !== end) {
    var id = target.id.replace('div-','');
    var html = target.children[0];
    var htmlId = html.classList[0].replace('dashboard-','')
    html.id = parseInt(id)+1;
    target.removeChild(target.children[0]);
    target.appendChild(document.getElementById(data));
    var child =  target.children[0];
    var dashboardId = child.classList[0].replace('dashboard-','');
    updateOrder(dashboardId,id);
  }
  if (start < end) {
    updateOrder(htmlId,html.id);
    propogateForward(html,start,end);
  } else {
    updateOrder(htmlId,html.id-2);
    propogateBackward(html,start,end);
  }
}

// Finds Droppable Parent Target
function findDroppable(target) {
  while(!target.classList.contains('drop')) {
    target = target.parentNode;
  }
  return target;
}

// Moves photos around if photo is dragged forward
function propogateForward(html,start,end) {
  for (var i=start+1; i <= end; i++) {
    html = switchPhoto(html,i,0);
  }
}

// Moves photos around if photo is dragged backward
function propogateBackward(html,start,end) {
  for (var i=start-1; i >= end; i--) {
    html = switchPhoto(html,i,1);
  }
}

// Switches Photo
function switchPhoto(html,i,direction) {
  var target = document.getElementById('div-'+i);
  html.id = i;
  if (target.children[0] == undefined) {
    target.appendChild(html);
  } else {
    tempHtml = target.children[0];
    var dashboardId = tempHtml.classList[0].replace('dashboard-','');
    if (direction === 0) {
      updateOrder(dashboardId,i+1);
    } else {
      updateOrder(dashboardId,i+2);
    }
    target.removeChild(target.children[0]);
    target.appendChild(html);
    return tempHtml;
  }
}

// Update order number
function updateOrder(dashboardID, orderNum) {
  var url = '/dashboards/' + dashboardID;
  var data = {
    dashboard: {
      order: orderNum,
    }
  };
  $.ajax({
    type: "PUT",
    url: url,
    data: JSON.stringify(data),
    contentType: 'application/json',
    dataType: 'json',
    success: function(data) {
      console.log("Dashboard "+ dashboardID + " order updated.")
    },
    error: function(data) {
      console.log("error:",data);
    }
  });
}
