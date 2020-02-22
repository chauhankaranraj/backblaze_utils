#! /usr/bin/sh

# backblaze q1 2019 dataset links
DATASET_URLS=(
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q1_2019.zip"
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q2_2019.zip"
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q3_2019.zip"
    "https://f001.backblazeb2.com/file/Backblaze-Hard-Drive-Data/data_Q4_2019.zip"
)

for url in "${DATASET_URLS[@]}"; do
    # download
    echo "==> Downloading file from $url ..."
    fname=$(wget -nv $url 2>&1 | cut -d\" -f2)

    # extract
    echo "==> Unzipping downloaded file \"$fname\" ..."
    # NOTE: assumes the following
    # 1) first directory to be created will be the dataset directory
    # 2) unzip will display that on the second line
    # 3) dir name will be exactly after ": " and right before "/"
    data_dir=$(unzip -o $fname | awk 'NR==2' | cut -d ":" -f 2 | sed 's/.$//' | cut -c 2- )

    # remove non-useful stuff extracted
    rm -rf __MACOSX

    # convert csv's to parquet's
    echo "==> Converting csv's to parquet's ..."
    pipenv run python csv2parquet.py --dirname $data_dir

    # # compress parquet files, parallelize across all cores
    echo "==> Compressing parquet dataset directory ..."
    tar -cf - "${data_dir}_parquet" | xz -9v --threads=`nproc` -c - > "${data_dir}.tar.xz"
done
