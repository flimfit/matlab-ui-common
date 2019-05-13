function get_cellsegm(destination_path)
% Add bioformats to path.
% If required, download from OME and unzip first

    if nargin < 1
        destination_path = [fileparts(mfilename('fullpath')) filesep];
    end
    
    opts.destination_path = destination_path;
    opts.library_name = 'cellsegm';
    opts.url = 'https://github.com/ehodneland/cellsegm/archive/master.zip';
    opts.folder_name = 'cellsegm';
    opts.example_file_name = 'startupcellsegm.m';
    
    get_library(opts);
    
end