select
--NAME,
--FILENAME,
--DOC_SIZE,
--LAST_UPDATED,
trunc(LAST_UPDATED),
sum(doc_size),
MIME_TYPE,
CONTENT_TYPE,
CREATOR,
IS_USED,
IS_MARKED_FOR_DELETE
from portal.WWDOC_DOCUMENT$
where last_updated > sysdate -30
group by MIME_TYPE,trunc(last_updated),CONTENT_TYPE,
CREATOR,
IS_USED,
IS_MARKED_FOR_DELETE
order by 1,2,3,4,5.6
/
