## osm_descriptives takes a list with descriptives as an object and outputs tabs with these descriptives

## object: list with descriptives
## level: character string indicating the level in the output (i.e. '#', '##', '###' etc.)
osm_descriptives <- function(object, level){
  for (i in seq_along(object)){
    cat(level, names(object)[i], "\n")
    cat("\n")
    cat("Frequencies of ", names(object)[i], "\n")
    obj <- object[[i]]
    print(kable(obj))
    cat("\n")
  }
}