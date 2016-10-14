$ ->
  $("[data-tooltip]").each ->
    current_el = $(this)
    # grab tooltip text ready to inset into new div
    tooltip_text = current_el.attr "data-tooltip"

    # wrap all inner elements in a hover element to allow finer control
    current_el.wrapInner '<div class="ui-tooltip-hover-area"></div>'
    # active class
    current_el.addClass "has-tooltip"
    # create tooltip and insert text
    current_el.append '<div class="ui-tooltip-group"><div class="ui-tooltip-group__tooltip-text">' + tooltip_text + '</div></div>'

    $ui_hover_area = current_el.find(".ui-tooltip-hover-area")
    $ui_hover_area.on "mouseenter", ->
      # switch the classes and remove if necessary
      current_el
        .addClass "is-active-tooltip"
        .removeClass "is-inactive-tooltip"
    $ui_hover_area.on "mouseleave", ->
      # check if the tooltip is active (just in case...)
      if current_el.hasClass "is-active-tooltip"
        current_el
          .removeClass "is-active-tooltip"
          .addClass "is-inactive-tooltip"
