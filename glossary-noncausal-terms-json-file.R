############################################################################
#####  FIRST THE NONCAUSE_TERMS CHARACTER VECTOR IS UPDATED WITH THE R #####
#####   SCRIPT NAMED 'ADD-REMOVE TERMS IN CAUSAL_TERMS VECTOR.R AND    #####
#####           STORED AS AN .RDATA FILE IN THE DATA FOLDER            #####
############################################################################

##############################################################################
##### NEXT, CREATE/UPDATE GLOSSARY OF NONCAUSAL SEARCH TERMS JSON FILE   #####
#####  IN THIS R SCRIPT FILE FOR HIGHLIGHTING AND UNDERLINING THE CAUSAL #####
#####    AND NONCAUSAL TERMS. ACCORDINGLY, THIS JSON FILE OF TERMS       #####
#####                    MUST BE KEPT UP TO DATE                         #####
##############################################################################


#########################################################################
#####     I USE THE PYTHON SCRIPTS TO ANNOTATE PDF FILES WITH       #####
#####  HIGHLIGHTING AND UNDERLINING THE CAUSAL AND NONCAUSAL TERMS  #####
#####       SO THIS JSON FILE OF TERMS MUST BE KEPT UP TO DATE       #####
#########################################################################


# load libraries

library(tidyverse)
library(rjson)
library(jsonlite)


# Load noncausal_terms RData character vector ONLY AFTER updating it with R script named 'Add-Remove terms in noncausal_terms vector.R

load("data/noncausal_terms.RData") # contains most recent causal_terms character vector

# and sort alphabetically
noncausal_terms  <- sort(unique(noncausal_terms))


# Convert the list to JSON format
glossary_noncausal_terms <- toJSON(noncausal_terms)


# Write the JSON data to a file
write(glossary_noncausal_terms, "glossaries/glossary_noncausal_terms.json")





#####  LOADING THE JSON FILE  #####

# Load the search terms from the JSON file
noncausal_terms_glossary <- fromJSON('glossaries/glossary_noncausal_terms.json')



######################################################################
##### THERE ARE TWO WAYS TO ADD/REMOVE TERMS TO/FROM JSON FILE   #####
#####        PREFERRED METHOD IS TO USE THE R SCRIPT FILE        #####
#####    NAMED 'ADD-REMOVE TEMRS TO NONCAUSAL_TERMS VECTOR'      #####
#####  OR, USE CODE BELOW TO ADD/REMOVE TERMS TO/FROM JSON FILE  #####
######################################################################


# Example: Add a new term to noncausal terms 
# noncausal_terms_glossary <- c(noncausal_terms_glossary, 'NEW NONCAUSAL TERM')


# and sort alphabetically
# noncausal_terms_glossary <- sort(unique(noncausal_terms_glossary))


# Save the updated search terms back to the JSON file

# write(toJSON(noncausal_terms_glossary, pretty = TRUE), 'glossaries/glossary_noncausal_terms.json')




####################################@@########################
#####  REMOVING A NONCAUSAL SEARCH TERMS FROM JSON FILE  #####
##############################################################



# Read the JSON file into R

# json_file_path <- 'glossaries/glossary_noncausal_terms.json'
# noncausal_terms_glossary <- fromJSON(json_file_path)

# Remove a specific term, for example 'term_to_remove'

#term_to_remove <- 'TERM_TO_REMOVE'
#noncausal_terms_glossary <- noncausal_terms_glossary[noncausal_terms_glossary != TERM_TO_REMOVE]

# Save the updated search terms back to the JSON file

# write(toJSON(noncausal_terms_glossary, pretty = TRUE), json_file_path)















