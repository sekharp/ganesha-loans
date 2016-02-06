jQuery ->
  if $('#infinite-scrolling').size() > 0
    $(window).on 'scroll', ->
      more_projects_url = $('.pagination .next_page a').attr('href')
      if more_projects_url && $(window).scrollTop() > $(document).height() - $(window).height() - 100
          $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />')
          $.getScript more_projects_url
      return
    return
