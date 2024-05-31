%% This function restores digital mammography RAW images
%
%  Published: Borges, Lucas R., et al. "Restoration of low-dose digital breast tomosynthesis."
%  Measurement Science and Technology 29.6 (2018): 064003.
%
%  Inputs:    img - Original image with standard dose (RAW DBT projection or RAW FFDM)
%             Lambda - Gain of the quantum noise
%             reducFactor - Reduction rate (e.g. 0.5 for 50% dose reduction)
%             Tau - Detector offset (e.g. ~50 for Hologic DBT systems)
%             Sigma_E - Standard deviation of the electronic noise (e.g. ~3 for Hologic systems)
%
%  THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

function [imgRest , imgDenoised] = DoseRestoration(img, Lambda, reducFactor, Tau, Sigma_E,bm3dProfile)

%% Generalized Anscombe transformation (GAT)
fz = 2./Lambda.*sqrt(max(0,Lambda.*(img-Tau) + (3/8).*Lambda.^2 + Sigma_E^2));


%% Denoising
% Normalization
m=min(fz(:));
M=max(fz(:));
fz_norm=(fz-m)/(M-m);

% Denoising step
[D] = BM3D(fz_norm, 1/(M-m),bm3dProfile);
D = D.*(M-m) + m;

%% Inverse GAT

yhat_cfa = GenAnscombe_inverse_closed_form(D,Sigma_E,Lambda,0);

imgRest = (yhat_cfa) + Tau;

imgDenoised = imgRest;

%% Weighted sum of reduced img and denoised img

yhat=(imgRest-Tau)./reducFactor;

omega1 = sqrt((Lambda.*yhat+Sigma_E^2)./(reducFactor*Lambda.*yhat+Sigma_E^2));
omega2 = (1/reducFactor)-omega1;

imgRest = omega1.*(img - Tau) + omega2.*(imgRest-Tau) + Tau;

end