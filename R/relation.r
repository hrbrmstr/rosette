#' Rosette API relationship extraction service
#'
#' Returns each relationship extracted from the input. The response is a list of
#' extracted relationships.
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' ros_relationships("The Ghostbusters movie was filmed in Boston.")
ros_relationships <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/relationships/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
