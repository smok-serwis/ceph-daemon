FROM ceph/daemon

ADD entrypoint.sh /entrypoint2.sh
RUN chmod ugo+x /entrypoint2.sh
ENTRYPOINT ["/entrypoint2.sh"]
