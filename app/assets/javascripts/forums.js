$(document).on("page:change", function() {
  if( $(".forums.show").length === 1 ){
    function lock_success(data) {

      var icon = $("i#" + data.id);
      var lock = data.lock;

      if( lock ){
        if( icon.hasClass("unlock")){
          icon.removeClass("unlock");
          icon.addClass("lock");
        }
      }else {
        if( icon.hasClass("lock")){
          icon.removeClass("lock");
          icon.addClass("unlock");
        }
      }

    }


    $("i.unlock.icon").on("click", function(e) {
      var id = e.target.id;

      $.ajax({
        method: "POST",
        url: "/topics/lock",
        dataType: "json",
        data: { "topic": { "lock": true }, "id": id},
        error: function(jqXHR, string){ console.log(jqXHR) },
        success: lock_success
      })
    });

    $("i.lock.icon").on("click", function(e) {
      var id = e.target.id;

      $.ajax({
        method: "POST",
        url: "/topics/lock",
        dataType: "json",
        data: { "topic": { "lock": false}, "id": id},
        success: lock_success
      })
    });

    function sticky_success(data) {
      console.log(data);
      var icon = $("i#" + data.id + "sticky");
      console.log(icon);
      var sticky = data.sticky;
      console.log(sticky);

      if( sticky ){
        if( icon.hasClass("pin icon")) {
          icon.removeClass("pin icon");
          icon.addClass("checkmark icon");
        }
      }else {
        if( icon.hasClass("checkmark icon")) {
          icon.removeClass("checkmark icon");
          icon.addClass("pin icon");
        }
      }
    }

    $("i.pin.icon").on("click", function(e) {
      console.log("pin icon or not stickied will now be stickied");
      var id = e.target.id;

      $.ajax({
        method: "POST",
        url: "/topics/sticky",
        dataType: "json",
        data: { "topic": { "sticky": true}, "id": id},
        success: sticky_success
      })
    })

    $("i.checkmark.icon").on("click", function(e) {
      console.log("checkmark icon or stickied will now be unstickied");
      var id = e.target.id;

      $.ajax({
        method: "POST",
        url: "/topics/sticky",
        dataType: "json",
        data: { "topic": { "sticky": false}, "id": id},
        success: sticky_success
      })
    })

  }
});
