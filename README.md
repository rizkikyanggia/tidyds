
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Fundamental Tidy Data Science in R

## Prosedur

1.  Klik tombol **Fork** pada bagian kanan atas
2.  Setelah berhasil silakan klik tombol **Clone or download** (tombol
    berwarna hijau pada bagian kanan)
3.  Pilih prosedur HTTPS dan salin tautan URL yang disediakan
4.  Buka RStudio Anda dan kemudian pilih menu **“File – New Project” **
5.  Pilih opsi **Version Control - Git**
6.  Tempelkan tautan yang telah disalin serta sesuaikan lokasi direktori
    sesuai keinginan Anda
7.  Klik tombol **Create Project**

## Persiapan

Jalankan baris kode berikut untuk mempersiapkan paket-paket yang akan
digunakan selama pelatihan:

``` r
install.packages("devtools")
devtools::install_deps()
devtools::load_all()
tidyds::check_deps()
```

## Struktur direktori

Repositori ini tersusun atas subdirektori, berkas, dan dokumen sebagai
berikut:

    #> .
    #> ├── data
    #> │   ├── un_smp_lm.rda
    #> │   └── un_smp_rf.rda
    #> ├── data-raw
    #> │   ├── anggaran-dinkes-2013.csv
    #> │   ├── anggaran-dinkes-2014.csv
    #> │   ├── anggaran-dinkes-2015.csv
    #> │   ├── anggaran-dinkes-2016.csv
    #> │   ├── anggaran-dinkes-2017.csv
    #> │   ├── anggaran-dinkes-2018.csv
    #> │   ├── content_dev.R
    #> │   ├── Dago.csv
    #> │   ├── Gedebage.csv
    #> │   ├── Pajajaran.csv
    #> │   ├── prep-datasets.R
    #> │   ├── roster.xlsx
    #> │   ├── sherlock.csv
    #> │   ├── udara_bandung.csv
    #> │   ├── udara_bandung.xlsx
    #> │   ├── Ujungberung.csv
    #> │   └── un_smp.csv
    #> ├── DESCRIPTION
    #> ├── inst
    #> │   └── aq
    #> │       ├── global.R
    #> │       ├── server.R
    #> │       └── ui.R
    #> ├── LICENSE
    #> ├── man
    #> │   ├── check_deps.Rd
    #> │   ├── figures
    #> │   │   └── README-pressure-1.png
    #> │   └── run_aq.Rd
    #> ├── NAMESPACE
    #> ├── R
    #> │   ├── check-deps.R
    #> │   └── run-aq.R
    #> ├── README.md
    #> ├── README.Rmd
    #> ├── tidyds.Rproj
    #> └── vignettes
    #>     ├── m1_essentials.Rmd
    #>     ├── m2_data-import.Rmd
    #>     ├── m3_tidy-data-carpentry.Rmd
    #>     └── m4_data-visualisation.Rmd
    #> 
    #> 8 directories, 37 files

## Konfigurasi git

Anda perlu melakukan konfigurasi git agar dapat melakukan prosedur
“Push” dan **Pull** repositori lokal ke repositori daring di GitHub.
Hal ini dapat dilakukan melalui RStudio dengan cara klik menu **“Tools –
Terminal”** dan menjalankan baris kode berikut:

``` bash
git config --global user.email "Email Anda"
git config --global user.name "Nama Anda"
```
