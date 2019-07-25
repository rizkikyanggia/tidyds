# Install packages --------------------------------------------------------

remotes::install_github("aswansyahputra/bandungjuara")
install.packages("here")
install.packages("tidyverse")

# Load packages -----------------------------------------------------------

library(bandungjuara)
library(here)
library(tidyverse)
library(tidytext)
library(gutenbergr)

# Anggaran Dinas Kesehatan Kota Bandung -----------------------------------

anggaran_dinkes_raw <-
  cari("anggaran dinas kesehatan") %>%
  impor() %>%
  bind_rows()

anggaran_dinkes <-
  anggaran_dinkes_raw %>%
  mutate(
    program = str_remove_all(program, "Program |\\n") %>% str_to_title(),
    program = str_replace_all(program, "Peningkatanpelayanan", "Peningkatan Pelayanan"),
    program = str_replace_all(program, "Pelayanankesehatan", "Pelayanan Kesehatan"),
    program = str_replace_all(program, "Peningkatandan", "Peningkatan Dan "),
    program = str_replace_all(program, "Danpemberdayaan", "Dan Pemberdayaan"),
    program = str_replace_all(program, "Puskemas", "Puskesmas"),
    program = str_replace_all(program, "Klb", "Kejadian Luar Biasa"),
    program = str_replace_all(program, "Blud", "Badan Layanan Usaha Daerah"),
    program = str_replace_all(program, "Sdm", "SDM"),
    program = str_replace_all(program, "Dan", "dan"),
    program = str_replace_all(program, "\\s-\\s\\s", ", "),
    program = str_replace_all(program, "\\s\\s", " "),
    program = str_replace_all(program, "/\\s", "/"),
    serapan = realisasi/anggaran
  ) %>%
  select(tahun, everything(), -skpd, -catatan, -persentase_serapan) %>%
  arrange(tahun, program)

anggaran_dinkes %>%
  mutate(id = paste0("anggaran-dinkes-", tahun)) %>%
  group_by(id) %>%
  group_walk(~write_csv(.x, paste0(here("data-raw"), "/", .y$id, ".csv")))

# Kualitas udara Kota Bandung ---------------------------------------------

udara_bandung_raw <-
  cari("udara") %>%
  impor() %>%
  bind_rows()

udara_bandung_raw %>%
  mutate(station = coalesce(stasiun, statsiun)) %>%
  rename(day = waktu) %>%
  select(-stasiun, -statsiun) %>%
  group_by(station) %>%
  group_walk(~write_csv(.x, paste0(here("data-raw"), "/", .y$station, ".csv")))

vroom::vroom(fs::dir_ls(path = "data-raw", regexp = "*.csv")[1:4], id = "station") %>%
  dplyr::mutate(station = gsub(pattern = "\\.csv$", "", basename(station))) %>%
  readr::write_csv("data-raw/udara_bandung.csv")

# Dirty excel file (from janitor) -----------------------------------------

download.file("https://github.com/sfirke/janitor/raw/master/dirty_data.xlsx", here("data-raw", "roster.xlsx"))


# UN SMP Kota Bandung -----------------------------------------------------

un_smp_raw <- cari("UN SMP") %>%
  impor()

un_smp <-
  un_smp_raw %>%
  bind_rows(.id = "id") %>%
  transmute(
    tahun = str_extract(id, "\\d{4}"),
    status = if_else(str_detect(id, "Swasta"), "Swasta", "Negeri"),
    nama_sekolah = coalesce(nama_satuan_pendidikan, nama_satuan),
    jumlah_peserta = jumlah_peserta,
    bahasa_indonesia = bahasa_indonesia,
    bahasa_inggris = bahasa_inggris,
    matematika = matematika,
    ipa = ipa
  )

un_smp %>%
  write_csv(here("data-raw", "un_smp.csv"))

# Sherlock Holmes ---------------------------------------------------------
sherlock_raw <- gutenberg_download(1661)

sherlock <- sherlock_raw %>%
  mutate(
    story = if_else(str_detect(text, "ADVENTURE"),
                    text,
                    NA_character_),
    story = str_remove_all(story, "^ADVENTURE "),
    text = na_if(text, "")
  ) %>%
  fill(story) %>%
  filter(story != "THE ADVENTURES OF SHERLOCK HOLMES") %>%
  select(story, text)

sherlock %>%
  write_csv(here("data-raw", "sherlock.csv"))


tidy_sherlock <- sherlock %>%
  group_by(story) %>%
  unnest_tokens(word, text) %>%
  ungroup() %>%
  anti_join(stop_words) %>%
  count(story, word, sort = TRUE)

sherlock_dtm <- tidy_sherlock %>%
  cast_dtm(story, word, n)

sherlock_dtm

sherlock_lda <- LDA(sherlock_dtm, k = 6)

sherlock_lda %>%
  tidy() %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  mutate(topic = paste0("Topic ", topic),
         term = reorder_within(term, beta, topic)) %>%
  ggplot(aes(term, beta, fill = as.factor(topic))) +
  geom_col(alpha = 0.8, show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free_y") +
  coord_flip() +
  scale_x_reordered() +
  labs(x = NULL, y = expression(beta),
       title = "Highest word probabilities for each topic",
       subtitle = "Different words are associated with different topics")

sherlock_lda %>%
  tidy(matrix = "gamma") %>%
  group_by(document) %>%
  top_n(1, gamma)

sherlock_lda %>%
  tidy(matrix = "gamma") %>%
  count(story = document, topic, sort = TRUE)

sherlock_lda %>%
  tidy(matrix = "gamma") %>%
  ggplot(aes(x = gamma, fill = factor(topic))) +
  geom_histogram() +
  facet_wrap(~document)

sherlock_lda %>%
  augment(data = sherlock_dtm) %>%
  count(story = document, .topic, sort = TRUE) %>%
  arrange(.topic)

sherlock_lda %>%
  tidy()
