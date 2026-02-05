FROM tethysplatform/tethys-core:4.4.3-py3.12-dj5.2

#################
# ENV VARIABLES #
#################
ENV DAM_INVENTORY_MAX_DAMS="50"

##############
# COPY FILES #
###############
COPY apps/tethysapp-dam_inventory ${TETHYS_HOME}/apps/tethysapp-dam_inventory
COPY images/ /tmp/custom_theme/images/

###########
# INSTALL #
###########
# Activate tethys conda environment during build
ARG MAMBA_DOCKERFILE_ACTIVATE=1
RUN cd ${TETHYS_HOME}/apps/tethysapp-dam_inventory && tethys install --no-db-sync

##################
# COPY SALT FILES #
##################
COPY salt/ /srv/salt/

#########
# PORTS #
#########
EXPOSE 80

#######
# RUN #
#######
WORKDIR ${TETHYS_HOME}
CMD bash run.sh