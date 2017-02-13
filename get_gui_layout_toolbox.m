function get_gui_layout_toolbox()
% Add bioformats to path.
% If required, download from OME and unzip first

    cdir = [fileparts(mfilename('fullpath')) filesep];

    if ~exist([cdir filesep 'layout'], 'dir')
        
        disp('Downloading gui-layout...');
        url = 'http://au.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/47982/versions/11/download/zip';
        file = [cdir 'gui-layout.zip'];
        websave(file, url);
        unzip(file, cdir);
        delete(file);
    
    end
    
    addpath([cdir 'layout'])
    
end