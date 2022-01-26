This is a sample project to showcase https://github.com/zwilias/elm-coverage/issues/44

## STR

1. Install elm, elm-coverage, and elm-test globally.
2. `elm-coverage client/src -t client/tests`

## Expected

It would work. This is the documented way to reference src and test files in non-default locations.

## Actual

```
[11:07:31.31] Instrumenting sources...
[11:07:31.36] Running tests...

[11:07:31.44] Ruh roh, tests failed.
[11:07:31.44] Something went wrong:
Error: The "source-directories" field in your elm.json lists the following directory:

/Users/rob/Projects/elm-coverage-bug/.coverage/instrumented/client/tests

It doesn't exist though. Is it missing? Is there a typo?
```

Looking in the `.coverage/instrumented` directory, the `elm.json` file contains `"source-directories":["client/src","client/tests"]`, but the actual directory structure is:

```
instrumented
- client
  - src
- tests
- elm.json
```

So it looks like the tests directory just doesn't get copied over correctly.
