####################################################################
##########    FIRST, UPDATE NONCAUSAL_TERMS HERE, THEN    ##########
##########  FEED TO GLOSSARY-NONCAUSAL-TERMS-JSON-FILE.R  ##########
####################################################################


#####################################################################
##########  TO ADD SEARCH TERMS TO NONCAUSAL_TERMS VECTOR  ##########
#####################################################################


# load libraries
library(tidyverse)


# Load the .RData file
load("data/linking word ratings.RData") # contains search terms to be added to noncausal_terms character vector

load("data/noncausal_terms.RData") # contains current noncausal_terms character vector


# Filter the new dataframe and select unique observations and output as a character vector to add to existing character vector 'noncausal_terms' 

weak_noncausal_words <- df.word.ratings %>%
  dplyr::filter(Rating %in% c("Weak", "Moderate")) %>% 
  dplyr::distinct(Root.word) %>% 
  dplyr::pull(Root.word)

# Combine the two lists into a new list with each term separate and no duplicates
noncausal_terms <- dplyr::union(noncausal_terms, weak_noncausal_words)

# Alphabetize the new character vector
noncausal_terms <- sort(noncausal_terms)

# Save the 'noncausal_terms' character vector as an RData object
save(noncausal_terms, file = "data/noncausal_terms.RData")




#####################################################################
##########  TO REMOVE SEARCH TERMS FROM NONCAUSAL_TERMS VECTOR  #####
#####################################################################


# Specify the search terms to remove
search_terms_to_remove <- c("term1", "term2", "term3")  # add terms you want to remove within the c() function

# Remove the specified search terms from causal_terms vector
removed_terms <- noncausal_terms[noncausal_terms %in% search_terms_to_remove]
if (length(removed_terms) == 0) {
  message("No search terms were removed")
} else {
  message("The following search terms were removed: ", paste(removed_terms, collapse = ", "))
  noncausal_terms <- noncausal_terms[!(noncausal_terms %in% search_terms_to_remove)]
}


# Alphabetize the new character vector
noncausal_terms <- sort(noncausal_terms)


# Save the 'causal_terms' character vector as an RData object
save(noncausal_terms, file = "data/noncausal_terms.RData")




