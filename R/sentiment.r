#' Rosette API sentiment analysis service
#'
#' Analyzes the positive and negative sentiment expressed by the input. The response
#' contains sentiment analysis results.
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' txt <- c("Original Ghostbuster Dan Aykroyd, who also co-wrote the 1984 Ghostbusters ",
#'          "film, couldn’t be more pleased with the new all-female Ghostbusters cast, ",
#'          "telling The Hollywood Reporter, “The Aykroyd family is delighted by this ",
#'          "inheritance of the Ghostbusters torch by these most magnificent women in comedy.")
#' ros_sentiment(paste0(txt, collapse=""))
ros_sentiment <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/sentiment/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
