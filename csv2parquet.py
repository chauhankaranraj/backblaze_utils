import argparse
import dask.dataframe as dd
from os.path import join as ospj


if __name__ == "__main__":
    # script args. basically just to get name of dataset directory
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-d", "--dirname",
        type=str,
        required=True,
        help="Name of the dataset directory containing all the csv's. E.g. drive_stats_2019_Q1"
    )
    args = parser.parse_args()

    # read in csv's
    df = dd.read_csv(ospj(args.dirname, '*.csv'), assume_missing=True)

    # save as parquet
    df.to_parquet(f"{args.dirname}_parquet")
