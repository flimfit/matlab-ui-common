function compile_function(func_name,program_name,additional_folders)
    
    if nargin < 3
        additional_folders = {};
    elseif ~iscell(additional_folders)
        additional_folders = {additional_folders};
    end

    % Get version
    [~,ver] = system('git describe','-echo');
    ver = ver(1:end-1);
    is_release = isempty(regexp(ver,'-\d-+[a-z0-9]+','ONCE'));
    
    % Build App
    if exist(['.' filesep 'build'],'dir')
        rmdir('build','s');
    end

    mkdir('build');
    delete(['build' filesep '*']);
    
    args = {'-m',func_name, '-v', '-d', 'build', '-o', program_name};
    for i=1:length(additional_folders)
        args = [args {'-a' additional_folders{i}}];
    end
    
    mcc(args{:});
        
    if ispc
        ext = '.exe';
    else
        ext = '.app';
    end
   
    new_file = [program_name ' ' ver ' ' computer('arch')];
    movefile(['build' filesep program_name ext], ['build' filesep new_file ext]);
    
    if ismac
        mkdir(['build' filesep 'dist']);
        movefile(['build' filesep new_file ext], ['build' filesep 'dist' filesep new_file ext]);
        cmd = ['hdiutil create "./build/' new_file '.dmg" -srcfolder ./build/dist/ -volname "' new_file '" -ov'];
        system(cmd)
        final_file = ['build/' new_file '.dmg'];
    else
        final_file = ['build' filesep new_file ext];
    end
    
    if is_release
        dir1 = 'release';
    else 
        dir1 = 'latest';
    end
    mkdir(['build' filesep dir1]);
    mkdir(['build' filesep dir1 filesep ver]);
    
    movefile(final_file, ['build' filesep dir1 filesep ver]);
end