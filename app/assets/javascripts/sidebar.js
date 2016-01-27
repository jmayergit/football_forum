$(document).on('page:change', function(e) {
  /// computer
  $('#sidebar_acct').on('click', function() {
    $('.ui.top.inverted.menu.sidebar').sidebar('setting', 'transition', 'push').sidebar('toggle');
  });
  
  /// tablet
  $('#sidebar_sidebar_tab').on('click', function() {
    console.log('sidebar sidebar');
    $('.ui.right.inverted.vertical.menu.sidebar').sidebar('setting', 'transition', 'push').sidebar('toggle');
  });

  $('#sidebar_usr_tab').on('click', function() {
    console.log('sidebar usr');
    $('.ui.left.inverted.vertical.menu.sidebar').sidebar('setting', 'transition', 'push').sidebar('toggle');
  });

  /// mobile
  $('#sidebar_sidebar').on('click', function() {
    console.log('sidebar sidebar');
    $('.ui.right.inverted.vertical.menu.sidebar').sidebar('setting', 'transition', 'push').sidebar('toggle');
  });

  $('#sidebar_usr').on('click', function() {
    console.log('sidebar usr');
    $('.ui.left.inverted.vertical.menu.sidebar').sidebar('setting', 'transition', 'push').sidebar('toggle');
  });

})
