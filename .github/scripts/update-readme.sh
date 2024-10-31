

now=$(date -u '+%m/%d/%Y %H:%M')
sed -r -i 's@[[TEMPL_UPDATE]]@Last Sync: $now@g' README.md
sed -r -i "s@Last Sync: [0-9]{2}\/[0-9]{2}\/[0-9]{4} [0-9]{2}\:[0-9]{2}@Last Sync: $now@g" README.md