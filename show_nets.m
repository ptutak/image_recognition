path = 'nets/';

files = dir(path);

networks = {};

for i=1:length(files)
    file = files(i);
    if ~file.isdir && endsWith(file.name, '.mat') && ~ startsWith(file.name, 'google')
        file_path = [file.folder,'/', file.name];
        network_data = load_net(file_path);
        network_data.name = string(['network_', num2str(i)]);
        networks = [networks; network_data];
    end
end

networks_table = table;

for i = 1:length(networks)
    network = networks{i};
    new_table = struct2table(network.options);
    accuracy = network.accuracy;
    accuracy_table = table(accuracy);
    name = network.name;
    name_table = table(name);
    new_table = [name_table, new_table, accuracy_table];
    networks_table = [networks_table; new_table];
end

% Modyfikacje obrazu: "RandXScale: [0.9000 1.1000], RandYScale: [0.9000 1.1000], RandXTranslation: [-30 30], RandYTranslation: [-30 30]"

new_figure = uifigure;
uitable(new_figure, "Data", networks_table, "FontSize", 18);