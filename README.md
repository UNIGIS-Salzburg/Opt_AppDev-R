# UNIGIS Salzburg: Application Development - Scripting with R

These learning materials are designed for the UNIGIS distance-learning study programs as part of a module that introduces into Application Development. 

The contents of this module are based on [granolarr](https://sdesabbata.github.io/granolarr/), a *geogGRaphic dAta scieNce, reprOducibLe teAching resouRce in R* by Stefano De Sabbata, University of Leicester. 
**!! important, source changed into [R for Geographic Data Science](https://github.com/sdesabbata/r-for-geographic-data-science)**

In this module, the granolarr materials will be adapted and extended to fit the UNIGIS curriculum and layout of materials. Like the source materials, this work is licensed under the [GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.html).

## Major Revision Branch

### Overview
This branch focuses on the major revision of the course, emphasizing the integration of spatial concepts and tools in R. The objective is to provide a more comprehensive exploration of spatial data, primarily leveraging newer spatial packages in R. This naturally increases the course's workload but ensures students are exposed to the latest tools and techniques in spatial data analysis.

Neat, concise information in: [Geocomputation with R](https://r.geocompx.org/) as well as [Spatial Data Science](https://rspatial.org/index.html)

### Objectives
- Enrich the course content by focusing on applied spatial concepts.
- Explore and integrate newer spatial packages in R.
- Provide hands-on exercises using spatial datasets and solving problems.
- Foster a collaborative environment for students to share findings, challenges, and solutions... -> Discussion Forum and a few more Exercises via collapsible section [>]

### Key Packages and Tools
- Spatial Data: The [**spData**](https://cran.r-project.org/web/packages/spData/index.html) package could be a primary resource for practical exercises. It's actively developed and offers a variety of datasets suitable for our course. For more details, refer to their [**manual**](https://cran.r-project.org/web/packages/spData/spData.pdf).

- Spatial Packages: We'll be focusing on modern spatial packages like [**sf**](https://r-spatial.github.io/sf/), [**terra**](https://rspatial.org/pkg/), [**stars**](https://r-spatial.github.io/stars/), and [**spatstat**](https://cran.r-project.org/web/packages/spatstat/index.html). These packages represent the current state-of-the-art in spatial data handling in R.
  
- Visualization: Packages like [**ggplot2**](https://ggplot2.tidyverse.org/) and [**ggspatial**](https://cran.r-project.org/web/packages/ggspatial/index.html) will be used extensively for spatial data visualization.

- Consider retired packages see: [**evolution blog**](https://r-spatial.org/r/2023/05/15/evolution4.html) and [**spatial blog**](https://cran.r-project.org/web/views/Spatial.html), both reliable source of authors in the spatial R community.

### Chapter Overview
**Note:** high probability of change!

#### Rewrite: Chapter 7: Read and write data
Although, I made a few changes already using httr2 instead of httr. There are a lot of neat functions, we could show the students and make them familiar with other examples. (for an introduction how it may look like, see "example_introduction_packages" directory. (examples will be increased in the future.))

#### Rewrite: Assignment 1
Will not be shown on Github, hence will be sent if needed.

## Added:
## Chapter 10: Spatial Data Structures
this digs deep into spatial data structures, laying the groundwork for understanding the basics and more. It distinguishes between traditional and spatial data structures, exploring vector and raster data structures in detail. The chapter demonstrates how to represent these structures in R using the sf and terra packages as well as in theory, providing a hands-on approach to learning and ventures into advanced topics such as spatial indexing and understanding topological relationships, ensuring a comprehensive grasp of the subject matter. 

## Chapter 11: Spatial Data Wrangling
underscores the crucial role of spatial data wrangling in geoinformatics. It navigates through various aspects such as spatial aggregation, coordinate transformations, raster resampling, and data merging. The chapter addresses common challenges encountered in spatial data wrangling, including handling missing data and cleaning spatial data. Practical exercises and a comprehensive case study are integrated to ensure students can apply the learned techniques effectively, bridging the gap between theory and practice.

## Chapter 12: Spatial Data Manipulation and (Advanced Spatial Statistics?)
This chapter delves deeper, in the nuances between data wrangling and data manipulation in the spatial context. It covers a range of topics from filtering spatial data, performing spatial joins, executing geometric and raster operations, to exploring advanced spatial statistics with **spatstat**. The chapter could also provide insights into point pattern analysis, spatial clustering, and nearest neighbor analysis, offering a rounded perspective on spatial data manipulation and its statistical implications. Additionally, a comparative analysis of different spatial packages is included, allowing students to discern the strengths and weaknesses of each tool within the R ecosystem and in comparison to other open-source ecosystems like Python and computation via compiler...) (We could of course easily branch of the Spatial Statistics into an additional Chapter.. But I think the basics would be very beneficial.)

### Chapters to debate or just quick ideas:
#### Chapter X: "ChatGPT and R":
Has a high probability of changing way faster then state of the art packages or syntax of R language.
- **Consider** creating an innovative lesson on integrating ChatGPT with R.
- **Assess** the **complexity and relevance** of the topic.
- Explore **whether to use ChatGPT or explore alternative technologies**.
- **Determine the required frequency of updates** for the lesson (**Note**: with a high probability that it may require more updates than even the packages.. Main reason why I would debate).
- Although, there are very interesting plugins for programming and data visualizations see GPT-4 (although, so far, Advanced Data Analysis only uses Python - Time of Writing: (11.09.2023) - and the data analysis tool is for paying customers.)

#### Chapter X: "Machine Learning with Spatial Data"
Very debatable, ... ML workloads normally need a lot of foundation in mathematical understanding...
- Introduce machine learning techniques tailored for spatial data.
- Discuss spatial autocorrelation and its implications in predictive modeling.

#### Chapter X: "Web Applications for Spatial Data"
- Introduce the concept of creating web applications to showcase spatial analyses.
- Discuss the importance of interactive web maps and dashboards.
- Explore the [**shiny**](https://shiny.posit.co/) package and its integration with spatial packages.

#### Chapter X: "Spatial Data Visualization Techniques"
- Dives deeper into advanced visualization techniques specific to spatial data.
- Explore 3D visualizations, interactive maps, and animation of spatial-temporal data.
- Introduce packages like [**mapview**](https://r-spatial.github.io/mapview/), [**leaflet**](https://rstudio.github.io/leaflet/), and [**rayshader**](https://www.rayshader.com/).

#### Chapter X: "Spatial Network Analysis"
- Dives into the world of spatial networks, such as transportation and social networks.
- Discuss shortest path, network flow, and centrality measures in a spatial context.
- Explore packages like [**sfnetworks**](https://luukvdmeer.github.io/sfnetworks/).

#### Chapter X: "Time-Series Analysis with Spatial Data"
- Discuss the importance of temporal data in spatial analyses.
- Introduce techniques to analyze spatial data that changes over time.

#### Chapter X: Integrating Remote Sensing Data in R
- Introduce the concept of remote sensing and its importance in spatial analyses.
- Discuss the processing and analysis of satellite imagery.
- Explore packages like **stars**, and tools for specific satellite data.

#### Chapter X: TDD (Test-Driven-Development)
(Could actually be quite beneficial!)
- Introduction to TDD: What it is, How it works
- Testing Scopes (Unit, Integration, Blackbox-testing)
- When to use it ..

### folder: example_introduction_packages
- In this folder, I will add more and more examples, on how we might use the packages / libraries for examples. And what they do essentially. (will be modified into .rmd files.)

### Automation Tools
- [packagechecker.R](https://github.com/UNIGIS-Salzburg/Opt_AppDev-R/blob/major-revision/packagechecker.R) - to lookup the packages used in the .RMD files
- [broken_links.py](https://github.com/Secreez/task_scripts/tree/master/python/broken_links) - to check for any broken links in the .RMD files.
