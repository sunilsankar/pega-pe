JAVA_OPTS="-Xms4096m -Xmx4096m -XX:+CMSClassUnloadingEnabled -XX:TargetSurvivorRatio=90 -XX:+UseG1GC -XX:+UseStringDeduplication -XX:+DisableExplicitGC -XX:+UseCMSInitiatingOccupancyOnly  -XX:ReservedCodeCacheSize=756m -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=80 -XX:NewSize=256"
JAVA_OPTS="$JAVA_OPTS -DNodeType=Stream,BackgroundProcessing,WebUser,Search
