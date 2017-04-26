function get_bioformats()
% Add bioformats to path.
% If required, download from OME and unzip first

    cdir = [fileparts(mfilename('fullpath')) filesep];
    path = [cdir 'bfmatlab' filesep];
    
    if ~exist(path, 'dir')
        
        disp('Downloading bioformats...');
        bflink = 'http://downloads.openmicroscopy.org/bio-formats/5.4.1/artifacts/bfmatlab.zip';
        file = [cdir 'bfmatlab.zip'];
        websave(file,bflink);
        unzip(file, cdir);
        delete(file);
    
    end
    
    addpath(path);
    
end