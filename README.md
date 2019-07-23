
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Fundamental Tidy Data Science in R

## Konfigurasi git

``` bash
git config --global user.name "Nama Anda"
git config --global user.email "Email Anda"
```

## Pemasangan paket

``` r
install.packages("devtools")
devtools::install_deps()
```

``` r
devtools::load_all()
tidyds::check_deps()
```

## Struktur direktori

    #> .
    #> ├── data-raw
    #> │   ├── anggaran-dinkes-2013.csv
    #> │   ├── anggaran-dinkes-2014.csv
    #> │   ├── anggaran-dinkes-2015.csv
    #> │   ├── anggaran-dinkes-2016.csv
    #> │   ├── anggaran-dinkes-2017.csv
    #> │   ├── anggaran-dinkes-2018.csv
    #> │   ├── Dago.csv
    #> │   ├── Gedebage.csv
    #> │   ├── Pajajaran.csv
    #> │   ├── prep-datasets.R
    #> │   ├── roster.xlsx
    #> │   ├── udara_bandung.xlsx
    #> │   └── Ujungberung.csv
    #> ├── DESCRIPTION
    #> ├── inst
    #> │   └── datavis
    #> │       ├── global.R
    #> │       ├── server.R
    #> │       └── ui.R
    #> ├── LICENSE
    #> ├── man
    #> │   ├── check_deps.Rd
    #> │   ├── figures
    #> │   │   └── README-pressure-1.png
    #> │   └── run_datavis.Rd
    #> ├── NAMESPACE
    #> ├── R
    #> │   ├── check_deps.R
    #> │   └── run_datavis.R
    #> ├── README.md
    #> ├── README.Rmd
    #> ├── tidyds.Rproj
    #> └── vignettes
    #>     ├── m1_essentials.Rmd
    #>     ├── m2_data-import.Rmd
    #>     ├── m3_tidy-data-carpentry.Rmd
    #>     ├── m4_data-visualisation.Rmd
    #>     ├── m5_modeling-1.Rmd
    #>     ├── m6_modeling-2.Rmd
    #>     ├── m7_shiny-1.Rmd
    #>     └── m8_shiny-2.Rmd
    #> 
    #> 7 directories, 35 files
