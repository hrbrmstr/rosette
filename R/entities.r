#' Rosette API entity extraction service
#'
#' Returns each entity extracted from the input. The response is a list of extracted
#' entities. Each entity includes an entityId (Wikidata QID or temporary ID), mention
#' (entity text in the input), normalized text (complete form of the entity in the input),
#' and the count (number of mentions of entity in the input).
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' txt <- c("Bill Murray will appear in new Ghostbusters film: Dr. Peter Venkman was ",
#'          "spotted filming a cameo in Boston this… http://dlvr.it/BnsFfS")
#' txt <- paste0(txt, collapse="")
#' ros_entities(txt)
ros_entities <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/entities/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
