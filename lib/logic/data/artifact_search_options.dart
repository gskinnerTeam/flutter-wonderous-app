class ArtifactSearchOptions {
  ArtifactSearchOptions(
      {required this.query,
      this.count = 1000,
      this.offset = 0,
      this.isTitle,
      this.isKeyword,
      this.isHighlight,
      this.departmentId,
      this.location,
      this.startYear,
      this.endYear});

  final String query; // User query to search with.
  final int count; // Number of results to return, starting from offset.
  final int offset; // Result offset; skip over returning loaded results for paging.
  final bool? isTitle; // True if user search query is part of artifact title.
  final bool? isKeyword; // True if user search query is part of artifact keywords.
  final bool? isHighlight; // True if artifacts returned are to be classified as highlights.
  final String? departmentId; // If set, returns results from a specific department. IDs can be loaded in.
  final String? location; // Geolocation of artifacts to search for.
  final int? startYear; // Earliest year range of artifact results.
  final int? endYear; // Latest year range of artifact results.
}
