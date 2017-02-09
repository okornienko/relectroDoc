#! /bin/sh
#
# shell script to deploy relectroDoc to web server
# place this script in the crontab
#
## m h  dom mon dow   command
##0 8,12,18 * * * /home/kevin/repo/relectroDoc/deploy/deploy_relectroDoc.sh


## get latest relectro
cd /home/kevin/repo/relectro
git pull
cd ..
R CMD build relectro
R CMD INSTALL relectro

## get latest relectroDoc
cd /home/kevin/repo/relectroDoc
git pull

## render the book from files
cd /home/kevin/repo/relectroDoc
echo "library(relectro)
library(methods)
bookdown::render_book(\"index.Rmd\")" > /tmp/cmd
cat /tmp/cmd
R CMD BATCH /tmp/cmd

## copy the html files to the web space
cd /home/kevin/repo/relectroDoc/_book
cp -a * /var/www/html/


