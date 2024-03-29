/// GitHub Repository Model
class GitHub {
  /// Repository full name.
  final String fullName;

  /// Repository description.
  final String description;

  /// Language in use.
  final String language;

  /// Repository html url.
  final String htmlUrl;

  /// Count of stars.
  final int stargazersCount;

  /// Count of watchers.
  final int watchersCount;

  /// Count of forks repository.
  final int forksCount;

  GitHub.fromJson(Map<String, dynamic> json)
      : fullName = json['full_name'],
        description = json['description'],
        language = json['language'],
        htmlUrl = json['html_url'],
        stargazersCount = json['stargazers_count'],
        watchersCount = json['watchers_count'],
        forksCount = json['forks_count'];
}
