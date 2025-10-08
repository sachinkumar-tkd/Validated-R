# Load the aws.s3 package
library(aws.s3)

# Set AWS credentials (Option 1: Environment Variables)
Sys.setenv("AWS_ACCESS_KEY_ID" = "ASIARRH55YXE7THBDKEF",
           "AWS_SECRET_ACCESS_KEY" = "<SECRET KEY>",
           "AWS_SESSION_TOKEN" = "IQoJb3JpZ2luX2VjEBIaCXVzLWVhc3QtMSJIMEYCIQD6dayEcNwH6MtGsfV5LfsISzwY2hHxlseVBJQU/GQTsAIhANTqwWtHLlCF86x89MbZNgkS+QHyGn3SgEKyuoV7j+0rKpgDCKr//////////wEQAhoMMTA1NzU5MjI5Mzg1IgxNRdRnjIcbYcjX6FQq7AKE4D2eljpDd31amRgc58fq9bENtenEYUbDH+j9vLnWySlXU8JeBelc1p0PM2U0VBbHrzYVLkFsEjiKu3bzxzCHR3ql+76hcjza3cSPXZHSrYhJyrQcG/Ywo/TBYQnPSTEdK/9Po46NIJU+0R4z3a+W6rf+p3ZJR6whhOhssBBGzQoKlkefJV4BZWf8kb6K653+GhynH2Kg8l6lGXtbTic/nySV/CgfXAKm1TJ6eeg3B0HCuY9tz0DVIyZ55Xi8smJ28hG3rnDQ8ftEX57R5thWYeHhg6Ye6eLXifmK4xar8FrJYHMNuaC+wm4EAvx5M+zGsKy0oAkg2mkiC8IvDlANrAbBqk2zX29DTi+XUg/fAzLibjawCP2e5jgMY0wPO4RjxxlvcsSM3ZLxX10SFxxrB1tlsum75p3UIbTMyfcBIO13uWcQ4xcHp8xI+IG1zDYB36XgWEAb5AX0pysbFkTGnxhccNsbqESaHOkqMM6VlccGOqUBw6+y2esvCmwMGoT/Cb2rxj+XuLETd/WsqNSiNtp+lEriUEV1yjGd+8v5gS/7ApLH9hGzdJcfYjo9Rrkw+cdAQYBa0fnRetTI3+HfXhSKMbLi9cl5Z4OgP89pOmbYtVinZ85aXhNL1jSbQzXzKdyTtT6hKfAV5efK3YXvN6RRkrQhXI/ki8s5iF1Oa9+y+Gi6otAfa1k1KLvMr8oLq3VGGWQYR/Ej")

bucketlist()

bucket_name <- "tec-dev-usvga-dhr-raw-01"
#file_path_in_s3 <- "s3://tec-dev-usvga-dhr-raw-01/Business_Function/GI2/test_from_TAGG.sas7bdat"
file_path_in_s3 <- "Business_Function/GI2/CARS.sas7bdat"


# Create a temporary file path
temp_file <- tempfile(fileext = ".sas7bdat")

# Download the SAS file from S3 to the temporary local file
save_object(
  object = file_path_in_s3,
  bucket = bucket_name,
  file = temp_file
)

# Read the SAS file into R
sas_data <- read_sas(temp_file)

# Display the data to verify it was loaded correctly
print(sas_data)

test = sas_data

s3write_using(
  x = sas_data,
  FUN = write.csv,
  bucket = bucket_name,
  object = "Business_Function/GI2/test",
  row.names = FALSE # Prevents R from writing row numbers to the CSV
)
