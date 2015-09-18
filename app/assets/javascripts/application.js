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
//= require jquery_ujs
//= require turbolinks
//= require ckeditor/init
//= require_tree .


 $(function(){
  $('#question_tag_list').tokenInput('/alltags.json', {
     crossDomain:false,
     prePopulate: $('#question_tag_list').data('pre')
   });
 });

$(function(){
  $('#myTab a').click(function (e) {
  e.preventDefault()
  $(this).tab('show')
 });
});

$(function(){
  if ($('#answers').length > 0 ){
    setTimeout(updateAnswers, 10000);
 }
});

function updateAnswers(){
 var question_id = $('#question').attr('data-id');
 var after = $('#answer-body:last-child').attr('data-time');
 $.getScript("/answers.js?question_id="+question_id+"&after="+after)
 setTimeout(updateAnswers, 10000);
}


$('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
  e.target // activated tab
  e.relatedTarget // previous tab
})

$(function(){
$(".online").click(function(){
 $("#online").load('/users/who_is_online .users');
 });
});


$(function(){
$('#users_search input').keyup(function () {
    $.get($('#users_search').attr('action'),
        $('#users_search').serialize(), null, 'script');
    return false;
});
});


$(document).on('page:fetch',   function() { NProgress.start(); });
$(document).on('page:change',  function() { NProgress.done(); });
$(document).on('page:restore', function() { NProgress.remove(); });






$(document).ready(function() {
    $('#add_h1').on("click", function(e) {
        e.preventDefault();
        md_insert_h1_to('question[body]');
    });

    $('#add_h2').on("click", function(e) {
        e.preventDefault();
        md_insert_h2_to('question[body]');
    });

    $('#add_h3').on("click", function(e) {
        e.preventDefault();
        md_insert_h3_to('question[body]');
    });

    $('#add_h4').on("click", function(e) {
        e.preventDefault();
        md_insert_h4_to('question[body]');
    });

    $('#add_h5').on("click", function(e) {
        e.preventDefault();
        md_insert_h5_to('question[body]');
    });

    $('#add_h6').on("click", function(e) {
        e.preventDefault();
        md_insert_h6_to('question[body]');
    });

    $('#add_em').on("click", function(e) {
        e.preventDefault();
        md_insert_em_to('question[body]');
    });

    $('#add_strong').on("click", function(e) {
        e.preventDefault();
        md_insert_strong_to('question[body]');
    });

    $('#add_paragraph').on("click", function(e) {
        e.preventDefault();
        md_insert_paragraph_to('question[body]');
    });

    $('#add_blockquote').on("click", function(e) {
        e.preventDefault();
        md_insert_blockquote_to('question[body]');
    });

    $('#add_unord_list').on("click", function(e) {
        e.preventDefault();
        md_insert_unord_list_to('question[body]');
    });

    $('#add_ord_list').on("click", function(e) {
        e.preventDefault();
        md_insert_ord_list_to('question[body]');
    });

    $('#add_link').on("click", function(e) {
        e.preventDefault();
        alert("welcme");
        md_insert_link_to('question[body]');
    });

    $('#insert_code').on("click", function(e) {
        e.preventDefault();
        md_insert_code_to('question[body]');
    });
});

function md_insert_link_to(element) {
    insertText(element, "[", "](http://link_address)", "link_name")
}

function md_insert_h1_to(element) {
    insertText(element, "\n# ", "\n", "H1")
}

function md_insert_h2_to(element) {
    insertText(element, "\n## ", "\n", "H2")
}

function md_insert_h3_to(element) {
    insertText(element, "\n### ", "\n", "H3")
}


function md_insert_em_to(element) {
    insertText(element, "*", "*", "italic")
}

function md_insert_strong_to(element) {
    insertText(element, "**", "**", "bold")
}

function md_insert_code_to(element) {
    insertText(element, "```", "```", "code")
}

function md_insert_paragraph_to(element) {
    insertText(element, "\n", "\n\n", "paragraph")
}

function md_insert_blockquote_to(element) {
    insertText(element, "\n> ", "\n", "blockquote")
}

function md_insert_unord_list_to(element) {
    insertText(element, "\n* ", "\n", "element")
}

function md_insert_ord_list_to(element) {
    insertText(element, "\n1 ", "\n", "element")
}




function insertText(element_name, before_text, after_text, default_text) {
    // get element by name
    var element = document.getElementsByName(element_name)[0];

    //IE specific patch: IE 9 etc.
    if (selection = document.selection) {
        IE_insertText(element, selection, before_text, after_text, default_text);
        //modern browsers
    } else if (element.selectionStart || element.selectionStart == '0') {
        var selection_from       = element.selectionStart;
        var selection_to         = element.selectionEnd;
        var val                  = element.value;
        var text_before_selected = val.substring(0, selection_from);
        var text_after_selected  = val.substring(selection_to, val.length);
        var selected_text        = val.substring(selection_from, selection_to);
        var content;

        // if we didn't select anything we add default text
        if (selection_from == selection_to) {
            content = default_text;
            // otherwise we use selected text
        } else {
            content = selected_text;
        }

        // updating element value
        element.value = text_before_selected + before_text + content +
            after_text + text_after_selected;
        element.focus();

        // do highlight text
        element.selectionStart = selection_from + before_text.length;
        element.selectionEnd   = element.selectionStart + content.length;

        if (selection_from != selection_to) {
            window.getSelection().collapseToEnd();
        }
        //other ones?
    } else {
        alert("still not fully implemented");
    }
}

$('.hide-form').click(function(){
    alert('welcome')
})
