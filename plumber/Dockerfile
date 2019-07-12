# example Dockerfile to expose a plumber service

FROM r-base:3.6.0

# install the randomForest package
RUN R -e 'install.packages(c("plumber","randomForest"))'

# copy model and scoring script
RUN mkdir /data
COPY bos_rf.rds /data
COPY bos_rf_score.R /data
WORKDIR /data

# plumb and run server
EXPOSE 8000
ENTRYPOINT ["R", "-e", \
    "pr <- plumber::plumb('/data/bos_rf_score.R'); \
    pr$run(host='0.0.0.0', port=8000)"]