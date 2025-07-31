#######################################################################
##########  TO DETERMINE PERCENTAGE OF TOTAL WORDS THAT HAVE  ##########
##########      EITHER CAUSAL OR NONCAUSAL IMPLICATIONS.      ##########
##########     USE THE ANNOTATION PYTHON SCRIPTS TO PRODUCE   ##########
##########    A PDF WITH HIGHLIGHTED CAUSAL/NONCAUSAL TERMS   ##########
##########     TO PROVIDE THE CONTEXT THE TERMS APPEAR IN.    ##########
#######################################################################


# Load necessary libraries
library(tidyverse)
library(pdftools)
library(reticulate)
library(rjson)
library(jsonlite)

# Define the path to your PDF file
pdf_input_path <- "pdf input/Lorentzen-The Relationship Between School Board Governance Behaviors and St2.pdf"

# Read the text content of the PDF file
pdf_text <- pdf_text(pdf_input_path) %>%
  tolower()  # Convert text to lowercase for case-insensitive search


# Load the causal search terms from the JSON file
causal_terms_glossary <- fromJSON('glossaries/glossary_causal_terms.json')


# Load the search terms from the JSON file
noncausal_terms_glossary <- fromJSON('glossaries/glossary_noncausal_terms.json')


# Function to count occurrences of whole words in text
count_terms_in_text <- function(term) {
  pattern <- paste0('\\b', term, '\\b')
  sum(str_count(pdf_text, regex(pattern, ignore_case = TRUE)))
}


# Map the counting function over causal search terms
causal_term_counts <- map_int(causal_terms_glossary, count_terms_in_text)


# Combine causal search terms and their counts into a tibble
causal_term_counts_df <- tibble(term = causal_terms_glossary, count = causal_term_counts)


# Map the counting function over noncausal search terms
noncausal_term_counts <- map_int(noncausal_terms_glossary, count_terms_in_text)


# Combine causal search terms and their counts into a tibble
noncausal_term_counts_df <- tibble(term = noncausal_terms_glossary, count = noncausal_term_counts)


# Arrange the causal results in descending order of counts
causal_term_counts_df <- causal_term_counts_df %>% 
  arrange(desc(count))


# Arrange the noncausal results in descending order of counts
noncausal_term_counts_df <- noncausal_term_counts_df %>% 
  arrange(desc(count))


# Print the causal term counts dataframe
print(causal_term_counts_df, n = Inf)


# Print the noncausal term counts dataframe
print(noncausal_term_counts_df, n = Inf)



##### Print percentage that search words represent of total words  #####

# Convert pdf_text to a single string
pdf_text_combined <- tolower(paste(pdf_text, collapse = " "))


# Calculate total words
total_words <- str_count(pdf_text_combined, boundary("word"))


# Calculate occurrences of each causal search term and sum them
causal_terms_total_occurrences <- sum(sapply(causal_terms_glossary, function(term) {
  pattern <- paste0('\\b', term, '\\b')
  sum(str_count(pdf_text_combined, regex(pattern, ignore_case = TRUE)))
}))


# Calculate occurrences of each noncausal search term and sum them
noncausal_terms_total_occurrences <- sum(sapply(noncausal_terms_glossary, function(term) {
  pattern <- paste0('\\b', term, '\\b')
  sum(str_count(pdf_text_combined, regex(pattern, ignore_case = TRUE)))
}))


# Calculate the percentage of causal terms in document
causal_percentage <- (causal_terms_total_occurrences / total_words) * 100


# Calculate the percentage of noncausal terms in document
noncausal_percentage <- (noncausal_terms_total_occurrences / total_words) * 100


# Print the percentage for causal terms
print(paste("The causal search terms represent", round(causal_percentage, 2), "% of the total words."))


# Print the percentage for noncausal terms
print(paste("The noncausal search terms represent", round(noncausal_percentage, 2), "% of the total words."))




#####################################################################
##########      RUN PYTHON SCRIPTS TO ANNOTATE PDF FILES   ##########
##########    WITH SEARCH WORDS HIGHLIGHTED OR UNDERLINED  ##########
##########  PYTHON CODE IS FOUND IN .py FILE IN DIRECTORY  ##########
########## THIS CODE SETS UP PYTHON ENVIRONMENT IN RSTUDIO ##########
#####################################################################



# Load the reticulate package
library(reticulate)

# Start the Python REPL  Enter 'quit' to exit the REPL and return to R
repl_python()

