function get_bioformats(destination_path, version)
% Add bioformats to path.
% If required, download from OME and unzip first

    if nargin < 1
        destination_path = [fileparts(mfilename('fullpath')) filesep];
    end
    if nargin < 2
        version = '5.8.2';
    end
    
    opts.destination_path = destination_path;
    opts.library_name = 'bioformats';
    opts.url = ['http://downloads.openmicroscopy.org/bio-formats/' version '/artifacts/bfmatlab.zip'];
    opts.folder_name = 'bfmatlab';
    opts.example_file_name = 'bfopen.m';
    
    downloaded = get_library(opts);
    
    if downloaded
       folder = [destination_path filesep opts.folder_name filesep];
       movefile([folder 'bioformats_package.jar'],[folder 'bioformats_package.zip']);
       delete_from_zip([folder 'bioformats_package.zip'],...
           {'org\slf4j\impl\StaticMDCBinder.class','org\slf4j\impl\StaticMarkerBinder.class','org\slf4j\impl\StaticLoggerBinder.class'});
       movefile([folder 'bioformats_package.zip'],[folder 'bioformats_package.jar']);
    end
    
end