function path = get_gui_layout_toolbox()
% Add bioformats to path.
% If required, download from OME and unzip first

    cdir = [fileparts(mfilename('fullpath')) filesep];
    path = [cdir 'layout' filesep];

    if ~exist(path, 'dir')
        
        disp('Downloading gui-layout...');
        url = 'https://storage.googleapis.com/flimfit-downloads/toolboxes/GUI%20Layout%20Toolbox%202.3.2.zip';
        file = [cdir 'gui-layout.zip'];
        websave(file, url);
        unzip(file, cdir);
        delete(file);
    
    end
    
    addpath(path);
    
end