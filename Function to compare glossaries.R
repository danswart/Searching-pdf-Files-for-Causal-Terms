compare_glossaries <- function(causal_path, noncausal_path) {
  # Load glossaries
  causal <- jsonlite::fromJSON(causal_path)
  noncausal <- jsonlite::fromJSON(noncausal_path)

  # Normalize (lowercase, trim whitespace)
  causal_clean <- base::tolower(base::trimws(causal))
  noncausal_clean <- base::tolower(base::trimws(noncausal))

  # Find overlaps
  overlaps <- base::intersect(causal_clean, noncausal_clean)

  # Create summary
  summary_df <- base::data.frame(
    Metric = base::c(
      "Total Causal Terms",
      "Total Noncausal Terms",
      "Overlapping Terms",
      "Unique Causal Terms",
      "Unique Noncausal Terms"
    ),
    Count = base::c(
      base::length(causal_clean),
      base::length(noncausal_clean),
      base::length(overlaps),
      base::length(base::setdiff(causal_clean, noncausal_clean)),
      base::length(base::setdiff(noncausal_clean, causal_clean))
    )
  )

  # Return results
  base::list(
    summary = summary_df,
    overlapping_terms = overlaps,
    causal_only = base::setdiff(causal_clean, noncausal_clean),
    noncausal_only = base::setdiff(noncausal_clean, causal_clean)
  )
}

# Run comparison
results <- compare_glossaries(
  'glossaries/glossary_causal_terms.json',
  'glossaries/glossary_noncausal_terms.json'
)

# Display results
base::print(results$summary)

if (base::length(results$overlapping_terms) > 0) {
  base::cat("\n⚠️ OVERLAPPING TERMS FOUND:\n")
  base::print(results$overlapping_terms)
}
