#' Get or set ROSETTE_API_KEY value
#'
#' The API wrapper functions in this package all rely on a Rosette API
#' key residing in the environment variable \code{ROSETTE_API_KEY}. The
#' easiest way to accomplish this is to set it in the `\code{.Renviron}` file in your
#' home directory.
#'
#' @param force force setting a new Rosette API key for the current environment?
#' @return atomic character vector containing the Rosette API key
#' @export
rosette_api_key <- function(force = FALSE) {

  env <- Sys.getenv('ROSETTE_API_KEY')
  if (!identical(env, "") && !force) return(env)

  if (!interactive()) {
    stop("Please set env var ROSETTE_API_KEY to your Dark Sky API key",
      call. = FALSE)
  }

  message("Couldn't find env var ROSETTE_API_KEY See ?rosette_api_key for more details.")
  message("Please enter your API key and press enter:")
  pat <- readline(": ")

  if (identical(pat, "")) {
    stop("Rosette API key entry failed", call. = FALSE)
  }

  message("Updating ROSETTE_API_KEY env var to PAT")
  Sys.setenv(ROSETTE_API_KEY = pat)

  pat

}
