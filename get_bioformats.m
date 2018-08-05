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
       movefile('ThirdParty\bfmatlab\bioformats_package.jar','ThirdParty\bfmatlab\bioformats_package.zip')
       delete_from_zip('ThirdParty\bfmatlab\bioformats_package.zip',...
           {'org\slf4j\impl\StaticMDCBinder.class','org\slf4j\impl\StaticMarkerBinder.class','org\slf4j\impl\StaticLoggerBinder.class'});
       movefile('ThirdParty\bfmatlab\bioformats_package.zip','ThirdParty\bfmatlab\bioformats_package.jar')
    end
    
end