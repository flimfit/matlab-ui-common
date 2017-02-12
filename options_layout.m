classdef options_layout < handle
   
    properties
       
        parent;
        layout;
        grid;
        grid_idx;
        
    end
    
    methods
        
        function obj = options_layout(parent)
            obj.parent = parent;
            obj.layout = uix.VBox('Parent',parent,'Spacing',2,'Padding',5);
        end
        
        function StartGroup(obj,label)
            uicontrol('Style','text','String',label,'FontWeight','bold','Parent',obj.layout);
            obj.grid = uix.Grid('Parent',obj.layout,'Spacing',5);
            obj.layout.Heights(end-1:end) = [22; 10];
            obj.grid_idx = length(obj.layout.Children);
        end
        
        function lay = StartCustomGroup(obj,label)
            uicontrol('Style','text','String',label,'FontWeight','bold','Parent',obj.layout);
            obj.layout.Heights(end) = 22;
            lay = obj.layout;
        end
        
        function control = AddControl(obj,label,varargin)
            if isempty(obj.grid)
                obj.StartGroup('Options')
            end
            
            uicontrol('Style','text','String',label,'Parent',obj.grid);
            control = uicontrol(varargin{:},'Parent',obj.grid);
        end

        function EndGroup(obj)
            n = length(obj.grid.Children);
            
            idx = [1:2:n 2:2:n];
            obj.grid.Children = obj.grid.Children(idx);

            obj.grid.Widths = [100 -1];
            obj.grid.Heights = 22*ones(n/2,1);

            obj.layout.Heights(obj.grid_idx) = n/2 * 27;   
            
            uix.Empty('Parent',obj.layout);
            obj.layout.Heights(end) = 20;
        end
        
        function control = AddButton(obj,varargin)
            control = uicontrol('Style','pushbutton','Parent',obj.layout,varargin{:});
            obj.layout.Heights(end) = 22;
        end
        
        function SetLastControlHeight(obj, height)
            obj.layout.Heights(end) = height;
        end
        
        function Finish(obj)
            uix.Empty('Parent',obj.layout);
            obj.layout.Heights(end) = -1;
        end
        
    end
    
    
    
end