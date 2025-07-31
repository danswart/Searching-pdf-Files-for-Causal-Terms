# To get the cryptic variable names and plain English descriptions
# from the PDF that accompanies the Excel file from TEA


#####################################################################
##########  RUN THIS CODE IN THE CONSOLE TO SET UP PYTHON  ##########
##########  ENVIRONMENT IN R.  THEN RUN PYTHON CODE BELOW  ##########
##########  TO BUILD VARIABLE-KEYWORD TABLE FOR RENAMING THE ########
##########   COLUMNS FROM EXCEL FILES DOWNLOADED FROM TEA  ##########
#####################################################################


# Load the reticulate package
library(reticulate)

# Start the Python REPL  Enter 'quit' to exit the REPL and return to R
repl_python()

#######################################################################


import fitz  # PyMuPDF library for working with PDF files
import re
import csv


# Define the function to extract the content from the pdf file

def extract_variables(pdf_path, output_csv):
    doc = fitz.open(pdf_path)
    
    extracted_variables = []
    
    for page_num in range(len(doc)):
        page = doc.load_page(page_num)
        text = page.get_text("text")
        
        lines = text.split('\n')
        
        try:
            header_row = lines.index("Variable Type Len Label")
            variable_index = lines[header_row].index("Variable")
            label_index = lines[header_row].index("Label")
            
            for line in lines[header_row + 1:]:
                columns = line.split()
                if len(columns) > label_index:
                    variable = columns[variable_index]
                    label = ' '.join(columns[label_index:])
                    extracted_variables.append((variable, label))
        except ValueError:
            continue
    
    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        writer.writerow(["Variable", "Label"])
        writer.writerows(extracted_variables)
    
    doc.close()


# Specify the paths for input PDF and output CSV files
pdf_path = "pdf input/2023-RDA Data Dictionary.pdf"
output_csv = "csv output/2023_variables_and_labels.csv"


# Call the function to extract variables and labels from the PDF
extract_variables(pdf_path, output_csv)
