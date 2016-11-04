

$(function() {

$('.top.menu .item').tab();

$('.ui.dropdown').dropdown();

$('.call-modal').click(function() {
  $('.auth-modal')  .modal({
    blurring: true
  }).modal('setting', 'transition', 'horizontal flip').modal('show');
});




$('.share-caller').click(function() {
  var id =  $(this).data('id');
  var name = $(this).data('question');
  eval('var obj='+name)
  $('.share-modal').modal({
    blurring: true
  }).modal('setting', 'transition', 'horizontal flip').modal('show');
  $('.share-name').text(obj.name);
  $('#share-link-form').val(obj.url)
  $('#twitter').attr("href", "https://twitter.com/share?url="+obj.url+'&text='+obj.name);
  $('#facebook').attr("href", "https://www.facebook.com/dialog/share?app_id=484766111702543&href="+obj.url+"redirect_uri=http://www.onozor.com");
  $('#linkedin').attr("href", "https://www.linkedin.com/cws/share?url="+obj.url);
  $('#google-plus').attr("href", "https://plus.google.com/share?url="+obj.url);
  $('#reddit').attr("href", "http://www.reddit.com/submit?url="+ obj.url +"&title="+obj.name);
  $('#hacker').attr("href", "http://news.ycombinator.com/submitlink?u="+ obj.url + "&t="+obj.name);
});


$('.ask-some-one-button').click(function() {
  $('.ask-some-one').modal({
    blurring: true
  }).modal('setting', 'transition', 'horizontal flip').modal('show');
});




$('.button')
  .popup({
    transition: 'horizontal flip',
    inline   : true,
    hoverable: true,
    position : 'top left'
  })
;

var changeJsonResponse = function(data) {
	var content =  [];
 for (var i = 0; i < data.length; i++ ) {
 	data[i].title = data[i].name;
	delete data[i].name;
	content.push(name[i]);
 }
 return content;
};




$(".prompt").focus(function() {
    $.get("/users/categories.json", function(data, status) {
        var content = changeJsonResponse(data);
        console.table("Alex", data);
        $('.ui.search')
        .search({
          searchFields: ['title'],
          source: data,
          error: {
            noResults: 'Something went wrong'
          },
          onSelect : function(event) {
            var intId =  parseInt(event.id)

            $.ajax({
              url: '/user_category',
              type: 'POST',
              dataType: "script",
              data: {category_id:intId},
              success: function(data) {
                $('.prompt').val("").blur();
              }
            });
          }
        })
      ;
    });
});
//

  $('.sidebar').click(function() {
    $('.ui.sidebar')
    .sidebar('setting', 'dimPage', false, 'transition', 'push')
    .sidebar('toggle');
  })

  $('.ui.checkbox')
    .checkbox();
    $('.item').click(function() {
      $('.item').removeClass('active');
      $(this).addClass('active');
      $('.loader-margin').show();
    })
});



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
