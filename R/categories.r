#' Rosette API categorizatioin service
#'
#' Returns a category identified in the input. The possible categories are Tier 1
#' contextual categories defined in the QAG Taxonomy The response is the contextual
#' categories identified in the input.
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' txt <- c('Sony Pictures is planning to shoot a good portion of the new "Ghostbusters" in Boston as well.')
#' ros_categories(txt)
ros_categories <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/categories/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
