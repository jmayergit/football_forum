$(document).on('page:change', function(event) {
  if($(".topics.new").length > 0) {
    $("#topic_posts_attributes_0_body").on("focus", function(event) {
      var selector = "#topic_posts_attributes_0_body",
          element = $(selector),
          current = jQuery(element).val();

      if(current === "(No Text)"){
        jQuery(element).val("");
      }
    });
  }
})
