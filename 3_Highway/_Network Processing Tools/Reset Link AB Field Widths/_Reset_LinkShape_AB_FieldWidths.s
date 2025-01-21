
LinkShapeDBF_Input  = 'SummitWasatch - 2020-01-15 - Link - original.dbf'
LinkShapeDBF_Output = 'SummitWasatch - 2020-01-15 - Link.dbf'


RUN PGM=MATRIX
FILEI RECI = '@LinkShapeDBF_Input@'


FILEO RECO[1] = '_temp_Link_AB.dbf',
    FIELDS=A, 
           B

FILEO RECO[2] = '_temp_Link_NoAB.dbf',
    FIELDS=RECI.ALLFIELDS,
    EXCLUDERECI=A, B


    ZONES = 310
    
    ; write data to defined output files
    WRITE RECO=1-2
    
ENDRUN


RUN PGM=MATRIX
FILEI DBI = '_temp_Link_AB.dbf',
    AUTOARRAY=ALLFIELDS
    
FILEI RECI = '_temp_Link_NoAB.dbf'


FILEO RECO[1] = '@LinkShapeDBF_Output@',
    FIELDS=A(20.0), 
           B(20.0),
           RECI.ALLFIELDS

    ZONES = 310
    
    ; write data to defined output files
    RO.A = dba.1.A[RECI.RECNO]
    RO.B = dba.1.B[RECI.RECNO]
    
    WRITE RECO=1
    
ENDRUN


*(DEL "_temp_Link_AB.dbf", "_temp_Link_NoAB.dbf")
