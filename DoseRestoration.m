%% This function restores digital mammography RAW images
%
%  Published: Brandao, Renann F. et al. Exploring the impact of image restoration in
%  simulating higher dose mammography: effects on the detectability of microcalcifications
%  across different sizes using model observer analysis". Journal of
%  Medical Imaging, (2025), adapted from Borges, Lucas R., et al.
%  "Restoration of low-dose digital breast tomosynthesis." Measurement Science
%  and Technology 29.6 (2018): 064003.
%
%  Inputs:    Z - Original image with standard dose
%             xi_q - Gain of the quantum noise
%             Beta - Gain target for restoration (e.g. of input 100%, the final restored image simulates 200%)
%             Tau - Detector offset 
%             xi_e - Standard deviation of the electronic noise 
%
%  THIS WORK SHOULD ONLY BE USED FOR NON-PROFIT PURPOSES!

function [imgRest , D] = DoseRestoration(Z, xi_q, Beta, Tau, xi_e,bm3dProfile)

%% Generalized Anscombe transformation (GAT)
fz = 2./xi_q.*sqrt(max(0,xi_q.*(Z-Tau) + (3/8).*xi_q.^2 + xi_e^2));


%% Denoising
% Normalization
m=min(fz(:));
M=max(fz(:));
fz_norm=(fz-m)/(M-m);

% Denoising step
[D_GAT] = BM3D(fz_norm, 1/(M-m),bm3dProfile);
D_GAT = D_GAT.*(M-m) + m;

%% Inverse GAT

D = GenAnscombe_inverse_closed_form(D_GAT,xi_e,xi_q,0);

rho1 = sqrt((Beta*xi_q.*D + xi_e^2)./(xi_q.*D + xi_e^2));
rho2 = Beta - rho1;

%% Weighted sum of reduced img and denoised img
imgRest = rho1.*(Z - Tau) + rho2.*D + Tau;


end
