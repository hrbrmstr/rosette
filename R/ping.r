#' Rosette API availability
#'
#' @export
ros_ping <- function() {

  res <- httr::GET(url = "https://api.rosette.com/rest/v1/ping/",
                   encode="json",
                   httr::accept_json(),
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}

#' Rosette API version info
#'
#' @export
ros_info <- function() {

  res <- httr::GET(url = "https://api.rosette.com/rest/v1/info/",
                   encode="json",
                   httr::accept_json(),
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}

#' Make a Name object
#'
#' @param name the name to be matched
#' @param entity_type the entity type of the text. One of \code{PERSON}, \code{LOCATION} or
#'        \code{ORGANIZATION} (optional)
#' @param language ISO 639-3 code for the name's langauge (optional)
#' @param script ISO 15924 code for the name's script (optional)
#' @export
#' @examples
#' ros_make_name("Michael Jackson")
ros_make_name <- function(name, entity_type=NULL, language=NULL, script=NULL) {

  out <- list(text=name)

  if (!is.null(language)) out$language <- language
  if (!is.null(entity_type)) out$entityType <- match.arg(toupper(entity_type),
                                                    c("PERSON", "LOCATION", "ORGANIZATION"))
  if (!is.null(script)) out$script <- script

  out

}

#' Rosette API version info
#'
#' Returns the confidence score of matching 2 names. You must specify the names to be matched.
#'
#' @param name1,name2 a name object constructed by a call to \code{ros_make_name()}
#' @export
#' @examples
#' ros_name_similarity(ros_make_name("Michael Jackson"), ros_make_name("迈克尔·杰克逊"))
ros_name_similarity <- function(name1, name2) {

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/name-similarity/",
                   encode="json",
                   httr::accept_json(),
                   body=list(name1=name1, name2=name2),
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}

#' Rosette API name translation service
#'
#' Returns the translation of a name. You must specify the name to translate and the
#' target language for the translation.
#'
#' @param name string (name) to be translated
#' @param target_language ISO 639-3 code for the translation langauge
#' @param target_scheme transliteration scheme for the translation (optional)
#' @param target_script ISO 15924 code for the translation script (optional)
#' @param entity_type the entity type of the text. One of \code{PERSON}, \code{LOCATION} or
#'        \code{ORGANIZATION} (optional)
#' @param source_language_origin ISO 639-3 code for the name's language of origin (optional)
#' @param source_language_use ISO 639-3 code for the name's language of use (optional)
#' @param source_script ISO 15924 code for the name's script (optional)
#' @export
#' @examples
#' ros_name_translation("معمر محمد أبو منيار القذاف", "eng")
ros_name_translation <- function(name, target_language, target_scheme=NULL, target_script=NULL,
                                 entity_type=NULL, source_language_origin=NULL,
                                 source_language_use=NULL, source_script=NULL) {

  if (!is.null(entity_type)) out$entityType <- match.arg(toupper(entity_type),
                                                    c("PERSON", "LOCATION", "ORGANIZATION"))

  res <- httr::POST(url = "https://api.rosette.com/rest/v1/name-translation/",
                   encode="json",
                   httr::accept_json(),
                   body=list(name=name,
                             entityType=entity_type,
                             sourceLanguageOfOrigin=source_language_origin,
                             sourceLanguageOfUse=source_language_use,
                             sourceScript=source_script,
                             targetLanguage=target_language,
                             targetScheme=target_scheme,
                             targetScript=target_script),
                   httr::add_headers(`X-Rosetteapi-Key` = rosette_api_key()))

  httr::stop_for_status(res)

  res <- httr::content(res, as="text", encoding="UTF-8")
  res <- jsonlite::fromJSON(res)

  res

}
