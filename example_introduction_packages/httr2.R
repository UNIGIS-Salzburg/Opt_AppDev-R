# Load the httr2 library
library(httr2)

# Define the base URL and parameters
base <- "http://api.openweathermap.org/data/2.5/weather"
lat <- "47.81"    
lon <- "13.03"
apiKey <- "3f87141421b32590d50416aae5ca780c"

# Construct the full URL with query parameters
full_url <- sprintf("%s?lat=%s&lon=%s&appid=%s", base, lat, lon, apiKey)

# Print the constructed URL
print(full_url)

# Create the request
# New (httr2): Uses request to create a request object and then req_perform to send the request. 
#This two-step process is a fundamental change in httr2.
req <- request(full_url)

# Perform the request and store the response
resp <- req_perform(req)

# Check the status code of the response
print(resp_status(resp))

# View the content structure of the response in JSON
# Original (httr): Uses content to get the content of the response.
# New (httr2): Uses resp_body_json to get the JSON content of the response.
str(resp_body_json(resp))

# ---

# Directly Using resp_body_json: If you're certain that the response will always be in JSON format, 
# you can directly convert the response to a data frame without the intermediate 
# step of storing it in response_content.

# Convert the response content directly to a data frame
response_df <- as.data.frame(resp_body_json(resp))

# Or:
# Convert the response content to a data frame
library(jsonlite)

response_content <- resp_body_json(resp)
response_df <- as.data.frame(response_content)

# The httr2 code might seem a bit more verbose, but it offers more flexibility, 
# especially when constructing complex requests. The two-step process of creating a request 
# and then performing it allows for more granular control over the request process.
