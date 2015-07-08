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
















