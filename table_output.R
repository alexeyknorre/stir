freqtab <- function(variable,
                    n = 10,
                    round_prct = 0,
                    show_sum = T,
                    show_na = T,
                    sum_prct_override = T) {
  if (show_na == T) 
    { usena <- "ifany" } 
  else 
    {usena <- "no"}
  # Counting frequencies and percentages
  tab <- cbind( Frequency = table(variable,useNA  = usena), '%' = round(prop.table(table(variable, useNA = usena))*100,round_prct))
  # Order them in descending fashion
  tab <-tab[ order(-tab[,1]), ]
  # We cut most frequent values and sum others only if we have many unique values
  if (n < length(unique(variable))) { 
    # Count other options after cut
    Other <- colSums(tab[n:length(tab[,1]),])
    # Cut values
    tab <- head(tab, n-1)
    # Add Other values
    tab <- rbind(tab,Other)
  }
  # Summing up by columns
  if (show_sum == T) {tab <- addmargins(tab, 1)}
  # Row names to first column
  #tab <- cbind(Name = rownames(tab), tab)
  #rownames(tab) <- NULL
  # Fix NA to avoid data.frame conversion error
  row.names(tab)[which(is.na(row.names(tab)))] <- "NA"
  # Override sum of percentages to have 100
  if (sum_prct_override == T) {
    tab[,2][[length(tab[,2])]] <- 100
  }
  # Result
  as.data.frame(tab)
  
}

crosstab <- function(variable_row,
                     variable_column,
                     row_n = 5,
                     col_n = 5,
                     round_prct = 0,
                     na = T,
                     sum = T){
  if (na == T) { usena <- "ifany" } 
  else {usena <- "no"}
  tab <- table(variable_row, variable_column, useNA = usena)
  #tab <- table(df$v1, df$v2, useNA = "ifany")
  
  colnames(tab)[is.na(colnames(tab))] <- "NAs"
  row.names(tab)[is.na(row.names(tab))] <- "NAs"
  
  tab <- as.data.frame.matrix(tab)
  
  tab <- tab[order(rowSums(tab),decreasing = T),]
  tab <- tab[order(colSums(tab),decreasing = T)]
  
  #tab <- t(head(t(head(tab,row_n)), col_n))
  
  # CUT COLUMNS
  # We cut most frequent values and sum other only if we have many unique values
  if (col_n < length(unique(variable_column))) { 
    # Count other options after cut
    Other <- rowSums(tab[,col_n:ncol(tab)])
    # Cut values
    tab <- tab[,1:col_n-1]
    # Add Other values
    tab <- cbind(tab,Other)
  }
  
  # CUT ROWS
  # We cut most frequent values and sum other only if we have many unique values
  if (row_n < length(unique(variable_row))) { 
    # Count other options after cut
    Other <- as.data.frame(t(colSums(tab[row_n:nrow(tab),])))
    rownames(Other) <- "Other"
    # Cut values
    tab <- tab[1:row_n-1,]
    # Add Other values
    tab <- rbind(tab,Other)
  }
  tab_freqs <- tab
  if (sum == T) {tab_freqs <- as.data.frame(addmargins(as.matrix(tab)))}
  
  ### Percentage tables
  
  # Columns
  tab_perc_columns <- round(prop.table(as.matrix(tab), margin = 2)*100, round_prct)
  tab_perc_columns <- as.data.frame(addmargins(as.matrix(tab_perc_columns), margin = 1))
  tab_perc_columns[] <- lapply(tab_perc_columns, function(x) paste0(x, "%"))
  
  # Rows
  tab_perc_rows <- round(prop.table(as.matrix(tab), margin = 1)*100, round_prct)
  tab_perc_rows <- as.data.frame(addmargins(as.matrix(tab_perc_rows), margin = 2))
  tab_perc_rows[] <- lapply(tab_perc_rows, function(x) paste0(x, "%"))
  
  tab_list <- list("Frequencies" = tab_freqs,
                   "Columns_percentages" = tab_perc_columns,
                   "Rows_percentages" = tab_perc_rows)
  return(tab_list)
  
}



