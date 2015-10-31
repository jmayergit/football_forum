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

function validate(username) {
  var re = /\W/;
  var valid = !re.test(username);
  var field = ":input#user_username";
  //     invalid          valid
  //       |                |
  //    ---------       ----------
  //   |         |     |          |
  // present    not  present     not
  if (valid) {
    if (field in errors) {
      remove_error(field);
      unpaint(field);
    }
  } else {
    if (!(field in errors)) {
      add_error(field, "Invalid characters");
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
    var value = $(":input#user_username")[0].value;
    validate(value);
  });
});
