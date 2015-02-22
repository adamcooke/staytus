## This is a manifest file that'll be compiled into application.js, which will include all the files
## listed below.
##
## Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
## or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
##
## It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
## compiled file.
##
## Read Sprockets README (https:##github.com/sstephenson/sprockets#sprockets-directives) for details
## about supported directives.
##
##= require jquery
##= require jquery_ujs
##= require_tree .

$ ->

  $('time').timeago()

  #
  # Checkbox reveal areas
  #
  revealCheckboxes = $('input[data-reveal-area]')
  toggleRevealCheckboxValue = (checkbox)->
    hiddenArea = $(checkbox.data('reveal-area'))
    if checkbox.data('reveal-area-invert')
      if checkbox.prop('checked') then hiddenArea.hide() else hiddenArea.show()
    else
      if checkbox.prop('checked') then hiddenArea.show() else hiddenArea.hide()

  if revealCheckboxes.length
    $.each revealCheckboxes, -> toggleRevealCheckboxValue($(this))
    revealCheckboxes.on 'change', -> toggleRevealCheckboxValue($(this))

  #
  # Watching for chronic preview
  #
  $('.has-chronicPreview').each ->
    chronicWatchTimer = null
    field = $(this)
    field.on 'keyup', ->
      clearTimeout(chronicWatchTimer) if chronicWatchTimer
      if field.val().length
        chronicWatchTimer = setTimeout ->
          $.get "/admin/helpers/chronic", {string: field.val()}, (data)->
            field.parent().find('.chronicPreview').remove()
            value = if data.formatted then data.formatted else 'Invalid Date'
            $("<p class='chronicPreview'>#{value}</p>").insertBefore(field)
        , 1000
      else
        field.parent().find('.chronicPreview').remove()

  #
  # Clicking on notices will hide them
  #
  notices = $('#flash-notice, #flash-alert')
  if notices.length
    notices.on 'click', -> $(this).hide('fast')
    setTimeout ->
      notices.hide('fast')
    , 5000

  #
  # Open external links in new window
  #
  $('a[href^=http]:not([rel=internal])').attr('target', '_blank');

  #
  # Deleting image attachments
  #
  $('.imagePreview a').on 'click', ->
    container = $(this).parent()
    # remove images
    $('img', container).replaceWith("Will remove on save...")
    $(this).remove()
    # add hidden field
    $('input[type=hidden]', container).val('delete')
    container.addClass('imagePreview--deleting')

    false
