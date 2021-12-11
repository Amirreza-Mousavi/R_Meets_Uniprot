#R_Meets_Uniprot Version 1.0
#Written by SeyyedAmirreza Mousavi Majd
#Biostrings package must be installed prior to use.


####Initialization

library(Biostrings)       
setwd("C:/Users/Amirreza/Desktop/Search_Results/") 


####Defining SearchEBI function

searchEBI = function(Bio_database="uniprotkb",
                     Query="OCT4",
                     Result_size=20){
  
dest_file_location=paste0("Uniprot_query_at_",
    as.character(Sys.time()),".txt",
    collapse = ""
    )

dest_file_location=gsub(":","_",dest_file_location)
dest_file_location=gsub("-","_",dest_file_location)
  
####Download an XML file, containing data for the query, saved as text

download.file(url = paste0(
    "https://www.ebi.ac.uk/ebisearch/ws/rest/"
    ,Bio_database,"?query=",Query,
    "&size=",toString(Result_size),
    "&fieldurl=true&format=xml",
    collapse = ""),destfile = dest_file_location)
    
####parse the txt file, to retrieve URL for each result

dat=readLines(dest_file_location)
stidx=unlist(gregexpr2('<fieldURL name="main">',dat))
endidx=unlist(gregexpr2('</fieldURL>',dat))
l=list()

for(i in 1:(length(stidx))){
      s1=subseq(dat,stidx[i],endidx[i]-1)
      s2=subseq(s1,23)
      l=c(l,s2)
}
    

####Return the URLs of the query results

  return(unlist(l))
}


####Defining storeFasta function

storeFasta=function(url_string, sleep_time=0.01){

  Sys.sleep(sleep_time) 

  filename_fa=paste0(subseq(url_string,start = 33),
                     ".fasta",collapse = "")
  fetch_address=paste0(url_string,
                       ".fasta",collapse = "")
  download.file(fetch_address,filename_fa)
  
  cat(filename_fa)
  cat(" ")
  cat("has successfully been downloaded from ")
  cat(fetch_address)
  cat("\n")
}

####EXAMPLE!
S=searchEBI("uniprotkb","OCT4",20)
for(i in 1:20){storeFasta(S[i])}
