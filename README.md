# Backblaze Hard Drive Data Utils

## Introduction

Backblaze, Inc. has been collecting and graciously publishing some of their hard drive data [here](https://www.backblaze.com/b2/hard-drive-test-data.html). However, the dataset sizes can be considerably large, which makes it difficult to share it with people who don't have the best network resources.

This repo contains scripts to minimize the size of the datasets so that they are easier to share. The scripts simply download the data (assuming host has good internet access), converts csv's to parquet's, and then compresses it with maximum level of compression, to send it over to the recepient (who does not have good internet access).


## Citation

I neither own nor take responsibility for the data. I hereby cite Backblaze, Inc. as the source of this data. Their request about data usage is listed [below](#how-you-can-use-the-data). I ask that anyone who uses or contributes to any of the work in this repo follow these same guidelines.

### How You Can Use the Data

You can download and use this data for free for your own purpose, all we ask is three things

1. You cite Backblaze as the source if you use the data,
2. You accept that you are solely responsible for how you use the data
3. You do not sell this data to anyone, it is free.
