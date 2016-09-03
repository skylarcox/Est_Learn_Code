% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [probMask, loc] = detect_feature(I,matToLoad)
%[probMask, loc] = detectBall_new(I, matToLoad, thresh)
% function [segI, loc] = detectBall(I)
%
% INPUT
% I       120x160x3 numerial array 
%
% OUTPUT
% segI    120x160 numeric array
% loc     1x2 or 2x1 numeric array 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hard code your learned model parameters here
%
% mu = 
% sig = 
% thre = 

% [file,path] = uigetfile('*.mat','Select *.mat file to load which contains mu and sigma.');
% matToLoad   = fullfile(path,file);
load(matToLoad)
%thresh = 0.000001;
% if strcmpi(thresh,'default')
%     thresh = 5E-6;
% end
thresh = 5E-6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
[numRows,numCols,~] = size(I);
imageMat = double(I);
probMat  = zeros(numRows,numCols);

for iRow = 1:numRows
    for iCol = 1:numCols
        pixOfInt = squeeze(imageMat(iRow,iCol,:))';
        probVal = mvnpdf(pixOfInt,muVal,sigmaVal);
        probMat(iRow,iCol) = probVal; %mvnpdf(pixOfInt,mu,sigma);
    end
end

probMask = zeros(size(probMat));
probMask(probMat>thresh) = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Do more processing to segment out the right cluster of pixels.
% You may use the following functions.
%   bwconncomp
%   regionprops
% Please see example_bw.m if you need an example code.
Concomp = bwconncomp(probMask);
numPixels = cellfun(@numel,Concomp.PixelIdxList);
[~,idx] = max(numPixels);
probMask(Concomp.PixelIdxList{idx}) = true; 

S = regionprops(Concomp,'Centroid');
loc = S(idx).Centroid;


figure 
imshow(probMask); hold on;
plot(loc(1), loc(2), '+b','MarkerSize',7);
end
%
% figure 
% imshow(probMask); hold on;
% plot(xCent,yCent,'r.','MarkerSize',5)
% plot(xCent,yCent,'r+','MarkerSize',12)