#!/bin/zsh

work_path=$1

find "$work_path" -type f | while read f
# curl -m 900 -X POST -H "Content-Type: multipart/form-data" -H "Cookie: csrftoken=wpjKD7Xakjj3v2GXXYjQpXW4jMTb3R9gZLtRVO8Mfem07YWwPmpDoskn3PuXSx1q; sessionid=tzzmtpl10dv1g4vrw2cvs4jalp19zx0z;" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -H "Referer: http://a-larionov.ru/admin_123/upload/" -F "sessionid=tzzmtpl10dv1g4vrw2cvs4jalp19zx0z" -F "album=1" -F "csrfmiddlewaretoken=fXi0DU9eelWTMMrkG0Pr48Ck43aQC1CkIjs7VBkQ9gZQoIHTyoVe3D0DO6LCrHuu" -F "photos=@/Users/sanya/ForPhotoSite/_MG_1146_ps_2.jpg" -F "photos=@/Users/sanya/ForPhotoSite/_MG_0740_Panorama.jpg" http://a-larionov.ru/admin_123/upload/
do
	mv "$f" $(echo "$f" | tr ' ' '_')
	echo photos=@"$f"
done