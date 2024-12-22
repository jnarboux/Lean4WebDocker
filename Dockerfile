FROM node
WORKDIR  /root
ENV PATH="/root/.elan/bin:/root/.local/bin:$PATH"
# do not use bubblewrap as it seems to be incompatible with the kernel of the docker image
RUN apt-get update && apt-get -y install  git cmake clang lld libc++-dev
RUN curl https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh -sSf | sh -s -- -y && \
     . ~/.profile && \
    elan toolchain install $(curl https://raw.githubusercontent.com/leanprover-community/mathlib/master/leanpkg.toml | grep lean_version | awk -F'"' '{print $2}') && \
    elan default stable

RUN git clone --recurse-submodules https://github.com/leanprover-community/lean4web.git
RUN cd lean4web && npm install && npm run build
EXPOSE 8080
ENV PORT=8080
CMD cd lean4web && npm run production

