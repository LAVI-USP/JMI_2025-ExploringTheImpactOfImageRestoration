%% This code illustrates the pipeline used in this paper:

%  Published: R.F. Brandão; L. E. Soares; L.R. Borges; P. R. Bakicc; A. Tingberg; M.A.C. Vieira.
%  "Evaluating an image restoration pipeline for digital mammography across varied 
%   radiation exposures and microcalcification sizes using model observer analysis".
%
%  NOTE: This package contains pre-calculated noise parameters from Siemens Mammomat
%  Inspiration on FFDM mode. The parameters may differ from system to system
%  depending on the calibration aspects. For more information regarding
%  noise parameter estimation please refer to the publication mentioned 
%  above.

% THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

% Initial Configuration
close all
imtool close all
clear
clc

% Settings and Parameters
prct = 100;
MCSizes = [390 350 310 270 230 190];
reducFactor = 0.5;
NumberRlz = 3;
addpath('Noise Parameters', 'MCs', 'BM3D_New', 'BM3D_New\bm3d')

% Data Loading
load('Phantom_FD.mat')
load('Parameters_Siemens_FFDM.mat')
load('DenseMask_Libra.mat') %Loads the density and breast masks
% NOTE: The density and breast masks were used to facilitate the automated
% insertion of MCs. The masks were obtained using the open-souce algorithm
% LIBRA, available for download at: 
% https://www.med.upenn.edu/sbia/libra.html

FullBreastMask = res.BreastMask;
DenseMask = res.DenseMask;
SetProfile = BM3DProfile('refilter');

% Results Directory
ImgFolder_final = 'Results';
info_ori = info;
img = Img;
PossiblePoints = logical(DenseMask);

% Main Loop
usedRegions = false(size(DenseMask)); % Initialize a mask to track used regions
for n = 1:NumberRlz
    disp(['Restoring: 100% -> 200%'])
    disp(['Number of realization: ' num2str(n) ' of ' num2str(NumberRlz)])
    for mc = 1:length(MCSizes)
        disp(['Microcalcification size: ' num2str(MCSizes(mc)) 'um'])
        [usedRegions,PossiblePoints]=insertLesion(n, mc, MCSizes(mc), prct, img, info_ori, PossiblePoints, ImgFolder_final, SetProfile, reducFactor, FullBreastMask, Lambda_e, Sigma_E, Tau, usedRegions);
    end
end

% Function to insert lesion
function [usedRegions,PossiblePoints]=insertLesion(n, mc, mcSize, prct, img, info_ori, PossiblePoints, ImgFolder_final, SetProfile, reducFactor, FullBreastMask, Lambda_e, Sigma_E,Tau, usedRegions)
Contrast = 0.08;
newfolder_aux = fullfile(ImgFolder_final, 'MC insert', [num2str(prct) 'prct'], [num2str(mcSize) 'um'], ['rls_' num2str(n)]);
if ~exist(newfolder_aux, 'dir')
    mkdir(newfolder_aux);
    mkdir(fullfile(ImgFolder_final, 'MC insert', [num2str(prct/reducFactor) 'prct'], [num2str(mcSize) 'um'], ['rls_' num2str(n)]));
end

if ~exist(fullfile(ImgFolder_final, 'MC insert', [num2str(prct/reducFactor) 'prct'], [num2str(mcSize) 'um'], ['rls_' num2str(n)]), 'dir')
    mkdir(fullfile(ImgFolder_final, 'MC insert', [num2str(prct/reducFactor) 'prct'], [num2str(mcSize) 'um'], ['rls_' num2str(n)]));
end

% Load lesion mask
load(['MCs\MaskMC_' num2str(mcSize) 'um.mat'])
Mask = MaskMC;
SimulationInfo_Signal{1}.Mask = Mask;

% Select coordinates for the lesion
if mc == 1
    [Coordinates, PossiblePoints, usedRegions] = selectCoordinates(PossiblePoints, usedRegions, Mask);
    SimulationInfo_Signal{1}.Coordinates = Coordinates;
    save(fullfile(newfolder_aux, 'SimulationInfo_Signal.mat'), 'SimulationInfo_Signal');
else
    load(fullfile('Results', 'MC insert', '100prct', '390um', ['rls_' num2str(n)], 'SimulationInfo_Signal.mat'), 'SimulationInfo_Signal');
    SimulationInfo_Signal{1}.Mask = Mask;
end

[ImgL, SimulationInfo_Signal] = LesionInsert(SimulationInfo_Signal, img, Contrast, Tau);
ROI_with_MC = getROI(ImgL, SimulationInfo_Signal{1}.Coordinates, Mask);

% Save image with lesion
saveDicomImage(ImgL, newfolder_aux, ['FullBreast_MC_' num2str(mcSize) 'um.IMA'], info_ori);
saveDicomImage(ROI_with_MC, newfolder_aux, ['ROI_MC_' num2str(mcSize) 'um.IMA'], info_ori);

% Process absence of lesion
[usedRegions,PossiblePoints]=processAbsenceOfLesion(n, mc, mcSize, img, PossiblePoints, newfolder_aux, info_ori, SimulationInfo_Signal, ImgFolder_final, Mask, usedRegions);

% Restoration step
[imgRest, imgDenoised] = restoreImage(ImgL, Lambda_e, reducFactor, Tau, Sigma_E, SetProfile, FullBreastMask);

% Save restored image with lesion
ROI_with_MC_Rest = getROI(imgRest, SimulationInfo_Signal{1}.Coordinates, Mask);
saveDicomImage(imgRest, fullfile(ImgFolder_final, 'MC insert', '200prct', [num2str(mcSize) 'um'], ['rls_' num2str(n)]), ['FullBreast_MC_' num2str(mcSize) 'um.IMA'], info_ori);
saveDicomImage(ROI_with_MC_Rest, fullfile(ImgFolder_final, 'MC insert', '200prct', [num2str(mcSize) 'um'], ['rls_' num2str(n)]), ['ROI_MC_' num2str(mcSize) 'um.IMA'], info_ori);

% Save restored image without lesion
for r = 1:3
    load(fullfile(ImgFolder_final, 'MC insert', '100prct', '390um', ['rls_' num2str(n)], ['SimulationInfo_Absent_' num2str(r) '.mat']), 'SimulationInfo_Absent');
    ROI_without_MC = getROI(imgRest, SimulationInfo_Absent{1}.Coordinates, Mask);
    saveDicomImage(ROI_without_MC, fullfile(ImgFolder_final, 'MC insert', '200prct', [num2str(mcSize) 'um'], ['rls_' num2str(n)]), ['absent_' num2str(r) '.IMA'], info_ori);
end
end

% Function to select coordinates
function [Coordinates, PossiblePoints, usedRegions] = selectCoordinates(PossiblePoints, usedRegions, Mask)
[I, J] = find(PossiblePoints == 1 & ~usedRegions);
Poss = [I J];
if isempty(Poss)
    error('No possible points remaining for lesion insertion.');
end
Point = datasample(1:size(Poss, 1), 1, 'Replace', false);
Coordinates = Poss(Point, :);
usedRegions(Coordinates(1)-20:Coordinates(1)+20,Coordinates(2)-20:Coordinates(2)+20) = true;
PossiblePoints(Coordinates(1)-20:Coordinates(1)+20,Coordinates(2)-20:Coordinates(2)+20) = 0;
end

% Function to get ROI
function ROI = getROI(img, Coordinates, Mask)
ROI = img(Coordinates(1)-ceil(size(Mask, 1)/2):Coordinates(1)+floor(size(Mask, 1)/2)-1, ...
    Coordinates(2)-ceil(size(Mask, 1)/2):Coordinates(2)+floor(size(Mask, 1)/2)-1);
end

% Function to save DICOM image
function saveDicomImage(img, folder, filename, info)
dicomwrite(uint16(img), fullfile(folder, filename), info, 'CreateMode', 'copy');
end

% Function to process absence of lesion
function [usedRegions,PossiblePoints]=processAbsenceOfLesion(n, mc, mcSize, img, PossiblePoints, newfolder_aux, info_ori, SimulationInfo_Signal, ImgFolder_final, Mask, usedRegions)
for r = 1:3
    Mask = zeros(140, 140);
    SimulationInfo_Absent{1}.Mask = Mask;
    
    if mc == 1
        [Coordinates, PossiblePoints, usedRegions] = selectCoordinates(PossiblePoints, usedRegions, Mask);
        SimulationInfo_Absent{1}.Coordinates = Coordinates;
        save(fullfile(newfolder_aux, ['SimulationInfo_Absent_' num2str(r) '.mat']), 'SimulationInfo_Absent');
    else
        load(fullfile('Results', 'MC insert', '100prct', '390um', ['rls_' num2str(n)], ['SimulationInfo_Absent_' num2str(r) '.mat']), 'SimulationInfo_Absent');
        SimulationInfo_Absent{1}.Mask = Mask;
    end
    
    ROI_without_MC = getROI(img, SimulationInfo_Absent{1}.Coordinates, Mask);
    saveDicomImage(ROI_without_MC, newfolder_aux, ['absent_' num2str(r) '.IMA'], info_ori);
    usedRegions(SimulationInfo_Absent{1}.Coordinates(1)-20:SimulationInfo_Absent{1}.Coordinates(1)+20,SimulationInfo_Absent{1}.Coordinates(2)-20:SimulationInfo_Absent{1}.Coordinates(2)+20) = true;
    PossiblePoints(SimulationInfo_Absent{1}.Coordinates(1)-20:SimulationInfo_Absent{1}.Coordinates(1)+20,SimulationInfo_Absent{1}.Coordinates(2)-20:SimulationInfo_Absent{1}.Coordinates(2)+20) = 0;
    
end

end

% Function to restore image
function [imgRest, imgDenoised] = restoreImage(ImgL, Lambda_e, reducFactor, Tau, Sigma_E, SetProfile, FullBreastMask)
Crop_z = ImgL(730:2720, 1350:end);
[imgRest_aux, imgDenoised_aux] = DoseRestoration(Crop_z, Lambda_e(730:2720, 1350:end), reducFactor, Tau, Sigma_E, SetProfile);

imgRest = (ImgL - Tau) ./ reducFactor + Tau;
imgRest(FullBreastMask(:, 1:end)) = imgRest_aux(FullBreastMask(730:2720, 1350:end));

imgDenoised = ImgL;
imgDenoised(FullBreastMask(:, 1:end)) = imgDenoised_aux(FullBreastMask(730:2720, 1350:end));
end
