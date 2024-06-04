# Restoration assessment with Model Observer

It contains the codes for the paper "Evaluating an image restoration pipeline for digital mammography across varied radiation exposures and microcalcification sizes using model observer analysis", submitted to the IWBI 2024 conference. 
We used The Laboratory for Individualized Breast Radiodensity Assessment ([LIBRA](https://www.med.upenn.edu/sbia/libra.html)), a software package developed by the University of Pennsylvania. 
We also used the Block-matching and 3D filtering ([BM3D](https://webpages.tuni.fi/foi/GCF-BM3D/)) algorithm, a software package developed by the Tampere University of Technology, Department of Signal Processing. The Model Observer used in this work is available in this ([GitHub directory](https://github.com/DIDSR/VICTRE_MO))

Disclaimer: For education purposes only.

## Abstract:
In this study, we assess the impact of an image restoration pipeline, designed for digital mammography, on the detectability of microcalcifications of different sizes across varied radiation exposures. The restoration pipeline first removes the noise of the image considering a Poisson-Gaussian noise model that incorporates quantum and electronic noise. Then, it appropriately merges the noisy and denoised images to achieve a signalto- noise ratio (SNR) comparable to an image obtained at a higher radiation dose. We created a database of mammographic images acquired at radiation doses between 50% and 200% of the automatic exposure control (AEC) using a physical anthropomorphic breast phantom. Clustered microcalcifications with diameters ranging from 190𝜇m to 390𝜇m were artificially inserted into the phantom images in regions with increased density. The Channelized Hotelling Observer (CHO) was employed as the model observer (MO) to evaluate the detectability of microcalcifications. A pilot study was conducted to adjust the percentage of correct detection to approximately 75% for microcalcifications with a diameter of 270 𝜇m at the AEC dose. We applied the restoration pipeline to the image dataset and calculated the percentage of correctly detected signals (PC) using the MO in a four-alternative forced choice (4-AFC) study. The results indicated a PC enhancement of up to 10% when applying restoration to simulate acquisitions with twice the AEC dose. Additionally, for images acquired with radiation doses below the AEC, our results demonstrated a potential dose reduction of up to 22.4% without compromising microcalcification detectability. The detection of microcalcifications with a diameter of 390 𝜇m remained unaffected by variations in radiation dose.

## Reference:

If you use the codes, we will be very grateful if you refer to this [paper](https://doi.org/10.1117/12.3026930).

BRANDÃO, Renann F. et al. "Evaluating an image restoration pipeline for digital mammography across varied radiation exposures and microcalcification sizes using model observer analysis." In: 17th International Workshop on Breast Imaging (IWBI 2024). SPIE, 2024. p. 246. [https://doi.org/10.1117/12.3026930](https://doi.org/10.1117/12.3026930)

```
@inproceedings{brandao2024evaluating,
  title={Evaluating an image restoration pipeline for digital mammography across varied radiation exposures and microcalcification sizes using model observer analysis},
  author={Brand{\~a}o, Renann F and Soares, Lucas E and Borges, Lucas R and Bakic, Predrag R and Tingberg, Anders and Vieira, Marcelo AC},
  booktitle={17th International Workshop on Breast Imaging (IWBI 2024)},
  volume={13174},
  pages={246},
  year={2024},
  organization={SPIE}
}
```

## Acknowledgments:
This work was supported by the São Paulo Research Foundation (FAPESP) grant #2021/12673-6 and by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior - Brasil (CAPES) - Finance Code 001.
