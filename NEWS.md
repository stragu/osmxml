# osmxml (development version)

* Rename package from "osmexport" to "osmxml" (and rename functions to use the 
"ox_" prefix instead of "oexp_") to expand its use to any OSM XML file and to 
clarify that the package's primary use is not data acquisition from OSM servers
* `print` and `plot` methods are now more consistent with generics. For example, 
you can now use the `main` argument to add a title to a visualisation.
* By default, `ox_download()` (previously `oexp_download()`) now uses a cached 
download if an export using the same bounding box was downloaded previously
* Add tests for `ox_download()` (previously `oexp_download()`)

# osmexport 0.2.0

* Initial release
