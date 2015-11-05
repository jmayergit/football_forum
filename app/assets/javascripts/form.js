var errors = {};

function paint(input) {
  $(input).addClass("invalid");
};

function unpaint(input) {
  $(input).removeClass("invalid");
};

function add_error(name, value) {
  errors[name] = value;
};

function remove_error(name) {
  delete errors[name];
};

function reveal_message(id) {
  $(id).removeClass("hidden");
};

function conceal_message(id) {
  $(id).addClass("hidden");
};

function clear_if_empty(field) {
  var value = $(field)[0].value;
  if (field in errors) {
    if (value === "") {
      remove_error(field);
      conceal_message("#error_password");
      unpaint(field);
    }
  }
};

function validate_username() {
  var field = ":input#user_username";
  var username = $(field)[0].value;
  var re = /\W/;
  var valid = !re.test(username);
  //     invalid          valid
  //       |                |
  //    ---------       ----------
  //   |         |     |          |
  // present    not  present     not
  if (valid) {
    if (field in errors) {
      remove_error(field);
      conceal_message("#error_username");
      unpaint(field);
    }
  } else {
    if (!(field in errors)) {
      add_error(field, "Invalid characters");
      reveal_message("#error_username");
      paint(field);
    }
  }
};

function validate_password() {
  var field = ":input#user_password";
  var password = $(field)[0].value;
  var valid = password.length >= 8;
  if (valid) {
    if (field in errors) {
      remove_error(field);
      conceal_message("#error_password");
      unpaint(field);
    }
  } else {
    if (!(field in errors)) {
      add_error(field, "Password not long enough");
      reveal_message("#error_password");
      paint(field);
    }
  }
};

function validate_confirmation() {
  var field = ":input#user_password_confirmation";
  var confirmation = $(field)[0].value;
  var password = $(":input#user_password")[0].value;
  var match = (confirmation === password);
  if (match) {
    if (field in errors) {
      remove_error(field);
      conceal_message("#error_confirmation");
      unpaint(field);
    }
  } else {
    if (!(field in errors)) {
      add_error(field, "Passwords do not match");
      reveal_message("#error_confirmation");
      paint(field);
    }
  }
};

$(document).on('ready page:load', function(event) {
  // console.log("non-idempotent function");
});

$(document).on('page:change', function(event) {
  // console.log("idempotent function");
  $(":input#user_username").on("keyup", function(e) {
    validate_username();
  });


  $(":input#user_password").on("keyup", function(e) {
    validate_password();

    if (":input#user_password_confirmation" in errors) {
      validate_confirmation();
    }
  });

  $(":input#user_password").on("blur", function(e) {
    var field = ":input#user_password";
    clear_if_empty(field);
  });

  $(":input#user_password_confirmation").on("keyup", function(e) {
    validate_confirmation();
  });
});
