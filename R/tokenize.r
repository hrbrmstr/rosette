#' Rosette API tokenizatioin service
#'
#' Divides the input into tokens. The response contains a list of tokens.
#'
#' @param content either a URI or character vector of content to process
#' @param genre document genre (optional)
#' @param language Language: ISO 639-3 code (optional)
#' @export
#' @examples
#' ros_tokens("北京大学生物系主任办公室内部会议")
ros_tokens <- function(content, genre=NULL, language=NULL) {

  bdy <- list(genre=genre, language=language)

  if (grepl("^http[s]://", content)) {
    bdy$contentUri <- content
  } else {
    bdy$content <- content
  }

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/tokens/",
                   encode="json",
                   httr::accept_json(),
                   body=bdy,
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
