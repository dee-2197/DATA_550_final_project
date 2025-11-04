final_project.html: final_project.rmd code/04_render_report.R output/clean_data.rds \
  output/table1.rds output/boxplot.png output/regression_tables.rds
	Rscript code/04_render_report.R
 
output/clean_data.rds: code/00_load_data.R raw_data/diabetes.csv
	Rscript code/00_load_data.R
	
output/table1.rds: code/01_make_table1.R output/clean_data.rds
	Rscript code/01_make_table1.R
	
output/boxplot.png: code/02_make_graph.R output/clean_data.rds
	Rscript code/02_make_graph.R
	
output/regression_tables.rds: code/03_make_regression_tables.R output/clean_data.rds
	Rscript code/03_make_regression_tables.R
	
.PHONY: clean
clean:
	rm -f output/*.html && rm -f output/*.png && rm -f final_project.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"