#' Rosette API morphological analysis service
#'
#' Returns morphological analysis of input. The response may include lemmas, part of
#' speech tags, compound word components, and Han readings. Support for specific return
#' types depends on language.
#'
#' @param content either a URI or character vector of content to process
#' @param feature one of "complete", "lemmas", "parts-of-speech", "compound-components", or
#'                "han-readings". Defaults to "complete"
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' ros_morph("The quick brown fox jumped over the lazy dog. Yes he did.")
#' ros_morph("The quick brown fox jumped over the lazy dog. Yes he did.", "parts-of-speech")
ros_morph <- function(content,
                      feature=c("complete", "lemmas", "parts-of-speech",
                                "compound-components", "han-readings"),
                      genre=NULL, language=NULL) {

  feature <- match.arg(tolower(feature),
                       c("complete", "lemmas", "parts-of-speech", "compound-components", "han-readings"))

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = sprintf("https://api.rosette.com/rest/v1/morphology/%s", feature),
                    encode="json",
                    httr::accept_json(),
                    body=bdy,
                    httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
