function get_iterVSTpoisson()
% Add bioformats to path.
% If required, download from OME and unzip first

    cdir = [fileparts(mfilename('fullpath')) filesep];
    path = [cdir 'iterVSTpoisson_STANDALONE' filesep];
    
    if ~exist(path, 'dir')
        
        disp('Downloading iterVSTpoisson_STANDALONE...');
        disp('Please observe the terms of the TUT limited licence for denoising. [http://www.cs.tut.fi/~foi/invansc/Legal_Notice.pdf]');
        link = 'http://www.cs.tut.fi/~foi/invansc/iterVSTpoisson_STANDALONE.zip';
        file = [cdir 'iterVSTpoisson_STANDALONE.zip'];
        websave(file,link);
        unzip(file, path);
        delete(file);
    
    end
    
     
    addpath(path);
    
end