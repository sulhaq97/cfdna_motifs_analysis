# This script has a bunch of functions for fragmentomcics analyses
#
# Written by Sami Ul Haq, May 2, 2024

# Function to generate k-mer permutations
generate_kmer_permutations <- function(k) {
  # Generate all possible combinations of nucleotides
  all_combinations <- expand.grid(replicate(k, c("A", "T", "C", "G"), simplify = FALSE))
  
  # Convert combinations to strings
  all_kmers <- apply(all_combinations, 1, paste, collapse = "")
  
  return(all_kmers)
}

# Calculate F-profiles per sample using reference F-profiles
calculate_f_profiles_per_sample <- function(input_data, reference_f_profiles) {
  f_profiles <- apply(input_data, 2, function(x) {
    nnls(reference_f_profiles, x)$x
  })
  return(f_profiles)
}
