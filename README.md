# elm todomvc with api

The official [elm-todomvc](https://github.com/evancz/elm-todomvc) uses localStorage to persist state. Since most
real-world elm apps will interact with a web api to persist state,
this is a simple elm todo app demonstrating interaction
with a simple json api server.

## Getting Started

To play with it, first start up the api:

```
npm run api
```

All changes will be reflected in `db.json`.

Then, run the following to start a hot-reloading dev server through webpack:

```
npm run dev
```
