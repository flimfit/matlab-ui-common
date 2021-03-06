function EC(fcn,varargin)
            
    if strcmp(computer,'MACI64') && ~isdeployed
        fcn(varargin{:});
    else            
        try
            fcn(varargin{:});
        catch e
            d = getReport(e,'extended','hyperlinks','off');
            clipboard('copy',d);
            error_dialog({d});
        end
    end

end