# Convertigo image with LibreOffice and the lib_fill_odt_pdf fonts preinstalled, so the
# conversions (u_convert, odt2pdf, soffice_odt2pdf) work as soon as the container starts.
#
#   docker build -f docker/Dockerfile --build-arg CONVERTIGO_TAG=8.4.1 -t convertigo-odf:8.4.1 .
#   docker run -d -p 28080:28080 convertigo-odf:8.4.1
#
# With this image the init_config / init_config_loop auto start sequences are not needed:
# set the global symbols auto_start.init_config=false and auto_start.init_config_loop=false
# (administration console > Global symbols). To keep LibreOffice processes running between
# conversions (about 50 ms per conversion instead of 2 s), set the global symbol
# lib_fill_odt_pdf.office_pool_size (or the LIB_FILL_ODT_PDF_OFFICE_POOL_SIZE environment
# variable) to the number of processes.
ARG CONVERTIGO_TAG=8.4.1
FROM convertigo:${CONVERTIGO_TAG}

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-core libreoffice-common \
    fontconfig fonts-dejavu fonts-liberation \
 && rm -rf /var/lib/apt/lists/*

COPY fonts/ /usr/share/fonts/truetype/custom/
RUN chmod -R a+rX /usr/share/fonts/truetype/custom/ && fc-cache -f
