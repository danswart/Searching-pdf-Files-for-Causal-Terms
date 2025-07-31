import fitz  # PyMuPDF
import re
import json


def annotate_causal_and_noncausal_terms(pdf_input_path, causal_terms_glossary, noncausal_terms_glossary):
    try:
        doc = fitz.open(pdf_input_path)
        for page in doc:
            text = page.get_text("text")
            # Highlight causal terms with word boundaries
            causal_pattern = r'\b(' + '|'.join(map(re.escape, causal_terms_glossary)) + r')\b'
            causal_regex = re.compile(causal_pattern, re.IGNORECASE)
            for match in causal_regex.finditer(text):
                rects = page.search_for(match.group(0))
                for rect in rects:
                    highlight = page.add_highlight_annot(rect)
            # Signify noncausal terms using squiggly method with word boundaries
            noncausal_pattern = r'\b(' + '|'.join(map(re.escape, noncausal_terms_glossary)) + r')\b'
            noncausal_regex = re.compile(noncausal_pattern, re.IGNORECASE)
            for match in noncausal_regex.finditer(text):
                rects = page.search_for(match.group(0))
                for rect in rects:
                    squiggly_annot = page.add_squiggly_annot(rect)
        output_path = pdf_output_path.replace('.pdf', '_squiggly_annotated.pdf')
        doc.save(output_path, garbage=4, deflate=True)
        doc.close()
        print("Causal and noncausal terms annotation complete. Annotated PDF saved as:", output_path)
        return output_path
    except Exception as e:
        print("Error:", str(e))

pdf_input_path = "pdf input/Lorentzen-The Relationship Between School Board Governance Behaviors and St2.pdf"
pdf_output_path = "pdf output/Lorentzen-The Relationship Between School Board Governance Behaviors and St2.pdf"

# Load the causal search terms from caual_terms JSON file
with open('glossaries/glossary_causal_terms.json', 'r') as file:
    causal_terms_glossary = json.load(file)

# Load the noncausal search terms from noncausal_terms JSON file
with open('glossaries/glossary_noncausal_terms.json', 'r') as file:
    noncausal_terms_glossary = json.load(file)

annotated_pdf_path = annotate_causal_and_noncausal_terms(pdf_input_path, causal_terms_glossary, noncausal_terms_glossary)
