library('rvest')

# This project is about demonstrating basic webscraping techniques in R
# the IMDb top 100 feature films will be scraped and converted into a tidy format
# it is based upon the tutorial found here https://www.analyticsvidhya.com/blog/2017/03/beginners-guide-on-web-scraping-in-r-using-rvest-with-hands-on-knowledge/

url <- 'https://www.imdb.com/search/title?count=100&release_date=2017,2017&title_type=feature'

webpage <- read_html(url)

# the webpage is scraped for the following fields:
# * Rank
# * Title
# * Description
# * Runtime
# * Genre
# * Rating
# * Metascore
# * Votes
# * Gross_Earning_in_Mil
# * Director
# * Actor

# The scraping is done with the help of CSS selectors. An easy way to get the CSS selectors for the fields we want is to use the
# following chrome extension: https://chrome.google.com/webstore/detail/selectorgadget/mhjhnkcfbdhnjickkkdbjoemdmbfginb

html_selector_list<- list()
movies_df<-data.frame()

html_selector_list[[ 'Rank' ]] <- '.text-primary'
html_selector_list[[ 'Title' ]] <- '.lister-item-header a'
html_selector_list[[ 'Description' ]] <- '.text-muted'
html_selector_list[[ 'Runtime' ]] <- '.runtime'
html_selector_list[[ 'Genre' ]] <- '.genre'
html_selector_list[[ 'Rating' ]] <- '.ratings-imdb-rating strong'
html_selector_list[[ 'Metascore' ]] <- '.ratings-metascore'
html_selector_list[[ 'Votes' ]] <- '.sort-num_votes-visible span:nth-child(2)'
html_selector_list[[ 'Gross_Earning_in_Mil' ]] <- '.ghost~ .text-muted+ span'
html_selector_list[[ 'Director' ]] <- '.text-muted+ p a:nth-child(1)'
html_selector_list[[ 'Actor' ]] <- '.lister-item-content .ghost+ a'

html_selector_list

for(key in names(html_selector_list)){
  selector <-  html_selector_list[[key]]
  print(paste("Extracting data for column ", key, " with selector ", selector, sep = ""))
  data_html <- html_nodes(webpage, selector)
  text_data <- html_text(data_html)
  cbind(movies_df, text_data)
}

head(movies_df)
