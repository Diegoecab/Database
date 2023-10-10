run {
allocate channel ch01 device type disk;
allocate channel ch02 device type disk;
allocate channel ch03 device type disk;
allocate channel ch04 device type disk;
allocate channel ch05 device type disk;
allocate channel ch06 device type disk;
allocate channel ch07 device type disk;
allocate channel ch08 device type disk;

set newname for datafile   4 to '+DATA_HP2/CSIBSR/DATAFILE/undotbs1.719.988985075';
set newname for datafile    5 to '+DATA_HP2/CSIBSR/DATAFILE/undotbs2.649.988985983';
set newname for datafile    6 to '+DATA_HP2/CSIBSR/DATAFILE/users.664.988986039';
set newname for datafile    7 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.628.988985077';
set newname for datafile    8 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.625.988985075';
set newname for datafile    9 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.632.988985077';
set newname for datafile   10 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.631.988985077';
set newname for datafile   11 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.630.988985077';
set newname for datafile   12 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.629.988985077';
set newname for datafile   13 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.634.988985077';
set newname for datafile   14 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.636.988985077';
set newname for datafile   15 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.638.988985077';
set newname for datafile   16 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.635.988985077';
set newname for datafile   17 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.633.988985077';
set newname for datafile   18 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.643.988985077';
set newname for datafile   19 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.639.988985077';
set newname for datafile   20 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.641.988985077';
set newname for datafile   21 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.640.988985077';
set newname for datafile   22 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.637.988985077';
set newname for datafile   23 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.644.988985077';
set newname for datafile   24 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.642.988985077';
set newname for datafile   45 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.669.988986051';
set newname for datafile   46 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.670.988986065';
set newname for datafile   47 to '+DATA_HP2/CSIBSR/DATAFILE/data_cl.671.988986065';
set newname for datafile   48 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.727.988985073';
set newname for datafile   49 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.701.988985073';
set newname for datafile   50 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.711.988985075';
set newname for datafile   51 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.735.988985073';
set newname for datafile   52 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.622.988985075';
set newname for datafile   53 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.703.988985075';
set newname for datafile   61 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.624.988985075';
set newname for datafile   62 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.623.988985075';
set newname for datafile   63 to '+DATA_HP2/CSIBSR/DATAFILE/index_cl.626.988985075';
set newname for datafile   75 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.665.988986041';
set newname for datafile   76 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.651.988986021';
set newname for datafile   77 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.655.988986029';
set newname for datafile   78 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.646.988985977';
set newname for datafile   79 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.666.988986043';
set newname for datafile   80 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.652.988986023';
set newname for datafile   81 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.657.988986031';
set newname for datafile   82 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.647.988985979';
set newname for datafile   83 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.660.988986035';
set newname for datafile   84 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.667.988986045';
set newname for datafile   85 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.653.988986025';
set newname for datafile   86 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.659.988986033';
set newname for datafile   87 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.658.988986033';
set newname for datafile   88 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.648.988985981';
set newname for datafile   89 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.662.988986037';
set newname for datafile   90 to '+DATA_HP2/CSIBSR/DATAFILE/indexlrg.668.988986049';
set newname for datafile   96 to '+DATA_HP2/CSIBSR/DATAFILE/undotbs2.645.988985945';
set newname for datafile   97 to '+DATA_HP2/CSIBSR/DATAFILE/undotbs2.650.988986003';
set newname for datafile  106 to '+DATA_HP2/CSIBSR/DATAFILE/datasml.654.988986027';
set newname for datafile  107 to '+DATA_HP2/CSIBSR/DATAFILE/datasml.661.988986037';
set newname for datafile  108 to '+DATA_HP2/CSIBSR/DATAFILE/datausr.656.988986029';
set newname for datafile  109 to '+DATA_HP2/CSIBSR/DATAFILE/indexsml.663.988986039';
restore datafile 4, 5
,  6
,  7
,  8
,  9
, 10
, 11
, 12
, 13
, 14
, 15
, 16
, 17
, 18
, 19
, 20
, 21
, 22
, 23
, 24
, 45
, 46
, 47
, 48
, 49
, 50
, 51
, 52
, 53
, 61
, 62
, 63
, 75
, 76
, 77
, 78
, 79
, 80
, 81
, 82
, 83
, 84
, 85
, 86
, 87
, 88
, 89
, 90
, 96
, 97
,106
,107
,108
,109 from service CSIBSP_PRIMARY;
switch datafile 4 to copy;
switch datafile 5 to copy;
switch datafile   6 to copy;
switch datafile   7 to copy;
switch datafile   8 to copy;
switch datafile   9 to copy;
switch datafile  10 to copy;
switch datafile  11 to copy;
switch datafile  12 to copy;
switch datafile  13 to copy;
switch datafile  14 to copy;
switch datafile  15 to copy;
switch datafile  16 to copy;
switch datafile  17 to copy;
switch datafile  18 to copy;
switch datafile  19 to copy;
switch datafile  20 to copy;
switch datafile  21 to copy;
switch datafile  22 to copy;
switch datafile  23 to copy;
switch datafile  24 to copy;
switch datafile  45 to copy;
switch datafile  46 to copy;
switch datafile  47 to copy;
switch datafile  48 to copy;
switch datafile  49 to copy;
switch datafile  50 to copy;
switch datafile  51 to copy;
switch datafile  52 to copy;
switch datafile  53 to copy;
switch datafile  61 to copy;
switch datafile  62 to copy;
switch datafile  63 to copy;
switch datafile  75 to copy;
switch datafile  76 to copy;
switch datafile  77 to copy;
switch datafile  78 to copy;
switch datafile  79 to copy;
switch datafile  80 to copy;
switch datafile  81 to copy;
switch datafile  82 to copy;
switch datafile  83 to copy;
switch datafile  84 to copy;
switch datafile  85 to copy;
switch datafile  86 to copy;
switch datafile  87 to copy;
switch datafile  88 to copy;
switch datafile  89 to copy;
switch datafile  90 to copy;
switch datafile  96 to copy;
switch datafile  97 to copy;
switch datafile 106 to copy;
switch datafile 107 to copy;
switch datafile 108 to copy;
switch datafile 109 to copy;
}