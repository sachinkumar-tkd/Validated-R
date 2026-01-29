# Load the aws.s3 package
library(aws.s3)

# Set AWS credentials (Option 1: Environment Variables)
Sys.setenv("AWS_ACCESS_KEY_ID" = "ASIARRH55YXE7THBDKEF",
           "AWS_SECRET_ACCESS_KEY" = "<SECRET KEY>",
           "AWS_SESSION_TOKEN" = "<copy your token here>")

bucketlist()

bucket_name <- "tec-tst-usvga-dhr-raw-01"
#file_path_in_s3 <- "s3://tec-dev-usvga-dhr-raw-01/Business_Function/GI2/test_from_TAGG.sas7bdat"
file_path_in_s3 <- "Business_Function/GI2/poisson.sas7bdat"


# Create a temporary file path
temp_file <- tempfile(fileext = ".sas7bdat")

# Download the SAS file from S3 to the temporary local file
save_object(
  object = file_path_in_s3,
  bucket = bucket_name,
  file = temp_file
)

library(haven)

# Read the SAS file into R
sas_data <- read_sas(temp_file)

# Display the data to verify it was loaded correctly
print(sas_data)

test = sas_data

bucket_trusted <- "tec-tst-usvga-dhr-trusted-01"

s3write_using(
  x = sas_data,
  FUN = write.csv,
  bucket = bucket_trusted,
  object = "Business_Function/GI2/test.rtf",
  row.names = FALSE # Prevents R from writing row numbers to the CSV
)
