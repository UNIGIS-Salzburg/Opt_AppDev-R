library(terra)

r <- terra::rast(ncol=20, nrow=20)
terra::values(r) <- stats::runif(terra::ncell(r),0,1)
plot(r)

cnt <- 0

for(row in c(1:nrow(r))) {
  
  for(col in 1:ncol(r)) {                 
    
    if(r[row, col] > 0.5){
      
      cnt <- cnt + 1
      
    }
    
  }
}

cnt