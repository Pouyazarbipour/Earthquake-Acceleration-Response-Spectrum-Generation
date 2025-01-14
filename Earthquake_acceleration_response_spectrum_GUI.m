function Earthquake_acceleration_response_spectrum_GUI()
    % Generates Acceleration Response Spectrum Based on API RP 2WSD 2014

    % Create the figure
    fig = figure('Name', 'Acceleration Response Spectrum Generator', ...
        'NumberTitle', 'off', ...
        'Position', [300, 300, 500, 400]);

    % Input Controls
    uicontrol('Style', 'text', 'Position', [20, 365, 120, 20], 'String', 'Coefficient (G):');
    g_edit = uicontrol('Style', 'edit', 'Position', [150, 370, 80, 20], 'String', '1');

    uicontrol('Style', 'text', 'Position', [20, 340, 120, 20], 'String', 'Soil Type (A/B/C):');
    soil_popup = uicontrol('Style', 'popupmenu', 'Position', [150, 345, 80, 20], ...
        'String', {'A', 'B', 'C'}, 'Value', 1);

    % Generate Button
    uicontrol('Style', 'pushbutton', 'Position', [20, 300, 120, 30], ...
        'String', 'Generate Spectrum', 'Callback', @generate_spectrum_callback);

    % Status Text
    status_text = uicontrol('Style', 'text', 'Position', [20, 280, 460, 20], ...
        'String', '', 'HorizontalAlignment', 'left');

    % Plot Axes
    ax = axes('Position', [0.1, 0.1, 0.8, 0.55]);
    xlabel(ax, 'Period (s)');
    ylabel(ax, 'Spectral Acceleration (g)');
    title(ax, 'Acceleration Response Spectrum');
    grid(ax, 'on');

    % Callback for Generate Button
    function generate_spectrum_callback(~, ~)
        % Reset status text
        set(status_text, 'String', 'Generating spectrum...');

        % Get input values
        g_val = str2double(get(g_edit, 'String'));
        soil_index = get(soil_popup, 'Value');
        soiltype = char(get(soil_popup, 'String'));
        soiltype = soiltype(soil_index, :);

        % Input validation
        if isnan(g_val) || g_val <= 0
            set(status_text, 'String', 'Error: Enter a positive value for G.');
            return;
        end

        % Generate Spectrum Data
        try
            t_values = 0.01:0.01:5; % Period values
            sa_values = arrayfun(@(t) spec(soiltype, g_val, t), t_values);

            % Plot spectrum
            plot(ax, t_values, sa_values, 'b', 'LineWidth', 1.5);
            xlabel(ax, 'Period (s)');
            ylabel(ax, 'Spectral Acceleration (g)');
            title(ax, 'Acceleration Response Spectrum');
            grid(ax, 'on');

            % Export to file
            save_to_file(t_values, sa_values);

            % Update status text
            set(status_text, 'String', 'Spectrum generated successfully!');
        catch ME
            set(status_text, 'String', ['Error: ', ME.message]);
        end
    end

    % Save data to text file
    function save_to_file(t_values, sa_values)
        [file, path] = uiputfile('*.txt', 'Save Spectrum Data');
        if ischar(file)
            filepath = fullfile(path, file);
            fileID = fopen(filepath, 'w');
            fprintf(fileID, 'Period (s)\tSpectral Acceleration (g)\n');
            fprintf(fileID, '%6.2f\t%8.3f\n', [t_values; sa_values]);
            fclose(fileID);
        end
    end

    % Spectrum Calculation Function
    function sa = spec(soiltype, g, t)
        samax = 2.5 * g; % Maximum spectrum value

        if t <= 0.05
            sa = g;
        elseif t <= 0.135
            sa = min(20 * t * g, samax);
        else
            % Soil type multiplier
            switch lower(soiltype)
                case 'a', factor = 0.8;
                case 'b', factor = 1.2;
                case 'c', factor = 1.8;
                otherwise, error('Invalid soil type');
            end
            sa = min(factor * g / t, samax);
        end
    end
end
