// idempotent function - page:change
$(document).on('page:change', function(e) {
  // no need to run this js on other pages
  if($('.topics.show').length > 0) {

    function increment(type, id){
      var selector = '#' + type + id,
          element = $(selector),
          current = parseInt(element.html());

      element.html(current + 1);
    }

    function decrement(type, id){
      var selector = '#' + type + id,
          element = $(selector),
          current = parseInt(element.html());

      element.html(current - 1);
    }

    function toggle(type, id){
      // provides visual aid of selection to user
      $('i' + '#' + id + '.arrow.circle.' + type).toggleClass('outline');
    }

    function success(data) {
      var registered = data["vote"]["registered"],
          first_vote = data["vote"]["first_vote"],
          type = data["vote"]["type"],
          id = data["vote"]["id"];

      if(registered){
        if(first_vote){
          toggle(type, id);
          increment(type, id);
        }else{

          if(type === "up"){
            // remove_css down
            toggle("down", id);
            // decrement down
            decrement("down", id);
            // add_css up
            toggle("up", id);
            // increment up
            increment("up", id)
          }else{
            // remove_css up
            toggle("up", id);
            // decrement up
            decrement("up", id);
            // add_css down
            toggle("down", id);
            // increment down
            increment("down", id);
          }

        }
      }
    }

    $('.arrow.circle.outline.up.icon').on('click', function(e) {
      var url = "/votes/up/" + event.target.id;

      $.ajax({
        type: "POST",
        url: url,
        data: {},
        success: success,
        dataType: "json"
      });
    });

    $('.arrow.circle.outline.down.icon').on('click', function(e) {
      var url = "/votes/down/" + event.target.id;

      $.ajax({
        type: "POST",
        url: url,
        data: {},
        success: success,
        dataType: "json"
      })
    });

  }
});
