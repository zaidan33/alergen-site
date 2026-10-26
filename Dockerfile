FROM nginx:1.27-alpine

RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY index.html 404.html robots.txt sitemap.xml favicon.svg /usr/share/nginx/html/
COPY images/ /usr/share/nginx/html/images/

# Bagian sementara untuk penjurian Indonesia Paten Award (D01-D09).
# Dapat dicabut kembali dengan menghapus baris COPY di bawah dan folder ipa/.
COPY ipa/ /usr/share/nginx/html/ipa/

RUN nginx -t

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/healthz >/dev/null 2>&1 || exit 1
