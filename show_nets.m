path = 'nets/';

files = dir(path);

networks = {};

for i=1:length(files)
    file = files(i);
    if ~file.isdir && endsWith(file.name, '.mat') && ~ startsWith(file.name, 'google')
        file_path = [file.folder,'/', file.name];
        network_data = load_net(file_path);
        networks = [networks; network_data];
    end
end

networks