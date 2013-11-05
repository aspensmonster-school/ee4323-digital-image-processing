function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 03-Nov-2013 16:44:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_selectCurrent.
function pushbutton_selectCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_selectCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = open_image;
axes(handles.axes_current);
imshow(image);
handles.imgcurr=image;
guidata(hObject, handles);



% --- Executes on button press in pushbutton_saveCurrent.
function pushbutton_saveCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_saveCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = handles.imgcurr;
save_image(image);

% --- Executes on button press in pushbutton_makePreviewCurrent.
function pushbutton_makePreviewCurrent_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_makePreviewCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image = handles.imgprev;
axes(handles.axes_current);
imshow(image);
handles.imgcurr=image;
guidata(hObject,handles);

% --- Executes on button press in pushbutton_lowPass.
function pushbutton_lowPass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lowPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_preview);

%selected = get(handles.uipanel_lowPassNeighboorhood,'SelectedObject');
neighboorhood = get(get(handles.uipanel_lowPassNeighboorhood,'SelectedObject'),'UserData');

image = smooth_n(handles.imgcurr,neighboorhood);
imshow(image);
handles.imgprev=image;
%imshow(smooth_n(handles.imgcurr,9));
guidata(hObject, handles);

function [g]=smooth_n(f,n)
[height width]=size(f);
g=f;
for row=1:height
    for col=1:width
        startrow=max(row-n,1);
        endrow=min(row+n,height);
        startcol=max(col-n,1);
        endcol=min(col+n,width);
        g(row,col)=mean(mean(f(startrow:endrow,startcol:endcol)));
    end
end

% --- Executes on button press in pushbutton_highPass.
function pushbutton_highPass_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_highPass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes_preview);
image = ideal_highpass_centered_freq(handles.imgcurr,5.0);
imshow(image);
handles.imgprev=image;
guidata(hObject,handles);

%high-pass filter
function [output]=ideal_highpass_centered_freq(input,radius)
%[output]=ideal_highpass_centered_frequency(input,radius)
%input and output are fourier frequency components which have been centered for display
height=size(input,1);
width=size(input,2);
distance=distance_from_center(height,width);

filter=distance >= radius;
output=input.*filter;

%dist. from center
function [distance]=distance_from_center(max_rows,max_columns)
%[distance]=distance_from_center(max_rows,max_columns)
%creates a 2-dimensional array of size max_rows by max_columns 
%whose elements are the euclidean distances from the center coordinates.
distance=zeros(max_rows,max_columns);
center_row=fix(max_rows/2+.5);
center_column=fix(max_columns/2+.5);

for row=1:max_rows
   for column=1:max_columns
      distance(row,column)=sqrt((row-center_row).^2+(column-center_column).^2);
   end
end

function edit_boostCoeff_Callback(hObject, eventdata, handles)
% hObject    handle to edit_boostCoeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_boostCoeff as text
%        str2double(get(hObject,'String')) returns contents of edit_boostCoeff as a double


% --- Executes during object creation, after setting all properties.
function edit_boostCoeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_boostCoeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_highBoost.
function pushbutton_highBoost_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_highBoost (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_preview);
image = handles.imgcurr;
image = imfilter(imsubtract(image,25),[-1 -1 -1;-1 8 -1;-1 -1 -1]);
imshow(image);
handles.imgprev = image;
guidata(hObject,handles);

% --- Executes on button press in pushbutton_histogram.
function pushbutton_histogram_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes_preview);
image = histequalize(handles.imgcurr);
imshow(image);
handles.imgprev=image;
guidata(hObject,handles);

% Shit below ain't workin' ; gotta adjust it for color images.
% Protip: It _does_ work for grayscale images.

function [g]=histequalize(f)
h=histogram(f);
[height,width]=size(f);
newcolors=zeros(1,256);
for k=1:256
    for j=1:k
        newcolors(k)=newcolors(k)+h(j);
    end
end
newcolors=255*newcolors/(height*width);
newcolors=uint8(newcolors);
g=zeros(height,width);
for r=1:height
    for c=1:width
        oldcolor=double(f(r,c));
        g(r,c)=newcolors(oldcolor+1);
    end
end
g=uint8(g);

function [h]=histogram(f);
 [xmax,ymax]=size(f);
 h=zeros(1,256);
 for x=1:xmax
    for y=1:ymax
        color=double(f(x,y));
        h(color+1)=h(color+1)+1;
    end;
 end;

function edit_brightness_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_brightness_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_brightness_step as text
%        str2double(get(hObject,'String')) returns contents of edit_brightness_step as a double


% --- Executes during object creation, after setting all properties.
function edit_brightness_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_brightness_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to slider_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_brightness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_brightness_percent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_brightness_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_brightness_percent as text
%        str2double(get(hObject,'String')) returns contents of edit_brightness_percent as a double
axes(handles.axes_preview);
image = handles.imgcurr;

percent = get(handles.edit_brightness_percent,'String');
percent = str2double(percent);
percent = percent/100;

if(percent >= 0)
    image2 = imadjust(image,[0 1],[percent 1]);
else
    percent = percent*(-1);
    image2 = imadjust(image,[0,1],[0 (1-percent)]);
end
imshow(image2);
handles.imgprev=image2;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_brightness_percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_brightness_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_contrast_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_contrast_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_contrast_step as text
%        str2double(get(hObject,'String')) returns contents of edit_contrast_step as a double


% --- Executes during object creation, after setting all properties.
function edit_contrast_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_contrast_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to slider_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_contrast_percent_Callback(hObject, eventdata, handles)
% hObject    handle to edit_contrast_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_contrast_percent as text
%        str2double(get(hObject,'String')) returns contents of edit_contrast_percent as a double
axes(handles.axes_preview);
image = handles.imgcurr;

percent = get(handles.edit_contrast_percent,'String');
percent = str2double(percent);
percent = percent/100;

if(percent >= 0)
    image2 = imadjust(image,[0 (1-percent)],[0 1]);
else
    percent = percent*(-1);
    image2 = imadjust(image,[percent 1],[0 1]);
end
imshow(image2);
handles.imgprev=image2;
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit_contrast_percent_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_contrast_percent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
