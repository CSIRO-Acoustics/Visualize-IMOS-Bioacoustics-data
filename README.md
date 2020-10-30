# Visualize IMOS Bioacoustics data (viz_sv)
 viz_sv is a 'Matlab' based function to read and visualise IMOS Bioacoustics NetCDF file.

For more information about this function see: https://csiro-acoustics.github.io/Visualize-IMOS-Bioacoustics-data/

For more information about IMOS Bioacoustics sub-Facility: http://imos.org.au/facilities/shipsofopportunity/bioacoustic/

## Syntax for usage
    viz_sv
    viz_sv(ncfile)
    viz_sv(ncfile, imagefile)
    viz_sv(ncfile, imagefile, 'channel', channel)
    viz_sv(ncfile, imagefile, 'all')
    viz_sv(ncfile, imagefile, 'depth', [min max])
    viz_sv(ncfile, imagefile, 'noplots')
    viz_sv(ncfile, imagefile, 'sun')
    viz_sv(data_struct,data_array)
    viz_sv(...,'title',title)
    viz_sv(...,'location',{start end})
    viz_sv(...,'channel', channel)
    viz_sv(...,'range',[min max])
    viz_sv(...,'depth',[min max])
    viz_sv(...,'cmap',cmap)
    viz_sv(...,'image',imagefile)
    viz_sv(...,'axis',ticktype)
    viz_sv(...,'ypos',ypos)
    viz_sv(...,'noplots')
    viz_sv(...,'sun')
    viz_sv(...,'csv',filename)
    viz_sv(...,'inf')
    viz_sv(...,'sv.csv')
    viz_sv(data_struct,data_array, title)

## Description
 The viz_sv function reads data from an IMOS_SOOP-BA*.nc file and plots
 the raw and processed Sv values in dB and the percentage good for each
 cell along with a plot of the vessel track and raw and processed NASC.

 viz_sv returns a data structure containing the data extracted from the
 NetCDF file. This data structure may be passed to later calls of viz_sv
 to plot other data sets.

## Examples
 If viz_sv is called without arguments or the ncfile argument is not a
 file (e.g. is empty or a directory) the user will be asked to select the
 file to read.

 If imagefile is specified and image of the plot will be written to file
 depending on the imagefile argument:
 
    [] - no file is written
    '' - empty string - the plot will be written to a file with the same
         name and directory as ncfile with a '.png' extension added.
    dir - if imagefile is a valid directory the image will be written to
         that directory with the same file name as ncfile with a '.png' 
         extension added.  
    '-dformat' - an image of the specified format will be written to a file
         with the same name as ncfile with a .format extension. See print 
         for a list of supported formats.
    filename - anything else is treated as the name of the file to write
         the image to.

 If the 'all' option is specified the data structure returned will contain
 all numeric (float or double) fields of the netCDF file.

 If the 'noplots' option is specified the data will be read and returned
 but no plots will be generated on screen - a plot will still be written
 to file if imagefile is specified.

 viz_sv(data_struct, data_array) will plot the data in data_array
 according to the axis found in data_struct. data_struct should be the
 output of an earlier viz_sv call (data read from a SOOP-BA NetCDF file).
 data_array may be a field of the data_struct or derived from a field of
 data_struct but must have the dimensions of the data_struct arrays.

 title will printed (along with the file name) as part of the plot title,
 e.g. title({data_struct.file ; title}).

 channel identifies which channel of a multi-channel (multi-frequency)
 data set is to be displayed. Channel may be either the integer index of
 the channel (1 for first channel), the name of the channel or the
 frequency of the channel (the first channel with that frequency). If the
 channel can not be identified or there is only one channel, the first
 channel is used.

 range will set the range for the color bar, e.g. caxis(range). An empty
 range will be replaced by the default Sv range [-84, -48].

 depth will limit the range for the vertical axis. An empty range will be
 replaced by the range covering valid (non-NaN) Sv data. A scalar range of
 0 will go from 0 to cover the valid data. A non-zero scalar range will go
 from 0 to the value given.

 cmap will be used as the colourmap for the plot, e.g. colormap(cmap). Use
 of the EK500 colourmap may cause matlab to use coarse colourmaps to
 overcome this explicitly state the number of colours to use e.g. 
 viz_sv(...,'cmap',jet(64))

 ticktype is one of 'time', 'lat', 'lon', 'latm', 'lonm'

 ypos is the number of graph heights from the bottom of the screen to
 place the plot.

 'sun' will use suncyle to calculate the sunrise and sunset times for each
 interval and add these values to the return structure as data.sun.
 It will also calculate whether each interval is in daylight (data.day).
 If a plot is requested it will draw a line on the plot showing day/night.
 This option requires suncycle.m to be in your path
 http://mooring.ucsd.edu/software/matlab/doc/toolbox/geo/suncycle.html 
 Note: this option is fairly slow.
 Bugs: 'sun' does not yet plot day/night on image files.

 'csv' will write a .csv file of the time, longitude and latitude and
 layer summary indices to the file specified. If the file name is empty
 then '.csv' will be added to the netCDF file name. Requires struct2txt in
 path.

 'inf' will generate MBSystem style .inf files and echoview style .gps.csv
 files for the data.

 'sv.csv' will generate echoview style .sv.csv and .gps.csv files for the
 data. One .sv.csv file will be created for each channel.

 The minimum requirements for a data_struct is that it must have two
 fields depth and time containing vectors. data_array must be a 2 or 3 
 dimensional array length(depth) x length(time) [x length(channels)].

 Other fields which may be used if present in data_struct are:
 
     longitude - vector with same size as time
     latitude  - vector with same size as time
     file      - string (usually containing filename) used in title
     location  - cell array of two strings to label start and end of plot
 
## Author and version   
     Tim Ryan <tim.ryan@csiro.au>
     Gordon Keith <gordon.keith@csiro.au>
     Contributor:  
     Haris Kunnath <haris.kunnath@csiro.au>
     Version: 2.7
     Date: 2020-10-02
