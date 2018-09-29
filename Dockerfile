# Note that there must be a tag
FROM thompsonsed/pycoalescence-circleci-0.0.1:c174a6f8cecc
# install pip
RUN pip install --no-cache-dir notebook==5.*
# Create the user
ENV NB_USER jovyan
ENV NB_UID 1000
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

CMD pip install pycoalescence

# Specify the default command to run
CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]