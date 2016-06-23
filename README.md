# elm-todo-rest-api

The official [elm-todomvc](https://github.com/evancz/elm-todomvc) uses localStorage to persist state. Since most
real-world elm apps will interact with a web api to persist state,
this is a simple elm todo app demonstrating interaction
with a simple json api server.

Additionally, the code here has about 10x the modularity of the official implementation.

This app is sparse on css on purpose.

The code is heavily-documented. If something is confusing,
submit an issue or PR and I'll improve the documentation there if possible.

## Getting Started

First, install dependencies:

```
npm install
elm package install
```

To play with the app, first start up the api:

```
npm run api
```

All changes will be reflected in `db.json`.

Then, run the following to start a hot-reloading dev server through webpack:

```
npm run dev
```
