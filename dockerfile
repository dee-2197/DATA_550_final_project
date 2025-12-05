FROM rocker/tidyverse:4.5.1 as base 
RUN Rscript -e "install.packages('renv')"
RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project

RUN mkdir renv
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
COPY .Rprofile .
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache
RUN apt-get update && apt-get install -y libnode-dev

RUN Rscript -e 'renv::restore(prompt = FALSE)'

#### do not edit stage 1 build lines above ####
FROM rocker/tidyverse:4.5.1

RUN mkdir /home/rstudio/project
WORKDIR /home/rstudio/project
COPY --from=base /home/rstudio/project .


RUN Rscript -e "renv::restore(prompt = FALSE)"
RUN Rscript -e "install.packages('broom.helpers')"
RUN Rscript -e "install.packages('car')"
RUN Rscript -e "install.packages('parameters')"
RUN Rscript -e "renv::snapshot(prompt = FALSE)"
COPY makefile .
COPY final_project.rmd .
RUN mkdir code
COPY code/* code
RUN mkdir output
RUN mkdir raw_data
RUN mkdir final_project
COPY raw_data/diabetes.csv raw_data
CMD make && mv final_project.html final_project 