# google_maps_flutter_web

This "package" is a _noop_ web implementation of the `google_maps_flutter_web`
so we can remove some project dependencies that aren't wasm-compatible yet, but
still use `google_maps_flutter` in mobile platforms through conditional imports.
