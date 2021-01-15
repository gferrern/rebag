# Install dependencies
FROM debian:latest

ENV FLUTTER_WEB_PORT="8090"
ENV FLUTTER_DEBUG_PORT="42000"


RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 jq psmisc
RUN apt-get clean
ENV PATH="/usr/local/bin:${PATH}"
# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
# Copy the frontend files to the container
ADD . usr/local/bin/rebag_frontend/
WORKDIR /usr/local/bin/rebag_frontend
# Enable flutter web
RUN flutter channel beta
RUN flutter config --enable-web --no-analytics 
RUN flutter upgrade
# Run flutter doctor
RUN flutter doctor
RUN flutter update-packages
# Set the working directory to the app files within the container
RUN flutter clean
# Get App Dependencies
RUN flutter pub get
RUN rm -fr build
# Document the exposed port
EXPOSE $FLUTTER_WEB_PORT $FLUTTER_DEBUG_PORT
RUN chmod +x entrypoint.sh
ENTRYPOINT ["bash","entrypoint.sh"]
