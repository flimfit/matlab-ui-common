function get_file(filename, url)
    if ~exist(filename, 'file')
        options = weboptions('Timeout',60);
        websave(filename, url, options);
    end
end