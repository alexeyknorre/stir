library(openxlsx)

library(officer)
library(ReporteRs)

save_to_word <- function(table_object, table_title, docx_path = "example.docx") {
  tab <- vanilla.table(table_object)
  tab <- setZebraStyle(tab, odd = '#eeeeee', even = 'white')
  
  doc <- docx()
  doc <- addTitle(doc, table_title)
  doc <- addFlexTable( doc, tab)
  writeDoc(doc, file = docx_path)
}

save_to_excel <- function(table_object, sheet_name, xlsx_path = "tables.xlsx") {
  # Check if there is an xlsx output file
  #if (file.exists(xlsx_path)) {
  #  wb <- loadWorkbook(file = xlsx_path)}
  #else {
  #  wb <- createWorkbook()
  #}
  wb <- createWorkbook()
  addWorksheet(wb, sheet_name)
  writeDataTable(wb, x = table_object, sheet = sheet_name,
                 colNames = TRUE, rowNames = F, withFilter = F,
                 tableStyle = "TableStyleLight1",
                 firstColumn = F, bandedRows = F)
                 #"TableStyleLight1")
  saveWorkbook(wb, xlsx_path, overwrite = T)
}
