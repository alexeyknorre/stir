# stir
Simple Tables In R (yet another mini-package for tables output in R)
# WTF?
So you want to make a frequency table in R. You use `table()`, then `sort()`, then `round()`, then ask to show a `head()`. Then you understand you also need to count NAs, percentages and so on... Arrrr.  
I wrote a set of functions that does all of these.

## How to use?
Just source R script with functions through Internet.  
`> source("https://raw.githubusercontent.com/alexeyknorre/stir/master/table_output.R")`  
Maybe some day it will become a package.

#  `freqtab()` 
Gives you a neat frequency table, with absolute counts and percentages, optional NAs, and sums.

## Syntax
It has next arguments:  
`variable` -- a column from your data.frame.  
`n` - number of rows to show in frequency table. Other rows will be counted as Other. Defaults to 10.  
`round_prct` - how many digits after dot to show in percentages(0 = "20", 1 = "20,5", 3 = "20,53"). Defaults to 0.  
`show_sum` - whether to count sums in the lower row. Defaults to TRUE.  
`show_nas` - whether to count NA. Defaults to TRUE.  
`sum_prct_override` - should sum of percentages be always 100? Defaults to TRUE. If FALSE, it just sums up the rounded percentages (so sum of percentages will not be always 100 due to rounding error).

## Example

```
> source("https://raw.githubusercontent.com/alexeyknorre/stir/master/table_output.R")
# And start using it:
> freqtab(mtcars$mpg)
      Frequency  %
10.4          2  6
15.2          2  6
19.2          2  6
21            2  6
21.4          2  6
22.8          2  6
30.4          2  6
13.3          1  3
14.3          1  3
Other        16 48
Sum          32 100

> freqtab(mtcars$mpg, n = 5)
      Frequency  %
10.4          2  6
15.2          2  6
19.2          2  6
21            2  6
Other        24 72
Sum          32 100

> freqtab(mtcars$mpg, n = 5, round_prct = 2)
      Frequency     %
10.4          2  6.25
15.2          2  6.25
19.2          2  6.25
21            2  6.25
Other        24 74.91
Sum          32   100
```

# `crosstab()`

Calculates cross-tabulation of two columns and gives you a list of three dataframes that contain frequencies, row percentages and column percentages.

## Syntax

`variable_row` - a column whose values will be inside rows of crosstab.  
`variable_column`  a column whose values will be inside columns of crosstab. 
`row_n` - number of rows to show (defaults to 5)
`col_n` - number of columns to show (defaults to 5)
`round_prct` - how many digits after dot to show in percentages(0 = "20", 1 = "20,5", 3 = "20,53"). Defaults to 0.  

## Example

```
> crosstab(mtcars$mpg, mtcars$cyl)
$Frequencies
       8  4 6 Sum
10.4   2  0 0   2
15.2   2  0 0   2
19.2   1  0 1   2
21     0  0 2   2
Other  9 11 4  24
Sum   14 11 7  32

$Columns_percentages
        8    4    6
10.4  14%   0%   0%
15.2  14%   0%   0%
19.2   7%   0%  14%
21     0%   0%  29%
Other 64% 100%  57%
Sum   99% 100% 100%

$Rows_percentages
         8   4    6  Sum
10.4  100%  0%   0% 100%
15.2  100%  0%   0% 100%
19.2   50%  0%  50% 100%
21      0%  0% 100% 100%
Other  38% 46%  17% 101%
```

# Outputting

I also made a routines to export such tables to Word and Excel inside `table_export_R`.

## To Word:
`save_to_word()` uses `ReporteRs` package to manipulate with .docx files. It creates (or appends to if it exists) a specified Word file and outputs dataframes as neat tables with zebra stripping. You can just stack as many tables as you want inside this Word file:  

### Syntax:
`table_object` - a dataframe to save.  
`table_title` - a title of a table.  
`docx_path` - where to store a Word file (append to a existing one or creates if it does not exist).  

### Example:  
```
save_to_word(mtcars$mpg, "First table", "results/tables.docx")
```

## To Excel:
`save_to_excel()` uses `openxlsx` to save dataframe inside an Excel file. It creates empty .xlsx file, a sheet there and saves a table inside the sheet.  

### Syntax:
`table_object` - a dataframe to save.  
`sheet_name` - a name of a sheet inside .xlsx file.  
`xlsx_path` - where to store an Excel file (creates a new one).  



