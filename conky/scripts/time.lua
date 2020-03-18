-- Script for displaying the time

require 'cairo'

function conky_main()
    if conky_window == nil then
        return 
    end

    local cs = cairo_xlib_surface_create(conky_window.display,
                                        conky_window.drawable,
                                        conky_window.visual,
                                        conky_window.width,
                                        conky_window.height)

    cr = cairo_create(cs)
    local hours =  (conky_parse('${time %H}'))
    local minutes =  (conky_parse('${time %M}'))
    local day = conky_parse('${time %a}')
    local month = conky_parse('${time %b}')
    local date = conky_parse('${time %d}')
    local year = conky_parse('${time %Y}')
    date_text = day .. ", " .. date .. " " .. month .. ", " .. year
    print(date_text)
    time_font = "Varela Round"
    time_font_size = 100
    text = hours .. ":" .. minutes
    time_xpos = 0
    time_ypos = 100
    time_red, time_green, time_blue, time_alpha = 255/255, 255/255, 255/255, 1
    time_font_slant = CAIRO_FONT_SLANT_NORMAL
    time_font_face = CAIRO_FONT_WEIGHT_NORMAL

    --displaying the time
    cairo_select_font_face(cr, time_font, time_font_slant, time_font_face)
    cairo_set_font_size(cr, time_font_size)
    cairo_set_source_rgba(cr, time_red, time_green, time_blue, time_alpha)
    cairo_move_to(cr, time_xpos, time_ypos)
    cairo_show_text(cr, text)
    cairo_stroke(cr)

    --date setup  
    date_font = "SF Mono Powerline"
    date_font_size = 16
    date_text = day .. ", " .. date .. " " .. month .. ", " .. year
    print(date_text)

    date_xpos = time_xpos + 50
    date_ypos = time_ypos+date_font_size+5
    date_red, date_green, date_blue, date_alpha = 1, 1, 1, 0.5
    date_font_slant = CAIRO_FONT_SLANT_NORMAL
    date_font_face = CAIRO_FONT_WEIGHT_NORMAL

    cairo_select_font_face(cr, date_font, date_font_slant, date_font_face)
    cairo_set_font_size(cr, date_font_size)
    cairo_set_source_rgba(cr, date_red, date_green, date_blue, date_alpha)
    cairo_move_to(cr, date_xpos, date_ypos)
    cairo_show_text(cr, date_text)
    cairo_stroke(cr)
    
    --destorying stuff to prevent memory leaks
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil

end
