%% InsertMC 
% This is an agorithm to insert microcalcificaition clusters into Digital
% Mammograms. The details are described in the article:

%[1] 'A 2-AFC study to validate artificially inserted microcalcification 
% clusters in digital mammography'SPIE Medical Imaging, 2019.

function [ImgL,SimulationInfo] = LesionInsert(SimulationInfo,img,Contrast,Tau)

Mask = SimulationInfo{1, 1}.Mask;
Coordinates = SimulationInfo{1}.Coordinates;
for cc=1:length(Contrast) % This loop will insert the exact same cluster at the exact same location at different contrasts
    ImgL(:,:,cc)=double(img);
    disp(['Processing lesion contrast ' num2str(cc) ' from ' num2str(length(Contrast))]);
    
    %%
    MaskN=Mask;
    MaskN(Mask~=0)=MaskN(MaskN~=0)*(Contrast(cc));
    MaskN=abs(MaskN-1);

    ImgL(Coordinates(1)-ceil(size(Mask,1)/2):Coordinates(1)+floor(size(Mask,1)/2)-1,Coordinates(2)-ceil(size(Mask,1)/2):Coordinates(2)+floor(size(Mask,1)/2)-1,cc)=(img(Coordinates(1)-ceil(size(Mask,1)/2):Coordinates(1)+floor(size(Mask,1)/2)-1,Coordinates(2)-ceil(size(Mask,1)/2):Coordinates(2)+floor(size(Mask,1)/2)-1)-Tau).*MaskN + Tau;

end

end

