// not meant to be secure, simply adds user experience

var errors = {};

function paint(input) {
  $(input).parent().addClass("error");
}

function unpaint(input) {
  $(input).parent().removeClass("error");
}

function add_error(name, value) {
  errors[name] = value;
}

function remove_error(name) {
  delete errors[name];
}

function reveal_message(id) {
  $(id).removeClass("hidden");
}

function conceal_message(id) {
  $(id).addClass("hidden");
}

function clear_if_empty(field) {
  var value = $(field)[0].value;

  if (field in errors) {
    if (value === "") {
      remove_error(field);
      conceal_message("#error_password");
      unpaint(field);
    }
  }
}

function validate_username() {
  var field = ":input[name='user[username]']",
      username = $(field)[0].value,
      re = /\W/,
      valid = !re.test(username);
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
}

function validate_password() {
  var field = ":input[name='user[password]']",
      password = $(field)[0].value,
      valid = password.length >= 8;

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
}

function validate_confirmation() {
  var field = ":input[name='user[password_confirmation]']",
      confirmation = $(field)[0].value,
      password = $(":input[name='user[password]']")[0].value,
      match = (confirmation === password);
      
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
}

function errors_present() {
  return Object.keys(errors).length > 0;
}

$(document).on('ready page:load', function(event) {
  // console.log("non-idempotent function");
});

$(document).on('page:change', function(event) {
  // console.log("idempotent function");
  // only want this behavior on sign up page, not any other form that has
  // username, password, or password confirmation (3)
  if ($(".registrations.new").length > 0) {
    $(":input[name='user[username]']").on("keyup", function(e) {
      validate_username();
    });


    $(":input[name='user[password]']").on("keyup", function(e) {
      validate_password();

      validate_confirmation();
    });

    $(":input[name='user[password_confirmation]']").on("keyup", function(e) {
      validate_confirmation();
    });

    $(":input[name='user[password]']").on("blur", function(e) {
      var field = ":input[name='user[password]']";
      clear_if_empty(field);
    });


    $(":input[value='Sign up']").on("click", function(e) {
      if ( errors_present() ) {
          e.preventDefault();
      }
    });
  }
});
