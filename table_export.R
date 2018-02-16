library(openxlsx)

library(officer)
library(ReporteRs)

save_to_word <- function(table_object,
                         table_title,
                         docx_path = "tables.docx",
                         overwrite = F) {
  # Create Word file if specified one is not found
  if (!file.exists(docx_path) |
      overwrite == T) {
    doc <- docx()
    writeDoc(doc, file = docx_path)
  }
  
  tab <- vanilla.table(table_object)
  tab <- setZebraStyle(tab, even = '#eeeeee', odd = 'white')
  
  doc <- docx(template = docx_path)
  doc <- addParagraph(doc, value = table_title) 
  #doc <- addTitle(doc, table_title)
  doc <- addFlexTable( doc, tab)
  doc <- addParagraph(doc, "")
  writeDoc(doc, file = docx_path)
}

save_to_excel <- function(table_object,
                          sheet_name,
                          xlsx_path = "tables.xlsx",
                          overwrite = F) {
  # Check if there is an xlsx output file
  if (file.exists(xlsx_path) & overwrite == F) {
    wb <- loadWorkbook(file = xlsx_path)}
  else {
    wb <- createWorkbook()
  }
  addWorksheet(wb, sheet_name)
  writeDataTable(wb, x = table_object, sheet = sheet_name,
                 colNames = TRUE, rowNames = F, withFilter = F,
                 tableStyle = "TableStyleLight1",
                 firstColumn = F, bandedRows = F)
                 #"TableStyleLight1")
  saveWorkbook(wb, xlsx_path, overwrite = T)
}
