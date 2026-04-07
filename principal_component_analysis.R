mut_mat <- df %>%
  select(ins.std, del.std, sub.std, microsat.std) %>%
  drop_na() %>%
  as.matrix()
complete_idx <- complete.cases(mut_mat)
mut_mat <- mut_mat[complete_idx, , drop = FALSE]
df_sub <- df %>% slice(which(complete_idx))
pca_res <- prcomp(mut_mat, center = TRUE, scale. = FALSE)
eig_vals <- (pca_res$sdev)^2
var_explained <- eig_vals / sum(eig_vals)
p_scree <- fviz_eig(pca_res, addlabels = TRUE, ylim = c(0, 100)) +
  ggtitle("Scree plot — Variance explained") +
  theme_minimal(base_size = 13)
scores <- as.data.frame(pca_res$x) %>%
  rownames_to_column(var = "window_id")
p_scatter <- ggplot(scores, aes(x = PC1, y = PC2)) +
  geom_point(size = 1.5, alpha = 0.8, color = "grey20") +
  labs(
    x = paste0("PC1 (", round(100 * var_explained[1], 1), "%)"),
    y = paste0("PC2 (", round(100 * var_explained[2], 1), "%)"),
    title = "PCA: PC1 vs PC2"
  ) +
  theme_minimal(base_size = 13)
loadings <- as.data.frame(pca_res$rotation[, 1:2]) %>%
  rownames_to_column(var = "variable")
multiplier <- min(
  (max(scores$PC1) - min(scores$PC1)) / (max(loadings$PC1) - min(loadings$PC1)),
  (max(scores$PC2) - min(scores$PC2)) / (max(loadings$PC2) - min(loadings$PC2))
) * 0.8
loadings_scaled <- loadings %>%
  mutate(PC1s = PC1 * multiplier,
         PC2s = PC2 * multiplier)
p_biplot <- p_scatter +
  geom_segment(data = loadings_scaled,
               aes(x = 0, y = 0, xend = PC1s, yend = PC2s),
               arrow = arrow(length = unit(0.25, "cm")), linewidth = 0.7,
               color = "steelblue") +
  geom_label_repel(data = loadings_scaled,
                   aes(x = PC1s, y = PC2s, label = variable),
                   size = 3.6, color = "steelblue", fill = "white") +
  theme(legend.position = "none")
p_contrib <- fviz_contrib(pca_res, choice = "var", axes = 1:2, top = 10) +
  ggtitle("Variable contributions to PCs") +
  theme_minimal(base_size = 13)
pca_res <- prcomp(mut_mat, center = TRUE, scale. = FALSE)
loadings_tbl <- as.data.frame(pca_res$rotation[, 1:2]) %>%
  rownames_to_column("Variable") %>%
  rename(
    "PC1 Loading" = PC1,
    "PC2 Loading" = PC2
  ) %>%
  mutate(across(-Variable, ~ round(.x, 3)))
loadings_tbl %>%
  kable("html", caption = "PCA Loadings for Mutation Rates (PC1 & PC2)") %>%
  kable_styling(full_width = FALSE, position = "center", bootstrap_options = c("striped", “hover"))
print(p_scree)
print(p_biplot)
