function save_image(varargin)
%save_image(image,file,type)
%must specify an 'image' array
%if no 'file' is specified, will prompt for filename
%if no 'type' is specified, will attempt to ascertain from filename

current_directory=cd;
if nargin<1,
    fprintf(2,'must specify an image array as first argument of save_image()\n');
    return;
end
image=varargin{1};
if nargin >= 3
    file=varargin{2};
    ftype=varargin{3};
elseif nargin == 2
    file=varargin{2};
else
    [file,path,findex]=uiputfile({...
        '*.ppm','PPM (*.ppm)';...
        '*.pgm','PGM (*.pgm)';...
        '*.pbm;*.pgm;*.ppm;*.pnm','PNM (*.pnm)';...
        '*.jpg;*.jpeg','JPEG (*.jpg)';...
        '*.png','PNG (*.png)';...
        '*.bmp','BMP (*.bmp)';...
        '*.tif;*.tiff','TIFF (*.tif)';...
        '*.pcx','PCX (*.pcx)';...
        '*.ras','RAS (*.ras)';...
        '*.xwd','XWD (*.xwd)';...
        '*.*','All files (*.*)'},...
        'Save Image as ...');  
    if isequal(file,0) | isequal(path,0)
        disp('User pressed cancel');
        return;
    end
    cd(path);
end
if nargin >= 3
    imwrite(varargin{:});
else
    imwrite(image,file);
end 
cd(current_directory);