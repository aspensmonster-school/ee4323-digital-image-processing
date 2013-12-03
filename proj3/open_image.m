% This function provided by Dr. Stapleton. Provides an open image dialog 
% to the user to specify the path to a file and converts that file into a 
% an appropriate matrix for use.

function [varargout]=open_image(varargin)
%[picture]=open_image(file)

current_directory=cd;

% user didn't provide path. Use MATLAB's uigetfile to grab the file.
if nargin<1,
    [file,path]=uigetfile({...
        '*.jpg;*.jpeg;*.bmp;*.gif;*.tif;*.tiff;*.png;*.pbm;*.pgm;*.ppm;*.pnm;*.pcx;*.ras;*.xwd;*.cur;*.ico','All Image Types';...
        '*.jpg;*.jpeg','JPEG (*.jpg, *.jpeg)';...
        '*.bmp','BMP (*.bmp)';...
        '*.gif','GIF (*.gif)';...
        '*.tif;*.tiff','TIFF (*.tif, *.tiff)';...
        '*.png','PNG (*.png)';...
        '*.pbm;*.pgm;*.ppm;*.pnm','PNM (*.pbm, *.pgm, *.ppm, *.pnm)';...
        '*.pcx','PCX (*.pcx)';...
        '*.ras','RAS (*.ras)';...
        '*.xwd','XWD (*.xwd)';...
        '*.cur;*.ico','Cursors and Icons (*.cur, *.ico)';...
        '*.*','All files (*.*)'});  

    % If user is manually entering a path within the dialog (why would they
    % do that?), then we're going to... die if they mess up? Why would WE do 
    % THAT?
    if isequal(file,0)||isequal(path,0)
       disp('File not found');
       picture=[];
       return
    end

    % um. Not sure here. As long as path is defined, go to it?
    if strcmp(current_directory,path) == 0 && ~isequal(path,0)
        cd(path);
    end

% user specified path to image file
else
    file=varargin{1};
end

% call MATLAB's imread to put image into a default matlab variable.
varargout{1}=imread(file);

% Put the binary file into a matrix? Or the filename into a string? Or what?
if nargout > 1
    varargout{2}=file;
end

% Put the binary file's path into a matrix? Or string? Who knows.
if nargout > 2
    varargout{3}=path;
end

cd(current_directory);
