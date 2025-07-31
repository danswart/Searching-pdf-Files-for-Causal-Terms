#########################################################
##########  UPDATE CAUSAL_TERMS, THEN FEED TO  ##########
##########  GLOSSARY-CAUSAL-TERMS-JSON-FILE.R  ##########
#########################################################



##################################################################
##########  TO ADD SEARCH TERMS TO CAUSAL_TERMS VECTOR  ##########
##################################################################


# load libraries

library(tidyverse)


# Load the .RData file
load("data/linking word ratings.RData") # contains search terms to be added to causal_terms character vector

load("data/causal_terms.RData") # contains most recent causal_terms character vector


# Filter the new dataframe and select unique observations and output as a character vector to add to existing character vector 'causal_terms' 

strong_causal_words <- df.word.ratings %>%
  filter(Rating == "Strong") %>%
  pull(Root.word) %>%
  unique()


# Combine the two lists into a new list with each term separate and no duplicates
causal_terms <- union(causal_terms, strong_causal_words)

# Alphabetize the new character vector
causal_terms <- sort(causal_terms)

# Save the 'causal_terms' character vector as an RData object
save(causal_terms, file = "data/causal_terms.RData")




##################################################################
##########  TO REMOVE SEARCH TERMS FROM CAUSAL_TERMS VECTOR  #####
##################################################################


# Specify the search terms to remove
search_terms_to_remove <- c("term1", "term2", "term3")  # add terms you want to remove within the c() function

# Remove the specified search terms from causal_terms vector
removed_terms <- causal_terms[causal_terms %in% search_terms_to_remove]
if (length(removed_terms) == 0) {
  message("No search terms were removed")
} else {
  message("The following search terms were removed: ", paste(removed_terms, collapse = ", "))
  causal_terms <- causal_terms[!(causal_terms %in% search_terms_to_remove)]
}

# Alphabetize the new character vector
causal_terms <- sort(causal_terms)

# Save the 'causal_terms' character vector as an RData object
save(causal_terms, file = "data/causal_terms.RData")
