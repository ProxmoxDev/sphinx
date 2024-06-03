FROM sphinxdoc/sphinx:7.3.7 AS base
WORKDIR /docs
COPY ./docs ./
RUN pip3 install \
sphinx-rtd-theme \
myst-parser

FROM base AS builder
RUN make html

FROM base AS dev


FROM nginx:alpine3.19-perl AS production
COPY --from=builder /docs/build/html /usr/share/nginx/html
EXPOSE 80