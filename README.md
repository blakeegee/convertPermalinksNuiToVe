# convertPermalinksNuiToVe
Devise a way to convert Primo NUI permalinks into Primo VE permalinks

Note: To start, you will need to find out the code that is being used in the directory after your institution code for CDI and local records:
CDI records
https://alliance-wsu.primo.exlibrisgroup.com/permalink/01ALLIANCE_WSU/*defo6d*/cdi_springer_books_10_1007_978_3_030_79389_0
Local records
https://alliance-wsu.primo.exlibrisgroup.com/permalink/01ALLIANCE_WSU/*1nce4q*/alma99900626287501842

This script converts a Primo NUI permalink to Primo VE permalink by making a call via the Primo Search API.
The script consists of two basic parts:
1) If .docs.pnx.display.lds04 is empty, the record is coming from CDI, and the mmd id does not change.
2) Otherwise (.docs.pnx.display.lds04 is not empty), the record is coming from Alma, the mms id does change and needs to be parsed from the lds04 field to find your local data.
