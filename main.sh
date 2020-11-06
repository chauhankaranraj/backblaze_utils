#! /usr/bin/sh

# backblaze q1 2019 dataset links
DATASET_URLS=(
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q1_2020.zip"
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q2_2020.zip"
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q3_2020.zip"
)

for url in "${DATASET_URLS[@]}"; do
    fname=$(echo $url | rev | cut --delimiter \/ -f1 | rev)
    data_dir=$(echo $fname | cut -d. -f1)

    # download
    echo "==> Downloading file $fname from $url ..."
    wget $url -O $fname

    # extract
    echo "==> Unzipping downloaded file $fname into directory $data_dir ..."
    unzip -o $fname -d $data_dir

    # convert csv's to parquet's
    echo "==> Converting csv's in directory $data_dir to parquet's ..."
    pipenv run python csv2parquet.py --dirname $data_dir

    # compress parquet files, parallelize across all cores
    echo "==> Compressing parquet dataset directory ${data_dir}_parquet ..."
    tar -cf - "${data_dir}_parquet" | xz -9v --threads=`nproc` -c - > "${data_dir}.tar.xz"

    # clean up non-essentials
    rm -rf $fname $data_dir "${data_dir}_parquet" __MACOSX

done
