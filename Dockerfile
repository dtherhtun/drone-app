FROM plugins/base:multiarch

ADD release/linux/amd64/hello /bin/

ENTRYPOINT ["/bin/hello"]
