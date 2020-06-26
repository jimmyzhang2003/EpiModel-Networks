# Assessing the Predictability of Network Models in EpiModel under Varying Degrees of Host Heterogeneity
<img src="https://github.com/jimmyzhang2003/EpiModel_Network_Predictability/blob/master/images/epimodel_network_model.gif" width="400" height="400"/>

## Introduction
With the development of advanced network models to simulate the spread of disease, host heterogeneity, which includes features such as race, sex, and age, has become a significant, yet difficult, concept to implement. In fact, in many disease modeling frameworks, such as EpiModel, host heterogeneity was not traditionally incorporated as a feature and was only implemented relatively recently. Therefore, by using a metric known as predictability, we can shed some light on the utility, reliability, and practical relevance of EpiModel's network models in modeling host heterogeneity.

## Getting Started
### Dependencies
- R v3.6.1 (or higher)
- RStudio
- EpiModel
- mgm
- ggplot2

### Install Packages 
```r
install.packages("EpiModel", dependencies = TRUE)
install.packages("mgm")
install.packages("ggplot2")
```

### About EpiModel
EpiModel is an R package and a disease modeling framework that provides the tools for building a variety of disease models: deterministic compartmental models, stochastic individual contact models, and stochastic network models. Network models in EpiModel exhibit dynamic network behavior, which rely on a discrete time, separable temporal exponential-family random graph model (STERGM) framework, which allows for more realistic and accurate disease simulations.

_Source code and more info available at: [Epimodel.org](http://www.epimodel.org/)

### About Predictability
Nodewise predictability, a metric proposed by Jonas Haslbeck and Lourens Waldorp, demonstrates the extent to which a given node (or individual) can be predicted by all other connected  nodes  in  the  network. Predictability values range from zero to one, where one represents perfect predictability: each node is perfectly explained by all of the nodes connected to it. The tools for calculating predictability are contained in the `mgm` package.


_Documentation available at: [mgm](https://cran.r-project.org/web/packages/mgm/mgm.pdf) 
