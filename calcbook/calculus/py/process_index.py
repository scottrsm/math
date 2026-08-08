#!/usr/bin/env python3
import sys
import numpy as np
import pandas as pd

# The index file
file = "mainindex.idx"

# Read in the index file.
df = pd.read_csv(file, header=None, names=["phrase", "lnum"])

# Group line numbers by phrases...
gs = (
    df.groupby("phrase")["lnum"]
      .agg(lambda s: ",".join(map(str, sorted(set(s.astype(int))))))
      .sort_index(key=lambda idx: idx.str.lower())
)

# Get the number of phrases.
N = np.size(gs)

# Create the first of two column index.
print(r"\hbox{\vtop{\hsize=4.5in \pretolerance = 10000 \hbadness = 10000 \parindent=-0.25in \normalbaselines \parskip=0pt")

# Loop over the phrases -- half way through switch the right hand column.
i=0
switchFlag=0
switchFlag=False
for phrase, lnums in gs.items():
    i += 1
    if i < N / 2:
        switchFlag = 1
    elif switchFlag == 1: # End the first column. 
        print(r"}")
        switchFlag = 2
    if switchFlag == 2:
        # Create the second column
        print(r"\vtop{\hsize=3.5in \pretolerance = 10000 \hbadness = 10000 \parindent=-0.25in \normalbaselines \parskip=0pt")
        switchFlag += 1

    # Write out (in the currenct column) the phrase followed a comma separated list of lines numbers.
    print(f"\\par {phrase} {lnums}")

# End the second column.
print(r"}}")

# Leave the probran with success.
sys.exit(0)


