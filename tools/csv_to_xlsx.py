import pandas as pd

# Read CSV
df = pd.read_csv('/Users/sbr-02/Belajar/sorga/levels_export.csv')

# Save as Excel
output_path = '/Users/sbr-02/Belajar/sorga/levels_export.xlsx'
df.to_excel(output_path, index=False, sheet_name='All Levels')

print(f'✅ Exported to: {output_path}')
print(f'Total levels: {len(df)}')
print(f'\nCategories breakdown:')
print(df['Category'].value_counts())
