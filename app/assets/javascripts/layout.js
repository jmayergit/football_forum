$(document).on("page:change", function(e) {
  $('.message .close').on('click', function(e) {
    $(this).closest('.message').transition('fade');
  });
});
