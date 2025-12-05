#Report assciated rules (run within a docker container)
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
	rm -f output/*.html && rm -f output/*.png && rm -f final_project.html && rm -f final_project/*
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"
	
#Docker associated rules(run on local machines)
projectfiles = final_project.rmd code/04_render_report.R code/00_load_data.R \
	code/01_make_table1.R code/02_make_graph.R code/03_make_regression_tables.R \
	code/03_make_regression_tables.R makefile
renvfiles = renv.lock renv/activate.R renv/settings.json

#Rule to  build an image
final_project_image: dockerfile $(projectfiles) $(renvfiles)
	docker build -t final_project_image . 
	touch $@

#Rule to run a container using image and build report automatically
final_project/final_project.html:
	docker build -t final_project_image . && docker run -v "/$$(pwd)"/final_project:/home/rstudio/project/final_project final_project_image