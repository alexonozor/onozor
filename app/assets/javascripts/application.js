// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require jquery.remotipart
//= require_tree .



$('.ui.dropdown').dropdown();


$(function() {
  $('#example4').progress();
})

$(document).on('ready page:load', function () {
  $('#get-notification').click( function(){
    $('.notifications-wrapper').load('/activities #notifications')
  });
});




$(function() {
  $('#myTab a').click(function(e) {
    e.preventDefault()
    $(this).tab('show')
  });
});

$(function() {
  if ($('#answers').length > 0) {
    setTimeout(updateAnswers, 10000);
  }
});

function updateAnswers() {
  var question_id = $('#question').attr('data-id');
  var after = $('#answer-body:last-child').attr('data-time');
  $.getScript("/answers.js?question_id=" + question_id + "&after=" + after)
  setTimeout(updateAnswers, 10000);
}


$('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
  e.target // activated tab
  e.relatedTarget // previous tab
})

$(function() {
  $(".online").click(function() {
    $("#online").load('/users/who_is_online .users');
  });
});


$(function() {
  $('#users_search input').keyup(function() {
    $.get($('#users_search').attr('action'),
      $('#users_search').serialize(), null, 'script');
    return false;
  });
});


 $(document).on('page:fetch', function() {
  NProgress.start();
});
$(document).on('page:change', function() {
  NProgress.done();
});
$(document).on('page:restore', function() {
  NProgress.remove();
});



$(function() {
  $('#question_name').blur(function() {
    $.get($('#question_name').attr('action'),
      $('#question_name').serialize(), null, 'script');
    return false;
  });
})


$(document).on('ready page:load', function(event) {
  $('.navbar-form input').focus(function() {
    $('.navbar-form input').animate({
      width: "20em"
    }, 500);
  })
  $('.navbar-form input').blur(function() {
    $(this).animate({
      width: '166px'
    }, 500);
  })
})

$(function() {
  $(document).ajaxComplete(function() {
    $(".loading").hide();
  });

  $(document).ajaxStart(function() {
    $(".loading").show();
  });

  $(document).ajaxError(function(e) {
    console.log(e)
  });
})

$(document).on('ready page:load', function(event) {
  if($('#select-category').length>0){
    $('#select-category').click();
  }
})

$(document).on('ready page:load', function(event) {
  $('.modal input[type=checkbox]:checked').each(function() {
    $(this).next().children('.marker').addClass('selected');
  })
})

$(document).on('ready page:load', function(event) {
  var clickCount = 0;
  $(".save-cat").val("5 Remaining")
  $('.modal input[type=checkbox]').click(function() {
    var click_length = ($('.modal input[type=checkbox]:checked').length);
    console.log(click_length, click_length < 3);
    if (click_length >= 5) {
      $(".save-cat").removeClass("disabled")
      $(".save-cat").val("Continue")
    } else {
      $(".save-cat").addClass("disabled")
      $(".save-cat").val(5 - click_length + " Remaining")

    }
    $(this).next().children('.marker').toggleClass('selected');

  });
});

$('body').on('hidden.bs.modal', '.modal', function () {
  $(this).removeData('bs.modal');
});

$(document).on('ready page:load', function(event) {
  $('#question_name').on('keyup keypress blur change onSubmit', function(e) {
    $('.submit-button').addClass("disabled");
    var str = $(this).val();
    if (str == "" || !str){
      $(".errors-message").show().text("This question needs more detail");
    }else if ($(this).val().slice(-1) != "?" ) {
      $(".errors-message").show().text("Must end with a question mark");
    }else{
      $('.submit-button').removeClass("disabled");
      $(".errors-message").hide();
    }
  })
});



$(document).on('ready page:load', function(event) {
  $('.boolean').prop('checked', true);
  $('.smile').click(function() {
    $('#question_picture').click();
  });
});

$(document).on('ready page:load', function(event) {
 $('.add-image').click(function(){
   $('#page_logo').click();
   $('#page_logo').change(function() {
     $('.upload_log_form').submit()
   });
 });
});



$(document).on('ready page:load', function(event) {
 $('.upload_cover_photo').click(function(){
   $('#page_cover_picture').click();
   $('#page_cover_picture').change(function() {
     $('.upload_cover_form').submit()
   });
 });
});

$(document).ajaxStart(function() {
  $('#ajaxStart').show();
});

$(document).ajaxStop(function() {
  $('#ajaxStart').hide();
});


function timeLineSetting() {
  var timeLineHeight = $('.time-line').innerHeight();
  var timeLine = $('.time-line');
  var timeLineWidth = $('.time-line').width();
  if (timeLineHeight < 315) {
    $('.page-profile-picture').css({'position':'static', 'top':'18px'});
    $('.add-image').css('top','18px');
  } else {
  }
}

$(function(){
  timeLineSetting();
})

$(function() {
  $('.details-link').click(function() {
    $('.question-details').toggle()
  })
})

$(function () {
  $('.question-field').keypress(function() {
    $('.call-count').show();
    var len = $(this).val().length;
    $('.call-count').text(len);
  })
})

$(function () {
  $('.expand-it').click(function () {
    var titleVal = $('.question-field').val();
    var details  = $('.question-details').val();
    $('.dec').val(titleVal)
    $('.desc_question').val(details);
  })
})

$(function () {
  $('#show-answer-form').click(function() {
   $('#answer-form-center').toggle();
  })
})
