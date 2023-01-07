import glob
import pandas as pd

# Remove any existing files with names matching the pattern "csv_oon*.csv"
!rm csv_oon*.csv

# Loop over all files with the .out extension in the current directory
for g in glob.glob('*.out'):
    # Read the file into a Pandas dataframe
    df = pd.read_csv(g, sep='\s+', names=['col1', 'col2', 'col3', 'col4'])

    # Extract the value of n from the first line containing "alpha and"
    n = df.loc[df['col2'] == 'and', 'col3'].iloc[0]

    # Extract the rows containing " $n f = " and the rows within 15 rows before and after these rows
    df = df.loc[df['col4'].str.contains(" $n f = ")]
    df = df.iloc[-31:]

    # Write the resulting dataframe to a file with a name of the form "csv_oon_of_FILENAME.csv"
    df.to_csv(f"csv_oon_of_{g[:-4]}.csv", index=False, header=False, sep=' ')

# Concatenate the contents of all the "csv_oon_of_*.csv" files into a single dataframe
df_all = pd.concat([pd.read_csv(f, sep='\s+', names=['col1', 'col2']) for f in glob.glob('csv_oon_of_*.csv')])

# Write the resulting dataframe to a file called "all.csv"
df_all.to_csv('all.csv', index=False, header=False, sep=' ')
