% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_apicarto_cadastre.R
\name{get_apicarto_cadastre}
\alias{get_apicarto_cadastre}
\alias{get_apicarto_cadastre.sf}
\alias{get_apicarto_cadastre.sfc}
\alias{get_apicarto_cadastre.character}
\title{Apicarto Cadastre}
\usage{
\method{get_apicarto_cadastre}{sf}(
  x,
  section = NULL,
  numero = NULL,
  code_abs = NULL,
  source_ign = "PCI"
)

\method{get_apicarto_cadastre}{sfc}(
  x,
  section = NULL,
  numero = NULL,
  code_abs = NULL,
  source_ign = "PCI"
)

\method{get_apicarto_cadastre}{character}(
  x,
  section = NULL,
  numero = NULL,
  code_abs = NULL,
  source_ign = "PCI"
)
}
\arguments{
\item{x}{It can be a shape or multiple insee code :
\itemize{
\item Shape : all the cadastral parcels contained in it are downloaded. It should
be an object of class \code{sf} or \code{sfc}.
\item Code insee : filter the response on the INSEE code entered (must be a
\code{character} or a vector of \code{character})
}}

\item{section}{A \code{character} or a vector of \code{character} to filter the
response on the cadastral section code entered (on 2 characters)}

\item{numero}{A \code{character} or a vector of \code{character} to filter the answers
on the entered parcel number (on 4 characters)}

\item{code_abs}{A \code{character} or a vector of \code{character} to filter the
answers on the code of absorbed commune. This prefix is useful to
differentiate between communes that have merged}

\item{source_ign}{Can be "BDP" for BD Parcellaire or "PCI" for Parcellaire
express. The BD Parcellaire is a discontinued product. Its use is no longer
recommended because it is no longer updated. The use of PCI Express is
strongly recommended and will become mandatory. More information on the
comparison of this two products can be found
\href{https://geoservices.ign.fr/sites/default/files/2021-07/Comparatif_PEPCI_BDPARCELLAIRE.pdf}{here}}
}
\value{
\code{get_apicarto_cadastre}return an object of class \code{sf}
}
\description{
Implementation of the cadastre module of the
\href{https://apicarto.ign.fr/api/doc/cadastre}{IGN's apicarto}
}
\details{
#' @usage
get_apicarto_cadastre(x,
section = NULL,
numero = NULL,
code_abs = NULL,
source_ign = "PCI")
}
\examples{
\dontrun{
library(sf)
library(tmap)

# line from the best town in France
line <- st_linestring(matrix(c(-4.372215, -4.365177, 47.803943, 47.79772),
                             ncol = 2))
line <- st_sfc(line, crs = st_crs(4326))

PCI_shape <- get_apicarto_cadastre(shape, section = c("AX", "AV"))
BDP_Code <- get_apicarto_cadastre("29158", section = c("AX", "BR"),
                                  source_ign = "BDP")

tm_shape(PCI_shape)+
   tm_borders()+
tm_shape(line)+
   tm_lines(col = "red")

tm_shape(BDP_Code)+
   tm_polygons(col = "section", border.col = "black")

}
}
