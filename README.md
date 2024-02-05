# Local version identifiers

## Context
This project contains some fake data and a test script to confirm the behaviour of local version identifiers.

The intention is to provide guidance on the use of local version identifiers when forking / patching upstream packages and to understand how these are handled transitively.

This was originally discussed in a [thread on Python Packaging](https://discuss.python.org/t/local-version-identifiers-for-custom-builds-and-transitive-dependencies/35483).

## Scenario

* “foo-pkg 2.0.0” requires “bar-pkg >= 1.0”
* There is a desire to patch “bar-pkg 1.0.0” and publish to a private index
* The patched “bar-pkg” is published as “bar-pkg 1.0.0+custom” to the private index
* The “bar-pkg 1.0.0+custom” identifier makes it easy to understand and manage the original package and version that was patched


Contents of requirements.in
```
bar-pkg==1.0.0+custom
foo-pkg
```

## Result

This works as desired. The custom patched version of “bar-pkg 1.0.0+custom” is selected to satisfy the transitive dependency from “foo-pkg 2.0.0 -> bar-pkg >= 1.0”