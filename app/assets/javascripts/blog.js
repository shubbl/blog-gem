document.addEventListener("turbolinks:load", function() {
  $( "#blog-archive-trigger" ).click(function() {
    var c = $(this).data("current")
    $(this).text($(this).data(c))
    if (c == "show"){
      $(".blog-gem-taglist-first").removeClass("hidden")
      $(".blog-gem-taglist-all").addClass("hidden")
      $(this).data("current", "hidden")
    }else{
      $(".blog-gem-taglist-first").addClass("hidden")
      $(".blog-gem-taglist-all").removeClass("hidden")
      $(this).data("current", "show")
    }
  });
})
