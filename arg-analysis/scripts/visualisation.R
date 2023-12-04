
# LOCATION ----------------------------------------------------------------

# Create a list of target antibiotics.
target_antibiotics <- unique(assay_samples_means$target_antibiotics_major)

# Create a loop for each target antibiotic.
for (target_antibiotic in target_antibiotics) {
  
  # Create a subset of the data for the current target antibiotic.
  data <- location_study[location_study$target_antibiotics_major == 
                           target_antibiotic, ]
  
  # Create a heatmap of the data.
  ggplot(data, aes(x = day, y = gene, fill = mean)) +
    geom_tile() +
    scale_y_discrete(limits = rev) +
    scale_fill_viridis(discrete = F) +
    labs(x = "day", y = "gene", colour = "abundance") +
    facet_grid(length ~ height) +
    theme_ipsum(base_size = 10)
  
  # Save the linegraph to a file.
  ggsave(paste0("arg-analysis/figures/heatmaps/location-heatmap-", 
                target_antibiotic, ".png"), width = 7, height = 7)
}

# Create a loop for each target antibiotic.
for (target_antibiotic in target_antibiotics) {
  
  # Create a subset of the data for the current target antibiotic.
  data2 <- location_study[location_study$target_antibiotics_major == 
                            target_antibiotic, ]
  
  # Create bar graphs of the data.
  data2 %>% 
    group_by(length, height) %>% 
    ggplot(aes(x = day, y = mean, fill = gene)) +
    geom_bar(position = "stack", stat = "identity") +
    geom_errorbar(aes(ymin = mean - se, ymax = mean + se, color = gene), width = 0.2) +
    scale_fill_viridis(discrete = T) +
    scale_color_viridis(discrete = T) +
    labs(x = "day", y = "abundance", fill = "gene") +
    facet_grid(length ~ height) +
    theme_ipsum(base_size = 10)
  
  # Save the linegraph to a file.
  ggsave(paste0("arg-analysis/figures/bargraph/location-bargraph-", 
                target_antibiotic, ".png"), width = 7, height = 7)
}

# TIME --------------------------------------------------------------------

# Create a loop for each target antibiotic.
for (target_antibiotic in target_antibiotics) {
  
  # Create a subset of the data for the current target antibiotic.
  data3 <- time_study[time_study$target_antibiotics_major == 
                        target_antibiotic, ]
  
  # Create a heatmap of the data.
  ggplot(data3, aes(x = day, y = gene, fill = mean)) +
    geom_tile() +
    scale_y_discrete(limits = rev) +
    scale_fill_viridis(discrete = F) +
    labs(x = "day", y = "gene", colour = "abundance") +
    theme_ipsum(base_size = 10)
  
  # Save the heatmap to a file.
  ggsave(paste0("arg-analysis/figures/heatmaps/time-heatmap-", 
                target_antibiotic, ".png"), width = 6, height = 5)
}

# Create a loop for each target antibiotic.
for (target_antibiotic in target_antibiotics) {
  
  # Create a subset of the data for the current target antibiotic.
  data4 <- time_study[time_study$target_antibiotics_major == 
                        target_antibiotic, ]
  
  # Create line graphs of the data.
  ggplot(data4, aes(x = day, 
                    y = mean, 
                    color = gene)) +
    geom_point() +
    geom_errorbar(aes(x = day,
                      ymin = mean - se,
                      ymax = mean + se),
                  width = .6) +
    geom_line(aes(color =  gene)) +
    labs(x = "day", y = "abundance", color = "gene") +
    scale_color_viridis(discrete = T) +
    theme_ipsum(base_size = 10)
  
  # Save the linegraph to a file.
  ggsave(paste0("arg-analysis/figures/linegraph/time-error-linegraph-", 
                target_antibiotic, ".png"), width = 6, height = 5)
}

# 16S ---------------------------------------------------------------------

# create a graph for total abundance of 16S data across samples.
ggplot(means_16S, aes(x = day, y = mean, fill = height)) +
  geom_col(position = 'dodge') +
  geom_errorbar(aes(x = day,
                    y = mean,
                    ymin = mean - sd, 
                    ymax = mean + sd), 
                width = 1) +
  labs(x = "day", y = "ct", fill = "location") +
  scale_color_viridis(discrete = F) +
  theme_ipsum(base_size = 10)
ggsave(paste0("arg-analysis/figures/16S-november.png"), width = 8, height = 5)