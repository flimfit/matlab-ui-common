function resume_gui_on_enter(fig)

    set(fig,'KeyPress',@keypress);
    
    function keypress(obj,evt)
        switch evt.Key
            case 'return'
                uiresume(obj);
            case 'escape'
                uiresume(obj);
        end
    end

end