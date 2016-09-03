% Robotics: Estimation and Learning 
% WEEK 3
% 
% This is an example code for collecting object sample colors using roipoly
function [muVal,sigmaVal,sampleImage] = characterize_features(fileStr)

close all
dirPath  = uigetdir('Select directory to characterize.');
%fileList = recursive_file_listing(dirPath, '*.png', false);
fileList = recursive_file_listing(dirPath, fileStr, false);

numFiles = size(fileList,1);
sampleImage = [];

for fileNum = 1:numFiles
    fileName = fileList{fileNum};
    
    % Load image
    imageMat = imread(fileName);
    
    % You may consider other color space than RGB
    R = imageMat(:,:,1);
    G = imageMat(:,:,2);
    B = imageMat(:,:,3);
    
    % Collect samples 
    disp('');
    disp('INTRUCTION: Click along the boundary of the ball. Double-click when you get back to the initial point.')
    disp('INTRUCTION: You can maximize the window size of the figure for precise clicks.')
    figure(1), 
    mask = roipoly(imageMat); 
    figure(2), imshow(mask); title('Mask');
    sample_ind = find(mask > 0);
    
    R = R(sample_ind);
    G = G(sample_ind);
    B = B(sample_ind);
    
    sampleImage = [sampleImage; [R G B]];
    
    disp('INTRUCTION: Press any key to continue. (Ctrl+c to exit)')
    pause
end

% visualize the sample distribution
figure;
scatter3(sampleImage(:,1),sampleImage(:,2),sampleImage(:,3),'.');
title('Pixel Color Distribubtion');
xlabel('Red');
ylabel('Green');
zlabel('Blue');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [IMPORTANT]
%
% Now choose you model type and estimate the parameters (mu and Sigma) from
% the sample data.
%

muVal = mean(sampleImage,1);
sigmaVal = cov(double(sampleImage));

