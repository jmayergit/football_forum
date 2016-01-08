$(document).on('page:change', function(event) {
  if($(".posts.new").length > 0) {
    $("#post_body").on("focus", function(event) {
      var selector = "#post_body",
          element = $(selector),
          current = jQuery(element).val();

      if(current === "(No Text)"){
        jQuery(element).val("");
      }
    });
  }
});
