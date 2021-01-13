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
layer_tables = {};
for i = 1:length(networks)
    network = networks{i};
    new_table = struct2table(network.options);
    accuracy = network.accuracy;
    accuracy_table = table(accuracy);
    name = string(['network_', num2str(i)]);
    name_table = table(name);
    new_table = [name_table, new_table, accuracy_table];
    networks_table = [networks_table; new_table];
    layer_table = table(network.layers, 'VariableNames', name);
    layer_tables{i} = layer_table;
end

% Modyfikacje obrazu: "RandXScale: [0.9000 1.1000], RandYScale: [0.9000 1.1000], RandXTranslation: [-30 30], RandYTranslation: [-30 30]"

networks_table;
layer_tables;

writetable(networks_table, "statistics.xlsx", 'Sheet', 'General');
for i = 1:length(layer_tables)
    range = [char(i + 64), '1'];
    writetable(layer_tables{i}, "statistics.xlsx", 'Sheet', 'Layers', 'Range', range);
end