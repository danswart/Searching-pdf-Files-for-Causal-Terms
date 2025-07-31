####################################################
#####  CREATE A NEW GLOSSARY AND SAVE IT AS A  #####
#####    CHARACTER VECTOR IN AN .RDATA FILE    #####
#####           IN THE /DATA FOLDER            #####
####################################################


# load libraries
library(tidyverse) 


# Create a character vector with 10 search terms
new_glossary_name <- c("term1", "term2", "term3", "term4", "term5", "term6", "term7", "term8", "term9", "term10")


  # Convert the character vector to a tibble
new_glossary_name <- tibble(search_term = new_glossary_name) %>%  
  # Remove duplicate entries
  distinct() %>%  
  # Sort the entries in alphabetical order
  arrange(search_term) %>%  
  # Extract the sorted and unique search terms as a character vector
  pull(search_term)  


###########################################################
#####  Save the 'new_glossary_name' character vector  #####  
#####     as an RData object in the /data folder      #####  
###########################################################


  # Define the file path for saving the .RData file
file_path <- file.path("data", "new_glossary_name.RData")  

# Save the 'new_glossary_name' character vector as an .RData object
save(new_glossary_name, file = file_path)  
