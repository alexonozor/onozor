
$('#example2').progress({
  percent: 50
});

$('.select-friends').modal('show');

$('.load-followers').html("<%=j render template: 'users/user_followers/modal_user_followers' %>")



$(document)
  .ready(function() {
  var $toggle  = $('.ui.toggle.button');
  $toggle
    .state({
      text: {
        inactive : 'Follow',
        active   : 'Following'
      }
    })
  ;

});
