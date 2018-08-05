function get_omero(destination_path, version)
% Add bioformats to path.
% If required, download from OME and unzip first

    if nargin < 1
        destination_path = [fileparts(mfilename('fullpath')) filesep];
    end
    if nargin < 2
        version = '5.3';
    end
    
    opts.destination_path = destination_path;
    opts.library_name = 'omero-matlab';
    opts.url = ['http://downloads.openmicroscopy.org/latest/omero' version '/matlab.zip'];
    opts.folder_name = 'omero-matlab';
    opts.example_file_name = 'omeroVersion.m';
    
    omero_path = [destination_path filesep 'omero-matlab' filesep];
    downloaded = get_library(opts);

    if downloaded
        unwanted_files = {'slf4j-log4j12.jar', 'slf4j-api.jar', 'log4j.jar'};
        for i = 1:length(unwanted_files)
            file = [omero_path 'libs' filesep unwanted_files{i}];
            if exist(file,'file'), delete(file), end
        end
    end
        
    get_file([omero_path 'ini4j.jar'],...
             'https://dl.bintray.com/imperial-photonics/omeUiUtils/OMEuiUtils-0.1.6.jar');
    
    get_file([omero_path 'OMEuiUtils.jar'],...
             'http://artifacts.openmicroscopy.org/artifactory/maven/org/ini4j/ini4j/0.3.2/ini4j-0.3.2.jar');
    
end