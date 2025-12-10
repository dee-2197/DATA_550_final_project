README for my final project
================
Deepanshu Goel

# Generating Final Report

To generate the final report, I used make command (type “make” in bash
terminal) as there is a makefile in my repo that describes targets, pre
requisites and action. It contains targets to make demographics tables,
box plots and regression tables to make final report. The make command
uses code in code folder 04_render_report.R and as rule to make
final_report.html is first, so running make command (type “make” in bash
terminal) renders the final_report

# Geneating Demographic Tables

In the repo, code folder contains code- 01_make_table1.R to generate
demographic table for my report. Make output/table1.rds also generate
table in output folder named table1.rds

# Geneating Figures

In the repo, code folder contains code- 02_make_graph.R to generate box
plots for my report. Make output/boxplot.png also generate box plot in
output folder named boxplot.png

# Geneating Regression Tables

In the repo, code folder contains code- 03_make_regression_tables.R to
generate regression table for my report. Make
output/regression_tables.rds also generate table in output folder named
regression_tables.rds

# Synchronizing Package Repository

In the repo, makefile contains code to synchronize package repository,
by simply running make install (type “make install in bash terminal)”
you can synchronize package repository

# Instructions for building a docker image

The repo contains a dockerfile, so for building an docker image, just
type “docker build -t <image_tag> .” in the bash terminal. Period (.) at
the end is important, as it tells docker to look for dockerfile in the
repo in order to build an image. for <image_tag> you can give any name
to image or simply type “make final_project_image” in the bash terminal,
to build an image.

I have uploaded a final_project_image at dockerhub too Link to docker
image on dockerhub-
<https://hub.docker.com/repository/docker/deepanshugoel21/final_project_image/general>

# Instructions for running a docker image and automatically creating a report

After building a docker image, to run a docker image just type “docker
run
-v”/$(pwd)"/report:/home/rstudio/project/final_project <image_tag>" in the bash terminal. image_tag- use same name used to build an image. "/$(pwd)“-
command substitution for working directory and in quotations as has
space, We used extra / as using windows operating system. This command
mounts project_final directory of our system root directory to the
project_final directory of image root directory, so as to open final
report created in image, in local final_project directory.

We can add “-it” in starting and “bash” at end like ” docker run -it -v
“/\$(pwd)”/report:/home/rstudio/project/final_project <image_tag> bash”
in the bash terminal, It opens an interactive container where type
“make” to build report and type “mv final_project.html
final_project_output” in order to view report in “report - folder” in
local directory

# Fully automatized report generation

We can use make command “make report/final_project.html” in bash
terminal. It Will build an image and generate report automatically,
which can be accessed in report directory in your local machine

Hint- use command “make clean” if u run multiple times, as it will
remove everything from final_project directory, for fresh report
