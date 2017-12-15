#!/usr/bin/perl
#
# MythWeb Streaming/Download module
#
#

# Necessary constants for sysopen
    use Fcntl;

# Other includes
    use Sys::Hostname;

    require "modules/$Path[0]/tv.pl";

    # Use the MythTV Services API URL if the $filename URL is not local
    unless ($filename) {
        # Retrieve the backend IP and port
        $sh = $dbh->prepare('SELECT data FROM settings WHERE value=?');
        $sh->execute('BackendServerIP');
        my ($backend_server_ip)   = $sh->fetchrow_array;
        $sh->execute('BackendStatusPort');
        my ($backend_status_port) = $sh->fetchrow_array;
        $sh->finish();
        
        # Reformat the recording start time
        use HTTP::Date qw(time2isoz);
        $starttime_isoz = time2isoz($starttime);
        $starttime_isoz =~ s/ /T/g;
        
        # Generate the MythTV Services API URL
        $filename = "http://${backend_server_ip}:${backend_status_port}/Content/GetRecording?ChanId=${chanid}&StartTime=${starttime_isoz}";
    }

# HTML5 video/ogv
    if ($ENV{'REQUEST_URI'} =~ /\.ogv$/i) {
        require "modules/$Path[0]/stream_ogv.pl";
    }
# HTML5 video/webm
    elsif ($ENV{'REQUEST_URI'} =~ /\.webm$/i) {
        require "modules/$Path[0]/stream_webm.pl";
    }
# ASX mode?
    elsif ($ENV{'REQUEST_URI'} =~ /\.asx$/i) {
        require "modules/$Path[0]/stream_asx.pl";
    }
# Flash?
    elsif ($ENV{'REQUEST_URI'} =~ /\.flvp$/i) {
        require "modules/$Path[0]/stream_flvp.pl";
    }
    elsif ($ENV{'REQUEST_URI'} =~ /\.flv$/i) {
        require "modules/$Path[0]/stream_flv.pl";
    }
# Mpeg4?
    elsif ($ENV{'REQUEST_URI'} =~ /\.mp4$/i) {
        require "modules/$Path[0]/stream_mp4.pl";
    }
# Raw file?
    else {
        require "modules/$Path[0]/stream_raw.pl";
    }

###############################################################################

# Escape a parameter for safe use in a commandline call
    sub shell_escape {
        $str = shift;
        $str =~ s/'/'\\''/sg;
        return "'$str'";
    }

# Return true
    1;
