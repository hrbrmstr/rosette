
`rosette` : Tools to Work with the [Rosette API](https://developer.rosette.com/api-doc)

You need to put your Rosette API key into your `~/.Renviron` file. For example:

    ROSETTE_API_KEY=someapikeyststring

The following functions are implemented:

-   `rosette_api_key`: Get or set `ROSETTE_API_KEY` value
-   `ros_categories`: Rosette API categorizatioin service
-   `ros_embedding`: Rosette API text embedding service
-   `ros_entities`: Rosette API entity extraction service
-   `ros_info`: Rosette API version info
-   `ros_language`: Rosette API language identification service
-   `ros_make_name`: Make a Name object
-   `ros_morph`: Rosette API morphological analysis service
-   `ros_name_similarity`: Rosette API version info
-   `ros_name_translation`: Rosette API name translation service
-   `ros_ping Rosette`: API availability
-   `ros_relationships`: Rosette API relationship extraction service
-   `ros_sentences`: Rosette API sentence determination service
-   `ros_sentiment`: Rosette API sentiment analysis service
-   `ros_tokens`: Rosette API tokenizatioin service

The following data sets are included:

### Installation

``` r
devtools::install_git("https://github.com/hrbrmstr/rosette.git")
```

``` r
options(width=120)
```

### Usage

``` r
library(rosette)

# current verison
packageVersion("rosette")
```

    ## [1] '0.1.0'

### Test Results

``` r
library(rosette)
library(testthat)

date()
```

    ## [1] "Tue Oct 11 17:54:08 2016"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
