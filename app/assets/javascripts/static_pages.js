var cleanGraphCurrentNodes = function () {
  $($(".node"), "#graph").removeClass("active")
};

var cleanGraphCompletedNodes = function () {
  $($(".node"), "#graph").removeClass("completed")
};


var setGraphCurrentNodes = function (nodes_array) {
  cleanGraphCurrentNodes();
  nodes_array.forEach(function (node) {
    node_id = node.process_graph_node_id
    $($("#node_" + node_id), "#graph").addClass("active");
  });
};

var setGraphCompletedNodes = function (nodes_array) {
  cleanGraphCompletedNodes();
  nodes_array.forEach(function (node) {
    node_id = node.process_graph_node_id
    $($("#node_" + node_id), "#graph").addClass("completed");
  });
};


var renderNodeDetails = function (node) {
  name = node.process_graph_node.name
  description = node.process_graph_node.description
  more_info = node.process_graph_node.more_info
  more_info_text = node.process_graph_node.more_info_text
  html = '<li><div id="node_description_container">' +
    '<div class="node_details">' +
      '<h4>Process Node id: ' + name + '</h4>' +
      '<h6>Process Node id: ' + node.id + '</h6>' +
      '<h6>Graph Node id: ' + node.process_graph_node_id + '</h6>' +
      '<p>'+ description +'</p>' +
      '<p>'+ more_info +'</p>' +
      '<p>'+ more_info_text +'</p>' +
      '<button type="button" class="complete_button"' +
      'value="' + node.id + '">' +
      'Complete node</button>' +
    '</div></div></li>';
  return html;
};

var clearNodeDetails = function () {
  $("#node_description_container").html('');
};

var bindCompleteActionToButtons = function () {
  $(".complete_button").off("click").on("click", function (){
    current_user_id = $("#user_id").val();
    $.ajax({
      type: "POST",
      url: "listings/1/next_actions/" + $(this).val() +
        "?user_id=" + current_user_id + 
        "&workflow_name=buyer",
      dataType: "json",
      success: function(response) {
        if (response.errors != null) {
          var error_message = "";
          response.errors.workflow.forEach(function (data) {
            error_message += data + ", ";
          });
          alert(error_message);
        }
        else {
          updateNodesForUser();          
        }
      }
    });
  });
}

var renderNodes = function (nodes_array) {
  clearNodeDetails();
  nodes_array.forEach(function (node) {
    $("#node_description_container").append(renderNodeDetails(node));
    bindCompleteActionToButtons();
  })
};

var updateNodesForUser = function () {
  var jsonData;
  $.ajax({
    type: "GET",
    url: "listings/1/next_actions?user_id=" + $("#user_id").val() + 
      "&workflow_name=buyer",
    dataType: "json",
    success: function(response) {
      jsonData = response;
      setGraphCurrentNodes(jsonData);
      updateCompletedNodesForUser();
      renderNodes(jsonData);
    }
  });
};

var updateCompletedNodesForUser = function () {
  var jsonData;
  $.ajax({
    type: "GET",
    url: "listings/1/completed_actions?user_id=" + $("#user_id").val() +
      "&workflow_name=buyer",
    dataType: "json",
    success: function(response) {
      jsonData = response;
      cleanGraphCompletedNodes(jsonData);
      setGraphCompletedNodes(jsonData);
    }
  });
};



$(document).ready( function () {
  updateNodesForUser();
  $("#user_id").on('change', updateNodesForUser);
});
