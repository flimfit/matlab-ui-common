function downloaded = get_library(opts)

    if ~isfield(opts,'destination_path')
        opts.destination_path = [fileparts(mfilename('fullpath')) filesep];
    end
    
    opts.destination_path = ensure_trailing_slash(opts.destination_path);
    library_path = [opts.destination_path opts.folder_name filesep];
    
    downloaded = false;
    if ~exist(library_path, 'dir') || ~exist([library_path opts.example_file_name], 'file')
        disp(['Downloading ' opts.library_name '...']);
        file = [tempdir hash(opts.url) '.zip'];
        %file = [opts.destination_path opts.library_name '.zip'];
        
        if ~exist(file,'file')
            options = weboptions('Timeout',60);
            websave(file,opts.url,options);
        end
        
        filenames = unzip(file, opts.destination_path);
        filenames = sort(filenames);
        new_path = [fileparts(filenames{1}) filesep];
        if ~strcmp(new_path, library_path)
            movefile(new_path, library_path);
        end
        
        downloaded = true;
    end
    
    addpath(genpath(library_path));
    
end