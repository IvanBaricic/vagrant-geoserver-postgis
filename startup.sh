cd /usr/local/geoserver/bin

# Geoserver configuration - use /etc/default/geoserver to override these vars
# user that shall run GeoServer
USER=geoserver
GEOSERVER_DATA_DIR=/home/$USER/data_dir
export GEOSERVER_DATA_DIR
#GEOSERVER_HOME=/home/$USER/geoserver
GEOSERVER_HOME=/usr/local/geoserver/
export GEOSERVER_HOME

PATH=/usr/sbin:/usr/bin:/sbin:/bin
DESC="GeoServer daemon"
NAME=geoserver
JAVA_OPTS="-Xms128m -Xmx512m"
DAEMON="$JAVA_HOME/bin/java"
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

# Read configuration variable file if it is present
[ -r /etc/default/$NAME ] && . /etc/default/$NAME

DAEMON_ARGS="$JAVA_OPTS $DEBUG_OPTS -DGEOSERVER_DATA_DIR=$GEOSERVER_DATA_DIR -Djava.awt.headless=true -jar start.jar"

# Load the VERBOSE setting and other rcS variables
[ -f /etc/default/rcS ] && . /etc/default/rcS

# Define LSB log_* functions.
# Depend on lsb-base (>= 3.0-6) to ensure that this file is present.
. /lib/lsb/init-functions

echo ' '
echo --- Launching GeoServer startup script ---
echo --- This will run in the background with nohup mode ---
echo --- To access the server, use vagrant ssh ---
echo --- To view the web client go to http://localhost:9090/geoserver ---
echo ' '

# run startup script and have it run in the background - output logged to nohup.out

echo "USER is" $USER
echo "GEOSERVER_DATA_DIR is" $GEOSERVER_DATA_DIR
echo "GEOSERVER_HOME is " $GEOSERVER_HOME

cd /usr/local/geoserver/bin/
echo " "
echo "Working directory:"
pwd
echo "--------"
echo "Starting up GeoServer"
sh /usr/local/geoserver/bin/startup.sh 0<&- &>/dev/null &
