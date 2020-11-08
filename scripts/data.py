from palmerpenguins import load_penguins
import pandas as pd

# load penguins
penguins = load_penguins()

# write full data to csv
penguins.to_csv('data/full_penguins.csv')

#--------- Clean data

# limit to variables in question
penguins = penguins[[
'species',
'bill_length_mm',
'bill_depth_mm',
'flipper_length_mm',
'body_mass_g'
]]

# drop na
penguins = penguins.dropna()

# write to csv

penguins.to_csv('data/cleaned_penguins.csv')
