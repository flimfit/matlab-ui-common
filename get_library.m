function downloaded = get_library(opts)

    if ~isfield(opts,'destination_path')
        opts.destination_path = [fileparts(mfilename('fullpath')) filesep];
    end
    
    opts.destination_path = ensure_trailing_slash(opts.destination_path);
    library_path = [opts.destination_path opts.folder_name filesep];
    
    downloaded = false;
    if ~exist(library_path, 'dir') || ~exist([library_path opts.example_file_name], 'file')
        disp(['Downloading ' opts.library_name '...']);
        file = [opts.destination_path opts.library_name '.zip'];
        websave(file,opts.url);
        filenames = unzip(file, opts.destination_path);

        new_path = filenames{1};

        if ~strcmp(new_path, library_path)
            movefile(new_path, library_path);
        end
        
        delete(file);
        downloaded = true;
    end
    
    addpath(genpath(library_path));
    
end