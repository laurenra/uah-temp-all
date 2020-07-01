# UAH Temp All

Show all plots from global satellite temperature measurements posted at 
the [Global Temperature Report website](https://www.nsstc.uah.edu/climate/) 
of the University of Alabama Huntsville (UAH) Earth System Science Center.

Raw data is here:

https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt 

**Note:** plotly-latest.min.js is copied to the **js/lib** directory for
fast loading. It is **not** included in the project so you will have to
get it from https://cdn.plot.ly/plotly-latest.min.js.

## Run it

Run Python simple HTTP server from root of project directory:

(Linux/Mac)
```shell
python3 -m http.server 8888
```
(Linux/Mac)
```shell
python -m SimpleHTTPServer 8888
```
(Windows)
```shell
python -m http.server 8888
```

- Access the page in a browser at http://localhost:8888/uah-temp-all.html.
- You can reference everything in the project local directory as
subdirectories and files under localhost:8000.
- Stop the server with Ctrl+C.

## Create deployment tarball

To simplify deploying to a web server, use the **make-deployment-tar** 
script to create a tarball with all the files required.

1\. Run the script. 

```shell script
./make-deployment-tar
```

2\. Copy **uah-temp-all.tar** to the server.

3\. Extract the files.

```shell script
tar xvf uah-temp-all.tar
```

Update the script when you add files to the project that are 
required for deployment. 

## Tutorials and Reference

[Plotly JavaScript Reference and Examples](https://plot.ly/javascript/)

[Plotly Time Series in JavaScript](https://plot.ly/javascript/time-series/)

[Plotly JavaScript Function Reference](https://plot.ly/javascript/plotlyjs-function-reference/)

[Plotting CSV Data from Ajax Call](https://plot.ly/javascript/ajax-call/)

[D3 API Reference](https://github.com/d3/d3/blob/master/API.md)

http://learnjsdata.com/read_data.html

https://www.tutorialsteacher.com/d3js/loading-data-from-file-in-d3js

[Run SimpleHTTPServer to solve CORS error for local files](https://stackoverflow.com/questions/21006647/cannot-import-data-from-csv-file-in-d3)

## Data

[UAH Temperature data (fixed-length)](https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt)

1. read into Excel
2. save as CSV
3. change dates to yyyy-mm-dd format
4. modify header names
5. delete footer
6. save as uahncdc_lt_6.0_monthly.csv
