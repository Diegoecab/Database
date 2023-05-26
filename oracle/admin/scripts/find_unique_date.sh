find . -type f -printf '%TY-%Tm-%Td\n' | sort | uniq -c

find . -type f -printf '%TY-%Tm-%Td %TH\n'  | sort | uniq -c

find . -type f -mtime -1 -exec grep "CDM_PE" {} \; -printf '%TY-%Tm-%Td %TH\n'  | sort | uniq -c