# Exploring the impact of image restoration in simulating higher dose mammography: effects on the detectability of microcalcifications across different sizes using model observer analysis

It contains the codes for the paper "Exploring the impact of image restoration in simulating higher dose mammography: effects on the detectability of microcalcifications across different sizes using model observer analysis", submitted to the Journal of Medical Imaging (JMI). 
We used The Laboratory for Individualized Breast Radiodensity Assessment ([LIBRA](https://www.med.upenn.edu/sbia/libra.html)), a software package developed by the University of Pennsylvania. 
We also used the Block-matching and 3D filtering ([BM3D](https://webpages.tuni.fi/foi/GCF-BM3D/)) algorithm, a software package developed by the Tampere University of Technology, Department of Signal Processing. The Model Observer used in this work is available in this [GitHub Repository](https://github.com/DIDSR/VICTRE_MO)

Disclaimer: For education purposes only.

## Abstract:
**Purpose:** Breast cancer is one of the leading causes of cancer-related deaths among women, and digital mammography plays a key role in screening and early detection. The radiation dose on mammographic exams directly influences image quality and radiologists’ performance. We evaluate the impact of an image restoration pipeline, designed to simulate higher dose acquisitions, on the detectability of microcalcifications of various sizes in mammograms acquired at different radiation doses.

**Approach:** The restoration pipeline denoises the image using a Poisson–Gaussian noise model, combining it with the noisy image to achieve a signal-to-noise ratio comparable with an acquisition at twice the original dose. We created a database of images using a physical breast phantom at doses ranging from 50% to 200% of the standard dose. Clustered microcalcifications were computationally inserted into the phantom images. The channelized Hotelling observer was employed in a fouralternative forced-choice to evaluate the detectability of microcalcifications across different sizes and exposure levels.

**Results:** The restoration of low-dose images acquired at ∼75% of the standard dose resulted in detectability levels comparable with those of images acquired at the standard dose. Moreover, images restored at the standard dose demonstrated detectability similar to those acquired at 160% of the nominal radiation dose, with no statistically significant differences.

**Conclusions:** We demonstrate the potential of an image restoration pipeline to simulate higher quality mammography images. The results indicate that reducing noise through denoising and restoration impacts the detectability of microcalcifications. This method improves image quality without hardware modifications or additional radiation exposure.

## Reference:



## Acknowledgments:
This work was supported by the São Paulo Research Foundation (FAPESP) (Grant No. #2021/ 12673-6) and by the Coordenação de Aperfeiçoamento de Pessoal de Nível Superior—Brasil (CAPES)—Finance Code 001.
