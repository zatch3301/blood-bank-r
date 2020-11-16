# Visualization webapp in R using Shiny <img src="src/logo.png" align="right" width=120 height=139 alt="Shiny"/>

[![CRAN](https://www.r-pkg.org/badges/version/shiny)](https://CRAN.R-project.org/package=shiny)
[![RStudio community](https://img.shields.io/badge/community-leaflet-blue?style=social&logo=rstudio&logoColor=75AADB)](https://community.rstudio.com/new-topic?title=&tags=leaflet&body=%0A%0A%0A%20%20--------%0A%20%20%0A%20%20%3Csup%3EReferred%20here%20by%20%60leaflet%60%27s%20GitHub%3C/sup%3E%0A&u=barret)

### Blood Bank Visualization:
This is a simple shiny app which will make it easier to locate blood banks in India along with pin-code, addresses, website and number with [Leaflet](https://rstudio.github.io/leaflet/) in [Shiny](https://shiny.rstudio.com/).

### Data:
Data for the blood bank application is sourced from [Open Government Data Platform](https://data.gov.in/). The original data is available as a csv file called "Blood Bank Directory (updated Till Last Month)".


### Data limitation:
One of the limitations of this application is that the data is not accurate. The data for few bloood bank are missing and NA values.

Hence i have replace the NA values with blank and taken only those columns which have sufficient data available.

### Help:
In case you observe the data projected on map is incorrect and you have more accurate or additional information that could be updated it will be great if you can email me and i will update the same.

### Thank you ^ ^
