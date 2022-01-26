This is a sample project to showcase https://github.com/zwilias/elm-coverage/issues/45

## STR

1. `npm install`
2. `./node_modules/.bin/elm-coverage --elm-test ./node_modules/.bin/elm-test`

## Expected

It would work. This is the documented way to use non-global binaries.

## Actual

```
[11:36:29.78] Instrumenting sources...
[11:36:29.83] Running tests...
node:events:368
      throw er; // Unhandled 'error' event
      ^

Error: spawn ./node_modules/.bin/elm-test ENOENT
    at Process.ChildProcess._handle.onexit (node:internal/child_process:282:19)
    at onErrorNT (node:internal/child_process:477:16)
    at processTicksAndRejections (node:internal/process/task_queues:83:21)
Emitted 'error' event on ChildProcess instance at:
    at Process.ChildProcess._handle.onexit (node:internal/child_process:288:12)
    at onErrorNT (node:internal/child_process:477:16)
    at processTicksAndRejections (node:internal/process/task_queues:83:21) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'spawn ./node_modules/.bin/elm-test',
  path: './node_modules/.bin/elm-test',
  spawnargs: [
    '--compiler',
    '/Users/rob/Projects/elm-coverage-bug/node_modules/elm-coverage/bin/fake-elm',
    'tests/'
  ]
}
```

I also tried `./node_modules/.bin/elm-coverage --elm-test ./node_modules/.bin/elm-test -- --compiler ./node_modules/.bin/elm-test`, but the only difference that made was tacking on a couple more arguments to `spawnargs`:

```
  spawnargs: [
    '--compiler',
    '/Users/rob/Projects/elm-coverage-bug/node_modules/elm-coverage/bin/fake-elm',
    'tests/',
    '--compiler',
    './node_modules/.bin/elm-test'
  ]
```

It looks like `/Users/rob/Projects/elm-coverage-bug/node_modules/elm-coverage/bin/fake-elm` is looking for a global `elm` install, but even if I `npm i -g elm` I get the same result for `./node_modules/.bin/elm-coverage --elm-test ./node_modules/.bin/elm-test`:

```
[11:43:51.49] Instrumenting sources...
[11:43:51.54] Running tests...
node:events:368
      throw er; // Unhandled 'error' event
      ^

Error: spawn ./node_modules/.bin/elm-test ENOENT
    at Process.ChildProcess._handle.onexit (node:internal/child_process:282:19)
    at onErrorNT (node:internal/child_process:477:16)
    at processTicksAndRejections (node:internal/process/task_queues:83:21)
Emitted 'error' event on ChildProcess instance at:
    at Process.ChildProcess._handle.onexit (node:internal/child_process:288:12)
    at onErrorNT (node:internal/child_process:477:16)
    at processTicksAndRejections (node:internal/process/task_queues:83:21) {
  errno: -2,
  code: 'ENOENT',
  syscall: 'spawn ./node_modules/.bin/elm-test',
  path: './node_modules/.bin/elm-test',
  spawnargs: [
    '--compiler',
    '/Users/rob/Projects/elm-coverage-bug/node_modules/elm-coverage/bin/fake-elm',
    'tests/'
  ]
}
```

In any case, I don't want to globally install these things because I want the versions to be pinned in each of my projects.

## Additional info

```
% npm --version
8.1.2
```
