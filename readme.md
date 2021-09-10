# Future Data Track

## Installation
A. If PostgreSQL will be installed in Docker:
1. Clone this repository
2. cd into `future-data-1`
3. Make sure Docker is installed.
4. Make sure PostgreSQL is installed on Docker, if not yet run `setup_db.sh`.
5. Run `restore_db.sh`.
6. Update Airflow config on `airflow.conn.cfg` and `airflow.var.cfg`.
7. Run `setup.sh`.

B. If PostgreSQL is already installed:
1. Clone this repository
2. cd into `future-data-1`
3. Run `download_restore_db.sh`
4. Restore `schema.sql` and `database.tar` from `backup` to PostgreSQL
5. Run all step from __A.6__

## Deliverables
1. Database Schema (.sql)
    - [Download link](https://storage.googleapis.com/dionricky-static/schema-latest.sql)
2. Database Backup (.tar)
    - [Download link](https://storage.googleapis.com/dionricky-static/database-latest.tar) 

## Progress Tracker
Progress akan dibuat dalam bentuk *summary* setiap 2 minggu sekali, yaitu pada 2 minggu pertama dan 2 minggu terakhir setiap bulan.

Progress dan plan dibuat dalam bentuk checklist beserta Github Issue untuk setiap goals.

Goals yang sudah tercapai akan terlihat sebagai checklist yang dicentang. Goals yang tidak tercapai akan dilimpahkan pada periode selanjutnya namun tidak dihapus pada periode sebelumnya dan tetap mereferensi pada Github Issue yang sama.

### 01-14 Februari 2021
- [x] Mencari dataset ([#1](https://github.com/dion-ricky/future-data/issues/1))
- [x] Setup postgresql ([#4](https://github.com/dion-ricky/future-data/issues/4))
- [x] Buat database dan definisikan relationship ([#5](https://github.com/dion-ricky/future-data/issues/5))
- [x] Buat DWH ([#6](https://github.com/dion-ricky/future-data/issues/6))

### 15-28 Februari 2021
- [x] Buat DWH ([#6](https://github.com/dion-ricky/future-data/issues/6))

### 01-15 Maret 2021
- [x] Membuat 5 Business Question ([#3](https://github.com/dion-ricky/future-data/issues/3))
- [x] Eksplor pakai metabase utk mencari BQ

### 16-31 Maret 2021
- [x] Membuat 5 Business Question ([#3](https://github.com/dion-ricky/future-data/issues/3))
- [x] Rancang dan eksekusi ETL dimension table ([#8](https://github.com/dion-ricky/future-data/issues/8))
- [x] Metabase map visualization transformation ([#10](https://github.com/dion-ricky/future-data/issues/10))

### 01-15 April 2021
- [x] Menemukan 3 Business Question ([#3](https://github.com/dion-ricky/future-data/issues/3))
- [x] Membuat warehouse di metabase utk [BQ](https://github.com/dion-ricky/future-data/issues/3#issuecomment-809860470)
- [x] Setup metabase
- [x] Konfigurasi GeoJSON Indonesia for visualization

### 16 - 30 April 2021
- [x] Redo OLTP database
- [x] Clean up warehouse ETL on talend
- [x] Redo warehouse on date_dim
- [x] Dokumentasikan rancangan warehouse
- [x] Add time_dim to warehouse
- [x] Metabase recheck analysis after warehouse redoing
- [x] Install psycopg2 for Postgres driver ([link](https://www.psycopg.org/))
- [x] Add parent/master category ([#13](https://github.com/dion-ricky/future-data/issues/13))
- [x] Apply SCD 2 to Feedback dimension

### 1-15 Mei 2021
- [x] Continue ETL of facts

### 16-31 Mei 2021
- [x] Redo project planning ([#14](https://github.com/dion-ricky/future-data/issues/14))

### 1-15 Juni 2021
- [x] Menulis analisis untuk Business Question #1 ([#15](https://github.com/dion-ricky/future-data-1/issues/15))

### 16-30 Juni 2021
- [x] Jumlah seller per provinsi ([#15](https://github.com/dion-ricky/future-data-1/issues/15))
- [x] Pengaruh foto terhadap penjualan produk ([#16](https://github.com/dion-ricky/future-data-1/issues/16))
- [x] Pengaruh voucher terhadap feedback ([#17](https://github.com/dion-ricky/future-data-1/issues/17))
- [x] Pengaruh keterlambatan pengiriman terhadap feedback ([#18](https://github.com/dion-ricky/future-data-1/issues/18))
- [x] Biaya tarif pengiriman per kg pada setiap kota/provinsi ([#19](https://github.com/dion-ricky/future-data-1/issues/19))

### 1-15 Juli 2021
- [x] Prepare Jupyter environment
- [x] Created setup.sh for easier environment installation
- [x] Reinstall all env on remote because of connectivity problem
- [x] Reinstall all env on local as a backup

### 16-31 Juli 2021
- [x] K-Means clustering for MLv1
- [x] Agglomerative hierarchical clustering for MLv1

### 01-15 Agustus 2021
- [x] DBSCAN clustering for MLv1 (Ran into problem not enough memory)
- [x] SVR, SGD, MLP for sales prediction

### 16-31 Agustus 2021
- [x] Hyperparameter tuning for unsupervised model
- [x] Hyperparameter tuning for supervised model
- [x] Prepare powerpoint
- [x] Write blog post
- [x] Finalize project deliverables
