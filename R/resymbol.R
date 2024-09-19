library(readxl)
library(tidyr)

#' Update Gene Symbols
#' @description
#' Using local gene files to update symbols. Only unique symbols will be returned.
#' @details
#' Old symbols --> symbols not included in the newest symbol list --> symbols that matches only one time with previous/alias symbol --> matched new symbols for the remaining. The input symbols that didn't match the new symbol column in hgnc_complete_set.txt will be regarded as old symbols. Old symbols that matches only one time in first previous symbols list and if no matches then the alias symbols list will be used for matching new symbols.
#' @author Tu Jihao
#'
#' @param hgnc_complete_set A dataframe object import from file which can be downloaded from HGNC genenamesorg archived datasets at https://ftp.ebi.ac.uk/pub/databases/genenames/hgnc/archive/.
#' @param nameold A vector of symbols needed to be checked
#'
#' @return A dataframe including replaced symbols. old: symbols input. newnames: returned new symbols. prev/aliaschange: newnames searched by previous/alias symbol list. changenumber: how many new symbols did the old symbol matched. newname_to_use: unique updated symbol list
#' @export
#' @examples hgnc_complete_set <- read.delim("hgnc_complete_set.txt")
#' nameold = c("TP53","CD206")
#' nametotal = resymbol(hgnc_complete_set,nameold)
resymbol = function(hgnc_complete_set = hgnc_complete_set,nameold){
  length1 = strsplit(hgnc_complete_set$alias_symbol,"\\|")
  length1 = unlist(lapply(length1,length))
  dataalias <- hgnc_complete_set[,"alias_symbol",drop = F] %>%
    separate(col = alias_symbol, into = paste0("alias_name_", 1:max(length1)), sep = "\\|", extra = "merge", fill = "right")

  length1 = strsplit(hgnc_complete_set$prev_symbol,"\\|")
  length1 = unlist(lapply(length1,length))
  dataprev <- hgnc_complete_set[,"prev_symbol",drop = F] %>%
    separate(col = prev_symbol, into = paste0("prev_name_", 1:max(length1)), sep = "\\|", extra = "merge", fill = "right")

  ifchange = rep(F,length(nameold))
  aliaschange = rep(NA,length(nameold))
  prevchange = rep(NA,length(nameold))
  prenumber = rep(NA,length(nameold))
  aliasnumber = rep(NA,length(nameold))
  newname = rep(NA,length(nameold))
  hgncsingle = hgnc_complete_set[,c("symbol","alias_symbol","prev_symbol")]
  for (i in 1:length(nameold)) {
    if (nameold[i]%in%hgnc_complete_set$symbol) {
      ifchange[i] = F
    }
    if (!nameold[i]%in%hgnc_complete_set$symbol) {
      x1 = (dataalias==nameold[i]) %>% as.vector() %>% na.omit() %>% sum()
      x2 = (dataprev==nameold[i])%>% as.vector() %>% na.omit() %>% sum()
      prenumber[i] = x2
      if (x2 == 1) {
        whereisi = which(dataprev == nameold[i],arr.ind = T)
        beforechange = hgncsingle$symbol[whereisi[1]]
        prevchange[i] = beforechange
        if (!beforechange%in%nameold) {
          newname[i] = beforechange
          ifchange[i] = T
        }
      }
      aliasnumber[i] = x1
      if (x2 < 1 & x1 == 1) {
        whereisi = which(dataalias == nameold[i],arr.ind = T)
        beforechange = hgncsingle$symbol[whereisi[1]]
        aliaschange[i] = beforechange
        if (!beforechange%in%nameold) {
          newname[i] = beforechange
          ifchange[i] = T
        }
      }

    }
  }

  nametotal = data.frame(old = nameold,newname,ifchange,prevchange,prenumber,aliaschange,aliasnumber)
  nametotal$newname_to_use = ifelse(ifchange,nametotal$newname,nametotal$old)
  nametotal$newname_to_use = ifelse(duplicated(nametotal$newname_to_use)|duplicated(nametotal$newname_to_use,fromLast = T),nametotal$old,nametotal$newname_to_use)
  return(nametotal)
}
