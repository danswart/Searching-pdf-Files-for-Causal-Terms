###########################################################################
#####   FIRST THE CAUSE_TERMS CHARACTER VECTOR IS UPDATED WITH THE R  #####
#####  SCRIPT NAMED 'ADD-REMOVE TERMS IN CAUSAL_TERMS VECTOR.R AND    #####
#####           STORED AS AN .RDATA FILE IN THE DATA FOLDER           #####
###########################################################################

##############################################################################
#####   NEXT, CREATE/UPDATE GLOSSARY OF CAUSAL SEARCH TERMS JSON FILE    #####
#####          HERE FOR HIGHLIGHTING AND UNDERLINING THE CAUSAL          #####
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


# Load causal_terms RData character vector ONLY AFTER updating it with R script named 'Add-Remove terms in causal_terms vector.R
load("data/causal_terms.RData") # contains most recent causal_terms character vector


# and sort causal_terms alphabetically, just in case it needs it
causal_terms  <- sort(unique(causal_terms))


# Convert the list to JSON format
glossary_causal_terms <- toJSON(causal_terms)


# Write the JSON data to a file
write(glossary_causal_terms, "glossaries/glossary_causal_terms.json")





#####  LOADING THE JSON FILE  #####

# Load the causal search terms from the JSON file
causal_terms_glossary <- fromJSON('glossaries/glossary_causal_terms.json')




######################################################################
##### THERE ARE TWO WAYS TO ADD/REMOVE TERMS TO/FROM JSON FILE   #####
#####        PREFERRED METHOD IS TO USE THE R SCRIPT FILE        #####
#####      NAMED 'ADD-REMOVE TEMRS TO CAUSAL_TERMS VECTOR'       #####
#####  OR, USE CODE BELOW TO ADD/REMOVE TERMS TO/FROM JSON FILE  #####
######################################################################


# Example: Add a new term to causal terms 
# causal_terms_glossary <- c(causal_terms_glossary, 'NEW CAUSAL TERM')


# and sort alphabetically
# causal_terms_glossary <- sort(unique(causal_terms_glossary))


# Save the updated search terms back to the JSON file
# write(toJSON(causal_terms_glossary, pretty = TRUE), 'glossaries/glossary_causal_terms.json')




####################################@@#####################
#####   REMOVING CAUSAL SEARCH TERMS FROM JSON FILE   #####
###########################################################



# Read the JSON file into R
# json_file_path <- 'glossaries/glossary_causal_terms.json'
# causal_terms_glossary <- fromJSON(json_file_path)

# Remove a specific term, for example 'term_to_remove'
#term_to_remove <- 'TERM_TO_REMOVE'
#causal_terms_glossary <- causal_terms_glossary[causal_terms_glossary != term_to_remove]

# Save the updated search terms back to the JSON file
# write(toJSON(causal_terms_glossary, pretty = TRUE), json_file_path)








