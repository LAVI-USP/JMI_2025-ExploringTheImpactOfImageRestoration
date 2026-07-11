# Exploring the impact of image restoration in simulating higher-dose mammography: effects on the detectability of microcalcifications across different sizes using model observer analysis

This repository contains the MATLAB code accompanying the paper:

> **Exploring the impact of image restoration in simulating higher-dose mammography: effects on the detectability of microcalcifications across different sizes using model observer analysis**, *Journal of Medical Imaging (JMI)*, 2025.

## Overview

This repository contains the MATLAB implementation used in the experiments reported in the above publication. The proposed framework investigates how image restoration can be employed to simulate mammography images acquired at higher radiation dose levels and evaluates its impact on the detectability of microcalcifications using a model observer.

The repository includes the complete processing pipeline used in the study, from image restoration and dose simulation to model observer analysis and generation of the figures presented in the manuscript.

## External software

This work relies on the following external software and open-source implementations:

* **LIBRA (Laboratory for Individualized Breast Radiodensity Assessment)**, developed by the University of Pennsylvania, was used for automated breast density assessment and dense breast tissue segmentation. Available at: https://www.med.upenn.edu/sbia/libra.html

* **BM3D (Block-Matching and 3D Filtering)**, developed by the Department of Signal Processing at Tampere University, was used as one of the image denoising methods evaluated in this study. Available at: https://webpages.tuni.fi/foi/GCF-BM3D/

* **VICTRE Model Observer**, developed by the U.S. Food and Drug Administration (FDA), was used for the detectability analysis. The implementation is available at: https://github.com/DIDSR/VICTRE_MO

These external packages are maintained by their respective authors and are not distributed as part of this repository.

Disclaimer: For educational purposes only.


## Requirements

The code was developed and tested using:

- MATLAB R2025b

The implementation may also work with earlier MATLAB versions, although compatibility is not guaranteed.

---

## Getting started

1. Clone this repository

```bash
git clone https://github.com/LAVI-USP/JMI_2025-ExploringTheImpactOfImageRestoration.git
```

2. Open MATLAB.

3. Add the repository and all subfolders to the MATLAB path.

4. Execute the main script located in the `Scripts` folder.

---

## Data availability

The mammography images used in this study originate from clinical datasets and therefore cannot be publicly distributed.

This repository contains only the source code required to reproduce the methodology. Example data or simulated datasets may be provided whenever possible.

---

## Citation

If you use this code in your research, please cite:

```bibtex
@article{Brandao2025JMI,
  author = {Brandão, Renann de Faria and Soares, Lucas Exposto and Borges, Lucas Rodrigues and Bakic, Predrag R. and Tingberg, Anders and Vieira, Marcelo Andrade da Costa},
  title = {Exploring the impact of image restoration in simulating higher dose mammography: effects on the detectability of microcalcifications across different sizes using model observer analysis},
  journal = {Journal of Medical Imaging},
  volume = {12},
  number = {S2},
  pages = {S22013},
  year = {2025},
  doi = {10.1117/1.JMI.12.S2.S22013}
}
```

---

## License

This project is intended for academic and research purposes.

---

## Contact

Renann F. Brandão  
Laboratory for Advanced Vision and Imaging (LAVI)  
São Carlos School of Engineering (EESC)  
University of São Paulo (USP)


## Acknowledgments:
This work was supported by the São Paulo Research Foundation (FAPESP) (Grant No. #2021/ 12673-6) and by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior—Brasil (CAPES)—Finance Code 001.
