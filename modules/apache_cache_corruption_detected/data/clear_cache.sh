

#!/bin/bash



# Set the path to the Apache cache directory

cache_dir=${PATH_TO_CACHE_DIRECTORY}



# Delete all files in the cache directory

rm -rf $cache_dir/*



# Use Apache clean to clear the cache (optional)

# apache_clean ${PATH_TO_APACHE_CLEAN}



# Restart the Apache server

service apache2 restart