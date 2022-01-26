[![CC BY 4.0][cc-by-shield]][cc-by]  
# psychoCRFdemo
Illustration of how signal detection theory allows to extract a psychophysical contrast response function (CRF) from the threshold vs contrast (TvC) function.  
Psychophysical contrast response functions are generated from a transducer model and previously fitted parameters, then translated into threshold vs contrast psychophysical functions using signal detection theory. CRFs with and without a constant-contrast overlay mask are compared.

Model, threshold data and fits taken from [Meese, T. S., et al. (2007). "Contextual modulation involves suppression and facilitation from the center and the surround." Journal of Vision 7(4): 21.]. The modulated self-suppression model 3 is used along with data and fits from observer RHS.

<img src="./CRF_SDT_TvC.png" width=100% height=100%>

## Instructions
- See doIt.m for the main script.

## Extra
doIt_crossOrientation.m : Replotting of data and fits to show how cross-oriented overlay masks at different contrasts can either facilitate or suppress contrast perception at threshold.

<img src="./CRF_SDT_TvC.png" width=100% height=100%>

## License
This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by]  
by Sébastien Proulx, sebastien.prouxl2@mail.mcgill.ca, https://orcid.org/0000-0003-1709-3277  
[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
