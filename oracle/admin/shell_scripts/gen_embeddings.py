#!/usr/bin/env python3
"""
Filename: gen_embeddings.py
Author: Diego Cabrera
Date: 2025-03-04
Version: 1.0
Description: Gieven a CSV ot TSV file, this script generates vector embeddings using sentence transformers model. Then, a new file will be created with the new vector column called "embedding"
Usage: python gen_embeddings.py <filename> <colum_name_to_encode>
    E.g.: python gen_embeddings.py "title.principals.tsv" "characters"
"""
# Import statements

from sentence_transformers import SentenceTransformer
import time
import datetime
import pandas as pd
import sys

# Declare variables

#file_name = "title.principals.tsv"
file_name = sys.argv[1]
column_to_encode = sys.argv[2]
file_sep = "\t"
sentence_transformer_model = "sentence-transformers/distiluse-base-multilingual-cased-v2"
timeformat = "%y-%m-%d %H:%M:%S"


model = SentenceTransformer(sentence_transformer_model)

print(datetime.datetime.now().strftime(timeformat));
print ("\nEmbeddings generation started")
print ("\nWorking with filename", file_name);
df = pd.read_csv(file_name, sep=file_sep)

# Check the existing header row
print ("\nExisting columns: ",df.columns,sep='\n\n');

# Generate result using pandas
result = []
print(datetime.datetime.now().strftime(timeformat));
print ("Encoding column ",column_to_encode," using ",sentence_transformer_model)
t = 0
for value in df[column_to_encode]:
    result.append(model.encode(str(value)))
    t += 1
    if t % 1000000 == 0:
        print(datetime.datetime.now().strftime(timeformat));
        print(t + "rows encoded")


print(datetime.datetime.now().strftime(timeformat));
print ("Encoding has finished");

df['embedding'] = result

## Recast the elements of the "embedding" column to lists
df["embedding"] = df["embedding"].apply(lambda x: x.tolist())

print ("\nA new file called ","new."+file_name," will be created with these columns and rows: ");
print(df.head());
print (":::::::::::::::::::::::::::::::::")
print(df.tail());
df.to_csv("new."+file_name, sep=file_sep, index=False, header=None)
print(datetime.datetime.now().strftime(timeformat));
print ("\nEmbeddings generation finished")

