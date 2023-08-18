# Set the path to your Bookdown project directory
current_directory <- getwd()

# List all .Rmd files in the project directory
rmd_files <- list.files(current_directory, pattern = "\\.Rmd$", full.names = TRUE)
used_packages <- list()

# Loop through each .Rmd file and extract package usage
for (rmd_file in rmd_files) {
  rmd_content <- readLines(rmd_file)
  packages <- unique(sub(".*library\\(([^)]+)\\).*", "\\1", rmd_content[grep("library\\(|require\\(", rmd_content)]))
  used_packages <- c(used_packages, packages)
}

used_packages <- sort(unique(unlist(used_packages)))
cat("Packages used in the Bookdown project:\n")
cat(used_packages, sep = "\n")
