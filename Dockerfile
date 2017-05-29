# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install CollectD
RUN apt-get -y update && apt-get -y install \
	collectd \
	curl \
	&& rm -rf /var/lib/apt/lists/*

# Add CollectD Service
RUN mkdir /etc/service/collectd
COPY collectd.sh /etc/service/collectd/run
RUN chmod +x /etc/service/collectd/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME /config
