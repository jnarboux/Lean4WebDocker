FROM node

RUN apt-get update
RUN apt-get -y install  git bubblewrap
RUN git clone --recurse-submodules https://github.com/leanprover-community/lean4web.git

RUN cd lean4web && npm install && npm run build
EXPOSE 8080
ENV PORT=8080
CMD cd lean4web && npm run production

