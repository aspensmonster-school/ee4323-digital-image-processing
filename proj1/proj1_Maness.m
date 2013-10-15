% EE4323 - Digital Image Processing - Dr. Stapleton
% Project One - Basic Image Manipulation with MATLAB
% Author: Preston Maness

% The goal of this project is mainly to introduce the student to the MATLAB 
% scripting workflow. Usage of figure, imread, imwrite, imshow, and other 
% miscellaneous MATLAB tools is introduced in the process of performing basic 
% manipulations on monochrome and color bitmaps.

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                       %%
%%      Variables        %%
%%                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize all of the variables that will be used. See main part of program 
% for what each image should ultimately look like.

% Gradient image matrices
image1 = uint8(zeros(256,256));
image2 = uint8(zeros(256,256));
image3 = uint8(zeros(256,256));
image4 = uint8(zeros(256,256));
image5 = uint8(zeros(512,512));

% Monochrome Lena matrices
image6 = uint8(zeros(256,256));
image7 = uint8(zeros(512,512));

% Color gamut matrix
image11 = uint8(zeros(256,256,3));

% Color Lena matrices
image13 = uint8(zeros(256,256,3));
image14 = uint8(zeros(512,512,3));

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                       %%
%%      Main Program     %%
%%                       %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Gradient Manipulations %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% image1 - should be a solid block of medium grey

image1 = uint8(ones(256,256)*140);

figure;
imshow(image1);

%% image2 - should be a black to white gradient from top to bottom

for i=1:256,
  for j=1:256,
    image2(i,j) = i-1;
  end
end

figure;
imshow(image2);

%% image3 - should be a black to white gradient from left to right

for i=1:256,
  for j=1:256,
    image3(i,j) = j-1;
  end
end

figure;
imshow(image3);

%% image4 - should be a black to white gradient from top left to bottom right

for i=1:256,
  for j=1:256,
    %We can use floor since this should always be positive
    image4(i,j) = floor((((i-1)+(j-1))/2));
  end
end

figure;
imshow(image4);

%% image5 - should be a black to white gradient from outside in

% Top Left Quadrant; original image
for i=1:256,
  for j=1:256,
    image5(i,j)=image4(i,j);
  end
end

% Bottom Left Quadrant; reverse rows
for i=257:512,
  for j=1:256,
    image5(i,j)=image4(256-(i-257),j);
  end
end

% Top Right Quadrant; reverse columns
for i=1:256,
  for j=257:512,
    image5(i,j)=image4(i,256-(j-257));
  end
end

% Bottom Right Quadrant; reverse both
for i=257:512,
  for j=257:512,
    image5(i,j)=image4(256-(i-257),256-(j-257));
  end
end

% Display final image
figure;
imshow(image5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Monochrome Lena Manipulations %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% image6 - should be read from lena.pgm input file found in path of this 
%% script

image6=imread('lena.pgm');

figure;
imshow(image6);

%% image7 - should be lena in four different quadrants with different 
%% reflections in each quadrant. Same as with the gradient example image5

% Top Left Quadrant; original image
for i=1:256,
  for j=1:256,
    image7(i,j)=image6(i,j);
  end
end

% Bottom Left Quadrant; reverse rows
for i=257:512,
  for j=1:256,
    image7(i,j)=image6(256-(i-257),j);
  end
end

% Top Right Quadrant; reverse columns
for i=1:256,
  for j=257:512,
    image7(i,j)=image6(i,256-(j-257));
  end
end

% Bottom Right Quadrant; reverse both
for i=257:512,
  for j=257:512,
    image7(i,j)=image6(256-(i-257),256-(j-257));
  end
end

% Display final image
figure;
imshow(image7);

%%%%%%%%%%%%%%%%%%%%%
%% Writes to Files %%
%%%%%%%%%%%%%%%%%%%%%

% Write image4 to a JPG file
imwrite(image4,'homework1_4.jpg');

% Write image5 to a GIF file
imwrite(image5,'homework1_5.gif');

% Write image7 to a PGM file
imwrite(image7, 'homework1_7.pgm');

%%%%%%%%%%%%%%%%%
%% Color Gamut %%
%%%%%%%%%%%%%%%%%

%% image11 - A color gamut built from image2, image3, and image4

% Plane 1 - Red plane via image2
for i=1:256,
  for j=1:256,
    image11(i,j,1) = image2(i,j);
  end
end

% Plane 2 - Green plane via image3
for i=1:256,
  for j=1:256,
    image11(i,j,2) = image3(i,j);
  end
end

% Plane 3 - Blue plane via image4
for i=1:256,
  for j=1:256,
    image11(i,j,3) = image4(i,j);
  end
end

figure;
imshow(image11);
imwrite(image11,'homework1_11.ppm');

%%%%%%%%%%%%%%%%
%% Color Lena %%
%%%%%%%%%%%%%%%%

%% image13 - import lena_color.jpg
image13=imread('lena_color.jpg');

figure;
imshow(image13)

%% image14 - Lena in different quadrants with different mirrors

% Top Left Quadrant; original image
for i=1:256,
  for j=1:256,
    for k=1:3,
      image14(i,j,k)=image13(i,j,k);
    end
  end
end

% Bottom Left Quadrant; reverse rows
for i=257:512,
  for j=1:256,
    for k=1:3,
      image14(i,j,k)=image13(256-(i-257),j,k);
    end
  end
end

% Top Right Quadrant; reverse columns
for i=1:256,
  for j=257:512,
    for k=1:3,
      image14(i,j,k)=image13(i,256-(j-257),k);
    end
  end
end

% Bottom Right Quadrant; reverse both
for i=257:512,
  for j=257:512,
    for k=1:3,
      image14(i,j,k)=image13(256-(i-257),256-(j-257),k);
    end
  end
end

% display and write to file
figure;
imshow(image14);
imwrite(image14,'homework1_14.pnm');

%%%%%%%%%%%%%%%%%%%
%%  Wrapping Up  %%
%%%%%%%%%%%%%%%%%%%

% This stores the user-inputted string into str. We don't actually use it. 
% It's just there to pause the program prior to closing all the figure 
% windows.
str = input('Press any key to continue','s');

% Close all of the opened figure windows
close all
