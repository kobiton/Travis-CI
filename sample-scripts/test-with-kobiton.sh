#Get latest deployment version
ids=$(curl \
  -H "X-HockeyAppToken: $HOCKEYAPP_TOKEN" \
  https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions | jq -r '.app_versions[].id')

version=0
for i in ${ids}
do
  if [ $i -gt $version ]
  then
    version=$i
  fi
done

if [ $version -eq 0 ]
then
  exit 1
fi

#Get resigned URL
resignedUrl=$(curl \
-H "X-HockeyAppToken: $HOCKEYAPP_TOKEN" \
-w %{redirect_url} \
-s -o null https://rink.hockeyapp.net/api/2/apps/$APP_ID/app_versions/$version?format=$FILE_FORMAT)

#Automation test script execution command 
#Ex: VERSION=$version RESIGNED_URL=$resignedUrl <COMMAND> 