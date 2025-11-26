# I4R Replication Games in Amsterdam, July 2025.

Team members: Valentin Klotzbücher, Tim Krieger, Marco Wallner

Replication of "'They Never had a Chance': Unequal Opportunities and Fair Redistributions Get access Arrow", by Lu Dong, Lingbo
Huang, and Jaimie W Lien (*The Economic Journal*, Volume 135, Issue 667, April 2025, Pages 914–942, https://doi.org/10.1093/ej/ueae099)

## Repository layout

The repository is split between the cleaned-up replication package that we are actively working in and the untouched RAW package as it was distributed by the original authors.

- `3-replication-package/` – the working copy of the replication package:
  - `code/` containing the Stata do-files. Run order follows the numeric prefixes: start with `0PathSetup.do`,
    clean the data with the `1DataClean_*` scripts, and then run `worker_main.do` or `spectator_main.do`/`spectator_vary.do`
    to reproduce the experimental results.
  - `data/raw/` with the original CSV/Excel files from the experiment, `data/temp/` for intermediate exports,
    and `data/processed/` that stores the cleaned datasets created by the scripts above. NOT INCLUDED IN THE REPO - PLEASE DOWNLOAD THE DATA FROM THE ORIGINAL STUDY
  - `output/` where all tables and figures produced by the main do-files end up.
- `RAW_3-replication-package/` – the untouched download (except adjusted paths), including the original code, data, documentation PDF, and output for auditing.
- `compare.do` – script to diff our processed data against the raw package.
- `Report_KKW.xlsx` – spreadsheet where we collect the headline replication statistics. The Excel export included here summarizes all core treatment-effect and scenario-effect estimates (OLS and ordered-logit) needed for cross-study meta-analysis. It intentionally excludes auxiliary analyses such as the gamma GLM, information-treatment models, structural parameter estimates, and non-parametric tests.
- `Report_KKW.*` – LaTeX source, bibliography (`biblio.bib` and `.sav`), and compiled PDF.
- `Paper/` – folder with DHL paper and SI

