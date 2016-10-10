#' Rosette API sentence determination service
#'
#' Divides the input into sentences. The response contains a list of sentences.
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' lines <- c("This land is your land. This land is my land",
#'            "From California to the New York island;",
#'            "From the red wood forest to the Gulf Stream waters",
#'            "",  "This land was made for you and Me.",
#'            "", "As I was walking that ribbon of highway,",
#'            "I saw above me that endless skyway:",
#'            "I saw below me that golden valley:",
#'            "This land was made for you and me.")
#' ros_sentences(paste0(lines, collapse="\\n"))
ros_sentences <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/sentences/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
