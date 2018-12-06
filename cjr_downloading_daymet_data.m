%% Downloading Daymet Data

% User Prompts to define range of data to download

prompt = 'What is the working directory where the downloaded Daymet files will be saved?'
Working_dir = input('Working Directory:', 's'); % Instruct users to input working directory location
s=(['cd ' sprintf('%s', Working_dir)]);
eval(s); % Change current folder to working directory input


prompt = 'What are the start and end years for which you wish Daymet files to be downloaded?'
start_year = input('Start Year:'); % Intruct users to input start year of requested Daymet data
end_year = input('End Year:'); % Intruct users to input end year of requested Daymet data

% if 
%     start_year < 1980
%     or end_year > 2017
    
prompt = 'What are the start and end tiles that cover the spatial extent you want Daymet data for? Daymet tile numbers can be found here: https://daymet.ornl.gov/gridded/ Alternatively, if you wish to download a list of specific tiles, manual insert them in lin __ of this code'
start_tile = input('Start Tile:'); % Intruct users to input start tile of requested Daymet data
end_tile = input('End Tile:'); % Intruct users to input end tile of requested Daymet data

prompt = 'Select the output parameter you wish to download. Options include day1, prcp, srad, swe, tmax, tmin, vp.' 
output_parameter = input('Output Parameter:', 's'); % Intruct users to requested input the output parameter of requested Daymet data

% Create new folder for output parameter and set that as working directory
mkdir(sprintf('Daymet_%s', output_parameter))
wrk_d_2 = ([Working_dir,'\',(sprintf('Daymet_%s', output_parameter))]);
r=(['cd ' sprintf('%s', wrk_d_2)]);
eval(r); % Change current folder to new folder that will hold downloaded data 

% Downloading Specified Files

for year = (start_year:end_year)
  for tile = (start_tile:end_tile)
      %year_str = sprintf(year);
      %tile_str = sprintf(tile);
      api = 'https://thredds.daac.ornl.gov/thredds/fileServer/ornldaac/1328/tiles/';
      url = [api (sprintf('%u/%u_%u/%s.nc', year, tile, year, output_parameter)) ];
      filename = sprintf('%u_%u_%s_daymet.nc', tile, year, output_parameter);
      outfilename=websave(filename,url);
  end
end
%https://thredds.daac.ornl.gov/thredds/catalog/ornldaac/1328/tiles/2015/10090_2015/catalog.html?dataset=1328t/2015/10090_2015/vp.nc