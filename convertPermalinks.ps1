#collect or define NUI permalink
Write-Host "Enter a NUI permalink to convert to VE"
$permalinkNUI = $Host.UI.ReadLine()

#$permalinkNUI = "https://searchit.libraries.wsu.edu/permalink/f/1j6uprt/CP71369301200001451"
#$permalinkNUI = "https://searchit.libraries.wsu.edu/permalink/f/1jnr272/TN_cdi_springer_books_10_1007_978_3_030_79389_0"

#get mms id from NUI permalink

#for local records
$mms_id_lastSlash = $permalinkNUI.LastIndexOf('/')
$mms_id_distance = $permalinkNUI.length - $mms_id_lastSlash
$mms_id = $permalinkNUI.Substring($mms_id_lastSlash+1,$mms_id_distance-1)
#for CDI records
$mms_id = $mms_id.replace("TN_","")

#run primo search api to get values in lds04

$url_primoSearch = 'https://api-na.hosted.exlibrisgroup.com/primo/v1/search?vid=WSU&tab=default_tab&scope=WSU_everything&q=any,contains,' + $mms_id + '&lang=eng&offset=0&limit=10&sort=rank&apikey=[yourApiKey]'
$primoSearchResults = Invoke-WebRequest -Uri $url_primoSearch | ConvertFrom-Json
$lds04 = $primoSearchResults.docs.pnx.display.lds04

if ($lds04 -eq $null) {$permalinkVE = "https://alliance-wsu.primo.exlibrisgroup.com/permalink/01ALLIANCE_WSU/defo6d/" + $mms_id
}

else {
#isolate local value in lds04

$lds04_WSU_IWSU = $lds04 -match 'WSU'
$lds04_WSU_pos = $lds04_WSU_IWSU.LastIndexOf('$$IWSU')
$lds04_WSU_local = $lds04_WSU_IWSU.Substring(0,$lds04_WSU_pos)

#build permalink in VE
$permalinkVE = "https://alliance-wsu.primo.exlibrisgroup.com/permalink/01ALLIANCE_WSU/1nce4q/alma" + $lds04_WSU_local
#$permalinkVE = "https://searchit.libraries.wsu.edu/permalink/01ALLIANCE_WSU/1nce4q/alma" + $lds04_WSU_local
}

$permalinkVE

Write-Host -NoNewLine 'Press any key to continue...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

#example permalinks:
#https://searchit.libraries.wsu.edu/permalink/f/1j6uprt/CP71369301200001451
#https://searchit.libraries.wsu.edu/permalink/f/1jnr272/TN_cdi_springer_books_10_1007_978_3_030_79389_0
