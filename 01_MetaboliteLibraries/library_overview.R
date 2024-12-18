# ==============================================================================
# Setup
# ==============================================================================
# load required libraries ------------------------------------------------------
library(tidyverse)
library(ComplexHeatmap)
library(rcdk)
library(classyfireR)
library(treemapify)

# custom functions -------------------------------------------------------------
# calculate xlogP from SMILES
calc_xlogP <- function(x) {
  
  mol <- parse.smiles(x)[[1]]
  
  if(is.null(mol)) {
    return(NA_real_)
  } 
  
  get.xlogp(mol)
  
}

# calculate exact mass from SMILES
calc_exact_mass <- function(x) {
  mol <- parse.smiles(x)[[1]]
  
  if(is.null(mol)) {
    return(NA_real_)
  } 
  
  exact_mass <- get.exact.mass(mol)
  return(exact_mass)
}

# perform ClassyFire from InChIKey
classyfi <- function(x) {
  
  Sys.sleep(5)
  
  # get classifiction from ClassyFire server
  classification_result <- get_classification(x)
  
  # check results and retrieve results
  if(is.null(classification_result)) {
    
    kingdom <- NA
    superclass <- NA
    class <- NA
    subclass <- NA
    level5 <- NA
    level6 <- NA
    
  } else {
    
    kingdom <- paste0(classification_result@classification$Classification[1],
                      " (", classification_result@classification$CHEMONT[1], ")")
    superclass <- paste0(classification_result@classification$Classification[2],
                         " (", classification_result@classification$CHEMONT[2], ")")
    class <- paste0(classification_result@classification$Classification[3],
                    " (", classification_result@classification$CHEMONT[3], ")")
    subclass <- paste0(classification_result@classification$Classification[4],
                       " (", classification_result@classification$CHEMONT[4], ")")
    level5 <- paste0(classification_result@classification$Classification[5],
                     " (", classification_result@classification$CHEMONT[5], ")")
    level6 <- paste0(classification_result@classification$Classification[6],
                     " (", classification_result@classification$CHEMONT[6], ")")
    
  }
  
  # combine different results in columns
  bind_cols(classyfire.kingdom = kingdom,
            classyfire.superclass = superclass,
            classyfire.class = class,
            classyfire.subclass = subclass,
            classyfire.level5 = level5,
            classyfire.level6 = level6)
  
}

# ==============================================================================
# read data
# ==============================================================================
# read Sigma libaries ----------------------------------------------------------
aapmls <- read_tsv("01_MetaboliteLibraries/20241218_AAPMLS.tsv")
bacsmls <- read_tsv("01_MetaboliteLibraries/20241218_BACSMLS.tsv")
famls <- read_tsv("01_MetaboliteLibraries/20241218_FAMLS.tsv")
gutmls <- read_tsv("01_MetaboliteLibraries/20241218_GUTMLS.tsv")
msmls <- read_tsv("01_MetaboliteLibraries/20241218_MSMLS.tsv")
oamls <- read_tsv("01_MetaboliteLibraries/20241218_OAMLS.tsv")
phytomls <- read_tsv("01_MetaboliteLibraries/20241218_PHYTOMLS.tsv")

# read Agilent pesticide library -----------------------------------------------
pest <- read_tsv("01_MetaboliteLibraries/20241218_AgilentPesticide.tsv")

# read MetaSci library ---------------------------------------------------------
metasci <- read_tsv("01_MetaboliteLibraries/20241218_MetaSci.tsv")

# read BileOmix library --------------------------------------------------------
bileomix <- read_tsv("01_MetaboliteLibraries/20241218_BileOMix.tsv")

# ==============================================================================
# create upset plot
# ==============================================================================
# create list with InChIKey ----------------------------------------------------
upset_list <- list(aapmls = aapmls$InChIKey[which(!is.na(aapmls$InChIKey))],
                   bacsmls = bacsmls$InChIKey[which(!is.na(bacsmls$InChIKey))],
                   famls = famls$InChIKey[which(!is.na(famls$InChIKey))],
                   gutmls = gutmls$InChIKey[which(!is.na(gutmls$InChIKey))],
                   msmls = msmls$InChIKey[which(!is.na(msmls$InChIKey))],
                   oamls = oamls$InChIKey[which(!is.na(oamls$InChIKey))],
                   phytomls = phytomls$InChIKey[which(!is.na(phytomls$InChIKey))],
                   pest = pest$InChIKey[which(!is.na(pest$InChIKey))],
                   metasci = metasci$InChIKey[which(!is.na(metasci$InChIKey))],
                   bileomix = bileomix$InChIKey[which(!is.na(bileomix$InChIKey))])

# create combination matrix ----------------------------------------------------
upset_matrix <- make_comb_mat(upset_list)

# create UpSet plot ------------------------------------------------------------
UpSet(upset_matrix,
      top_annotation = upset_top_annotation(upset_matrix,
                                            add_numbers = TRUE),
      right_annotation = upset_right_annotation(upset_matrix,
                                                add_numbers = TRUE))

# ==============================================================================
# make logP and mass overview
# ==============================================================================
# calculate logP for all metabolites -------------------------------------------
# Sigma libraries
aapmls <- aapmls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
bacsmls <- bacsmls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
famls <- famls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
gutmls <- gutmls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
msmls <- msmls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
oamls <- oamls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))
phytomls <- phytomls %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))

# Agilent Pesticide library
pest <- pest %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))

# MetaSci library
metasci <- metasci %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))

# BileOmix library
bileomix <- bileomix %>% mutate(logP = unlist(lapply(.$SMILES, calc_xlogP)))

# combine into data frame for plotting -----------------------------------------
bind_rows(bind_cols(xlogP = aapmls$logP,
                    library = "aapmls"),
          bind_cols(xlogP = bacsmls$logP,
                    library = "bacsmls"),
          bind_cols(xlogP = famls$logP,
                    library = "famls"),
          bind_cols(xlogP = gutmls$logP,
                    library = "gutmls"),
          bind_cols(xlogP = msmls$logP,
                    library = "msmls"),
          bind_cols(xlogP = oamls$logP,
                    library = "oamls"),
          bind_cols(xlogP = phytomls$logP,
                    library = "phytomls"),
          bind_cols(xlogP = pest$logP,
                    library = "pest"),
          bind_cols(xlogP = metasci$logP,
                    library = "metasci"),
          bind_cols(xlogP = bileomix$logP,
                    library = "bileomix")) %>% 
  ggplot(aes(x = xlogP)) +
  geom_histogram(binwidth = 1) +
  geom_density() +
  facet_grid(library ~ ., scales = "free_y") +
  theme_bw()
     
# calculate mass for all metabolites -------------------------------------------
# Sigma libraries
aapmls <- aapmls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
bacsmls <- bacsmls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
famls <- famls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
gutmls <- gutmls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
msmls <- msmls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
oamls <- oamls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))
phytomls <- phytomls %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))

# Agilent Pesticide library
pest <- pest %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))

# MetaSci library
metasci <- metasci %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))

# BileOmix library
bileomix <- bileomix %>% mutate(mass = unlist(lapply(.$SMILES, calc_exact_mass)))

# combine into data frame for plotting -----------------------------------------
bind_rows(bind_cols(mass = aapmls$mass,
                    library = "aapmls"),
          bind_cols(mass = bacsmls$mass,
                    library = "bacsmls"),
          bind_cols(mass = famls$mass,
                    library = "famls"),
          bind_cols(mass = gutmls$mass,
                    library = "gutmls"),
          bind_cols(mass = msmls$mass,
                    library = "msmls"),
          bind_cols(mass = oamls$mass,
                    library = "oamls"),
          bind_cols(mass = phytomls$mass,
                    library = "phytomls"),
          bind_cols(mass = pest$mass,
                    library = "pest"),
          bind_cols(mass = metasci$mass,
                    library = "metasci"),
          bind_cols(mass = bileomix$mass,
                    library = "bileomix")) %>% 
  ggplot(aes(x = mass)) +
  geom_histogram(binwidth = 10) +
  geom_density() +
  facet_grid(library ~ ., scales = "free_y") +
  theme_bw()        

# ==============================================================================
# get ClassyFire classes
# ==============================================================================
# perform classification -------------------------------------------------------
# Sigma libraries
aapmls <- bind_cols(aapmls, map_dfr(aapmls$InChIKey, classyfi))
bacsmls <- bind_cols(bacsmls, map_dfr(bacsmls$InChIKey, classyfi))
famls <- bind_cols(famls, map_dfr(famls$InChIKey, classyfi))
gutmls <- bind_cols(gutmls, map_dfr(gutmls$InChIKey, classyfi))
msmls <- bind_cols(msmls, map_dfr(msmls$InChIKey, classyfi))
oamls <- bind_cols(oamls, map_dfr(oamls$InChIKey, classyfi))
phytomls <- bind_cols(phytomls, map_dfr(phytomls$InChIKey, classyfi))

# Agilent Pesticide library
pest <- bind_cols(pest, map_dfr(pest$InChIKey, classyfi))

# MetaSci library
metasci <- bind_cols(metasci, map_dfr(metasci$InChIKey, classyfi))

# BileOmix library
bileomix <- bind_cols(bileomix, map_dfr(bileomix$InChIKey, classyfi))

# create treemaps --------------------------------------------------------------
# Sigma libraries
aapmls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

bacsmls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

famls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

gutmls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

msmls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

oamls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

phytomls %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

# Agilent Pesticide library
pest %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

# MetaSci library
metasci %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()

# BileOmix library
bileomix %>% 
  count(.$classyfire.subclass) %>% 
  ggplot(aes(area = n, fill = `.$classyfire.subclass`)) +
  geom_treemap() +
  theme_bw()