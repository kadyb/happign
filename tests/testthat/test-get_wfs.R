test_that("hit_api_wfs format bbox from sf object", {

   shape_sf <- read_sf(system.file("shape/nc.shp", package = "sf"))
   expect_s3_class(shape_sf, "sf")
   expect_equal(dim(shape_sf), c(100, 15))

   bbox <- st_bbox(st_transform(shape_sf, 4326))
   expect_s3_class(bbox, "bbox")
   expect_length(bbox, 4)

   formated_bbox <- paste(bbox["xmin"], bbox["ymin"], bbox["xmax"], bbox["ymax"],
                          "epsg:4326",
                          sep = ",")
   expect_type(formated_bbox, "character")
   expect_length(formated_bbox, 1)
   expect_equal(length(gregexpr(",",formated_bbox, fixed = TRUE)[[1]]), 4)

})
test_that("hit_api_wfs format bbox from sfc object", {

   shape_sfc <- st_as_sfc(read_sf(system.file("shape/nc.shp", package = "sf")))
   expect_s3_class(shape_sfc, "sfc")
   expect_equal(length(shape_sfc), 100)

   bbox <- st_bbox(st_transform(shape_sfc, 4326))
   expect_s3_class(bbox, "bbox")
   expect_length(bbox, 4)

   formated_bbox <- paste(bbox["xmin"], bbox["ymin"], bbox["xmax"], bbox["ymax"],
                          "epsg:4326",
                          sep = ",")
   expect_type(formated_bbox, "character")
   expect_length(formated_bbox, 1)
   expect_equal(length(gregexpr(",",formated_bbox, fixed = TRUE)[[1]]), 4)

})
test_that("hit_api_wfs build request properly", {

   params <- list(
      service = "WFS",
      version = "2.0.0",
      request = "GetFeature",
      outputFormat = "json",
      srsName = "EPSG:4326",
      typeName = "layer_name",
      bbox = "formated_bbox",
      startindex = "startindex",
      count = 1000
   )

   apikey <- "VERIF"

   request <- request("https://wxs.ign.fr") %>%
      req_url_path_append(apikey) %>%
      req_url_path_append("geoportail/wfs") %>%
      req_user_agent("happign (https://paul-carteron.github.io/happign/)") %>%
      req_url_query(!!!params)

   expect_s3_class(request, "httr2_request")
   expect_equal(nchar(request$url), 194)
   expect_match(request$url, "VERIF")

})
test_that("hit_api_wfs error", {
   shape_sf <- read_sf(system.file("shape/nc.shp", package = "sf"))
   layer_name <- "no_need"

   expect_error(hit_api_wfs("a"))
   expect_error(hit_api_wfs())
   expect_error(hit_api_wfs(shape, layer_name,  1000)) # Don't forget the apikey !
   expect_error(hit_api_wfs("parcellaire", shape, layer_name,  1000)) # Forbidden
})
with_mock_dir("hit_api_wfs perform request", {
   #/!\ Again, you have to manually change encoding "UTF-8" to "ISO-8859-1" !
   test_that("hit_api_wfs perform request", {
      shape <- st_polygon(list(matrix(c(-4.373, -4.373, -4.372, -4.372, -4.373, 47.798,
                                            47.799, 47.799, 47.798, 47.798), ncol = 2)))
      shape <- st_sfc(shape, crs = st_crs(4326))

      apikey <- "parcellaire"
      layer_name <- "CADASTRALPARCELS.PARCELLAIRE_EXPRESS:parcelle"

      resp <- hit_api_wfs(shape, apikey, layer_name, startindex = 0)
      expect_s3_class(resp, "sf")
   })
}, simplify = FALSE)
with_mock_dir("get_wfs simple request", {
   #/!\ Again, you have to manually change encoding "UTF-8" to "ISO-8859-1" !
   test_that("get_wfs", {
      skip_on_cran()
      skip_if_offline()
      shape <- st_polygon(list(matrix(c(-4.373, -4.373, -4.372, -4.372, -4.373, 47.798,
                                        47.799, 47.799, 47.798, 47.798), ncol = 2)))
      shape <- st_sfc(shape, crs = st_crs(4326))
      apikey <- "cartovecto"
      layer_name <- "BDCARTO_BDD_WLD_WGS84G:troncon_route"

      filename <- file.path(tempdir(), "troncon_route.shp")

      layer <- get_wfs(shape = shape,
                       apikey = apikey,
                       layer_name = layer_name,
                       file = filename)

      expect_s3_class(layer, "sf")
      expect_match(list.files(tempdir()), "troncon_route", fixed = TRUE, all = FALSE)

   })
}, simplify = FALSE)
