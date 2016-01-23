$(document).on("page:change", function() {
  if( $(".forums.show").length === 1 ){
    $("i.unlock.icon").on("click", function(e) {
      console.log("unlock icon event handler");
    });

    $("i.lock.icon").on("click", function(e) {

    });
  }
});
