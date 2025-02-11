% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_apicarto_plu.R
\name{get_apicarto_plu}
\alias{get_apicarto_plu}
\title{Apicarto module Geoportail de l'urbanisme}
\usage{
get_apicarto_plu(x,
                 ressource = "zone-urba",
                 partition = NULL,
                 categorie = NULL)
}
\arguments{
\item{x}{An object of class \code{sf} or \code{sfc}. If NULL, \code{partition} must be filled
by partition of PLU.}

\item{ressource}{A character from this list : "document", "zone-urba",
"secteur-cc", "prescription-surf", "prescription-lin", "prescription-pct",
"info-surf", "info-lin", "info-pct". See detail for more info.}

\item{partition}{A character corresponding to PLU partition (can be retrieve
using \code{get_apicarto_plu(x, "document", partition = NULL)}). If \code{partition}
is explicitly set, all PLU features are returned and \code{geom} is override}

\item{categorie}{public utility easement according to the
national nomenclature ("http://www.geoinformations.developpement-durable.gouv.fr/nomenclature-nationale-des-sup-r1082.html")}
}
\value{
A object of class \code{sf}
}
\description{
Apicarto module Geoportail de l'urbanisme
}
\details{
For the moment the API cannot returned more than 5000 features.

All resssources description :
\itemize{
\item \verb{"municipality} : information on the communes (commune with RNU, merged commune)
\item \verb{"document'} : information on urban planning documents (POS, PLU, PLUi, CC, PSMV)
\item \code{"zone-urba"} : zoning of urban planning documents,
\item \code{"secteur-cc"} : communal map sectors
\item \code{"prescription-surf"} : surface prescriptions like Classified wooded area, Area contributing to the green and blue framework, Landscape element to be protected or created, Protected open space, ...
\item \code{"prescription-lin"} : linear prescription like pedestrian path, bicycle path, hedges or tree lines to be protected, ...
\item \code{"prescription-pct"} : punctual prescription like Building of architectural interest, Building to protect, Remarkable tree, Protected pools, ...
\item \code{"info-surf"} : surface information perimeters of urban planning documents like Protection of drinking water catchments, archaeological sector, noise classification, ...
\item \code{"info-lin"} : linear information perimeters of urban planning documents like Bicycle path to be created, Long hike, Façade and/or roof protected as historical monuments, ...
\item \code{"info-pct"} : punctual information perimeters of urban planning documents like Archaeological heritage, Listed or classified historical monument, Underground cavity, ...
}
}
\examples{
\dontrun{
library(tmap)
library(sf)
point <- st_sfc(st_point(c(-0.4950188466302029, 45.428039987269926)), crs = 4326)

# If you know the partition (all PLU features are returned, geom is override)
partition <- "DU_17345"
poly <- get_apicarto_plu(x = NULL, ressource = "zone-urba", partition = partition)
qtm(poly)+qtm(point, symbols.col = "red", symbols.size = 2)

# If you don't know partition (only intersection between geom and PLU features is returned)
poly <- get_apicarto_plu(x = point, ressource = "zone-urba", partition = NULL)
qtm(poly)+qtm(point, symbols.col = "red", symbols.size = 2)

# If you wanna find partition
document <- get_apicarto_plu(point, ressource = "document", partition = NULL)
partition <- unique(document$partition)

# Get all prescription : /!\ prescription is different than zone-urba
partition <- "DU_17345"
ressources <- c("prescription-surf", "prescription-lin", "prescription-pct")

library(purrr)
all_prescription <- map(.x = ressources,
                        .f = ~ get_apicarto_plu(point, .x, partition))
}

}
