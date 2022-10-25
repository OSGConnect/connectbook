FROM squidfunk/mkdocs-material:latest

COPY user-documentation/scripts/requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

ADD images/ /docs/images
ADD overrides/ /docs/overrides
COPY mkdocs.yml /docs/

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]
CMD ["serve", "--dev-addr=0.0.0.0:8000"]
