function get_file(filename, url)
    if ~exist(filename, 'file')
        websave(filename, url);
    end
end