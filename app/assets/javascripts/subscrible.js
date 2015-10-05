
$(document).ready(function() {
    $('a.btn-subscribed').filter(function(){
        var $this = $(this);
        var matches =  $(this).attr('id').match(/\d+/);
        if (matches) {
            $this.data('idNumber', matches[0]);
        }
        return matches;
    }).hover(function(){
        var user_id = $(this).data('idNumber');
        if($("a.subscribed"+user_id).hasClass('btn-subscribed')){
            $("a.subscribed"+user_id).addClass('unsubscrible');
            $("a.subscribed"+user_id).find("span.subscribed-count").text("Unsubscrible");
        }
    }, function(){
        var user_id = $(this).data('idNumber');
        if($("a.subscribed"+user_id).hasClass('btn-subscribed')){
            $("a.subscribed"+user_id).removeClass('unsubscrible');
            $("a.subscribed"+user_id).find("span.subscribed-count").text("Subscribled");
        }
    });

    $('body').on('ajax:success', 'a.btn-subscribe', function(xhr, data, status){
        if (data.status == "following") {
            $(this).addClass('btn-subscribed');
            $(this).addClass('subscribed'+$(this).attr('data-id'));
            $(this).find("span.subscribed-count").text("Subscribed");
            $(this).data('method', 'delete');
            $('a.btn-subscribed').filter(function(){
                var $this = $(this);
                var matches =  $(this).attr('id').match(/\d+/);
                console.debug(matches);
                if (matches) {
                    $this.data('idNumber', matches[0]);
                }

                return matches;
            }).hover(function(){
                var user_id = $(this).data('idNumber');
                if($("a.subscribed"+user_id).hasClass('btn-subscribe')){
                    $("a.subscribed"+user_id).addClass('unsubscribed');
                    $("a.subscribed"+user_id).find("span.subscribes-count").text("Unsubscribes");
                }
            }, function(){
                var user_id = $(this).data('idNumber');
                if($("a.subscribed"+user_id).hasClass('btn-subscribed')){
                    $("a.subscribed"+user_id).removeClass('unsubscribed');
                    $("a.subscribed"+user_id).find("span.subscribed-count").text("Subscribed");
                }
            });
            $('.count-subscribed').html(function(i, val) { return +val+1 });

        }
        else {
            $(this).removeClass('btn-subscribed');
            $(this).removeClass('subscribed'+$(this).attr('data-id'));
            $(this).find("span.subscribed-count").text("Subscribe");
            $(this).data('method', 'post');
            $('.count-subscribed').html(function(i, val) { return +val-1 });

        }
    });

});





