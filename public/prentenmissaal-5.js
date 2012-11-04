$(document).ready(function() {
    // kick off Masonry
    $('#container').masonry({
      // options
      itemSelector : '.item',
      columnWidth : 502
    }).imagesLoaded(function() {
	   $('#container').masonry('reload');
	});
});
$(window).load(function() {
    $('.thumbnailportrait').each(function(idx,img) {
      if ($(img).width() > $(img).height()) {
        $(img).removeClass('thumbnailportrait');
        $(img).addClass('thumbnaillandscape');
      }  
    });
});