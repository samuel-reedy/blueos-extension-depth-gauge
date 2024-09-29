# Use nginx instead of python base image
FROM nginx:alpine

# Copy the web application files (HTML, CSS, JS) to Nginx's web directory
COPY app/ /usr/share/nginx/html

# Expose port 80 for HTTP traffic (Nginx default port)
EXPOSE 80/tcp

# Metadata labels with version
LABEL version="0.0.3"

# ARG values to pass in during the build
ARG IMAGE_NAME
ARG AUTHOR
ARG AUTHOR_EMAIL
ARG MAINTAINER
ARG MAINTAINER_EMAIL
ARG REPO
ARG OWNER

# Permissions label for BlueOS extension
LABEL permissions='\
{\ 
  "ExposedPorts": {\
    "80/tcp": {}\
  },\
  "HostConfig": {\
    "Binds":["/usr/blueos/extensions/$IMAGE_NAME:/usr/share/nginx/html"],\
    "ExtraHosts": ["host.docker.internal:host-gateway"],\
    "PortBindings": {\
      "80/tcp": [\
        {\
          "HostPort": ""\
        }\
      ]\
    }\
  }\
}'

# Author and maintainer information labels
LABEL authors='[\ 
    {\ 
        "name": "$AUTHOR",\
        "email": "$AUTHOR_EMAIL"\
    }\ 
]'
LABEL company='{\
        "about": "",\
        "name": "$MAINTAINER",\
        "email": "$MAINTAINER_EMAIL"\
    }'

# Label for project source and documentation
LABEL type="example"
LABEL readme="https://raw.githubusercontent.com/$OWNER/$REPO/{tag}/README.md"
LABEL links='{\
        "source": "https://github.com/$OWNER/$REPO"\
    }'

# BlueOS core requirements
LABEL requirements="core >= 1.1"

# The entrypoint is to run nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
