#------------------------------------------------------------------------------
# Ubuntu Linux configure script command line examples:
#------------------------------------------------------------------------------
# 
# The following procedure serves to install the current version of MB-System
# (5.5.2307) on new installations of Ubuntu 16.04 in June 2017.
# 
# GMT:
# ----
# GMT is a key prerequisite for MB-System, which now requires GMT 5.2.1 or later.
# One can check which GMT version is available by querying the package manager in
# a terminal:
#       apt-cache show gmt
# 
# If the repositories you are already accessing do not include GMT, one can add the
# UbuntuGIS repo by typing:
#       sudo add-apt-repository ppa:ubuntugis/ppa
#       sudo apt-get update
#       sudo apt-get upgrade
# 
# These commands will add a GIS repository containing GMT, GDAL, GRASS,
# QGIS, etc, including an older version of MB-System:
#         https://launchpad.net/~ubuntugis/+archive/ubuntu/ppa
# 
# Motif:
# ------
# Another MB-System dependency that can be apparently unavailable is libmotif4. The
# Motif widget set is used by all of the MB-System interactive graphical tools. Do
# not use the old LessTif package - this served as a functional close of Motif long
# ago, but no longer duplicates all of the needed Motif functionality. Instead,
# install some version of Motif4. If 
#       apt-cache show libmotif4
# indicates that libmotif4 is unavailable, then add the ubuntu extras repo using
# the commands:
#       sudo su
#       echo 'deb http://cz.archive.ubuntu.com/ubuntu trusty main universe' \
#           >> /etc/apt/sources.list.d/extra.list
#       apt-get install update
# You will need to re-login or open a new terminal in order for this to take effect.
# 
# Install prerequisites:
# -------------------
# Use a single apt-get command to install the MB-System dependencies:
        sudo apt-get install gmt libgmt5 libgmt-dev gmt-gshhg gmt-doc \
            libx11-dev xorg-dev libmotif-dev libmotif4 \
            libxp-dev mesa-common-dev libsdl1.2-dev libsdl-image1.2-dev \
            sudo apt-get install  build-essential gfortran nautilus-open-terminal \
            libfftw3-3 libfftw3-dev libnetcdf-dev netcdf-bin \
            libgdal-bin gdal-dev gv csh libgmt-dev libproj-dev
# 
# MB-System:
# ----------
# These steps assume you have downloaded an MB-System distribution tar.gz file 
# from the ftp site:
#       ftp://mbsystemftp@ftp.mbari.org
# The current distribution file is mbsystem-5.5.2307.tar.gz
# 
# First, unpack the distribution using tar. This can be done in any location,
# but if one is working in a root-owned area such as /usr/local/src, obtaining
# root privileges using sudo is necessary for all steps:
#       sudo tar xvzf mbsystem-5.5.2307.tar.gz
# and then cd into the resulting directory:
#       cd mbsystem-5.5.2307
#
# If the prerequisites have all been installed as shown above, and it is desired
# to install MB-System in /usr/local, then only a simple call to configure is
# required:
       sudo ./configure
# 
# Once the makefiles have been generated by configure, build and install using:
        sudo make
        sudo make install
# 
# In some cases the system and/or user environment impedes the successful use of
# the GMT and/or MB-System shared libraries. In order to manually allow shared
# libraries to be found for linking or running, one can either set the CFLAGS
# environment variable during building or set the LD_LIBRARY_PATH environment
# variable at login by adding a command to the user's ~/.profile or ~/.bashrc files.
# 
# To set the CFLAGS environment variable during building include
# "-Wl,-rpath -Wl,LIBDIR" in the configure command as shown here:
# 
#       sudo CFLAGS="-Wl,-rpath -Wl,/usr/local/lib" ./configure
# 
# To augment the LD_LIBRARY_PATH environment variable during login add a line to
# the ~/.bashrc or ~/.profile file as shown here:
# 
#       export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
#
#------------------------------------------------------------------------------
