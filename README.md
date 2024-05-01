# UAH Temp All

Show all plots from global satellite temperature measurements posted at 
the [Global Temperature Report website](https://www.nsstc.uah.edu/climate/) 
of the University of Alabama Huntsville (UAH) Earth System Science Center.

Raw data is here:

https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt 

Note: **plotly-latest.min.js** is loaded from a CDN. It's fairly large, about
3.5 MB. You could download it to the **js/lib** directory for faster loading
for development, if you want. Modify the `<script>` tag in the HTML files.
The source is https://cdn.plot.ly/plotly-latest.min.js.

## Run it

Run the Python simple HTTP server from project root directory to view the HTML pages

Linux/Mac python3
```shell
python3 -m http.server
```
Linux/Mac python (old)
```shell
python -m SimpleHTTPServer
```
Windows python
```shell
python -m http.server
```
The default port is 8000. View it by going to [localhost:8000](http://localhost:8000) 
in a browser, which will show a directory listing. You can click on the .html 
files to show them. If you want a different port, like 8888, just add the port 
number to the command like this:

Linux/Mac python3
```shell
python3 -m http.server 8888
```

- Access the page in a browser at http://localhost:8888/uah-temp-all.html.
- You can reference everything in the project local directory as subdirectories
  and files under http://localhost:8000.
- Stop the server with Ctrl+C.
- If your changes don't appear, force the browser to refresh from the server.
  In Chrome, use Ctrl+Shift+R (Windows) or Cmd+Shift+R (Mac).

## UAH Temperature Time Series Plot Notes

- You can click on the legend on the right to display or hide specific plots,
  like the Southern Hemisphere temperature plot.
- You can load the page with specific plots displayed by using URL queries.
  For example, try:

```shell
http://localhost:8000/practice-1.html?ga=0&ta&na
```

This turns off the Global Average plot and displays Tropics (All) and Northern
Hemisphere (All) plots. The query parameters are described in the comments for
the uahTempTimeSeries() function.

### URL query parameters to show/hide plots

Example: http://localhost:8000/practice-1.html?ga=0&ta&na

- **ga=0** turns off Global (All), which is displayed by default
- **ta** shows Tropics (All)
- **na** shows Northern Hemisphere (All)

#### Valid Plot Name Parameters

- ga, gl, go = global All, Land, Oceans
- na, nl, no = northern hemisphere All, Land, Oceans
- sa, sl, so = southern hemisphere All, Land, Oceans
- ta, tl, to = tropics All, Land, Oceans
- nxa, nxl, nxo = northern extratropical All, Land, Oceans
- sxa, sxl, sxo = southern extratropical All, Land, Oceans
- npa, npl, npo = northern polar All, Land, Oceans
- spa, spl, spo = southern polar All, Land, Oceans
- us48, us49, aus = US lower 48, US 48 + Alaska, Australia?

## Update the data source .csv files with R scripts
The **noaa_battery_park_ny_meantrend-dates.csv** and **uah-monthly-all.csv**
used by the Plotly Javascript library to generate plots pull data from the NOAA
and UAH websites. To get the latest data, use the .R scripts in the /r directory.

1. Install R from https://cran.rstudio.com/
2. Install RStudio from https://posit.co/download/rstudio-desktop/

You could use an R command console to run the scripts but RStudio is far more
convenient.

In RStudio:

1. File > Open and locate one of the .R files, for example **get-uah-data-all.R**.
2. Run each line of the script by clicking Run (Cmd+Return Mac, Ctrl+Enter Windows).

### Description of process to get data and transform it into the final .CSV

1. Create a custom function called **moveme** to be used to reorder columns later.
   (Functions must load before they are used in the script.)
2. Install the RCurl package and include the RCurl library to use the getURL function.
3. Get the raw data from a URL.
4. Use a RegEx search to remove the descriptive text at the top and/or bottom,
   leaving just the column header names and the columns and rows of data.
5. Convert the text data into data frames that R can manipulate. (Variables, vectors,
   and data frames are removed along the way with **rm()** when they are no longer
   needed.)
6. Create custom column names.
7. Convert the Year and Month columns to a Date column. The date is the first day
   of the month.
8. Remove the Year and Month columns by making a table that is a subset of the original.
9. Move the Date column to be first.
10. Write the .csv file. **You'll have to modify the directory**.

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

[D3 API Reference](https://d3js.org/api)

http://learnjsdata.com/read_data.html

https://www.tutorialsteacher.com/d3js/loading-data-from-file-in-d3js

[Run SimpleHTTPServer to solve CORS error for local files](https://stackoverflow.com/questions/21006647/cannot-import-data-from-csv-file-in-d3)

### Update the UAH Temperature Data Manually

[UAH Temperature data (fixed-length)](https://www.nsstc.uah.edu/data/msu/v6.0/tlt/uahncdc_lt_6.0.txt)

1. read into Excel
2. save as CSV
3. change dates to yyyy-mm-dd format
4. modify header names
5. delete footer
6. save as uahncdc_lt_6.0_monthly.csv
