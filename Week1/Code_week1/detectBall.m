% Robotics: Estimation and Learning 
% WEEK 1
% 
% Complete this function following the instruction. 
function [probMask, loc] = detectBall(I)
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
% muVal = [153.052431404510,146.599293670198,56.5611246943765];
% sigmaVal = [164.840070843344,117.517004842182,-176.428283403346;...
%     117.517004842182,133.340023954230,-168.192729541039;...
%     -176.428283403346,-168.192729541039,316.961960859602];
muVal = [155.52,147.85,53.594];
sigmaVal = [134.70,102.78,-145.037;...
    102.78,130.81,-164.34;...
    -145.037,-164.34,292.05];
% sigmaVal = diag([180.8987  128.4632  339.5755]);
% mu =  [149.7198  144.5757   60.8763];
% sig = diag([180.8987  128.4632  339.5755]);

thresh = 1E-6;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find ball-color pixels using your model
% 
[numRows,numCols,~] = size(I);
imageMat = double(I);
probMat  = zeros(numRows,numCols);

for iRow = 1:numRows
    for iCol = 1:numCols
        pixOfInt = squeeze(imageMat(iRow,iCol,:))';
        probMat(iRow,iCol) = mvnpdf(pixOfInt,muVal,sigmaVal);
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
figure
imshow(probMask); hold on;

% Plot Figure-----------------------------------------
% figure 
% imshow(probMask); hold on;
% plot(xCent, yCent, '+b','MarkerSize',7);

S = regionprops(Concomp,'Centroid');
loc = S(idx).Centroid;

% [xCent,yCent] = compute_centroid(probMask);
% loc = [xCent,yCent];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute the location of the ball center
%

% segI = 
% loc = 
% 
% Note: In this assigment, the center of the segmented ball area will be considered for grading. 
% (You don't need to consider the whole ball shape if the ball is occluded.)

end
