
var myApp = new Framework7();

// Add view
var mainView = myApp.addView('.view-main', {
    // Because we want to use dynamic navbar, we need to enable it for this view:
    dynamicNavbar: true
    });

var $$ = Dom7;
$$('.open-3-modal').on('click', function () {
    myApp.modal({
        title:  'Modal with 3 buttons',
        text: 'Vivamus feugiat diam velit. Maecenas aliquet egestas lacus, eget pretium massa mattis non. Donec volutpat euismod nisl in posuere. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae',
        buttons: [
            {
                text: 'B1',
                onClick: function() {
                    myApp.alert('You clicked first button!')
                }
},
                    {
                        text: 'B2',
                        onClick: function() {
                        myApp.alert('You clicked second button!')
                        }
},
                    {
                        text: 'B3',
                        bold: true,
                        onClick: function() {
                        myApp.alert('You clicked third button!')
                        }
},
]
})
});
$$('.open-slider-modal').on('click', function () {
    var modal = myApp.modal({
    title: 'Awesome Photos?',
    text: 'What do you think about my photos?',
    afterText:  '<div class="slider-container" style="width: auto; margin:5px -15px">'+
    '<div class="slider-pagination"></div>'+
    '<div class="slider-wrapper">'+
    '<div class="slider-slide"><img src="http://hhhhold.com/270x150/jpg?1" height="150"></div>' +
    '<div class="slider-slide"><img src="http://hhhhold.com/270x150/jpg?2"></div>'+
    '</div>'+
    '</div>',
    buttons: [
    {
    text: 'Bad :('
    },
                    {
                        text: 'Awesome!',
                        bold: true,
                        onClick: function () {
                        myApp.alert('Thanks! I know you like it!')
                        }
},
]
})
myApp.slider($$(modal).find('.slider-container'), {pagination: '.slider-pagination'});
});

$$('.open-tabs-modal').on('click', function () {
    myApp.modal({
        title:  '<div class="buttons-row">'+
            '<a href="#tab1" class="button active tab-link">Tab 1</a>'+
            '<a href="#tab2" class="button tab-link">Tab 2</a>'+
            '</div>',
        text: '<div class="tabs">'+
            '<div class="tab active" id="tab1">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam convallis nunc non dolor euismod feugiat. Sed at sapien nisl. Ut et tincidunt metus. Suspendisse nec risus vel sapien placerat tincidunt. Nunc pulvinar urna tortor.</div>'+
            '<div class="tab" id="tab2">Vivamus feugiat diam velit. Maecenas aliquet egestas lacus, eget pretium massa mattis non. Donec volutpat euismod nisl in posuere. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae</div>'+
            '</div>',
        buttons: [
            {
                text: 'Ok, got it',
                bold: true
            },
]
})
});

function myFunction() {

  $$('.question-overlay, .question-modal').show("slow");
  $$('.question-overlay').click(function(){
  $$('.question-overlay, .question-modal').hide();
    });

}

function myFollowings() {

    $$('.question-overlay, .following-modal').show("slow");
    $$('.question-overlay').click(function(){
    $$('.question-overlay, .following-modal').hide();
    });

}

function myFollowed() {

    $$('.question-overlay, .followed-modal').show("slow");
    $$('.question-overlay').click(function(){
    $$('.question-overlay, .followed-modal').hide();
    });

}

function myFavorite() {

    $$('.question-overlay, .favourite-modal').show("slow");
    $$('.question-overlay').click(function(){
    $$('.question-overlay, .favourite-modal').hide();
    });

}




