# elm todomvc with api

The official [elm-todomvc](https://github.com/evancz/elm-todomvc) uses localStorage to persist state. Since most
real-world elm apps will interact with a web api to persist state,
this is a simple elm todo app demonstrating interaction
with a simple json api server.

This app purposely doesn't have any css styles.
You're probably here to learn Elm, so there's no reason to clutter things.

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
